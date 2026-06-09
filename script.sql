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
-- =======================================================
-- Parte IV. Actualización de Datos (UPDATE)
-- =======================================================
UPDATE TEmpleado SET nSalario = nSalario * 1.10;

UPDATE TEmpleado SET nSalario = nSalario * 1.20 WHERE nDepartamentoID = 3;

UPDATE TEmpleado SET cEmail = 'jorge.m@empresa.com' WHERE nEmpleadoID = 11;

UPDATE TEmpleado SET nCargoID = 1 WHERE nEmpleadoID = 3;

UPDATE TEmpleado SET nDepartamentoID = 2 WHERE nEmpleadoID IN (4, 8);

UPDATE TEmpleado SET bActivo = 0 WHERE nSalario < 500;

UPDATE TProyecto SET dFechaFinalizacion = '2023-12-31' WHERE nProyectoID = 2;

INSERT INTO TEmpleadoProyecto (nEmpleadoID, nProyectoID) VALUES (3, 2);

-- =======================================================
-- Parte V. Eliminación de Datos (DELETE)
-- =======================================================
DELETE FROM TEmpleado WHERE cNIF = '013M';

DELETE FROM TEmpleado WHERE bActivo = 0;

DELETE FROM TEmpleadoProyecto WHERE nProyectoID = 3;
DELETE FROM TProyecto WHERE nProyectoID = 3;

DELETE FROM TEmpleadoProyecto WHERE nEmpleadoID = 6;

INSERT INTO TDepartamento (cNombreDepartamento) VALUES ('Logística');
DELETE FROM TDepartamento WHERE nDepartamentoID NOT IN (SELECT ISNULL(nDepartamentoID, 0) FROM TEmpleado);

-- =======================================================
-- Parte VI. Consultas de Verificación
-- =======================================================
SELECT * FROM TEmpleado ORDER BY cApellido ASC;

SELECT * FROM TEmpleado WHERE nSalario > 1000;

SELECT * FROM TEmpleado WHERE bActivo = 1;

SELECT * FROM TEmpleado WHERE YEAR(dFechaContratacion) = YEAR(GETDATE());

SELECT E.cNombre, E.cApellido, D.cNombreDepartamento 
FROM TEmpleado E
LEFT JOIN TDepartamento D ON E.nDepartamentoID = D.nDepartamentoID;

SELECT E.cNombre, E.cApellido, C.cNombreCargo 
FROM TEmpleado E
LEFT JOIN TCargo C ON E.nCargoID = C.nCargoID;

SELECT DISTINCT E.cNombre, E.cApellido 
FROM TEmpleado E
INNER JOIN TEmpleadoProyecto EP ON E.nEmpleadoID = EP.nEmpleadoID;

SELECT D.cNombreDepartamento, COUNT(E.nEmpleadoID) AS CantidadEmpleados
FROM TDepartamento D
LEFT JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;

SELECT D.cNombreDepartamento, AVG(E.nSalario) AS SalarioPromedio
FROM TDepartamento D
INNER JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;

SELECT D.cNombreDepartamento, MAX(E.nSalario) AS SalarioMaximo, MIN(E.nSalario) AS SalarioMinimo
FROM TDepartamento D
INNER JOIN TEmpleado E ON D.nDepartamentoID = E.nDepartamentoID
GROUP BY D.cNombreDepartamento;

SELECT P.cNombreProyecto, COUNT(EP.nEmpleadoID) AS TotalEmpleados
FROM TProyecto P
INNER JOIN TEmpleadoProyecto EP ON P.nProyectoID = EP.nProyectoID
GROUP BY P.cNombreProyecto
HAVING COUNT(EP.nEmpleadoID) > 2;

SELECT * FROM TEmpleado WHERE cApellido LIKE 'G%';

SELECT * FROM TEmpleado ORDER BY nSalario DESC;

SELECT TOP 3 * FROM TEmpleado ORDER BY nSalario DESC;

SELECT * FROM TEmpleado WHERE nEdad BETWEEN 25 AND 40;

SELECT COUNT(*) AS TotalActivos FROM TEmpleado WHERE bActivo = 1;

SELECT COUNT(*) AS TotalProyectos FROM TProyecto;

-- =======================================================
-- Parte VII. Administración de Objetos
-- =======================================================
ALTER TABLE TEmpleado DROP CONSTRAINT CHK_Edad;
ALTER TABLE TEmpleado DROP CONSTRAINT UQ_Email;

