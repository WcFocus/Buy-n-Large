CREATE TRIGGER trg_AuditUserActions
ON [User]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Variables para almacenar información de la acción
    DECLARE @ActionType NVARCHAR(50);
    DECLARE @UserID BIGINT;
    DECLARE @EntityCatalogID BIGINT;
    DECLARE @PermissionID BIGINT;
    DECLARE @ActionDetails NVARCHAR(MAX);

    -- Obtener el ID de la entidad "User" desde EntityCatalog
    SET @EntityCatalogID = (SELECT id_entit FROM EntityCatalog WHERE entit_name = 'User');

    -- Determinar el tipo de acción (INSERT, UPDATE, DELETE)
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @ActionType = 'UPDATE';
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SET @ActionType = 'INSERT';
    END
    ELSE IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SET @ActionType = 'DELETE';
    END

    -- Obtener el ID del usuario que realizó la acción (asumiendo que el usuario está autenticado)
    -- En un sistema real, esto se obtendría de la sesión del usuario.
    SET @UserID = 1; -- Cambia esto por el ID del usuario autenticado.

    -- Obtener el ID del permiso asociado a la acción (asumiendo un permiso genérico)
    SET @PermissionID = (SELECT id_permi FROM Permission WHERE name = 'MANAGE_USERS');

    -- Registrar la acción en la tabla AuditLog
    IF @ActionType IS NOT NULL
    BEGIN
        INSERT INTO AuditLog (
            user_id,
            entitycatalog_id,
            permission_id,
            action_type,
            action_details,
            is_success
        )
        VALUES (
            @UserID,
            @EntityCatalogID,
            @PermissionID,
            @ActionType,
            'Acción realizada en la tabla User',
            1 -- Indica que la acción fue exitosa
        );
    END
END;