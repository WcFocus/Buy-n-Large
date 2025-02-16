/*
Compañía.

Una compañía representa una entidad empresarial con sus datos de identificación,
ubicación y características principales dentro del sistema ERP.

¿Para qué sirve?:

1. Gestión centralizada de la información básica de las empresas en el sistema.

2. Soporte para operaciones comerciales y administrativas específicas de cada empresa.

3. Cumplimiento de requisitos legales y fiscales relacionados con la identificación empresarial.

4. Base para la configuración de parámetros y políticas específicas de cada empresa.

5. Facilitar la gestión multi-empresa dentro del sistema ERP.

Creado por:
@Claudio

Fecha: 27/9/2024
*/

-- Create Company Table
CREATE TABLE Company (
    -- Primary Key
    id_compa BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la compañía
    
    -- Company Information
    compa_name NVARCHAR(255) NOT NULL,                        -- Nombre legal completo de la compañía
    compa_tradename NVARCHAR(255) NOT NULL,                   -- Nombre comercial o marca de la compañía
    
    -- Document Information
    compa_doctype NVARCHAR(2) NOT NULL                        -- Tipo de documento de identificación de la compañía
        CONSTRAINT CK_Company_DocType 
        CHECK (compa_doctype IN ('NI', 'CC', 'CE', 'PP', 'OT')),
    compa_docnum NVARCHAR(255) NOT NULL,                      -- Número de identificación fiscal o documento legal de la compañía
    
    -- Location Information
    compa_address NVARCHAR(255) NOT NULL,                     -- Dirección física de la compañía
    compa_city NVARCHAR(255) NOT NULL,                        -- Ciudad donde está ubicada la compañía
    compa_state NVARCHAR(255) NOT NULL,                       -- Departamento o estado donde está ubicada la compañía
    compa_country NVARCHAR(255) NOT NULL,                     -- País donde está ubicada la compañía
    
    -- Contact Information
    compa_industry NVARCHAR(255) NOT NULL,                    -- Sector industrial al que pertenece la compañía
    compa_phone NVARCHAR(255) NOT NULL,                       -- Número de teléfono principal de la compañía
    compa_email NVARCHAR(255) NOT NULL,                       -- Dirección de correo electrónico principal de la compañía
    compa_website NVARCHAR(255) NULL,                         -- Sitio web oficial de la compañía
    
    -- Media
    compa_logo NVARCHAR(MAX) NULL,                           -- Logo oficial de la compañía
    
    -- Status
    compa_active BIT NOT NULL DEFAULT 1                       -- Indica si la compañía está activa (1) o inactiva (0)
);