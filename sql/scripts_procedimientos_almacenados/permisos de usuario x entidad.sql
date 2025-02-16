
CREATE PROCEDURE [dbo].[GetUserPermissionsOnEntity]
    @user_id BIGINT,
    @entitycatalog_id BIGINT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Tabla temporal para almacenar los permisos
    CREATE TABLE #UserPermissions (
        PermissionName NVARCHAR(255),
        Pdescription NVARCHAR(255),
        can_create BIT,
        can_read BIT,
        can_update BIT,
        can_delete BIT,
        can_import BIT,
        can_export BIT
    );

    -- Obtener el nombre del usuario
    DECLARE @user_name NVARCHAR(255);
    SELECT @user_name = user_username
    FROM [User]
    WHERE id_user = @user_id;

    IF @user_name IS NULL
    BEGIN
        RAISERROR ('El usuario no existe', 16, 1);
        RETURN;
    END;

    -- Obtener la descripción de la entidad (si aplica)
    DECLARE @entit_descrip NVARCHAR(255) = NULL;
    IF @entitycatalog_id IS NOT NULL
    BEGIN
        SELECT @entit_descrip = entit_descrip
        FROM [EntityCatalog]
        WHERE id_entit = @entitycatalog_id;

        IF @entit_descrip IS NULL
        BEGIN
            RAISERROR ('La entidad no existe', 16, 1);
            RETURN;
        END;
    END;

    -- Permisos directos del usuario
    INSERT INTO #UserPermissions
    SELECT 
        p.name, 
        p.description, 
        p.can_create, 
        p.can_read, 
        p.can_update, 
        p.can_delete, 
        p.can_import, 
        p.can_export
    FROM 
        PermiUser pu
    INNER JOIN Permission p ON pu.permission_id = p.id_permi
    INNER JOIN UserCompany uc ON pu.usercompany_id = uc.id_useco
    WHERE 
        uc.user_id = @user_id
        AND (@entitycatalog_id IS NULL OR pu.entitycatalog_id = @entitycatalog_id)
        AND pu.peusr_include = 1;

    -- Permisos del usuario a través de roles
    INSERT INTO #UserPermissions
    SELECT 
        p.name, 
        p.description, 
        p.can_create, 
        p.can_read, 
        p.can_update, 
        p.can_delete, 
        p.can_import, 
        p.can_export
    FROM 
        PermiRole pr
    INNER JOIN Permission p ON pr.permission_id = p.id_permi
    INNER JOIN Role r ON pr.role_id = r.id_role
    INNER JOIN UserCompany uc ON r.company_id = uc.company_id
    WHERE 
        uc.user_id = @user_id
        AND (@entitycatalog_id IS NULL OR pr.entitycatalog_id = @entitycatalog_id)
        AND pr.perol_include = 1;

    -- Retornar los resultados
    SELECT 
        @user_name AS UserName, 
        PermissionName, 
        Pdescription, 
        @entit_descrip AS EntityDescription, 
        can_create, 
        can_read, 
        can_update, 
        can_delete, 
        can_import, 
        can_export
    FROM #UserPermissions;

    -- Eliminar tabla temporal
    DROP TABLE #UserPermissions;
END;
