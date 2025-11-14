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

CREATE TABLE [dbo].[Modules] (
    [ID]          INT            IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (255) NOT NULL,
    [Slug]        NVARCHAR (255) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [CreatedAt]   DATETIME       DEFAULT (getdate()) NULL,
    [ImagePath]   NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
);

CREATE TABLE [dbo].[Lessons] (
    [ID]           INT            IDENTITY (1, 1) NOT NULL,
    [ModuleID]     INT            NOT NULL,
    [Title]        NVARCHAR (255) NOT NULL,
    [ContentPath]  NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Lessons_Modules] FOREIGN KEY ([ModuleID]) REFERENCES [dbo].[Modules] ([ID]) ON DELETE CASCADE
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

-- =============================================
-- Insert Sample Data
-- =============================================

INSERT INTO [dbo].[Users] ([Email], [DisplayName], [Password], [Role], [CreatedAt], [IsActive])
VALUES
    ('admin@gmail.com', 'admin', 'Admin123!', 'Admin', GETDATE(), 1),
    ('teacher@gmail.com', 'teacher', 'Teacher123!', 'Teacher', GETDATE(), 1),
    ('learner@gmail.com', 'learner', 'Learner123!', 'Learner', GETDATE(), 1);


INSERT INTO [dbo].[Modules] ([Title], [Slug], [Description], [ImagePath])
VALUES
('Poker', 'poker', 'Welcome to the Poker Probability module! This module explores the fascinating world of probability through poker hands, card draws, and combinations. You''ll learn how to calculate the probability of getting specific hands like a flush, straight, or royal flush. We''ll cover concepts such as permutations, combinations, and conditional probability in the context of card games. Perfect for understanding how probability applies to real-world card playing scenarios.', 'ImgModule/poker.jpg'),

('UNO', 'uno', 'Explore probability concepts through UNO, the popular card matching game! This module focuses on card matching probabilities, color probabilities, and strategic decision-making based on probability calculations. Learn how to determine the likelihood of drawing specific cards, matching colors or numbers, and making optimal plays. This interactive module makes probability learning fun and practical.', 'ImgModule/uno.png'),

('Mahjong', 'mahjong', 'Discover probability through the ancient game of Mahjong! This module delves into tile patterns, combinations, and the mathematical foundations of Mahjong strategies. You''ll explore how probability theory applies to tile matching, sequence forming, and winning combinations. Learn about probability distributions, expected values, and how to make strategic decisions based on mathematical probability in this traditional game.', 'ImgModule/mahjong.jpeg'),

('Dice', 'dice', 'Master probability fundamentals with dice! This module covers outcomes, sums, and combinations when rolling dice. Learn how to calculate probabilities for single and multiple dice rolls, understand probability distributions, and explore concepts like expected values and variance. From simple single-die outcomes to complex multi-dice scenarios, this module builds a solid foundation in probability through engaging dice examples.', 'ImgModule/dice.jpeg'),

('Slot Machines', 'slot-machines', 'Understand independent events and probability through slot machines! This module explains how probability works in gambling scenarios, focusing on independent events, expected values, and probability calculations. Learn why the house always has an edge, how to calculate payback percentages, and understand the mathematics behind slot machine outcomes. Perfect for understanding probability in real-world gambling contexts.', 'ImgModule/slot_machine.jpeg');

-- Module 1: Poker (6 Topics)
INSERT INTO [Lessons] ([ModuleID], [Title], [ContentPath])
VALUES
(1, 'Topic 1: Basic Poker Probability Concepts', '~/ModuleContent/Poker/Topic1.html'),
(1, 'Topic 2: Card Drawing Probabilities', '~/ModuleContent/Poker/Topic2.html'),
(1, 'Topic 3: Poker Hand Probabilities', '~/ModuleContent/Poker/Topic3.html'),
(1, 'Topic 4: Poker Deck Structure and Review', '~/ModuleContent/Poker/Topic4.html'),
(1, 'Topic 5: Card Combinations and Pairs', '~/ModuleContent/Poker/Topic5.html'),
(1, 'Topic 6: Complex Poker Hands', '~/ModuleContent/Poker/Topic6.html'),

