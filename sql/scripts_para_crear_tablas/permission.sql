/*
Permiso.

Un permiso representa los diferentes niveles de acceso y operaciones
que pueden realizarse sobre una entidad del sistema.

¿Para qué sirve?:

1. Control granular de acciones sobre entidades del sistema.

2. Definición de permisos específicos para operaciones CRUD.

3. Gestión de capacidades de importación y exportación de datos.

4. Implementación de políticas de seguridad y acceso.

5. Configuración flexible de permisos por funcionalidad.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create Permission Table
CREATE TABLE Permission (
    -- Primary Key
    id_permi BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el permiso
    
    -- Basic Information
    name NVARCHAR(255) NOT NULL,                              -- Nombre descriptivo del permiso
    description NVARCHAR(MAX) NULL,                           -- Descripción detallada del permiso y su propósito
    
    -- CRUD Permissions
    can_create BIT NOT NULL DEFAULT 0,                        -- Permite crear nuevos registros
    can_read BIT NOT NULL DEFAULT 0,                          -- Permite ver registros existentes
    can_update BIT NOT NULL DEFAULT 0,                        -- Permite modificar registros existentes
    can_delete BIT NOT NULL DEFAULT 0,                        -- Permite eliminar registros existentes
    
    -- Data Transfer Permissions
    can_import BIT NOT NULL DEFAULT 0,                        -- Permite importar datos masivamente
    can_export BIT NOT NULL DEFAULT 0                         -- Permite exportar datos del sistema
);