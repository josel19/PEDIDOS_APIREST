create database DBPEDIDOS;
go

use DBPEDIDOS;

-- Creación de la tabla Clientes con fecha de creación y estado
CREATE TABLE Clientes (
    ClienteId INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    Correo NVARCHAR(100),
    Telefono NVARCHAR(15),
    FechaCreacion DATETIME2 NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Activo'
);

-- Creación de la tabla Pedidos con fecha de creación y estado
CREATE TABLE Pedidos (
    PedidoId INT PRIMARY KEY IDENTITY(1,1),
    ClienteId INT NOT NULL,
    FechaPedido DATETIME2 NOT NULL,
    MontoTotal DECIMAL(10, 2) NOT NULL,
    FechaCreacion DATETIME2 NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(20) NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (ClienteId) REFERENCES Clientes(ClienteId)
);

-- Creación de la tabla DetallesPedido
CREATE TABLE DetallesPedido (
    DetallePedidoId INT PRIMARY KEY IDENTITY(1,1),
    PedidoId INT NOT NULL,
    NombreProducto NVARCHAR(100) NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,
    FechaCreacion DATETIME2 NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (PedidoId) REFERENCES Pedidos(PedidoId)
);

-- Insertando datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, Correo, Telefono) VALUES 
('Juan', 'Pérez', 'juan.perez@example.com', '1234567890'),
('Ana', 'López', 'ana.lopez@example.com', '0987654321');

-- Insertando datos en la tabla Pedidos
INSERT INTO Pedidos (ClienteId, FechaPedido, MontoTotal, Estado) VALUES 
(1, '2024-09-10', 150.00, 'Completado'),
(2, '2024-09-11', 200.00, 'Pendiente');

-- Insertando datos en la tabla DetallesPedido
INSERT INTO DetallesPedido (PedidoId, NombreProducto, Cantidad, PrecioUnitario) VALUES 
(1, 'Producto A', 2, 50.00),
(1, 'Producto B', 1, 50.00),
(2, 'Producto C', 4, 50.00);
GO

-- Crear un nuevo cliente
CREATE PROCEDURE spCrearCliente
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15)
AS
BEGIN
    INSERT INTO Clientes (Nombre, Apellido, Correo, Telefono)
    VALUES (@Nombre, @Apellido, @Correo, @Telefono);
END;
GO

-- Leer todos los clientes
CREATE PROCEDURE spLeerClientes
AS
BEGIN
    SELECT * FROM Clientes WHERE Estado = 'Activo';
END;
GO

-- Leer un cliente por su ID
CREATE PROCEDURE spLeerClientePorId
    @ClienteId INT
AS
BEGIN
    SELECT * FROM Clientes WHERE ClienteId = @ClienteId AND Estado = 'Activo';
END;
GO

-- Actualizar un cliente
CREATE PROCEDURE spActualizarCliente
    @ClienteId INT,
    @Nombre NVARCHAR(50),
    @Apellido NVARCHAR(50),
    @Correo NVARCHAR(100),
    @Telefono NVARCHAR(15)
AS
BEGIN
    UPDATE Clientes
    SET Nombre = @Nombre,
        Apellido = @Apellido,
        Correo = @Correo,
        Telefono = @Telefono
    WHERE ClienteId = @ClienteId AND Estado = 'Activo';
END;
GO

-- Eliminar (desactivar) un cliente
CREATE PROCEDURE spEliminarCliente
    @ClienteId INT
AS
BEGIN
    UPDATE Clientes
    SET Estado = 'Inactivo'
    WHERE ClienteId = @ClienteId;
END;
GO

-- Crear un nuevo pedido
CREATE PROCEDURE spCrearPedido
    @ClienteId INT,
    @FechaPedido DATETIME2,
    @MontoTotal DECIMAL(10, 2),
    @Estado NVARCHAR(20) = 'Pendiente'
AS
BEGIN
    INSERT INTO Pedidos (ClienteId, FechaPedido, MontoTotal, Estado)
    VALUES (@ClienteId, @FechaPedido, @MontoTotal, @Estado);
END;
GO

-- Leer todos los pedidos
CREATE PROCEDURE spLeerPedidos
AS
BEGIN
    SELECT * FROM Pedidos;
END;
GO

-- Leer un pedido por su ID
CREATE PROCEDURE spLeerPedidoPorId
    @PedidoId INT
AS
BEGIN
    SELECT * FROM Pedidos WHERE PedidoId = @PedidoId;
END;
GO

-- Actualizar un pedido
CREATE PROCEDURE spActualizarPedido
    @PedidoId INT,
    @FechaPedido DATETIME2,
    @MontoTotal DECIMAL(10, 2),
    @Estado NVARCHAR(20)
AS
BEGIN
    UPDATE Pedidos
    SET FechaPedido = @FechaPedido,
        MontoTotal = @MontoTotal,
        Estado = @Estado
    WHERE PedidoId = @PedidoId;
END;
GO

-- Eliminar (cancelar) un pedido
CREATE PROCEDURE EliminarPedido
    @PedidoId INT
AS
BEGIN
    UPDATE Pedidos
    SET Estado = 'Cancelado'
    WHERE PedidoId = @PedidoId;
END;
GO

-- Crear un nuevo detalle de pedido
CREATE PROCEDURE spCrearDetallePedido
    @PedidoId INT,
    @NombreProducto NVARCHAR(100),
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO DetallesPedido (PedidoId, NombreProducto, Cantidad, PrecioUnitario)
    VALUES (@PedidoId, @NombreProducto, @Cantidad, @PrecioUnitario);
END;
GO

-- Leer todos los detalles de un pedido por el ID del pedido
CREATE PROCEDURE spLeerDetallesPedidoPorPedidoId
    @PedidoId INT
AS
BEGIN
    SELECT * FROM DetallesPedido WHERE PedidoId = @PedidoId;
END;
GO

-- Actualizar un detalle de pedido
CREATE PROCEDURE spActualizarDetallePedido
    @DetallePedidoId INT,
    @NombreProducto NVARCHAR(100),
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10, 2)
AS
BEGIN
    UPDATE DetallesPedido
    SET NombreProducto = @NombreProducto,
        Cantidad = @Cantidad,
        PrecioUnitario = @PrecioUnitario
    WHERE DetallePedidoId = @DetallePedidoId;
END;
GO

-- Eliminar un detalle de pedido
CREATE PROCEDURE spEliminarDetallePedido
    @DetallePedidoId INT
AS
BEGIN
    DELETE FROM DetallesPedido WHERE DetallePedidoId = @DetallePedidoId;
END;
GO



