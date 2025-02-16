/*
Permiso de Usuario con Registro.

Representa los permisos específicos asignados a un usuario para una 
entidad particular y un registro específico dentro de una compañía.

¿Para qué sirve?:

1. Asignación de permisos específicos por usuario y entidad a nivel de registro.

2. Control granular de accesos a nivel de usuario-compañía y registro.

3. Personalización de capacidades por entidad y registro del sistema.

4. Gestión detallada de privilegios por usuario a nivel de registro.

5. Implementación de políticas de seguridad específicas por entidad y registro.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create PermiUserRecord Table
CREATE TABLE PermiUserRecord (
    -- Primary Key
    id_peusr BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso de usuario
    
    -- Foreign Keys
    usercompany_id BIGINT NOT NULL                            -- Relación usuario-compañía a la que se asigna el permiso
        CONSTRAINT FK_PermiUserRecord_UserCompany 
        FOREIGN KEY REFERENCES UserCompany(id_useco),
        
    permission_id BIGINT NOT NULL                             -- Permiso asignado al usuario
        CONSTRAINT FK_PermiUserRecord_Permission 
        FOREIGN KEY REFERENCES Permission(id_permi),
        
    entitycatalog_id BIGINT NOT NULL                          -- Entidad sobre la que se aplica el permiso
        CONSTRAINT FK_PermiUserRecord_EntityCatalog 
        FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    
    -- Record Specific Information
    peusr_record BIGINT NOT NULL,                             -- Identificador del registro específico de la entidad al que aplica el permiso
    
    -- Permission Configuration
    peusr_include BIT NOT NULL DEFAULT 1,                     -- Indica si el permiso se incluye (1) o se excluye (0) para el usuario
    
    -- Unique constraint for user-company, permission, entity catalog and record combination
    CONSTRAINT UQ_UserCompany_Permission_Entity_Record 
        UNIQUE (usercompany_id, permission_id, entitycatalog_id, peusr_record)
);