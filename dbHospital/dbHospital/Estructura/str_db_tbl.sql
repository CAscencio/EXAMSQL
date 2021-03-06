CREATE DATABASE dbHospital
GO

USE dbHospital
GO

CREATE SCHEMA Paciente
GO

CREATE SCHEMA Medico
GO

CREATE SCHEMA Historia
GO 

CREATE TABLE Paciente.PACIENTE(
	CODPAC int NOT NULL identity(1,1),
	NOMPAC varchar(120) NOT NULL,
	APEPATPAC varchar(120) NOT NULL,
	APEMATPAC varchar(120) NOT NULL,
	FECNACPAC date NOT NULL,
	SEXPAC char(1) NOT NULL,
	DNIPAC char(6) NOT NULL,
	TELEFPAC varchar(9) NULL,
	EMAILPAC varchar(100)  NULL,
	DOMPAC varchar(120) NOT NULL,
	UBIGEOPAC char(6) NOT NULL,
	FECREGPAC datetime NULL,
	OBSERVPAC varchar(250) NULL
	CONSTRAINT CODPAC_PK PRIMARY KEY(CODPAC)		 
)
GO

CREATE TABLE Historia.HISTORIA(
	CODHIST int NOT NULL identity(1,1),
	FECHIST datetime NOT NULL,
	OBSHIST varchar(1800) NOT NULL
	CONSTRAINT CODHIST_PK PRIMARY KEY(CODHIST)
)
GO

CREATE TABLE Paciente.HISTORIA_PACIENTE(
	CODHIST int NOT NULL,
	CODPAC int NOT NULL,
	CODMED int NOT NULL
	CONSTRAINT CODHIST_PK PRIMARY KEY(CODHIST,CODPAC,CODMED)
)
GO

CREATE TABLE Historia.TURNO(
	CODTUR int NOT NULL identity(1,1),
	FECTUR datetime,
	ESTTUR smallint,
	OBSTUR varchar(500)
	CONSTRAINT CODTUR_PK PRIMARY KEY(CODTUR)
)
GO

CREATE TABLE Paciente.TURNO_PACIENTE(
	CODTUR int NOT NULL,
	CODPAC int NOT NULL,
	CODMED int NOT NULL
	CONSTRAINT CODTUR_PK PRIMARY KEY(CODTUR,CODPAC,CODMED)
)
GO

CREATE TABLE Paciente.UBIGEO(
	CODUB char(6) NOT NULL,
	DISTUB varchar(60),
	PROVUB varchar(60),
	DEPAUB varchar(60)
	CONSTRAINT CODUB_PK PRIMARY KEY(CODUB)
)
GO

CREATE TABLE Medico.ESPECIALIDAD(
	CODESP int NOT NULL identity(1,1),
	NOMESP varchar(80) NOT NULL,
	OBSESP varchar(100) NULL,
	CONSTRAINT CODESP_PK PRIMARY KEY(CODESP)
)
GO

CREATE TABLE Medico.MEDICO(
	CODMED int NOT NULL identity(1,1),
	NOMMED varchar(120) NOT NULL,
	APEPATMED varchar(120) NOT NULL,
	APEMATMED varchar(120) NOT NULL,
	FECNACMED date NOT NULL,
	SEXMED char(1) NOT NULL,
	DNIMED char(8) NOT NULL,
	TELEFMED varchar(9) NULL,
	EMAILMED varchar(120) NULL,
	DOMMED varchar(120) NOT NULL,
	UBIGEOMED char(6) NOT NULL,
	FECREGMED datetime NULL,
	OBSERVMED varchar(180) NULL
	CONSTRAINT CODMED_PK PRIMARY KEY(CODMED)
)
GO

CREATE TABLE Medico.MEDICO_ESPECIALIDAD(
	CODMED int NOT NULL,
	CODESP int NOT NULL,
	DESCESP varchar(1000)
	CONSTRAINT CODMED PRIMARY KEY(CODMED,CODESP)
)
GO

-- Relaciones 
	
ALTER TABLE Paciente.PACIENTE ADD CONSTRAINT FK_PACIENTE_UBIGEO
    FOREIGN KEY (UBIGEOPAC)
    REFERENCES Paciente.UBIGEO (CODUB)
	GO

ALTER TABLE Medico.MEDICO_ESPECIALIDAD ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD_MEDICO 
    FOREIGN KEY (CODMED)
    REFERENCES Medico.MEDICO (CODMED)
	GO

ALTER TABLE Medico.MEDICO_ESPECIALIDAD ADD CONSTRAINT FK_MEDICO_ESPECIALIDAD_ESPECIALIDAD  
    FOREIGN KEY (CODESP)
    REFERENCES Medico.ESPECIALIDAD (CODESP)
	GO

ALTER TABLE Paciente.TURNO_PACIENTE ADD CONSTRAINT FK_TURNO_PACIENTE_TURNO  
    FOREIGN KEY (CODTUR)
    REFERENCES Historia.TURNO (CODTUR)
	GO

ALTER TABLE Paciente.TURNO_PACIENTE ADD CONSTRAINT FK_TURNO_PACIENTE_PACIENTE  
    FOREIGN KEY (CODPAC)
    REFERENCES Paciente.PACIENTE (CODPAC)
	GO

ALTER TABLE Paciente.TURNO_PACIENTE ADD CONSTRAINT FK_TURNO_PACIENTE_MEDICO  
    FOREIGN KEY (CODMED)
    REFERENCES Medico.MEDICO (CODMED)
	GO

ALTER TABLE Paciente.HISTORIA_PACIENTE ADD CONSTRAINT FK_HISTORIA_PACIENTE_PACIENTE  
    FOREIGN KEY (CODPAC)
    REFERENCES Paciente.PACIENTE (CODPAC)
	GO

ALTER TABLE Paciente.HISTORIA_PACIENTE ADD CONSTRAINT FK_HISTORIA_PACIENTE_MEDICO   
    FOREIGN KEY (CODMED)
    REFERENCES Medico.MEDICO (CODMED)
	GO

ALTER TABLE Paciente.HISTORIA_PACIENTE ADD CONSTRAINT FK_HISTORIA_PACIENTE_HISTORIA   
    FOREIGN KEY (CODHIST)
    REFERENCES Historia.HISTORIA (CODHIST)
	GO

ALTER TABLE Medico.MEDICO ADD CONSTRAINT FK_MEDICO_UBIGEO   
    FOREIGN KEY (UBIGEOMED)
    REFERENCES Paciente.UBIGEO (CODUB)
	GO


