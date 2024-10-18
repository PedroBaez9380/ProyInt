--Comandos de definicion de la BD
CREATE DATABASE BookKeeperDB;

--Comandos de pais
CREATE TABLE Pais (
    ID_pais TINYINT IDENTITY(1,1) PRIMARY KEY,
    Nombre_pais NVARCHAR(100) NOT NULL -- 
);

CREATE TABLE Estado (
    ID_estado TINYINT IDENTITY(1,1) PRIMARY KEY,
    Nombre_estado NVARCHAR(100) NOT NULL, 
    ID_pais TINYINT FOREIGN KEY REFERENCES Pais(ID_pais)
);

CREATE TABLE Municipio (
    ID_municipio TINYINT IDENTITY(1,1) PRIMARY KEY,
    Nombre_municipio NVARCHAR(100) NOT NULL, 
    ID_estado TINYINT FOREIGN KEY REFERENCES Estado(ID_estado) 
);

-------------------------------------------------------Comandos de la empresa-------------------------------------------------------------------
CREATE TABLE Empresa (
	ID_empresa INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	ID_pais TINYINT FOREIGN KEY REFERENCES Pais(ID_pais) NOT NULL,
	ID_estado TINYINT FOREIGN KEY REFERENCES Estado(ID_estado) NOT NULL,
	ID_municipio TINYINT FOREIGN KEY REFERENCES Municipio(ID_municipio) NOT NULL,
	Calle NVARCHAR(100) NOT NULL,
	Numero_telefono NVARCHAR(15) NOT NULL,
	Correo NVARCHAR(320) NOT NULL
);

---------------------------------------------------------Comandos para libro---------------------------------------------------------------------

CREATE TABLE Condicion (
	ID_condicion TINYINT IDENTITY(1,1) PRIMARY KEY,
	Descripcion NVARCHAR(100) NOT NULL
);

CREATE TABLE Idioma (
	ID_idioma TINYINT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL
);

CREATE TABLE Ubicacion (
	ID_ubicacion TINYINT IDENTITY(1,1) PRIMARY KEY,
	Seccion NVARCHAR(30) NOT NULL, 
	Estanteria tinyint NOT NULL
);

CREATE TABLE Editorial (
	ID_editorial SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL, 
);

CREATE TABLE Genero (
	ID_genero SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL, 
);

CREATE TABLE Autor (
	ID_autor SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Apellido NVARCHAR(100) NOT NULL
);

CREATE TABLE Libro (
	ID_libro INT IDENTITY(1,1) PRIMARY KEY,
	Titulo NVARCHAR(100) NOT NULL,
	Numero_ISBN NVARCHAR(13) NOT NULL,
	ID_editorial SMALLINT FOREIGN KEY REFERENCES Editorial(ID_editorial) NOT NULL,
	Year_publicacion DATETIME NOT NULL,
	N_paginas SMALLINT NOT NULL,
	Tipo_pasta char(1) NOT NULL,
	ID_ubicacion TINYINT FOREIGN KEY REFERENCES Ubicacion(ID_ubicacion) NOT NULL,
	ID_Idioma TINYINT FOREIGN KEY REFERENCES Idioma(ID_idioma) NOT NULL,
	ID_condicion TINYINT FOREIGN KEY REFERENCES Condicion(ID_condicion) NOT NULL
);


CREATE TABLE GeneroLibro (
	ID_genero SMALLINT FOREIGN KEY REFERENCES Genero(ID_genero) NOT NULL, 
	ID_libro INT FOREIGN KEY REFERENCES Libro(ID_libro) NOT NULL, 
	CONSTRAINT PK_GeneroLibro PRIMARY KEY (ID_genero, ID_libro)
);

CREATE TABLE AutorLibro (
	ID_autor SMALLINT FOREIGN KEY REFERENCES Autor(ID_autor) NOT NULL, 
	ID_libro INT FOREIGN KEY REFERENCES Libro(ID_libro) NOT NULL, 
	CONSTRAINT PK_AutorLibro PRIMARY KEY (ID_autor, ID_libro)
);

