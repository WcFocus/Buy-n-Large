/*
Catálogo de Entidades.

Un catálogo de entidades representa una tabla que almacena todas las entidades 
(modelos) disponibles en el sistema Django, facilitando su gestión y referencia.

¿Para qué sirve?:

1. Mantener un registro centralizado de todas las entidades del sistema.

2. Facilitar la gestión y el mantenimiento de la estructura de la base de datos.

3. Permitir la referencia dinámica a diferentes modelos del sistema.

4. Proveer una base para la implementación de funcionalidades genéricas.

5. Apoyar en la documentación y organización del sistema.

Creado por:
@Claudio

Fecha: 27/9/2024
*/

-- Create EntityCatalog Table
CREATE TABLE EntityCatalog (
    -- Primary Key
    id_entit BIGINT IDENTITY(1,1) PRIMARY KEY,                    -- Identificador único para el elemento del catálogo de entidades
    
    -- Entity Information
    entit_name NVARCHAR(255) NOT NULL UNIQUE,                  -- Nombre del modelo Django asociado
    entit_descrip NVARCHAR(255) NOT NULL,                      -- Descripción del elemento del catálogo de entidades
    
    -- Status
    entit_active BIT NOT NULL DEFAULT 1,                       -- Indica si el elemento del catálogo está activo (1) o inactivo (0)
    
    -- Configuration
    entit_config NVARCHAR(MAX) NULL                           -- Configuración adicional para el elemento del catálogo
);