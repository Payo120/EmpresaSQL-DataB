-- =======================================================
-- Parte I. Creación de Base de Datos y Tablas (DDL)
-- =======================================================
CREATE DATABASE EmpresaSQL;
GO

USE EmpresaSQL;
GO

CREATE TABLE TDepartamento (
    nDepartamentoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreDepartamento VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE TCargo (
    nCargoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreCargo VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE TEmpleado (
    nEmpleadoID INT IDENTITY(1,1) PRIMARY KEY,
    cNIF VARCHAR(20) UNIQUE,
    cNombre VARCHAR(50),
    cApellido VARCHAR(50),
    nDepartamentoID INT,
    nCargoID INT,
    dFechaContratacion DATE DEFAULT GETDATE(),
    nSalario DECIMAL(10,2) CHECK (nSalario > 300)
);

ALTER TABLE TEmpleado 
    ADD CONSTRAINT FK_Empleado_Departamento FOREIGN KEY (nDepartamentoID) REFERENCES TDepartamento(nDepartamentoID);
ALTER TABLE TEmpleado 
    ADD CONSTRAINT FK_Empleado_Cargo FOREIGN KEY (nCargoID) REFERENCES TCargo(nCargoID);

CREATE TABLE TProyecto (
    nProyectoID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreProyecto VARCHAR(100) NOT NULL,
    dFechaInicio DATE NOT NULL,
    dFechaFinalizacion DATE
);

CREATE TABLE TEmpleadoProyecto (
    nEmpleadoID INT,
    nProyectoID INT,
    PRIMARY KEY (nEmpleadoID, nProyectoID),
    CONSTRAINT FK_TEmpProy_Empleado FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID),
    CONSTRAINT FK_TEmpProy_Proyecto FOREIGN KEY (nProyectoID) REFERENCES TProyecto(nProyectoID)
);
-- =======================================================
-- Parte II. Modificación de Estructuras (ALTER)
-- =======================================================
ALTER TABLE TEmpleado ADD cEmail VARCHAR(100);
ALTER TABLE TEmpleado ADD cTelefono VARCHAR(15);

ALTER TABLE TEmpleado ALTER COLUMN cNombre VARCHAR(100);
ALTER TABLE TEmpleado ALTER COLUMN cApellido VARCHAR(100);

ALTER TABLE TEmpleado ADD cDireccion VARCHAR(200);
ALTER TABLE TEmpleado ADD nEdad INT;
ALTER TABLE TEmpleado ADD CONSTRAINT CHK_Edad CHECK (nEdad BETWEEN 18 AND 65);

ALTER TABLE TEmpleado ADD CONSTRAINT UQ_Email UNIQUE (cEmail);
ALTER TABLE TEmpleado ADD bActivo BIT DEFAULT 1;

ALTER TABLE TEmpleado DROP COLUMN cDireccion;
ALTER TABLE TEmpleado ALTER COLUMN cTelefono VARCHAR(20);

ALTER TABLE TEmpleado ADD cGenero CHAR(1);
ALTER TABLE TEmpleado ADD CONSTRAINT CHK_Genero CHECK (cGenero IN ('M', 'F'));
ALTER TABLE TEmpleado ADD dFechaNacimiento DATE;

CREATE TABLE TSucursal (
    nSucursalID INT IDENTITY(1,1) PRIMARY KEY,
    cNombreSucursal VARCHAR(100) NOT NULL
);
-- =======================================================
-- Parte III. Inserción de Datos (INSERT)
-- =======================================================
INSERT INTO TDepartamento (cNombreDepartamento) 
VALUES ('Recursos Humanos'), ('Ventas'), ('TI'), ('Marketing'), ('Finanzas');

INSERT INTO TCargo (cNombreCargo) 
VALUES ('Gerente'), ('Analista'), ('Desarrollador'), ('Asistente'), ('Director');

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nDepartamentoID, nCargoID, nSalario, cEmail, nEdad, cGenero) VALUES 
('001A', 'Juan', 'Perez', 3, 3, 1200.00, 'juan@empresa.com', 28, 'M'),
('002B', 'Ana', 'Gomez', 1, 1, 2000.00, 'ana@empresa.com', 35, 'F'),
('003C', 'Luis', 'Martinez', 2, 2, 800.00, 'luis@empresa.com', 24, 'M'),
('004D', 'Maria', 'Garcia', 4, 4, 600.00, 'maria@empresa.com', 22, 'F'),
('005E', 'Carlos', 'Lopez', 5, 5, 2500.00, 'carlos@empresa.com', 45, 'M'),
('006F', 'Laura', 'Guzman', 3, 3, 1300.00, 'laura@empresa.com', 29, 'F'),
('007G', 'Pedro', 'Ruiz', 2, 1, 1900.00, 'pedro@empresa.com', 38, 'M'),
('008H', 'Sofia', 'Hernandez', 1, 4, 550.00, 'sofia@empresa.com', 21, 'F'),
('009I', 'Miguel', 'Garrido', 3, 2, 900.00, 'miguel@empresa.com', 26, 'M'),
('010J', 'Elena', 'Diaz', 4, 2, 850.00, 'elena@empresa.com', 27, 'F');

INSERT INTO TProyecto (cNombreProyecto, dFechaInicio, dFechaFinalizacion) VALUES 
('Sistema Web', '2023-01-10', '2023-06-15'),
('Campaña Anual', '2023-02-01', NULL),
('Auditoría', '2023-03-15', '2023-04-20');

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES 
(1, 1), (6, 1), (9, 1), 
(4, 2), (10, 2),        
(2, 3), (5, 3);         

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario) 
VALUES ('011K', 'Jorge', 'Mendez', 700.00);

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario, cEmail) 
VALUES ('012L', 'Rosa', 'Vargas', 750.00, 'rosa.vargas@empresa.com');

INSERT INTO TEmpleado (cNIF, cNombre, cApellido, nSalario) 
VALUES ('013M', 'David', 'Suarez', 650.00);

INSERT INTO TSucursal (cNombreSucursal) 
VALUES ('Sucursal Norte'), ('Sucursal Sur'), ('Sucursal Centro');
