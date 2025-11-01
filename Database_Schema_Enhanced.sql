-- =============================================
-- Database Schema for Probfessional Application
-- Enhanced version with recommended improvements
-- =============================================

USE [Probfessional]
GO

-- =============================================
--  TABLE: Users
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        DisplayName NVARCHAR(100) NOT NULL,
        PasswordHash NVARCHAR(255) NOT NULL,
        Role NVARCHAR(20) NOT NULL DEFAULT 'Learner',
        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
        IsActive BIT NOT NULL DEFAULT 1,
        CONSTRAINT CK_Users_Role CHECK (Role IN ('Admin', 'Learner', 'Teacher'))
    );
    
    CREATE INDEX IX_Users_Email ON Users (Email);
    CREATE INDEX IX_Users_Role ON Users (Role);
    PRINT 'Users table created successfully';
END
GO

-- =============================================
--  TABLE: Modules
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Modules]') AND type in (N'U'))
BEGIN
    CREATE TABLE Modules (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(100) NOT NULL,
        Slug NVARCHAR(100) NOT NULL UNIQUE,
        Description NVARCHAR(MAX),
        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
        ImagePath NVARCHAR(255)
    );
    
    CREATE INDEX IX_Modules_Slug ON Modules (Slug);
    PRINT 'Modules table created successfully';
END
GO

-- =============================================
--  TABLE: Lessons
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lessons]') AND type in (N'U'))
BEGIN
    CREATE TABLE Lessons (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        ModuleID INT NOT NULL,
        Title NVARCHAR(150) NOT NULL,
        HtmlContent NVARCHAR(MAX),
        [Order] INT DEFAULT 0,
        CONSTRAINT FK_Lessons_Modules FOREIGN KEY (ModuleID) 
            REFERENCES Modules(ID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE INDEX IX_Lessons_ModuleID ON Lessons (ModuleID);
    CREATE INDEX IX_Lessons_Order ON Lessons (ModuleID, [Order]);
    PRINT 'Lessons table created successfully';
END
GO

-- =============================================
--  TABLE: Quiz
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quiz]') AND type in (N'U'))
BEGIN
    CREATE TABLE Quiz (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        ModuleID INT NOT NULL,
        Title NVARCHAR(150) NOT NULL,
        UserID INT NOT NULL,
        CONSTRAINT FK_Quiz_Modules FOREIGN KEY (ModuleID) 
            REFERENCES Modules(ID) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_Quiz_Users FOREIGN KEY (UserID) 
            REFERENCES Users(ID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE INDEX IX_Quiz_ModuleID ON Quiz (ModuleID);
    CREATE INDEX IX_Quiz_UserID ON Quiz (UserID);
    PRINT 'Quiz table created successfully';
END
GO

-- =============================================
--  TABLE: QuizQuestion
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizQuestion]') AND type in (N'U'))
BEGIN
    CREATE TABLE QuizQuestion (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        QuizID INT NOT NULL,
        [Text] NVARCHAR(MAX) NOT NULL,
        CONSTRAINT FK_QuizQuestion_Quiz FOREIGN KEY (QuizID) 
            REFERENCES Quiz(ID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE INDEX IX_QuizQuestion_QuizID ON QuizQuestion (QuizID);
    PRINT 'QuizQuestion table created successfully';
END
GO

-- =============================================
--  TABLE: QuizOptions
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizOptions]') AND type in (N'U'))
BEGIN
    CREATE TABLE QuizOptions (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        QuizQuestionID INT NOT NULL,
        [Text] NVARCHAR(255) NOT NULL,
        IsCorrect BIT NOT NULL DEFAULT 0,
        CONSTRAINT FK_QuizOptions_QuizQuestion FOREIGN KEY (QuizQuestionID) 
            REFERENCES QuizQuestion(ID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE INDEX IX_QuizOptions_QuizQuestionID ON QuizOptions (QuizQuestionID);
    CREATE INDEX IX_QuizOptions_IsCorrect ON QuizOptions (QuizQuestionID, IsCorrect);
    PRINT 'QuizOptions table created successfully';
END
GO

-- =============================================
--  TABLE: QuizAttempts
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizAttempts]') AND type in (N'U'))
BEGIN
    CREATE TABLE QuizAttempts (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        UserID INT NOT NULL,
        QuizID INT NOT NULL,
        TakenTime DATETIME NOT NULL DEFAULT GETDATE(),
        Score DECIMAL(5,2) DEFAULT 0,
        CONSTRAINT FK_QuizAttempts_Users FOREIGN KEY (UserID) 
            REFERENCES Users(ID) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_QuizAttempts_Quiz FOREIGN KEY (QuizID) 
            REFERENCES Quiz(ID) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    CREATE INDEX IX_QuizAttempts_UserID ON QuizAttempts (UserID);
    CREATE INDEX IX_QuizAttempts_QuizID ON QuizAttempts (QuizID);
    CREATE INDEX IX_QuizAttempts_UserID_QuizID ON QuizAttempts (UserID, QuizID);
    PRINT 'QuizAttempts table created successfully';
END
GO

-- =============================================
--  TABLE: UserProgress
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserProgress]') AND type in (N'U'))
BEGIN
    CREATE TABLE UserProgress (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        UserID INT NOT NULL,
        ProgressPercent DECIMAL(5,2) NOT NULL DEFAULT 0,
        ModuleID INT NOT NULL,
        UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_UserProgress_Users FOREIGN KEY (UserID) 
            REFERENCES Users(ID) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT FK_UserProgress_Modules FOREIGN KEY (ModuleID) 
            REFERENCES Modules(ID) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT CK_UserProgress_Percent CHECK (ProgressPercent >= 0 AND ProgressPercent <= 100)
    );
    
    CREATE INDEX IX_UserProgress_UserID ON UserProgress (UserID);
    CREATE INDEX IX_UserProgress_ModuleID ON UserProgress (ModuleID);
    CREATE INDEX IX_UserProgress_UserID_ModuleID ON UserProgress (UserID, ModuleID);
    PRINT 'UserProgress table created successfully';
END
GO

PRINT '======================================================='
PRINT 'All database tables created successfully!'
PRINT '======================================================='
GO

