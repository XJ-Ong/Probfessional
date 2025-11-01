-- =============================================
-- Database Schema for Probfessional Application
-- =============================================

USE [Probfessional]
GO

-- =============================================
-- Table: Users
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Users](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [Email] [nvarchar](100) NOT NULL UNIQUE,
        [DisplayName] [nvarchar](100) NOT NULL,
        [PasswordHash] [nvarchar](255) NOT NULL,
        [Role] [nvarchar](20) NOT NULL DEFAULT 'Learner',
        [CreatedAt] [datetime] NOT NULL DEFAULT GETDATE(),
        [IsActive] [bit] NOT NULL DEFAULT 1,
        CONSTRAINT [CK_Users_Role] CHECK ([Role] IN ('Admin', 'Learner', 'Teacher'))
    )
    CREATE INDEX [IX_Users_Email] ON [dbo].[Users] ([Email])
    CREATE INDEX [IX_Users_Role] ON [dbo].[Users] ([Role])
END
GO

-- =============================================
-- Table: Modules
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Modules]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Modules](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [Title] [nvarchar](100) NOT NULL,
        [Slug] [nvarchar](100) NOT NULL UNIQUE,
        [Description] [nvarchar](max) NULL,
        [CreatedAt] [datetime] NOT NULL DEFAULT GETDATE(),
        [ImagePath] [nvarchar](255) NULL
    )
    CREATE INDEX [IX_Modules_Slug] ON [dbo].[Modules] ([Slug])
END
GO

-- =============================================
-- Table: Lessons
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Lessons]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Lessons](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [ModuleID] [int] NOT NULL,
        [Title] [nvarchar](150) NOT NULL,
        [HtmlContent] [nvarchar](max) NULL,
        [Order] [int] NULL,
        CONSTRAINT [FK_Lessons_Modules] FOREIGN KEY ([ModuleID])
            REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_Lessons_ModuleID] ON [dbo].[Lessons] ([ModuleID])
    CREATE INDEX [IX_Lessons_ModuleID_Order] ON [dbo].[Lessons] ([ModuleID], [Order])
END
GO

-- =============================================
-- Table: Quiz
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quiz]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Quiz](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [ModuleID] [int] NOT NULL,
        [Title] [nvarchar](150) NOT NULL,
        [UserID] [int] NOT NULL,
        CONSTRAINT [FK_Quiz_Modules] FOREIGN KEY ([ModuleID])
            REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT [FK_Quiz_Users] FOREIGN KEY ([UserID])
            REFERENCES [dbo].[Users] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_Quiz_ModuleID] ON [dbo].[Quiz] ([ModuleID])
    CREATE INDEX [IX_Quiz_UserID] ON [dbo].[Quiz] ([UserID])
END
GO

-- =============================================
-- Table: QuizQuestion
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizQuestion]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[QuizQuestion](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [QuizID] [int] NOT NULL,
        [Text] [nvarchar](max) NOT NULL,
        CONSTRAINT [FK_QuizQuestion_Quiz] FOREIGN KEY ([QuizID])
            REFERENCES [dbo].[Quiz] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_QuizQuestion_QuizID] ON [dbo].[QuizQuestion] ([QuizID])
END
GO

-- =============================================
-- Table: QuizOptions
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizOptions]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[QuizOptions](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [QuizQuestionID] [int] NOT NULL,
        [Text] [nvarchar](255) NOT NULL,
        [IsCorrect] [bit] NOT NULL DEFAULT 0,
        CONSTRAINT [FK_QuizOptions_QuizQuestion] FOREIGN KEY ([QuizQuestionID])
            REFERENCES [dbo].[QuizQuestion] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_QuizOptions_QuizQuestionID] ON [dbo].[QuizOptions] ([QuizQuestionID])
    CREATE INDEX [IX_QuizOptions_IsCorrect] ON [dbo].[QuizOptions] ([QuizQuestionID], [IsCorrect])
END
GO

-- =============================================
-- Table: QuizAttempts
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuizAttempts]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[QuizAttempts](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [UserID] [int] NOT NULL,
        [QuizID] [int] NOT NULL,
        [TakenTime] [datetime] NOT NULL DEFAULT GETDATE(),
        [Score] [decimal](5,2) NULL DEFAULT 0,
        CONSTRAINT [FK_QuizAttempts_Users] FOREIGN KEY ([UserID])
            REFERENCES [dbo].[Users] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT [FK_QuizAttempts_Quiz] FOREIGN KEY ([QuizID])
            REFERENCES [dbo].[Quiz] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_QuizAttempts_UserID] ON [dbo].[QuizAttempts] ([UserID])
    CREATE INDEX [IX_QuizAttempts_QuizID] ON [dbo].[QuizAttempts] ([QuizID])
    CREATE INDEX [IX_QuizAttempts_UserID_QuizID] ON [dbo].[QuizAttempts] ([UserID], [QuizID])
END
GO

-- =============================================
-- Table: UserProgress
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserProgress]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[UserProgress](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [UserID] [int] NOT NULL,
        [ProgressPercent] [decimal](5,2) DEFAULT 0,
        [ModuleID] [int] NOT NULL,
        [UpdatedAt] [datetime] DEFAULT GETDATE(),
        CONSTRAINT [FK_UserProgress_Users] FOREIGN KEY ([UserID])
            REFERENCES [dbo].[Users] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT [FK_UserProgress_Modules] FOREIGN KEY ([ModuleID])
            REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE ON UPDATE CASCADE
    )
    CREATE INDEX [IX_UserProgress_UserID] ON [dbo].[UserProgress] ([UserID])
    CREATE INDEX [IX_UserProgress_ModuleID] ON [dbo].[UserProgress] ([ModuleID])
    CREATE INDEX [IX_UserProgress_UserID_ModuleID] ON [dbo].[UserProgress] ([UserID], [ModuleID])
END
GO

PRINT 'Database schema created successfully!'
GO