-- MODULE 2: UNO (6 Topics)
(2, 'Topic 1: UNO Card Distribution and Basic Probability', '~/ModuleContent/Uno/Topic1.html'),
(2, 'Topic 2: Color Matching and Conditional Probability', '~/ModuleContent/Uno/Topic2.html'),
(2, 'Topic 3: Action Cards and Special Probabilities', '~/ModuleContent/Uno/Topic3.html'),
(2, 'Topic 4: UNO Deck Structure and Review', '~/ModuleContent/Uno/Topic4.html'),
(2, 'Topic 5: Drawing Multiple Cards', '~/ModuleContent/Uno/Topic5.html'),
(2, 'Topic 6: Game Strategy and Probabilities', '~/ModuleContent/Uno/Topic6.html'),

-- MODULE 3: MAHJONG (6 Topics)
(3, 'Topic 1: Introduction to Mahjong Probability', '~/ModuleContent/Mahjong/Topic1.html'),
(3, 'Topic 2: Sampling Without Replacement', '~/ModuleContent/Mahjong/Topic2.html'),
(3, 'Topic 3: Tile Categories and Probability', '~/ModuleContent/Mahjong/Topic3.html'),
(3, 'Topic 4: Mahjong Tile Composition', '~/ModuleContent/Mahjong/Topic4.html'),
(3, 'Topic 5: Drawing Tiles Without Replacement', '~/ModuleContent/Mahjong/Topic5.html'),
(3, 'Topic 6: Sequential Draws and Combinations', '~/ModuleContent/Mahjong/Topic6.html'),

-- MODULE 4: DICE (6 Topics)
(4, 'Topic 1: Introduction to Dice Probability', '~/ModuleContent/Dice/Topic1.html'),
(4, 'Topic 2: Single Die Outcomes', '~/ModuleContent/Dice/Topic2.html'),
(4, 'Topic 3: Multiple Dice and Sums', '~/ModuleContent/Dice/Topic3.html'),
(4, 'Topic 4: Introduction to Dice Probability', '~/ModuleContent/Dice/Topic4.html'),
(4, 'Topic 5: Multiple Dice and Sums', '~/ModuleContent/Dice/Topic5.html'),
(4, 'Topic 6: Independent Events and Repeated Rolls', '~/ModuleContent/Dice/Topic6.html'),

-- MODULE 5: SLOT MACHINES (6 Topics)
(5, 'Topic 1: Independent Events in Slot Machines', '~/ModuleContent/SlotMachine/Topic1.html'),
(5, 'Topic 2: Multiplication Rule for Independent Events', '~/ModuleContent/SlotMachine/Topic2.html'),
(5, 'Topic 3: Complement Rule and ''At Least'' Problems', '~/ModuleContent/SlotMachine/Topic3.html'),
(5, 'Topic 4: Independent Events and Slot Machines', '~/ModuleContent/SlotMachine/Topic4.html'),
(5, 'Topic 5: Multiple Spins and Combinations', '~/ModuleContent/SlotMachine/Topic5.html'),
(5, 'Topic 6: At Least One and Repeated Trials', '~/ModuleContent/SlotMachine/Topic6.html');
GO

-- =============================================
-- Insert Quizzes
-- =============================================

INSERT INTO [dbo].[Quiz] ([ModuleID], [Title])
VALUES
    (1, 'Poker Probability Quiz'),
    (2, 'UNO Probability Quiz'),
    (3, 'Mahjong Probability Quiz'),
    (4, 'Dice Probability Quiz'),
    (5, 'Slot Machines Probability Quiz');
GO

-- =============================================
-- Insert Quiz Questions
-- =============================================

