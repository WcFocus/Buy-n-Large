CREATE PROCEDURE LogAuditAction
    @UserID BIGINT,                      -- ID del usuario
    @EntityCatalogID BIGINT,             -- ID de la entidad
    @PermissionID BIGINT,                -- ID del permiso
    @ActionType NVARCHAR(50),            -- Tipo de acción (CREATE, READ, UPDATE, DELETE)
    @ActionDetails NVARCHAR(MAX) = NULL, -- Detalles adicionales (opcional)
    @IsSuccess BIT = 1                   -- Estado de la acción (1 = éxito, 0 = fallo)
AS
BEGIN
    -- Insertar el registro de auditoría
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
        @ActionDetails,
        @IsSuccess
    );
END;