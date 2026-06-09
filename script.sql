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
