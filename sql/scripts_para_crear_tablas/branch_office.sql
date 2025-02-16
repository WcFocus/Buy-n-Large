/*
Sucursal.

Una sucursal representa un establecimiento físico o punto de operación 
que pertenece a una compañía específica.

¿Para qué sirve?:

1. Gestión y control de múltiples ubicaciones de una misma empresa.

2. Organización de operaciones por punto de venta o servicio.

3. Seguimiento y análisis de desempeño por sucursal.

4. Asignación y control de recursos específicos por ubicación.

5. Facilitar la gestión descentralizada de operaciones empresariales.

Creado por:
@Claude Assistant

Fecha: 27/10/2024
*/

-- Create BranchOffice Table
CREATE TABLE BranchOffice (
    -- Primary Key
    id_broff BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la sucursal

    -- Company Reference
    company_id BIGINT NOT NULL                                -- Compañía a la que pertenece esta sucursal
        CONSTRAINT FK_BranchOffice_Company 
        FOREIGN KEY REFERENCES Company(id_compa),
    
    -- Branch Office Information
    broff_name NVARCHAR(255) NOT NULL,                        -- Nombre descriptivo de la sucursal
    broff_code NVARCHAR(255) NOT NULL,                        -- Código único que identifica la sucursal dentro de la empresa
    
    -- Location Information
    broff_address NVARCHAR(255) NOT NULL,                     -- Dirección física de la sucursal
    broff_city NVARCHAR(255) NOT NULL,                        -- Ciudad donde está ubicada la sucursal
    broff_state NVARCHAR(255) NOT NULL,                       -- Departamento o estado donde está ubicada la sucursal
    broff_country NVARCHAR(255) NOT NULL,                     -- País donde está ubicada la sucursal
    
    -- Contact Information
    broff_phone NVARCHAR(255) NOT NULL,                       -- Número de teléfono de la sucursal
    broff_email NVARCHAR(255) NOT NULL,                       -- Dirección de correo electrónico de la sucursal
    
    -- Status
    broff_active BIT NOT NULL DEFAULT 1,                      -- Indica si la sucursal está activa (1) o inactiva (0)

    -- Unique constraint for company and branch code combination
    CONSTRAINT UQ_Company_BranchCode UNIQUE (company_id, broff_code)
);