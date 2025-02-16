/*
Centro de Costo.

Un centro de costo representa una unidad organizacional dentro de una empresa
que permite agrupar y controlar costos específicos.

¿Para qué sirve?:

1. Gestión y control de costos por unidad organizativa.

2. Seguimiento detallado de gastos y presupuestos por área.

3. Análisis de rentabilidad por centro de responsabilidad.

4. Facilitación de la toma de decisiones basada en costos.

5. Implementación de estructuras jerárquicas para el control de costos.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create CostCenter Table
CREATE TABLE CostCenter (
    -- Primary Key
    id_cosce BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para el centro de costo
    
    -- Foreign Keys
    company_id BIGINT NOT NULL                                -- Compañía a la que pertenece este centro de costo
        CONSTRAINT FK_CostCenter_Company 
        FOREIGN KEY REFERENCES Company(id_compa),
    
    cosce_parent_id BIGINT NULL                               -- Centro de costo superior en la jerarquía organizacional
        CONSTRAINT FK_CostCenter_Parent 
        FOREIGN KEY REFERENCES CostCenter(id_cosce),
    
    -- Basic Information
    cosce_code NVARCHAR(255) NOT NULL,                        -- Código único que identifica el centro de costo
    cosce_name NVARCHAR(255) NOT NULL,                        -- Nombre descriptivo del centro de costo
    cosce_description NVARCHAR(MAX) NULL,                     -- Descripción detallada del centro de costo y su propósito
    
    -- Financial Information
    cosce_budget DECIMAL(15,2) NOT NULL DEFAULT 0,            -- Presupuesto asignado al centro de costo
    
    -- Hierarchical Information
    cosce_level SMALLINT NOT NULL DEFAULT 1                   -- Nivel en la jerarquía de centros de costo (1 para nivel superior)
        CONSTRAINT CK_CostCenter_Level 
        CHECK (cosce_level > 0),
    
    -- Status
    cosce_active BIT NOT NULL DEFAULT 1,                      -- Indica si el centro de costo está activo (1) o inactivo (0)
    
    -- Unique constraint for company and cost center code combination
    CONSTRAINT UQ_Company_CostCenterCode UNIQUE (company_id, cosce_code)
);