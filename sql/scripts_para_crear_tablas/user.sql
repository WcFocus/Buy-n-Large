/*
Usuario.

Un usuario representa una persona que interactúa con el sistema,
con sus credenciales y datos básicos de acceso.

¿Para qué sirve?:

1. Gestión de acceso y autenticación en el sistema.

2. Almacenamiento de información básica de los usuarios.

3. Control de estados y permisos de usuarios.

4. Seguimiento de actividad y auditoría de usuarios.

5. Base para la personalización de la experiencia de usuario.

Creado por:
@Claudio

Fecha: 27/10/2024
*/

-- Create User Table
CREATE TABLE [User] (
    -- Primary Key
    id_user BIGINT IDENTITY(1,1) PRIMARY KEY,                 -- Identificador único para el usuario
    
    -- Authentication Information
    user_username NVARCHAR(255) NOT NULL,                     -- Nombre de usuario para iniciar sesión
    user_password NVARCHAR(255) NOT NULL,                     -- Contraseña encriptada del usuario
    
    -- Contact Information
    user_email NVARCHAR(255) NOT NULL,                        -- Dirección de correo electrónico del usuario
    user_phone NVARCHAR(255) NULL,                            -- Número de teléfono del usuario
    
    -- Access Control
    user_is_admin BIT NOT NULL DEFAULT 0,                     -- Indica si el usuario es Administrador (1) o normal (0)
    user_is_active BIT NOT NULL DEFAULT 1,                    -- Indica si el usuario está activo (1) o inactivo (0)
    
    -- Unique Constraints
    CONSTRAINT UQ_User_Username UNIQUE (user_username),
    CONSTRAINT UQ_User_Email UNIQUE (user_email)
);