INSERT INTO [QuizQuestion]
([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice])
VALUES
(1, 'What is the probability of being dealt an Ace as your first card in a standard deck?', '1/52', '1/13', '1/26', '1/4', 'B'),
(1, 'What is the probability of drawing a red card from a shuffled deck?', '1/4', '1/2', '1/13', '1/26', 'B'),
(1, 'What is the probability of drawing a heart from a standard deck?', '1/13', '1/26', '1/4', '1/2', 'C'),
(1, 'What is the probability of being dealt a pair in two cards?', '1/13', '1/17', '1/26', '1/52', 'B'),
(1, 'Probability first two cards are both spades?', '(13/52)*(12/51)', '(1/4)*(1/4)', '(1/13)*(1/13)', '(26/52)*(25/51)', 'A'),
(1, 'Probability of flush on 5-card deal? (same suit)', '1/13', '1/254', '1/508', '1/693', 'C'),
(1, 'Probability of getting a full house?', '1/254', '1/693', '1/128', '1/500', 'B'),
(1, 'Probability king and queen are first two cards (order matters)?', '(4/52)*(4/51)', '(8/52)*(4/51)', '(4/52)*(3/51)', '(2/52)*(2/51)', 'A'),
(1, 'What is probability dealt a straight in 5 cards?', '1/128', '1/254', '1/693', '1/10', 'B'),
(1, 'Probability of no pairs in 5 cards?', '1/2', '1/10', '1/5', '1/3', 'A');

INSERT INTO [QuizQuestion] 
([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice])
VALUES
(2, 'What is the chance of drawing a red card from a standard UNO deck (25 of each color in 108 total cards)?', '25/108', '1/4', '1/2', '1/8', 'A'),
(2, 'What is the probability of drawing a Wild card on your turn? (8 wild cards in 108 total cards)', '8/108', '4/108', '16/108', '12/108', 'A'),
(2, 'What is the probability the next card is a blue reverse? (2 blue reverse cards in 108 total)', '1/108', '2/108', '4/108', '1/54', 'B'),
(2, 'In UNO, P(drawing skip card | 8/108)?', '8/108', '4/108', '12/108', '16/108', 'A'),
(2, 'UNO: P(no red in 5 cards)? (83/108 * 82/107 * ...)', '≈0.25', '≈0.35', '≈0.45', '≈0.55', 'C'),
(2, 'UNO: Probability first card is wild, second is skip? (8*8/108/107)', '≈0.006', '≈0.008', '≈0.01', '≈0.02', 'B'),
(2, 'UNO: If you have 3 yellow cards, P(opponent has no yellows)?', '≈0.45', '≈0.55', '≈0.65', '≈0.75', 'B'),
(2, 'UNO: P(top card is not a number card)? (32/108)', '1/4', '1/3', '32/108', '3/4', 'C'),
(2, 'What is the chance the next player can play a card if only color needs to match and they have 7 cards?', '≈0.55', '≈0.65', '≈0.75', '≈0.85', 'C'),
(2, 'UNO: If all number cards are gone, P(drawing wild)?', '8/108', '8/76', '8/100', '8/80', 'B');

INSERT INTO [QuizQuestion] 
([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice])
VALUES
(3, 'In simplified Mahjong, what is the probability of drawing a bamboo tile from a full set of 36 bamboo, 36 character, and 36 dot tiles?', '1/2', '1/3', '1/4', '1/6', 'B'),
(3, 'What is the chance of drawing a dragon tile (There are 12 dragons in 144 tiles)?', '1/10', '1/12', '1/15', '1/18', 'B'),
(3, 'What is the chance of drawing a flower tile (8 in 144)?', '8/144', '4/144', '12/144', '16/144', 'A'),
(3, 'What is the chance that a random tile is a "character" tile (36 of 144)?', '1/2', '1/3', '1/4', '1/5', 'B'),
(3, 'Probability of drawing a wind tile (16 of 144)?', '1/9', '1/8', '1/10', '1/6', 'B'),
(3, 'Probability that two randomly drawn tiles are both dots (without replacement)?', '(36/144)*(35/143)', '(36/144)*(36/143)', '(35/144)*(34/143)', '(16/144)*(15/143)', 'A'),
(3, 'Chance first drawn tile is NOT a flower (136/144)?', '1/2', '136/144', '1/3', '144/136', 'B'),
(3, 'Probability of drawing a 1-bamboo in three draws (4 in 144)?', '4/144', '12/144', '8/144', '16/144', 'A'),
(3, 'Draw a dragon then a wind in two draws? (12/144)*(16/143)', '1/81', '1/90', '1/100', '1/120', 'B'),
(3, 'One tile is green. Probability it''s a green dragon? (4/144)', '1/36', '1/12', '1/18', '1/48', 'A');