---------------------------------------------------------Comandos para empleado---------------------------------------------------------------------
CREATE TABLE Rol (
	ID_rol TINYINT IDENTITY(1,1) PRIMARY KEY,
	Descripcion NVARCHAR(100) NOT NULL
);


CREATE TABLE Cargo (
	ID_cargo TINYINT IDENTITY(1,1) PRIMARY KEY,
	Descripcion NVARCHAR(100) NOT NULL,
	ID_rol TINYINT FOREIGN KEY REFERENCES Rol(ID_rol) NOT NULL
);

CREATE TABLE Empleado (
	ID_empleado INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Apellido NVARCHAR(100) NOT NULL,
	ID_pais TINYINT FOREIGN KEY REFERENCES Pais(ID_pais) NOT NULL,
	ID_estado TINYINT FOREIGN KEY REFERENCES Estado(ID_estado) NOT NULL,
	ID_municipio TINYINT FOREIGN KEY REFERENCES Municipio(ID_municipio) NOT NULL,
	Calle NVARCHAR(100) NOT NULL,
	Correo NVARCHAR(320) NOT NULL,
	Numero_telefono NVARCHAR(15) NOT NULL,
	Fecha_contratacion DATETIME NOT NULL,
	Fecha_nacimiento DATETIME NOT NULL,
	ID_cargo TINYINT FOREIGN KEY REFERENCES Cargo(ID_cargo) NOT NULL
);

---------------------------------------------------------Comandos para cliente---------------------------------------------------------------------
CREATE TABLE Cliente (
	ID_cliente INT IDENTITY(1,1) PRIMARY KEY,
	Nombre NVARCHAR(100) NOT NULL,
	Apellido NVARCHAR(100) NOT NULL,
	ID_pais TINYINT FOREIGN KEY REFERENCES Pais(ID_pais) NOT NULL,
	ID_estado TINYINT FOREIGN KEY REFERENCES Estado(ID_estado) NOT NULL,
	ID_municipio TINYINT FOREIGN KEY REFERENCES Municipio(ID_municipio) NOT NULL,
	Calle NVARCHAR(100) NOT NULL,
	Correo NVARCHAR(320) NOT NULL,
	Numero_telefono NVARCHAR(15) NOT NULL,
	Fecha_registro DATETIME NOT NULL,
	Fecha_nacimiento DATETIME NOT NULL,
	Estado_renta bit NOT NULL
);

---------------------------------------------------------Comandos para Renta---------------------------------------------------------------------
CREATE TABLE Renta (
	ID_renta INT IDENTITY(1,1) PRIMARY KEY,
	Fecha_renta DATETIME NOT NULL,
	Fecha_devolucion DATETIME NOT NULL,
	Fecha_devolucion_real DATETIME NOT NULL,
	ID_cliente INT FOREIGN KEY REFERENCES Cliente(ID_cliente) NOT NULL,
	ID_empleado INT FOREIGN KEY REFERENCES Empleado(ID_empleado) NOT NULL
);

CREATE TABLE DetalleRenta(
	ID_detalle_renta INT IDENTITY(1,1) PRIMARY KEY,
	ID_renta INT FOREIGN KEY REFERENCES Renta(ID_renta) NOT NULL,
	ID_libro INT FOREIGN KEY REFERENCES Libro(ID_libro) NOT NULL,
	ID_condicion TINYINT FOREIGN KEY REFERENCES Condicion(ID_condicion) NOT NULL
);
---------------------------------------------------------Comandos para Multas---------------------------------------------------------------------
CREATE TABLE TipoMulta (
	ID_tipo_multa SMALLINT IDENTITY(1,1) PRIMARY KEY,
	Descripcion NVARCHAR(100) NOT NULL, 
	Tarifa MONEY NOT NULL
);

