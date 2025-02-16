/*
Permiso por Rol.

Representa los permisos específicos asignados a un rol para una 
entidad particular dentro del sistema.

¿Para qué sirve?:

1. Asignación de permisos específicos por rol y entidad.

2. Control granular de accesos a nivel de rol.

3. Personalización de capacidades por entidad del sistema.

4. Gestión detallada de privilegios por rol.

5. Implementación de políticas de seguridad específicas por rol y entidad.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create PermiRole Table
CREATE TABLE PermiRole (
    -- Primary Key
    id_perol BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso de rol
    
    -- Foreign Keys
    role_id BIGINT NOT NULL                                   -- Rol al que se asigna el permiso
        CONSTRAINT FK_PermiRole_Role 
        FOREIGN KEY REFERENCES Role(id_role),
        
    permission_id BIGINT NOT NULL                             -- Permiso asignado al rol
        CONSTRAINT FK_PermiRole_Permission 
        FOREIGN KEY REFERENCES Permission(id_permi),
        
    entitycatalog_id BIGINT NOT NULL                          -- Entidad sobre la que se aplica el permiso
        CONSTRAINT FK_PermiRole_EntityCatalog 
        FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    
    -- Permission Configuration
    perol_include BIT NOT NULL DEFAULT 1,                     -- Indica si el permiso se incluye (1) o se excluye (0) para el rol
    perol_record BIGINT NULL,                                 -- Campo mencionado en unique_together pero no en el modelo
    
    -- Unique constraint for role, permission, entity catalog, and record combination
    CONSTRAINT UQ_Role_Permission_Entity_Record 
        UNIQUE (role_id, permission_id, entitycatalog_id, perol_record)
);