ALTER TABLE TEmpleado ADD CONSTRAINT CHK_Edad CHECK (nEdad BETWEEN 18 AND 65);
ALTER TABLE TEmpleado ADD CONSTRAINT UQ_Email UNIQUE (cEmail);

-- NOTA: Las sentencias DROP están comentadas para evitar borrar 
-- el trabajo si ejecutas el script completo de una vez.
-- DROP TABLE TEmpleadoProyecto;
-- DROP TABLE TProyecto;
-- DROP TABLE TEmpleado;
-- DROP TABLE TCargo;
-- DROP TABLE TDepartamento;
-- DROP TABLE TSucursal;
-- USE master;
-- DROP DATABASE EmpresaSQL;

-- =======================================================
-- Desafíos Adicionales
-- =======================================================
CREATE TABLE TCliente (
    nClienteID INT IDENTITY(1,1) PRIMARY KEY,
    cRUC VARCHAR(20) UNIQUE NOT NULL,
    cNombre VARCHAR(100) NOT NULL,
    cTelefono VARCHAR(20),
    cEmail VARCHAR(100) UNIQUE,
    cDireccion VARCHAR(200),
    dFechaRegistro DATE DEFAULT GETDATE(),
    bEstado BIT DEFAULT 1
);

CREATE TABLE TVenta (
    nVentaID INT IDENTITY(1,1) PRIMARY KEY,
    nClienteID INT,
    dFechaVenta DATE DEFAULT GETDATE(),
    nMontoTotal DECIMAL(12,2) CHECK (nMontoTotal >= 0),
    CONSTRAINT FK_Venta_Cliente FOREIGN KEY (nClienteID) REFERENCES TCliente(nClienteID)
);

INSERT INTO TCliente (cRUC, cNombre, cEmail) VALUES 
('RUC01', 'Cliente 1', 'c1@mail.com'), ('RUC02', 'Cliente 2', 'c2@mail.com'),
('RUC03', 'Cliente 3', 'c3@mail.com'), ('RUC04', 'Cliente 4', 'c4@mail.com'),
('RUC05', 'Cliente 5', 'c5@mail.com'), ('RUC06', 'Cliente 6', 'c6@mail.com'),
('RUC07', 'Cliente 7', 'c7@mail.com'), ('RUC08', 'Cliente 8', 'c8@mail.com');

INSERT INTO TVenta (nClienteID, dFechaVenta, nMontoTotal) VALUES 
(1, '2023-10-01', 150.50), (2, '2023-10-05', 300.00), (1, '2023-11-10', 500.00),
(3, '2023-11-12', 450.00), (4, '2023-12-01', 1000.00); 

UPDATE TVenta SET nMontoTotal = nMontoTotal * 0.95 WHERE nMontoTotal > 400;

DELETE FROM TCliente WHERE nClienteID NOT IN (SELECT DISTINCT nClienteID FROM TVenta);

SELECT TOP 5 C.cNombre, SUM(V.nMontoTotal) AS TotalComprado
FROM TCliente C
INNER JOIN TVenta V ON C.nClienteID = V.nClienteID
GROUP BY C.cNombre
ORDER BY TotalComprado DESC;

SELECT MONTH(dFechaVenta) AS Mes, YEAR(dFechaVenta) AS Anio, SUM(nMontoTotal) AS TotalVentasMes
FROM TVenta
GROUP BY YEAR(dFechaVenta), MONTH(dFechaVenta)
ORDER BY Anio, Mes;

SELECT C.cNombre, AVG(V.nMontoTotal) AS PromedioCompras
FROM TCliente C
INNER JOIN TVenta V ON C.nClienteID = V.nClienteID
GROUP BY C.cNombre;

ALTER TABLE TVenta ADD nEmpleadoID INT;
ALTER TABLE TVenta ADD CONSTRAINT FK_Venta_Empleado FOREIGN KEY (nEmpleadoID) REFERENCES TEmpleado(nEmpleadoID);

SELECT V.nVentaID, C.cNombre AS Cliente, E.cNombre AS EmpleadoAsesor, V.nMontoTotal, V.dFechaVenta
FROM TVenta V
INNER JOIN TCliente C ON V.nClienteID = C.nClienteID
INNER JOIN TEmpleado E ON V.nEmpleadoID = E.nEmpleadoID;