CREATE TABLE Multa (
	ID_multa INT IDENTITY(1,1) PRIMARY KEY,
	Motivo NVARCHAR(100) NOT NULL,
	Monto MONEY NOT NULL,
	Metodo_pago NVARCHAR(30) NOT NULL,
	Numero_tarjeta NVARCHAR(16),
	Fecha_multa DATETIME NOT NULL,
	ID_tipo_multa SMALLINT FOREIGN KEY REFERENCES TipoMulta(ID_tipo_multa) NOT NULL,
	ID_renta INT FOREIGN KEY REFERENCES Renta(ID_renta) NOT NULL
);
GO

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Comandos para la inicializacion de datos (en stored procedures)---------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Pais (Nombre_pais) VALUES ('Mexico');
INSERT INTO Estado (Nombre_estado, ID_pais) VALUES ('Nuevo Leon', 1);
INSERT INTO Municipio (Nombre_municipio, ID_estado) VALUES ('Monterrey', 1);
INSERT INTO Empresa VALUES ('El Buen Lector', 1, 1, 1, 'Plutarco Elias Calles 194', '12491428', 'BuenLector@hotmail.com' );
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Comandos para la modificacion de datos (en stored procedures)---------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[GestionPais]
    @Operacion VARCHAR(10),
    @ID_pais TINYINT = NULL,
    @Nombre_pais NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Pais;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Pais (Nombre_pais)
        VALUES (@Nombre_pais);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Pais
        SET Nombre_pais = @Nombre_pais
        WHERE ID_pais = @ID_pais;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Pais
        WHERE ID_pais = @ID_pais;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionEstado]
    @Operacion VARCHAR(10),
    @ID_estado TINYINT = NULL,
    @Nombre_estado NVARCHAR(100) = NULL,
    @ID_pais TINYINT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT e.ID_estado, e.Nombre_estado, e.ID_pais, p.Nombre_pais
        FROM Estado e
        JOIN Pais p ON e.ID_pais = p.ID_pais;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Estado (Nombre_estado, ID_pais)
        VALUES (@Nombre_estado, @ID_pais);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Estado
        SET Nombre_estado = @Nombre_estado,
            ID_pais = @ID_pais
        WHERE ID_estado = @ID_estado;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Estado
        WHERE ID_estado = @ID_estado;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionMunicipio]
    @Operacion VARCHAR(10),
    @ID_municipio TINYINT = NULL,
    @Nombre_municipio NVARCHAR(100) = NULL,
    @ID_estado TINYINT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT m.ID_municipio, m.Nombre_municipio, m.ID_estado, e.Nombre_estado
        FROM Municipio m
        JOIN Estado e ON m.ID_estado = e.ID_estado;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Municipio (Nombre_municipio, ID_estado)
        VALUES (@Nombre_municipio, @ID_estado);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Municipio
        SET Nombre_municipio = @Nombre_municipio,
            ID_estado = @ID_estado
        WHERE ID_municipio = @ID_municipio;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Municipio
        WHERE ID_municipio = @ID_municipio;
    END
