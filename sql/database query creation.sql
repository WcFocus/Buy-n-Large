CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Roles (
    RolID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Permisos (
    PermisoID INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE UsuarioRol (
    UsuarioID INT,
    RolID INT,
    PRIMARY KEY (UsuarioID, RolID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (RolID) REFERENCES Roles(RolID)
);

CREATE TABLE RolPermiso (
    RolID INT,
    PermisoID INT,
    PRIMARY KEY (RolID, PermisoID),
    FOREIGN KEY (RolID) REFERENCES Roles(RolID),
    FOREIGN KEY (PermisoID) REFERENCES Permisos(PermisoID)
);

CREATE TABLE PermisoTabla (
    PermisoID INT,
    TablaNombre NVARCHAR(100) NOT NULL,
    PRIMARY KEY (PermisoID, TablaNombre),
    FOREIGN KEY (PermisoID) REFERENCES Permisos(PermisoID)
);

CREATE TABLE PermisoRegistro (
    PermisoID INT,
    TablaNombre NVARCHAR(100) NOT NULL,
    RegistroID INT NOT NULL,
    PRIMARY KEY (PermisoID, TablaNombre, RegistroID),
    FOREIGN KEY (PermisoID) REFERENCES Permisos(PermisoID)
);



-- Insertar roles
INSERT INTO Roles (Nombre) VALUES ('Supervisor'), ('Gerente'), ('Administrador');

-- Insertar permisos
INSERT INTO Permisos (Nombre) VALUES ('VerEmpleados'), ('VerPagos'), ('VerTodosPagos'), ('VerDatosPersonales');

-- Asignar permisos a roles
INSERT INTO RolPermiso (RolID, PermisoID) VALUES 
(1, 1), -- Supervisor puede VerEmpleados
(2, 1), -- Gerente puede VerEmpleados
(2, 2), -- Gerente puede VerPagos
(3, 3), -- Administrador puede VerTodosPagos
(3, 4); -- Administrador puede VerDatosPersonales

-- Asignar permisos a tablas
INSERT INTO PermisoTabla (PermisoID, TablaNombre) VALUES 
(1, 'Empleados'), -- VerEmpleados aplica a la tabla Empleados
(2, 'Pagos'),     -- VerPagos aplica a la tabla Pagos
(3, 'Pagos'),     -- VerTodosPagos aplica a la tabla Pagos
(4, 'Empleados'); -- VerDatosPersonales aplica a la tabla Empleados

-- Asignar permisos a registros específicos
INSERT INTO PermisoRegistro (PermisoID, TablaNombre, RegistroID) VALUES 
(1, 'Empleados', 1), -- Supervisor puede ver el empleado con ID 1
(2, 'Pagos', 1);     -- Gerente puede ver el pago con ID 1



CREATE VIEW VW_Empleados AS
SELECT e.*
FROM Empleados e
WHERE EXISTS (
    SELECT 1
    FROM UsuarioRol ur
    JOIN RolPermiso rp ON ur.RolID = rp.RolID
    JOIN PermisoTabla pt ON rp.PermisoID = pt.PermisoID
    WHERE ur.UsuarioID = CURRENT_USER_ID() -- Función que obtiene el ID del usuario actual
    AND pt.TablaNombre = 'Empleados'
    AND (pt.PermisoID = 1 OR pt.PermisoID = 4) -- VerEmpleados o VerDatosPersonales
);