INSERT INTO [QuizQuestion] 
([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice])
VALUES
(4, 'What is the probability of rolling a 6 on a fair die?', '1/2', '1/4', '1/6', '1/12', 'C'),
(4, 'What is the probability of rolling an even number on a fair six-sided die?', '1/6', '1/3', '1/2', '2/3', 'C'),
(4, 'What is the probability of rolling two dice and getting a total sum of 7?', '1/12', '1/8', '1/6', '1/9', 'A'),
(4, 'What is the probability of rolling doubles with two dice?', '1/12', '1/8', '1/6', '1/9', 'A'),
(4, 'If you roll a die twice, what is the probability both are 1?', '(1/6)^2', '1/6', '1/3', '1/12', 'A'),
(4, 'Rolling a die, what''s the chance of NOT getting a 5?', '5/6', '1/6', '2/3', '1/3', 'A'),
(4, 'What is the probability to roll a 2 or 4?', '1/6', '1/3', '1/2', '2/3', 'B'),
(4, 'Probability of sum 12 with two dice?', '1/12', '1/36', '1/6', '1/24', 'B'),
(4, 'Probability of getting a 3 prior to a 6 in repeated rolls?', '1/3', '1/2', '1/4', '1/6', 'B'),
(4, 'You roll 3 dice. What''s the probability at least one is a 6?', '1 - (5/6)^3', '1/6', '3/6', '1/3', 'A');

INSERT INTO [QuizQuestion] 
([QuizID], [QuestionText], [ChoiceA], [ChoiceB], [ChoiceC], [ChoiceD], [CorrectChoice])
VALUES
(5, 'What is the probability of getting three cherries if each slot has 1/10 chance for cherries?', '(1/10)^3', '3/10', '1/10', '1/30', 'A'),
(5, 'Each spin on a slot machine is independent. If a cherry appears once, what is the chance it appears in the next spin?', 'Still 1/10', '1/5', '1/20', '1', 'A'),
(5, 'What is the probability of NOT getting a cherry (1/10 chance for cherries) in a single pull?', '9/10', '1/10', '1/5', '1/9', 'A'),
(5, 'If there are 5 different symbols in a slot, what''s the probability of getting three of the same symbol in a row? (equal chance)', '(1/5)^3', '3/5', '1/5', '1/15', 'A'),
(5, 'Probability of getting the bell symbol twice in two spins if P(bell)=1/20?', '(1/20)^2', '1/20', '1/10', '1/40', 'A'),
(5, 'If chance for jackpot is 1/250, play 3 times, P(at least one jackpot)?', '1 - (249/250)^3', '(1/250)*3', '1/250', '(1/250)^3', 'A'),
(5, 'P(cherry in first, orange in second), both P=1/10?', '(1/10)^2', '1/10', '2/10', '1/5', 'A'),
(5, 'With 8 symbols, chance of THREE sevens in a row?', '(1/8)^3', '3/8', '1/8', '1/24', 'A'),
(5, 'Play 10 times, never get a diamond (P=1/16) each time)?', '(15/16)^10', '(1/16)^10', '10/16', '15/16', 'A'),
(5, 'P(bar, cherry, and orange in any order in 3 spins)?', '6*(1/10)^3', '(1/10)^3', '3*(1/10)^3', '1/10', 'A');