/*
Permiso de Usuario.

Representa los permisos específicos asignados a un usuario para una 
entidad particular dentro de una compañía.

¿Para qué sirve?:

1. Asignación de permisos específicos por usuario y entidad.

2. Control granular de accesos a nivel de usuario-compañía.

3. Personalización de capacidades por entidad del sistema.

4. Gestión detallada de privilegios por usuario.

5. Implementación de políticas de seguridad específicas por entidad.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create PermiUser Table
CREATE TABLE PermiUser (
    -- Primary Key
    id_peusr BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso de usuario
    
    -- Foreign Keys
    usercompany_id BIGINT NOT NULL                            -- Relación usuario-compañía a la que se asigna el permiso
        CONSTRAINT FK_PermiUser_UserCompany 
        FOREIGN KEY REFERENCES UserCompany(id_useco),
        
    permission_id BIGINT NOT NULL                             -- Permiso asignado al usuario
        CONSTRAINT FK_PermiUser_Permission 
        FOREIGN KEY REFERENCES Permission(id_permi),
        
    entitycatalog_id BIGINT NOT NULL                          -- Entidad sobre la que se aplica el permiso
        CONSTRAINT FK_PermiUser_EntityCatalog 
        FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    
    -- Permission Configuration
    peusr_include BIT NOT NULL DEFAULT 1,                     -- Indica si el permiso se incluye (1) o se excluye (0) para el usuario
    
    -- Unique constraint for user-company, permission and entity catalog combination
    CONSTRAINT UQ_UserCompany_Permission_Entity 
        UNIQUE (usercompany_id, permission_id, entitycatalog_id)
);