create database DBPacientes

use DBPacientes

create table Especialidad(
IdEspecialidad int primary key identity,
Nombre varchar(50),
FechaCreacion datetime default getdate()
)

create table Paciente(
IdPaciente int primary key identity,
NombreCompleto varchar(50),  
IdEspecialidad int references Especialidad(IdEspecialidad),
Telefono int,
FechaCita datetime,
FechaCreacion datetime default getdate()
)

insert into Especialidad(Nombre) values 
('Periodoncia'),
('Psicología'),
('Psiquiatría'),
('Traumatología'),
('Radioterapia'),
('Reumatología')

insert into Paciente(NombreCompleto, IdEspecialidad, Telefono, FechaCita) values
('Kesly Ureta Aguilar',1,928156428,getdate())

create procedure ObtenerPaciente
as
begin
    select* from Paciente;

end

create procedure ObtenerEspecialidad
as
begin
    select * from Especialidad;

end

CREATE PROCEDURE ObtenerPacienteDTO
AS
BEGIN
	select p.*, e.Nombre as NombreEspecialidad from Paciente p INNER JOIN Especialidad e on p.IdEspecialidad = e.IdEspecialidad;
END

CREATE PROCEDURE ObtenerPacienteConespecialidadPorId
    @IdPaciente int
AS
BEGIN
    select p.*, e.Nombre as NombreEspecialidad
    from Paciente p 
    INNER JOIN Especialidad e ON p.IdEspecialidad = e.IdEspecialidad 
    where p.IdPaciente = @IdPaciente;
END

CREATE PROCEDURE CrearPaciente
    @NombreCompleto VARCHAR(50),
    @IdEspecialidad INT,
    @Telefono INT,
    @FechaCita DATETIME
AS
BEGIN
    insert into Paciente (NombreCompleto, IdEspecialidad, Telefono, FechaCita)
    values (@NombreCompleto, @IdEspecialidad, @Telefono, @FechaCita);
END

CREATE PROCEDURE EditarPaciente
	@IdPaciente int,
	@NombreCompleto varchar(50),
	@IdEspecialidad int,
	@Telefono int,
	@FechaCita datetime
AS
BEGIN
	Update Paciente set NombreCompleto=@NombreCompleto, IdEspecialidad = @IdEspecialidad, Telefono=@Telefono, FechaCita = @FechaCita
	where IdPaciente=@IdPaciente;
END

CREATE PROCEDURE EliminarPaciente
	@IdPaciente int
AS
BEGIN
	delete from Paciente where IdPaciente=@IdPaciente;
END

CREATE PROCEDURE CrearEspecialidad
    @Nombre VARCHAR(50)
AS
BEGIN
    insert into Especialidad (Nombre) values (@Nombre);
END

CREATE PROCEDURE ObtenerEspecialidadPorId
    @IdEspecialidad int
AS
BEGIN
    SELECT * FROM Especialidad WHERE IdEspecialidad=@IdEspecialidad
END

CREATE PROCEDURE EditarEspecialidad
	@IdEspecialidad int,
	@Nombre VARCHAR(50)
AS
BEGIN
	UPDATE Especialidad SET Nombre=@Nombre WHERE IdEspecialidad=@IdEspecialidad
END
