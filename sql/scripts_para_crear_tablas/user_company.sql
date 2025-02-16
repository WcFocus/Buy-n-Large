/*
Usuario por Compañía.

Representa la relación entre un usuario y una compañía, permitiendo gestionar
el acceso de usuarios a múltiples compañías en el sistema.

¿Para qué sirve?:

1. Gestión de permisos de usuarios por compañía.

2. Control de acceso multiempresa para cada usuario.

3. Seguimiento de actividades de usuarios por compañía.

4. Configuración de preferencias específicas por usuario y compañía.

5. Soporte para roles y responsabilidades diferentes en cada compañía.

Creado por:
@Claudio 

Fecha: 27/10/2024
*/

-- Create UserCompany Table
CREATE TABLE UserCompany (
    -- Primary Key
    id_useco BIGINT IDENTITY(1,1) PRIMARY KEY,                -- Identificador único para la relación usuario-compañía
    
    -- Foreign Keys
    user_id BIGINT NOT NULL                                   -- Usuario asociado a la compañía
        CONSTRAINT FK_UserCompany_User 
        FOREIGN KEY REFERENCES [User](id_user),
    
    company_id BIGINT NOT NULL                                -- Compañía asociada al usuario
        CONSTRAINT FK_UserCompany_Company 
        FOREIGN KEY REFERENCES Company(id_compa),
    
    -- Status
    useco_active BIT NOT NULL DEFAULT 1,                      -- Indica si la relación usuario-compañía está activa (1) o inactiva (0)
    
    -- Unique constraint for user and company combination
    CONSTRAINT UQ_User_Company UNIQUE (user_id, company_id)
);