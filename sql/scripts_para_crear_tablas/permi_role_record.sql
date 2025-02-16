/*
Permiso por Rol y Registro.

Representa los permisos específicos asignados a un rol para una 
entidad y registro particular dentro del sistema.

¿Para qué sirve?:

1. Asignación de permisos específicos por rol, entidad y registro.

2. Control granular de accesos a nivel de rol y registro.

3. Personalización de capacidades por entidad y registro del sistema.

4. Gestión detallada de privilegios por rol y registro específico.

5. Implementación de políticas de seguridad específicas por rol, entidad y registro.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create PermiRoleRecord Table
CREATE TABLE PermiRoleRecord (
    -- Primary Key
    id_perrc BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso de rol por registro
    
    -- Foreign Keys
    role_id BIGINT NOT NULL                                   -- Rol al que se asigna el permiso
        CONSTRAINT FK_PermiRoleRecord_Role 
        FOREIGN KEY REFERENCES Role(id_role),
        
    permission_id BIGINT NOT NULL                             -- Permiso asignado al rol
        CONSTRAINT FK_PermiRoleRecord_Permission 
        FOREIGN KEY REFERENCES Permission(id_permi),
        
    entitycatalog_id BIGINT NOT NULL                          -- Entidad sobre la que se aplica el permiso
        CONSTRAINT FK_PermiRoleRecord_EntityCatalog 
        FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    
    -- Record Specific Information
    perrc_record BIGINT NOT NULL,                             -- Identificador del registro específico al que se aplica el permiso
    
    -- Permission Configuration
    perrc_include BIT NOT NULL DEFAULT 1,                     -- Indica si el permiso se incluye (1) o se excluye (0) para el rol y registro
    
    -- Unique constraint for role, permission, entity catalog and record combination
    CONSTRAINT UQ_Role_Permission_Entity_Record 
        UNIQUE (role_id, permission_id, entitycatalog_id, perrc_record)
);