END;
GO
--
CREATE PROCEDURE GestionEmpresa
    @Operacion VARCHAR(10),
    @ID_empresa INT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    @ID_pais TINYINT = NULL,
    @ID_estado TINYINT = NULL,
    @ID_municipio TINYINT = NULL,
    @Calle NVARCHAR(100) = NULL,
    @Correo NVARCHAR(320) = NULL,
    @Numero_telefono NVARCHAR(15) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT e.ID_empresa, e.Nombre, e.Calle, e.Correo, e.Numero_telefono,
               p.ID_pais, p.Nombre_pais, 
               es.ID_estado, es.Nombre_estado, 
               m.ID_municipio, m.Nombre_municipio
        FROM Empresa e
        JOIN Pais p ON e.ID_pais = p.ID_pais
        JOIN Estado es ON e.ID_estado = es.ID_estado
        JOIN Municipio m ON e.ID_municipio = m.ID_municipio;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Empresa (Nombre, ID_pais, ID_estado, ID_municipio, Calle, Correo, Numero_telefono)
        VALUES (@Nombre, @ID_pais, @ID_estado, @ID_municipio, @Calle, @Correo, @Numero_telefono);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Empresa
        SET Nombre = @Nombre,
            ID_pais = @ID_pais,
            ID_estado = @ID_estado,
            ID_municipio = @ID_municipio,
            Calle = @Calle,
            Correo = @Correo,
            Numero_telefono = @Numero_telefono
        WHERE ID_empresa = @ID_empresa;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Empresa
        WHERE ID_empresa = @ID_empresa;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionCondicion] 
    @Operacion VARCHAR(10),
    @ID_condicion TINYINT = NULL,
    @Descripcion NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Condicion;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Condicion (Descripcion)
        VALUES (@Descripcion);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Condicion
        SET Descripcion = @Descripcion
        WHERE ID_condicion = @ID_condicion;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Condicion
        WHERE ID_condicion = @ID_condicion;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionIdioma]
    @Operacion VARCHAR(10),
    @ID_idioma TINYINT = NULL,
    @Nombre NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Idioma;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Idioma (Nombre)
        VALUES (@Nombre);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Idioma
        SET Nombre = @Nombre
        WHERE ID_idioma = @ID_idioma;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Idioma
        WHERE ID_idioma = @ID_idioma;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionUbicacion]
    @Operacion VARCHAR(10),
    @ID_ubicacion TINYINT = NULL,
    @Seccion NVARCHAR(30) = NULL,
    @Estanteria TINYINT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Ubicacion;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Ubicacion (Seccion, Estanteria)
        VALUES (@Seccion, @Estanteria);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Ubicacion
        SET Seccion = @Seccion,
            Estanteria = @Estanteria
        WHERE ID_ubicacion = @ID_ubicacion;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Ubicacion
        WHERE ID_ubicacion = @ID_ubicacion;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionEditorial]
    @Operacion VARCHAR(10),
    @ID_editorial SMALLINT = NULL,
    @Nombre NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Editorial;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Editorial (Nombre)
        VALUES (@Nombre);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Editorial
        SET Nombre = @Nombre
        WHERE ID_editorial = @ID_editorial;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Editorial
        WHERE ID_editorial = @ID_editorial;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionGenero]
    @Operacion VARCHAR(10),
    @ID_genero SMALLINT = NULL,
    @Nombre NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Genero;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Genero (Nombre)
        VALUES (@Nombre);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Genero
        SET Nombre = @Nombre
        WHERE ID_genero = @ID_genero;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Genero
        WHERE ID_genero = @ID_genero;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionAutor]
    @Operacion VARCHAR(10),
    @ID_autor SMALLINT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    @Apellido NVARCHAR(100) = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Autor;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Autor (Nombre, Apellido)
        VALUES (@Nombre, @Apellido);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Autor
        SET Nombre = @Nombre,
            Apellido = @Apellido
        WHERE ID_autor = @ID_autor;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Autor
        WHERE ID_autor = @ID_autor;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionLibro]
    @Operacion VARCHAR(10),
    @ID_libro INT = NULL,
    @Titulo NVARCHAR(100) = NULL,
    @Numero_ISBN NVARCHAR(13) = NULL,
    @ID_editorial SMALLINT = NULL,
    @Year_publicacion DATETIME = NULL,
    @N_paginas SMALLINT = NULL,
    @Tipo_pasta CHAR(1) = NULL,
    @ID_ubicacion TINYINT = NULL,
    @ID_idioma TINYINT = NULL,
    @ID_condicion TINYINT = NULL
