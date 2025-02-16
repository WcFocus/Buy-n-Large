CREATE TABLE AuditLog (
    -- Primary Key
    id_audit BIGINT IDENTITY(1,1) PRIMARY KEY, -- Identificador único del registro de auditoría

    -- Foreign Keys
    user_id BIGINT NOT NULL,                   -- Usuario que realizó la acción
        CONSTRAINT FK_AuditLog_User 
        FOREIGN KEY (user_id) REFERENCES [User](id_user),

    entitycatalog_id BIGINT NOT NULL,          -- Entidad a la que se accedió
        CONSTRAINT FK_AuditLog_EntityCatalog 
        FOREIGN KEY (entitycatalog_id) REFERENCES EntityCatalog(id_entit),

    permission_id BIGINT NOT NULL,             -- Permiso utilizado para el acceso
        CONSTRAINT FK_AuditLog_Permission 
        FOREIGN KEY (permission_id) REFERENCES Permission(id_permi),

    -- Action Information
    action_type NVARCHAR(50) NOT NULL,        -- Tipo de acción (CREATE, READ, UPDATE, DELETE)
    action_details NVARCHAR(MAX) NULL,        -- Detalles adicionales de la acción

    -- Timestamp
    action_timestamp DATETIME NOT NULL        -- Fecha y hora de la acción
        DEFAULT GETDATE(),

    -- Status
    is_success BIT NOT NULL DEFAULT 1          -- Indica si la acción fue exitosa (1) o fallida (0)
);