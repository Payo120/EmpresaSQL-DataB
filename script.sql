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
