CREATE TABLE [dbo].[Lessons] (
    [ID]       INT            IDENTITY (1, 1) NOT NULL,
    [ModuleID] INT            NOT NULL,
    [Title]    NVARCHAR (255) NOT NULL,
    [Content]  NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Lessons_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Modules] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (255) NOT NULL,
    [Slug]        NVARCHAR (255) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [CreatedAt]   DATETIME       DEFAULT (getdate()) NULL,
    [ImagePath]   NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Quiz] (
    [ID]       INT            IDENTITY (1, 1) NOT NULL,
    [ModuleID] INT            NOT NULL,
    [Title]    NVARCHAR (255) NOT NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[QuizAttempts] (
    [ID]        INT            IDENTITY (1, 1) NOT NULL,
    [UserID]    INT            NOT NULL,
    [QuizID]    INT            NOT NULL,
    [TakenTime] DATETIME       DEFAULT (getdate()) NULL,
    [Score]     DECIMAL (5, 2) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_QuizAttempts_Quiz] FOREIGN KEY ([QuizID]) REFERENCES [dbo].[Quiz] ([ID]),
    CONSTRAINT [FK_QuizAttempts_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID]) ON DELETE CASCADE
);

CREATE TABLE [QuizQuestion] (
    [ID] INT IDENTITY(1,1) PRIMARY KEY,
    [QuizID] INT NOT NULL,
    [QuestionText] NVARCHAR(MAX) NOT NULL,
    [ChoiceA] NVARCHAR(255) NOT NULL,
    [ChoiceB] NVARCHAR(255) NOT NULL,
    [ChoiceC] NVARCHAR(255) NOT NULL,
    [ChoiceD] NVARCHAR(255) NOT NULL,
    [CorrectChoice] CHAR(1) CHECK ([CorrectChoice] IN ('A','B','C','D')),
    CONSTRAINT FK_QuizQuestion_QuizID FOREIGN KEY ([QuizID])  
        REFERENCES [Quiz]([ID])
        ON DELETE CASCADE
);


CREATE TABLE [dbo].[UserProgress] (
    [ID]              INT            IDENTITY (1, 1) NOT NULL,
    [UserID]          INT            NOT NULL,
    [ProgressPercent] DECIMAL (5, 2) DEFAULT ((0)) NULL,
    [ModuleID]        INT            NOT NULL,
    [UpdatedAt]       DATETIME       DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_UserProgress_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserProgress_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([ID]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Users] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [Email]       NVARCHAR (255) NOT NULL,
    [DisplayName] NVARCHAR (100) NOT NULL,
    [Password]    NVARCHAR (255) NOT NULL,
    [Role]        NVARCHAR (50)  NOT NULL,
    [CreatedAt]   DATETIME       DEFAULT (getdate()) NULL,
    [IsActive]    BIT            DEFAULT ((1)) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    UNIQUE NONCLUSTERED ([Email] ASC),
    CHECK ([Role]='Teacher' OR [Role]='Learner' OR [Role]='Admin')
);