AS
BEGIN
	IF @Operacion = 'SELECTONE'
	BEGIN
		SELECT l.ID_libro, l.Titulo, l.ID_condicion, c.Descripcion AS Descripcion_condicion  FROM Libro l
		JOIN Condicion c ON l.ID_condicion = c.ID_condicion
		WHERE ID_libro = @ID_libro;

	END
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT l.ID_libro, l.Titulo, l.Numero_ISBN, l.ID_editorial, e.Nombre AS Nombre_editorial, 
               l.Year_publicacion, l.N_paginas, l.Tipo_pasta, l.ID_ubicacion, u.Seccion AS Seccion_ubicacion, u.Estanteria AS Estanteria_ubicacion, 
               l.ID_idioma, i.Nombre AS Nombre_idioma, l.ID_condicion, c.Descripcion AS Descripcion_condicion
        FROM Libro l
            JOIN Editorial e ON l.ID_editorial = e.ID_editorial
            JOIN Ubicacion u ON l.ID_ubicacion = u.ID_ubicacion
            JOIN Idioma i ON l.ID_idioma = i.ID_idioma
            JOIN Condicion c ON l.ID_condicion = c.ID_condicion;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Libro (Titulo, Numero_ISBN, ID_editorial, Year_publicacion, N_paginas, Tipo_pasta, ID_ubicacion, ID_idioma, ID_condicion)
        VALUES (@Titulo, @Numero_ISBN, @ID_editorial, @Year_publicacion, @N_paginas, @Tipo_pasta, @ID_ubicacion, @ID_idioma, @ID_condicion);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Libro
        SET Titulo = @Titulo,
            Numero_ISBN = @Numero_ISBN,
            ID_editorial = @ID_editorial,
            Year_publicacion = @Year_publicacion,
            N_paginas = @N_paginas,
            Tipo_pasta = @Tipo_pasta,
            ID_ubicacion = @ID_ubicacion,
            ID_idioma = @ID_idioma,
            ID_condicion = @ID_condicion
        WHERE ID_libro = @ID_libro;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Libro
        WHERE ID_libro = @ID_libro;
    END
END;
GO
drop procedure GestionLibro
--
CREATE PROCEDURE [dbo].[GestionGeneroLibro]
    @Operacion VARCHAR(10),
    @ID_genero SMALLINT = NULL,
    @ID_libro INT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT gl.ID_genero, g.Nombre AS Nombre_genero
		FROM GeneroLibro gl
		JOIN Genero g ON g.ID_genero = gl.ID_genero
		WHERE ID_libro = @ID_libro
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO GeneroLibro (ID_genero, ID_libro)
        VALUES (@ID_genero, @ID_libro);
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM GeneroLibro
        WHERE ID_libro = @ID_libro; --Se borra todos los registros del libro, y despues hacer insert con lo nuevo 
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionAutorLibro]
    @Operacion VARCHAR(10),
    @ID_autor SMALLINT = NULL,
    @ID_libro INT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT al.ID_autor, a.Nombre AS Nombre_autor
		FROM AutorLibro al
		JOIN Autor a ON a.ID_autor = al.ID_autor
		WHERE ID_libro = @ID_libro
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO AutorLibro (ID_autor, ID_libro)
        VALUES (@ID_autor, @ID_libro);
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM AutorLibro
        WHERE ID_libro = @ID_libro; --Se borra todos los registros del libro, y despues hacer insert con lo nuevo 
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionCargo]
    @Operacion VARCHAR(10),
    @ID_cargo TINYINT = NULL,
    @Descripcion NVARCHAR(100) = NULL,
    @ID_rol TINYINT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT c.ID_cargo, c.Descripcion, c.ID_rol, r.Descripcion AS Descripcion_rol
        FROM Cargo c
        JOIN Rol r ON c.ID_rol = r.ID_rol;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Cargo (Descripcion, ID_rol)
        VALUES (@Descripcion, @ID_rol);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Cargo
        SET Descripcion = @Descripcion,
            ID_rol = @ID_rol
        WHERE ID_cargo = @ID_cargo;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Cargo
        WHERE ID_cargo = @ID_cargo;
    END
END
GO


