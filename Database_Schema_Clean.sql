-- =============================================
-- Database Schema for Probfessional Application
-- Clean version matching your specifications
-- =============================================

USE [Probfessional]
GO

-- =============================================
--  TABLE: Users
-- =============================================
CREATE TABLE Users (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    DisplayName NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'Learner', 'Teacher')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);
GO

-- =============================================
--  TABLE: Modules
-- =============================================
CREATE TABLE Modules (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Slug NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    ImagePath NVARCHAR(255)
);
GO

-- =============================================
--  TABLE: Lessons
-- =============================================
CREATE TABLE Lessons (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ModuleID INT NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    HtmlContent NVARCHAR(MAX),
    [Order] INT,
    FOREIGN KEY (ModuleID) REFERENCES Modules(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- =============================================
--  TABLE: Quiz
-- =============================================
CREATE TABLE Quiz (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    ModuleID INT NOT NULL,
    Title NVARCHAR(150) NOT NULL,
    UserID INT NOT NULL,
    FOREIGN KEY (ModuleID) REFERENCES Modules(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- =============================================
--  TABLE: QuizQuestion
-- =============================================
CREATE TABLE QuizQuestion (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    QuizID INT NOT NULL,
    [Text] NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (QuizID) REFERENCES Quiz(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- =============================================
--  TABLE: QuizOptions
-- =============================================
CREATE TABLE QuizOptions (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    QuizQuestionID INT NOT NULL,
    [Text] NVARCHAR(255) NOT NULL,
    IsCorrect BIT DEFAULT 0,
    FOREIGN KEY (QuizQuestionID) REFERENCES QuizQuestion(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- =============================================
--  TABLE: QuizAttempts
-- =============================================
CREATE TABLE QuizAttempts (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    QuizID INT NOT NULL,
    TakenTime DATETIME DEFAULT GETDATE(),
    Score DECIMAL(5,2),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (QuizID) REFERENCES Quiz(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

-- =============================================
--  TABLE: UserProgress
-- =============================================
CREATE TABLE UserProgress (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProgressPercent DECIMAL(5,2) DEFAULT 0,
    ModuleID INT NOT NULL,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (ModuleID) REFERENCES Modules(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO

PRINT 'Database schema created successfully!'
GO

