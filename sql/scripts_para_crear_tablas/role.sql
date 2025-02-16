/*
Rol.

Un rol representa un conjunto de permisos y responsabilidades que pueden
ser asignados a usuarios dentro de una compañía específica.

¿Para qué sirve?:

1. Definición de niveles de acceso y permisos por compañía.

2. Agrupación de funcionalidades y accesos para asignación eficiente.

3. Control granular de las capacidades de los usuarios en el sistema.

4. Simplificación de la gestión de permisos por grupos de usuarios.

5. Estandarización de roles y responsabilidades dentro de cada compañía.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create Role Table
CREATE TABLE Role (
    -- Primary Key
    id_role BIGINT IDENTITY(1,1) PRIMARY KEY,                 -- Identificador único para el rol
    
    -- Foreign Keys
    company_id BIGINT NOT NULL                                -- Compañía a la que pertenece este rol
        CONSTRAINT FK_Role_Company 
        FOREIGN KEY REFERENCES Company(id_compa),
    
    -- Basic Information
    role_name NVARCHAR(255) NOT NULL,                         -- Nombre descriptivo del rol
    role_code NVARCHAR(255) NOT NULL,                         -- Código del rol (agregado basado en unique_together)
    role_description NVARCHAR(MAX) NULL,                      -- Descripción detallada del rol y sus responsabilidades
    
    -- Status
    role_active BIT NOT NULL DEFAULT 1,                       -- Indica si el rol está activo (1) o inactivo (0)
    
    -- Unique constraint for company and role code combination
    CONSTRAINT UQ_Company_RoleCode UNIQUE (company_id, role_code)
);