CREATE PROCEDURE [dbo].[GestionEmpleado]
    @Operacion VARCHAR(10),
    @ID_empleado INT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    @Apellido NVARCHAR(100) = NULL,
    @ID_pais TINYINT = NULL,
    @ID_estado TINYINT = NULL,
    @ID_municipio TINYINT = NULL,
    @Calle NVARCHAR(100) = NULL,
    @Correo NVARCHAR(320) = NULL,
    @Numero_telefono NVARCHAR(15) = NULL,
    @Fecha_contratacion DATETIME = NULL,
    @Fecha_nacimiento DATETIME = NULL,
    @ID_cargo TINYINT = NULL,
	@Estado_empleado BIT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT e.ID_empleado, e.Nombre, e.Apellido, e.ID_pais, p.Nombre_pais, 
               e.ID_estado, es.Nombre_estado, e.ID_municipio, m.Nombre_municipio, 
               e.Calle, e.Correo, e.Numero_telefono, e.Fecha_contratacion, 
               e.Fecha_nacimiento, e.ID_cargo, c.Descripcion AS Descripcion_cargo,
			   Estado_empleado
        FROM Empleado e
        JOIN Pais p ON e.ID_pais = p.ID_pais
        JOIN Estado es ON e.ID_estado = es.ID_estado
        JOIN Municipio m ON e.ID_municipio = m.ID_municipio
        JOIN Cargo c ON e.ID_cargo = c.ID_cargo;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Empleado (Nombre, Apellido, ID_pais, ID_estado, ID_municipio, Calle, Correo, Numero_telefono, Fecha_contratacion, Fecha_nacimiento, ID_cargo, Estado_empleado)
        VALUES (@Nombre, @Apellido, @ID_pais, @ID_estado, @ID_municipio, @Calle, @Correo, @Numero_telefono, GETDATE(), @Fecha_nacimiento, @ID_cargo, 1);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Empleado
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            ID_pais = @ID_pais,
            ID_estado = @ID_estado,
            ID_municipio = @ID_municipio,
            Calle = @Calle,
            Correo = @Correo,
            Numero_telefono = @Numero_telefono,
            Fecha_nacimiento = @Fecha_nacimiento,
            ID_cargo = @ID_cargo,
			Estado_empleado = @Estado_empleado
        WHERE ID_empleado = @ID_empleado;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionCliente]
    @Operacion VARCHAR(10),
    @ID_cliente INT = NULL,
    @Nombre NVARCHAR(100) = NULL,
    @Apellido NVARCHAR(100) = NULL,
    @ID_pais TINYINT = NULL,
    @ID_estado TINYINT = NULL,
    @ID_municipio TINYINT = NULL,
    @Calle NVARCHAR(100) = NULL,
    @Correo NVARCHAR(320) = NULL,
    @Numero_telefono NVARCHAR(15) = NULL,
    @Fecha_registro DATETIME = NULL,
    @Fecha_nacimiento DATETIME = NULL,
    @Estado_renta BIT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT c.ID_cliente, c.Nombre, c.Apellido, c.ID_pais, p.Nombre_pais, c.ID_estado, e.Nombre_estado, c.ID_municipio, m.Nombre_municipio, 
               c.Calle, c.Correo, c.Numero_telefono, c.Fecha_registro, c.Fecha_nacimiento, c.Estado_renta
        FROM Cliente c
        JOIN Pais p ON c.ID_pais = p.ID_pais
        JOIN Estado e ON c.ID_estado = e.ID_estado
        JOIN Municipio m ON c.ID_municipio = m.ID_municipio;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Cliente (Nombre, Apellido, ID_pais, ID_estado, ID_municipio, Calle, Correo, Numero_telefono, Fecha_registro, Fecha_nacimiento, Estado_renta)
        VALUES (@Nombre, @Apellido, @ID_pais, @ID_estado, @ID_municipio, @Calle, @Correo, @Numero_telefono, GETDATE(), @Fecha_nacimiento, @Estado_renta);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Cliente
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            ID_pais = @ID_pais,
            ID_estado = @ID_estado,
            ID_municipio = @ID_municipio,
            Calle = @Calle,
            Correo = @Correo,
            Numero_telefono = @Numero_telefono,
            Fecha_nacimiento = @Fecha_nacimiento,
            Estado_renta = @Estado_renta
        WHERE ID_cliente = @ID_cliente;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionRenta]
    @Operacion VARCHAR(10),
    @ID_renta INT = NULL,
    @Fecha_renta DATETIME = NULL,
    @Fecha_devolucion DATETIME = NULL,
    @Fecha_devolucion_real DATETIME = NULL,
    @ID_cliente INT = NULL,
    @ID_empleado INT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Renta;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Renta (Fecha_renta, Fecha_devolucion, Fecha_devolucion_real, ID_cliente, ID_empleado)
        VALUES (GETDATE(), @Fecha_devolucion, @Fecha_devolucion_real, @ID_cliente, @ID_empleado);
		SELECT SCOPE_IDENTITY() AS ID_renta;
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE Renta
        SET Fecha_devolucion_real = @Fecha_devolucion_real
        WHERE ID_renta = @ID_renta;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Renta
        WHERE ID_renta = @ID_renta;

		DELETE FROM DetalleRenta
		WHERE ID_Renta = @ID_renta
    END
