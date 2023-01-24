
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 12/19/2022 14:17:19
-- Generated from EDMX file: C:\Users\karlo\OneDrive\Radna površina\Zadace_PPPK\Zadaca04\MoviesMVC\MoviesMVC\Model.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [MoviesDatabase];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------


-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Movies'
CREATE TABLE [dbo].[Movies] (
    [IDMovie] int IDENTITY(1,1) NOT NULL,
    [Title] nvarchar(50)  NOT NULL,
    [Description] nvarchar(100)  NOT NULL,
    [Duration] int  NOT NULL,
    [PublishedDate] datetime  NOT NULL,
    [Genre] nvarchar(max)  NOT NULL,
    [Director] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'UploadedFiles'
CREATE TABLE [dbo].[UploadedFiles] (
    [IDUploadedFile] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL,
    [ContentType] nvarchar(50)  NOT NULL,
    [Content] varbinary(max)  NOT NULL,
    [MovieIDMovie] int  NOT NULL
);
GO

-- Creating table 'Genres'
CREATE TABLE [dbo].[Genres] (
    [IDGenre] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(50)  NOT NULL
);
GO

-- Creating table 'People'
CREATE TABLE [dbo].[People] (
    [IDPerson] int IDENTITY(1,1) NOT NULL,
    [FirstName] nvarchar(50)  NOT NULL,
    [LastName] nvarchar(50)  NOT NULL,
    [Nationality] nvarchar(50)  NOT NULL,
    [Age] int  NOT NULL
);
GO

-- Creating table 'MovieGenre'
CREATE TABLE [dbo].[MovieGenre] (
    [Movies_IDMovie] int  NOT NULL,
    [Genres_IDGenre] int  NOT NULL
);
GO

-- Creating table 'MoviePerson'
CREATE TABLE [dbo].[MoviePerson] (
    [Movies_IDMovie] int  NOT NULL,
    [People_IDPerson] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [IDMovie] in table 'Movies'
ALTER TABLE [dbo].[Movies]
ADD CONSTRAINT [PK_Movies]
    PRIMARY KEY CLUSTERED ([IDMovie] ASC);
GO

-- Creating primary key on [IDUploadedFile] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [PK_UploadedFiles]
    PRIMARY KEY CLUSTERED ([IDUploadedFile] ASC);
GO

-- Creating primary key on [IDGenre] in table 'Genres'
ALTER TABLE [dbo].[Genres]
ADD CONSTRAINT [PK_Genres]
    PRIMARY KEY CLUSTERED ([IDGenre] ASC);
GO

-- Creating primary key on [IDPerson] in table 'People'
ALTER TABLE [dbo].[People]
ADD CONSTRAINT [PK_People]
    PRIMARY KEY CLUSTERED ([IDPerson] ASC);
GO

-- Creating primary key on [Movies_IDMovie], [Genres_IDGenre] in table 'MovieGenre'
ALTER TABLE [dbo].[MovieGenre]
ADD CONSTRAINT [PK_MovieGenre]
    PRIMARY KEY CLUSTERED ([Movies_IDMovie], [Genres_IDGenre] ASC);
GO

-- Creating primary key on [Movies_IDMovie], [People_IDPerson] in table 'MoviePerson'
ALTER TABLE [dbo].[MoviePerson]
ADD CONSTRAINT [PK_MoviePerson]
    PRIMARY KEY CLUSTERED ([Movies_IDMovie], [People_IDPerson] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [MovieIDMovie] in table 'UploadedFiles'
ALTER TABLE [dbo].[UploadedFiles]
ADD CONSTRAINT [FK_MovieUploadedFile]
    FOREIGN KEY ([MovieIDMovie])
    REFERENCES [dbo].[Movies]
        ([IDMovie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MovieUploadedFile'
CREATE INDEX [IX_FK_MovieUploadedFile]
ON [dbo].[UploadedFiles]
    ([MovieIDMovie]);
GO

-- Creating foreign key on [Movies_IDMovie] in table 'MovieGenre'
ALTER TABLE [dbo].[MovieGenre]
ADD CONSTRAINT [FK_MovieGenre_Movie]
    FOREIGN KEY ([Movies_IDMovie])
    REFERENCES [dbo].[Movies]
        ([IDMovie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Genres_IDGenre] in table 'MovieGenre'
ALTER TABLE [dbo].[MovieGenre]
ADD CONSTRAINT [FK_MovieGenre_Genre]
    FOREIGN KEY ([Genres_IDGenre])
    REFERENCES [dbo].[Genres]
        ([IDGenre])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MovieGenre_Genre'
CREATE INDEX [IX_FK_MovieGenre_Genre]
ON [dbo].[MovieGenre]
    ([Genres_IDGenre]);
GO

-- Creating foreign key on [Movies_IDMovie] in table 'MoviePerson'
ALTER TABLE [dbo].[MoviePerson]
ADD CONSTRAINT [FK_MoviePerson_Movie]
    FOREIGN KEY ([Movies_IDMovie])
    REFERENCES [dbo].[Movies]
        ([IDMovie])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [People_IDPerson] in table 'MoviePerson'
ALTER TABLE [dbo].[MoviePerson]
ADD CONSTRAINT [FK_MoviePerson_Person]
    FOREIGN KEY ([People_IDPerson])
    REFERENCES [dbo].[People]
        ([IDPerson])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MoviePerson_Person'
CREATE INDEX [IX_FK_MoviePerson_Person]
ON [dbo].[MoviePerson]
    ([People_IDPerson]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------