END;
GO

CREATE PROCEDURE [dbo].[GestionDetalleRenta]
    @Operacion VARCHAR(10),
    @ID_detalle_renta INT = NULL,
    @ID_renta INT = NULL,
    @ID_libro INT = NULL,
    @ID_condicion TINYINT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT dr.*, c.Descripcion
        FROM DetalleRenta dr
        JOIN Condicion c ON dr.ID_condicion = c.ID_condicion
        WHERE dr.ID_renta = @ID_renta;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO DetalleRenta (ID_renta, ID_libro, ID_condicion)
        VALUES (@ID_renta, @ID_libro, @ID_condicion);
    END
    --ELSE IF @Operacion = 'UPDATE'
    --BEGIN
    --    UPDATE DetalleRenta
    --    SET ID_renta = @ID_renta,
    --        ID_libro = @ID_libro,
    --        ID_condicion = @ID_condicion
    --    WHERE ID_detalle_renta = @ID_detalle_renta;
    --END
    --ELSE IF @Operacion = 'DELETE'
    --BEGIN
    --    DELETE FROM DetalleRenta
    --    WHERE ID_detalle_renta = @ID_detalle_renta;
    --END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionTipoMulta]
    @Operacion VARCHAR(10),
    @ID_tipo_multa SMALLINT = NULL,
    @Descripcion NVARCHAR(100) = NULL,
    @Tarifa MONEY = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM TipoMulta;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO TipoMulta (Descripcion, Tarifa)
        VALUES (@Descripcion, @Tarifa);
    END
    ELSE IF @Operacion = 'UPDATE'
    BEGIN
        UPDATE TipoMulta
        SET Descripcion = @Descripcion,
            Tarifa = @Tarifa
        WHERE ID_tipo_multa = @ID_tipo_multa;
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM TipoMulta
        WHERE ID_tipo_multa = @ID_tipo_multa;
    END
END;
GO
--
CREATE PROCEDURE [dbo].[GestionMulta]
    @Operacion VARCHAR(10),
    @ID_multa INT = NULL,
    @Motivo NVARCHAR(100) = NULL,
    @Monto MONEY = NULL,
    @Metodo_pago NVARCHAR(30) = NULL,
    @Numero_tarjeta NVARCHAR(16) = NULL,
    @Fecha_multa DATETIME = NULL,
    @ID_tipo_multa SMALLINT = NULL,
    @ID_renta INT = NULL
AS
BEGIN
    IF @Operacion = 'SELECT'
    BEGIN
        SELECT * FROM Multa;
    END
    ELSE IF @Operacion = 'INSERT'
    BEGIN
        INSERT INTO Multa (Motivo, Monto, Metodo_pago, Numero_tarjeta, Fecha_multa, ID_tipo_multa, ID_renta)
        VALUES (@Motivo, (SELECT Tarifa FROM TipoMulta WHERE ID_tipo_multa = @ID_tipo_multa), @Metodo_pago, @Numero_tarjeta, GETDATE(), @ID_tipo_multa, @ID_renta);
		
    END
    ELSE IF @Operacion = 'DELETE'
    BEGIN
        DELETE FROM Multa
        WHERE ID_multa = @ID_multa;
    END
END;