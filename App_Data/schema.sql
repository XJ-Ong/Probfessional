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
    [ID]       INT            IDENTITY (1, 1) NOT NULL,
    [ModuleID] INT            NOT NULL,
    [Title]    NVARCHAR (255) NOT NULL,
    [Content]  NVARCHAR (MAX) NULL,
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
INSERT INTO [Lessons] ([ModuleID], [Title], [Content])
VALUES
(1, 'Topic 1: Basic Poker Probability Concepts', '<h2>Probability in Poker</h2>

                        <p>Poker uses a standard 52-card deck, offering a perfect platform for exploring probability through card games. Understanding probability in poker is essential for making informed betting decisions and reading the game effectively. Each card dealt changes the probability landscape, as cards are drawn without replacement, making the calculations more complex than simple independent events.</p>

                        <p>Probability in poker involves calculating the odds of various hands, understanding how the number of cards already dealt affects your chances, and recognizing when the odds are in your favor. Professional poker players rely heavily on probability calculations to determine whether to bet, call, raise, or fold. The key to success lies in combining probability knowledge with psychological insight and strategic thinking.</p>

                        <img src=''/ImgModule/poker.jpg'' alt=''Poker cards'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Card Probabilities</h3>

                        <ul>

                            <li><strong>Drawing an Ace:</strong> 4 Aces out of 52 cards = <strong>4/52 = 1/13</strong></li>

                            <li><strong>Red card:</strong> 26 red cards (hearts + diamonds) out of 52 = <strong>26/52 = 1/2</strong> (50%)</li>

                            <li><strong>Specific suit (e.g., hearts):</strong> 13 hearts out of 52 = <strong>13/52 = 1/4</strong></li>

                        </ul>

                        <h3>Hand Probabilities</h3>

                        <ul>

                            <li><strong>Pair in two cards:</strong> First card can be anything, second must match = <strong>3/51 = 1/17</strong></li>

                            <li><strong>Flush (5 cards, same suit):</strong> Approximately <strong>1/508</strong></li>

                            <li><strong>Full house:</strong> Approximately <strong>1/693</strong></li>

                            <li><strong>Straight:</strong> Approximately <strong>1/254</strong></li>

                        </ul>

                        <h3>Key Concepts</h3>

                        <ul>

                            <li>Cards are drawn without replacement, so probabilities change as cards are dealt</li>

                            <li>Combinations matter more than order in poker hands</li>

                            <li>Understanding odds helps make better betting decisions</li>

                        </ul>'),

(1, 'Topic 2: Card Drawing Probabilities', '<h2>Probability of Drawing Specific Cards</h2>

                        <p>In poker, understanding the probability of drawing specific cards is fundamental to making strategic decisions. Each card drawn changes the remaining deck composition.</p>

                        <img src=''/ImgModule/poker.jpg'' alt=''Poker card drawing'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Single Card Draws</h3>

                        <ul>

                            <li><strong>Ace:</strong> P(Ace) = 4/52 = 1/13 ≈ 7.69%</li>

                            <li><strong>Red Card:</strong> P(red) = 26/52 = 1/2 = 50%</li>

                            <li><strong>Heart:</strong> P(heart) = 13/52 = 1/4 = 25%</li>

                            <li><strong>Face Card:</strong> P(face card) = 12/52 = 3/13 ≈ 23.08%</li>

                        </ul>

                        <h3>Multiple Card Scenarios</h3>

                        <ul>

                            <li>P(first two cards both spades) = (13/52) × (12/51) ≈ 5.88%</li>

                            <li>P(king and queen in two draws) = 2 × (4/52) × (4/51) ≈ 1.21%</li>

                            <li>P(at least one Ace in two cards) = 1 - P(no Aces) = 1 - (48/52)×(47/51) ≈ 14.93%</li>

                        </ul>

                        <h3>Color and Suit Probabilities</h3>

                        <ul>

                            <li>P(black card) = P(black) = 26/52 = 1/2 = 50%</li>

                            <li>P(specific suit) = 13/52 = 1/4 = 25% for any suit</li>

                            <li>P(same color in two draws) = (26/52) × (25/51) ≈ 24.51%</li>

                        </ul>

                        <p><strong>Key Point:</strong> Probabilities change with each card drawn - the deck gets smaller!</p>'),

(1, 'Topic 3: Poker Hand Probabilities', '<h2>Calculating Poker Hand Probabilities</h2>

                        <p>Understanding the probability of different poker hands is crucial for strategic play. These probabilities help players assess the strength of their hand and make informed betting decisions.</p>

                        <img src=''/ImgModule/poker.jpg'' alt=''Poker hands'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Common Hand Probabilities</h3>

                        <ul>

                            <li><strong>Pair (in 5 cards):</strong> Approximately 42.26%</li>

                            <li><strong>Two Pair:</strong> Approximately 4.75%</li>

                            <li><strong>Three of a Kind:</strong> Approximately 2.11%</li>

                            <li><strong>Straight:</strong> Approximately 0.39% (1 in 254)</li>

                            <li><strong>Flush:</strong> Approximately 0.20% (1 in 508)</li>

                            <li><strong>Full House:</strong> Approximately 0.14% (1 in 693)</li>

                            <li><strong>Four of a Kind:</strong> Approximately 0.024%</li>

                            <li><strong>Straight Flush:</strong> Approximately 0.0014%</li>

                        </ul>

                        <h3>Probability Calculations</h3>

                        <ul>

                            <li>P(pair in first two cards) = 3/51 = 1/17 ≈ 5.88%</li>

                            <li>P(flush requires 5 cards of same suit) = (13/52) × (12/51) × (11/50) × (10/49) × (9/48) × 4 ≈ 0.198%</li>

                            <li>Calculations become complex with multiple cards!</li>

                        </ul>

                        <h3>Strategic Application</h3>

                        <ul>

                            <li>Understanding hand probabilities helps assess betting value</li>

                            <li>Rare hands (straight, flush) have high value</li>

                            <li>Common hands (pairs) are valuable but less rare</li>

                        </ul>

                        <p><strong>Remember:</strong> These probabilities assume random, fair dealing!</p>'),

(1, 'Topic 4: Poker Deck Structure and Review', '<h3>Standard Poker Deck</h3><p>A standard deck has <strong>52 cards</strong>: 4 suits (hearts, diamonds, clubs, spades) with 13 ranks each (A, 2-10, J, Q, K).</p><p><strong>Probability Basics:</strong></p><ul><li>Probability of drawing an Ace: 4/52 = 1/13</li><li>Probability of drawing a red card: 26/52 = 1/2</li><li>Probability of drawing a heart: 13/52 = 1/4</li><li>Probability of drawing a King: 4/52 = 1/13</li></ul><p><strong>Key Formula:</strong> P(Event) = Number of favorable outcomes / Total possible outcomes</p><p><strong>Practice:</strong></p><ul><li>P(Ace) = 4/52 = 1/13</li><li>P(red card) = 26/52 = 1/2</li><li>P(heart) = 13/52 = 1/4</li></ul>'),

(1, 'Topic 5: Card Combinations and Pairs', '<h3>Drawing Multiple Cards</h3><p>When drawing cards <strong>without replacement</strong>, the deck size decreases with each draw.</p><p><strong>Probability of a Pair:</strong></p><ul><li>First card: any card (52/52 = 1)</li><li>Second card matching: 3 remaining cards of same rank out of 51 cards = 3/51</li><li>P(pair) = 3/51 ≈ 1/17</li></ul><p><strong>Same Suit Probability:</strong></p><ul><li>First card spade: 13/52 = 1/4</li><li>Second card spade: 12/51</li><li>P(both spades) = (13/52) × (12/51) = (1/4) × (12/51) = 12/204 = 1/17</li></ul><p><strong>Sequential Drawing:</strong></p><ul><li>Order matters: P(King then Queen) = (4/52) × (4/51)</li><li>For order: P = (4/52) × (4/51) × 2 = 2/1326 (accounting for both orders)</li></ul><p><strong>Practice:</strong></p><ul><li>P(pair in two cards) = 3/51 ≈ 1/17</li><li>P(both spades) = 1/17</li><li>P(King then Queen, order matters) = 2/1326</li></ul>'),

(1, 'Topic 6: Complex Poker Hands', '<h3>Poker Hands: Flushes, Straights, and Full Houses</h3><p><strong>Flush (all same suit):</strong></p><ul><li>Ways to choose 5 cards from 13 of same suit: C(13,5)</li><li>Total ways to choose 5 cards: C(52,5)</li><li>P(flush) = 4 × C(13,5) / C(52,5) ≈ 1/508</li></ul><p><strong>Straight (5 consecutive ranks):</strong></p><ul><li>10 possible straights (A-5 through 10-A)</li><li>Each can be any suit: 4⁵ = 1024 ways</li><li>P(straight) ≈ 1/254</li></ul><p><strong>Full House (3 of one rank, 2 of another):</strong></p><ul><li>13 ways to choose rank for triple, 12 ways for pair</li><li>P(full house) ≈ 1/693</li></ul><p><strong>No Pairs:</strong> P(no pairs in 5 cards) ≈ 0.504</p><p><strong>Practice:</strong></p><ul><li>P(flush) ≈ 1/508</li><li>P(straight) ≈ 1/254</li><li>P(full house) ≈ 1/693</li><li>P(no pairs) ≈ 0.504</li></ul>'),

-- MODULE 2: UNO (6 Topics)
(2, 'Topic 1: UNO Card Distribution and Basic Probability', '<h2>Probability in UNO</h2>

                        <p>UNO uses a deck of 108 cards with specific color and card distributions, creating an engaging way to learn probability through strategic card gameplay. The probability of drawing specific cards changes as the game progresses because cards are not replaced after being drawn. This dynamic nature of probability makes UNO an excellent teaching tool for understanding conditional probability and sampling without replacement.</p>

                        <p>Understanding probability in UNO helps players make better strategic decisions. For example, knowing the probability that an opponent has a card of a certain color can influence whether you should change colors or play a wild card. As cards are drawn and discarded throughout the game, the probability calculations become more accurate, allowing skilled players to anticipate likely outcomes and plan their moves accordingly. This demonstrates how probability knowledge can be applied practically in games and decision-making.</p>

                        <img src=''/ImgModule/uno.png'' alt=''UNO cards'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Card Distribution</h3>

                        <ul>

                            <li><strong>Each color (Red, Blue, Green, Yellow):</strong> 25 cards per color</li>

                            <li><strong>Number cards:</strong> 76 cards (0-9 for each color, with duplicates for 1-9)</li>

                            <li><strong>Action cards (Skip, Reverse, Draw Two):</strong> 24 cards total</li>

                            <li><strong>Wild cards:</strong> 8 cards (4 Wild, 4 Wild Draw Four)</li>

                        </ul>

                        <h3>Basic Probabilities</h3>

                        <ul>

                            <li><strong>Drawing a red card:</strong> P(red) = 25/108 ≈ <strong>0.231</strong></li>

                            <li><strong>Drawing a Wild card:</strong> P(wild) = 8/108 = <strong>2/27</strong></li>

                            <li><strong>Drawing a Skip card:</strong> P(skip) = 8/108 = <strong>2/27</strong></li>

                            <li><strong>Top card is not a number:</strong> P(action/wild) = 32/108 ≈ <strong>0.296</strong></li>

                        </ul>

                        <h3>Strategic Applications</h3>

                        <ul>

                            <li>Probability changes as cards are drawn (without replacement)</li>

                            <li>Knowing remaining cards helps predict opponent''s hand</li>

                            <li>Probability of matching increases if you have cards of the current color</li>

                        </ul>

                        <p><strong>Note:</strong> UNO uses sampling without replacement, so probabilities update after each draw!</p>'),

(2, 'Topic 2: Color Matching and Conditional Probability', '<h2>Color Matching Probabilities in UNO</h2>

                        <p>UNO''s color-matching mechanic introduces conditional probability concepts. The probability of matching depends on what card is currently in play and what cards remain in the deck.</p>

                        <img src=''/ImgModule/uno.png'' alt=''UNO color matching'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Color Matching Basics</h3>

                        <ul>

                            <li>P(matching red if red is in play) depends on remaining red cards</li>

                            <li>If 20 red cards remain from 90 total, P(red) = 20/90 ≈ 22.2%</li>

                            <li>P(matching current color) changes as game progresses</li>

                        </ul>

                        <h3>Strategic Probability</h3>

                        <ul>

                            <li>Playing a color change affects opponent''s matching probability</li>

                            <li>If opponent has 7 cards, P(they can play) ≈ 1/4 if colors are balanced</li>

                            <li>Wild cards can change probability landscape instantly</li>

                        </ul>

                        <h3>Conditional Probability</h3>

                        <ul>

                            <li>P(drawing red | red is current color) depends on deck state</li>

                            <li>P(opponent can play | they have N cards) requires deck analysis</li>

                            <li>Probability updates with each card played</li>

                        </ul>

                        <p><strong>Tip:</strong> Track played cards to improve probability estimates!</p>'),

(2, 'Topic 3: Action Cards and Special Probabilities', '<h2>Probability of Drawing Action and Wild Cards</h2>

                        <p>UNO''s special cards (Skip, Reverse, Draw Two, Wild) have different probabilities that affect gameplay strategy. Understanding these probabilities helps make better decisions.</p>

                        <img src=''/ImgModule/uno.png'' alt=''UNO action cards'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Action Card Probabilities</h3>

                        <ul>

                            <li><strong>Skip Cards:</strong> 8 total (2 per color) = P(skip) = 8/108 = 2/27 ≈ 7.41%</li>

                            <li><strong>Reverse Cards:</strong> 8 total (2 per color) = P(reverse) = 8/108 = 2/27 ≈ 7.41%</li>

                            <li><strong>Draw Two:</strong> 8 total (2 per color) = P(draw two) = 8/108 = 2/27 ≈ 7.41%</li>

                            <li><strong>Wild Cards:</strong> 8 total (4 Wild, 4 Wild Draw Four) = P(wild) = 8/108 = 2/27 ≈ 7.41%</li>

                        </ul>

                        <h3>Combined Probabilities</h3>

                        <ul>

                            <li>P(any action card) = 24/108 = 2/9 ≈ 22.22%</li>

                            <li>P(action or wild) = (24 + 8)/108 = 32/108 ≈ 29.63%</li>

                            <li>P(number card) = 76/108 ≈ 70.37%</li>

                        </ul>

                        <h3>Game Progression Effects</h3>

                        <ul>

                            <li>As cards are played, probabilities of remaining cards increase</li>

                            <li>If many action cards are played, remaining deck has more number cards</li>

                            <li>Strategic card counting improves probability estimates</li>

                        </ul>

                        <p><strong>Strategy:</strong> Track which special cards have been played to better predict remaining deck composition!</p>'),

(2, 'Topic 4: UNO Deck Structure and Review', '<h3>Understanding the UNO Deck</h3><p>A standard UNO deck has <strong>108 cards</strong>:</p><ul><li>4 colors (Red, Blue, Green, Yellow) × 25 cards each = 100 colored cards</li><li>8 Wild cards</li><li>8 special action cards (Skip, Reverse, Draw Two)</li></ul><p><strong>Basic Probabilities:</strong></p><ul><li>P(red card) = 25/108</li><li>P(wild card) = 8/108 = 2/27</li><li>P(skip card) = 8/108 = 2/27</li><li>P(blue reverse) = 2/108 = 1/54</li></ul><p><strong>Practice:</strong></p><ul><li>P(red card) = 25/108</li><li>P(wild card) = 8/108 = 2/27</li><li>P(skip card) = 8/108 = 2/27</li><li>P(blue reverse) = 2/108 = 1/54</li></ul>'),

(2, 'Topic 5: Drawing Multiple Cards', '<h3>Card Drawing Probability</h3><p>When drawing cards <strong>without replacement</strong>, the deck size decreases, affecting probabilities.</p><p><strong>Examples:</strong></p><ul><li>P(no red in 5 cards): Draw 5 cards, none are red</li><li>First card not red: 83/108</li><li>Second card not red: 82/107</li><li>Continuing: P = (83/108) × (82/107) × (81/106) × (80/105) × (79/104) ≈ 0.24</li></ul><p><strong>Sequential Events:</strong></p><ul><li>P(wild then skip): (8/108) × (8/107) ≈ 0.0055</li><li>P(first card wild, second skip): (8/108) × (8/107)</li></ul><p><strong>Conditional Probability:</strong> If all number cards are gone, P(drawing wild) = 8/32 = 1/4</p><p><strong>Practice:</strong></p><ul><li>P(no red in 5 cards) ≈ 0.24</li><li>P(wild then skip) ≈ 0.0055</li><li>P(top card not a number card) = 32/108</li></ul>'),

(2, 'Topic 6: Game Strategy and Probabilities', '<h3>Strategic Probability in UNO</h3><p><strong>Color Matching:</strong></p><ul><li>With 7 cards in hand, probability of having a matching color depends on deck composition</li><li>If top card is red, P(you have red card) ≈ 1/4</li></ul><p><strong>Special Cards:</strong></p><ul><li>P(top card is not a number card): 32 special cards / 108 = 32/108</li><li>P(drawing skip card): 8/108 = 2/27</li></ul><p><strong>Game State Impact:</strong></p><ul><li>As cards are played, probabilities change</li><li>If you have 3 yellow cards, P(opponent has no yellows) depends on remaining deck</li><li>Later in game, probabilities shift significantly</li></ul><p><strong>Practice:</strong></p><ul><li>P(opponent can play if top card is red) ≈ 1/4</li><li>P(drawing skip card) = 8/108 = 2/27</li><li>P(all number cards gone, then wild) = 8/32 = 1/4</li></ul>'),

-- MODULE 3: MAHJONG (6 Topics)
(3, 'Topic 1: Introduction to Mahjong Probability', '<h2>Probability with Mahjong Tiles</h2>

                        <p>Mahjong uses a set of 144 tiles divided into different categories, creating a rich environment for exploring probability. Unlike dice where outcomes are independent, Mahjong demonstrates sampling without replacement - each tile drawn changes the probability of drawing subsequent tiles. This makes probability calculations in Mahjong more dynamic and interesting.</p>

                        <p>Understanding probability in Mahjong is crucial for strategic gameplay. Knowing the likelihood of drawing specific tiles helps players make informed decisions about which tiles to keep and which to discard. Since tiles are not replaced after drawing, the probabilities constantly shift throughout the game, requiring players to recalculate odds as the game progresses.</p>

                        <img src=''/ImgModule/mahjong.jpeg'' alt=''Mahjong tiles'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Tile Distribution</h3>

                        <ul>

                            <li><strong>Bamboo tiles:</strong> 36 tiles (1/3 of deck)</li>

                            <li><strong>Character tiles:</strong> 36 tiles (1/3 of deck)</li>

                            <li><strong>Dot tiles:</strong> 36 tiles (1/3 of deck)</li>

                            <li><strong>Dragon tiles:</strong> 12 tiles (1/12 of deck)</li>

                            <li><strong>Wind tiles:</strong> 16 tiles (1/9 of deck)</li>

                            <li><strong>Flower tiles:</strong> 8 tiles (1/18 of deck)</li>

                        </ul>

                        <h3>Probability Calculations</h3>

                        <ul>

                            <li><strong>Drawing a specific suit:</strong> P(bamboo) = 36/144 = <strong>1/4</strong></li>

                            <li><strong>Drawing a dragon:</strong> P(dragon) = 12/144 = <strong>1/12</strong></li>

                            <li><strong>Not drawing a flower:</strong> P(no flower) = 136/144 = <strong>17/18</strong></li>

                            <li><strong>Two consecutive draws (without replacement):</strong> Outcomes depend on first draw, reducing total available tiles</li>

                        </ul>

                        <p><strong>Tip:</strong> In Mahjong, probability changes as tiles are drawn because tiles are not replaced (sampling without replacement).</p>'),

(3, 'Topic 2: Sampling Without Replacement', '<h2>Understanding Sampling Without Replacement</h2>

                        <p>Mahjong demonstrates a crucial probability concept: sampling without replacement. Unlike dice where each roll is independent, Mahjong tiles are removed from the deck once drawn, affecting all subsequent probabilities.</p>

                        <img src=''/ImgModule/mahjong.jpeg'' alt=''Mahjong tiles distribution'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>How It Works</h3>

                        <ul>

                            <li><strong>Initial Probability:</strong> P(bamboo tile) = 36/144 = 1/4 at start</li>

                            <li><strong>After Drawing One:</strong> P(bamboo) = 35/143 if first was bamboo, or 36/143 if first was not</li>

                            <li>Each draw changes the remaining pool and probabilities</li>

                        </ul>

                        <h3>Consecutive Draws</h3>

                        <ul>

                            <li>P(drawing two bamboo tiles in a row) = (36/144) × (35/143) ≈ 0.0616</li>

                            <li>P(drawing dragon then flower) = (12/144) × (8/143) ≈ 0.0047</li>

                            <li>Order matters in these calculations!</li>

                        </ul>

                        <h3>Strategic Implications</h3>

                        <ul>

                            <li>As tiles are drawn, probabilities update continuously</li>

                            <li>Players must recalculate odds throughout the game</li>

                            <li>Knowing which tiles have been played affects future draws</li>

                        </ul>

                        <p><strong>Application:</strong> This concept applies to many card games and real-world sampling scenarios!</p>'),

(3, 'Topic 3: Tile Categories and Probability', '<h2>Mahjong Tile Categories and Their Probabilities</h2>

                        <p>Understanding the distribution of tile categories in Mahjong is essential for calculating probabilities accurately. Each category has different counts, affecting their individual probabilities.</p>

                        <img src=''/ImgModule/mahjong.jpeg'' alt=''Mahjong categories'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Major Categories</h3>

                        <ul>

                            <li><strong>Suit Tiles:</strong> Bamboo, Character, Dot (36 each = 108 total)</li>

                            <li>Each suit has probability 36/144 = 1/4 = 25%</li>

                            <li><strong>Honor Tiles:</strong> Dragons (12) + Winds (16) = 28 total</li>

                            <li><strong>Special Tiles:</strong> Flowers (8 tiles = 1/18 probability)</li>

                        </ul>

                        <h3>Calculating Specific Probabilities</h3>

                        <ul>

                            <li>P(specific suit, e.g., bamboo) = 36/144 = 1/4</li>

                            <li>P(dragon tile) = 12/144 = 1/12 ≈ 8.33%</li>

                            <li>P(wind tile) = 16/144 = 1/9 ≈ 11.11%</li>

                            <li>P(flower tile) = 8/144 = 1/18 ≈ 5.56%</li>

                        </ul>

                        <h3>Combined Probabilities</h3>

                        <ul>

                            <li>P(any suit tile) = 108/144 = 3/4 = 75%</li>

                            <li>P(honor or flower) = (28 + 8)/144 = 36/144 = 1/4 = 25%</li>

                            <li>P(NOT a flower) = 136/144 = 17/18 ≈ 94.44%</li>

                        </ul>

                        <p><strong>Remember:</strong> Probabilities must add up to 100% when considering all possible outcomes!</p>'),

(3, 'Topic 4: Mahjong Tile Composition', '<h3>Understanding Mahjong Tiles</h3><p>A standard Mahjong set has <strong>144 tiles</strong>:</p><ul><li>36 Bamboo tiles</li><li>36 Character tiles</li><li>36 Dot tiles</li><li>12 Dragon tiles (4 each of 3 types)</li><li>16 Wind tiles (4 each of 4 directions)</li><li>8 Flower tiles</li></ul><p><strong>Basic Probabilities:</strong></p><ul><li>P(bamboo tile) = 36/144 = 1/4</li><li>P(dragon tile) = 12/144 = 1/12</li><li>P(flower tile) = 8/144 = 1/18</li><li>P(character tile) = 36/144 = 1/4</li><li>P(wind tile) = 16/144 = 1/9</li></ul><p><strong>Practice:</strong></p><ul><li>P(bamboo) = 36/144 = 1/4</li><li>P(dragon) = 12/144 = 1/12</li><li>P(flower) = 8/144 = 1/18</li><li>P(wind) = 16/144 = 1/9</li></ul>'),

(3, 'Topic 5: Drawing Tiles Without Replacement', '<h3>Mahjong Tile Drawing</h3><p>Mahjong involves drawing tiles <strong>without replacement</strong>, so probabilities change with each draw.</p><p><strong>Multiple Draws:</strong></p><ul><li>P(both dots without replacement): First dot = 36/144, second dot = 35/143</li><li>P(both dots) = (36/144) × (35/143) = 35/572</li></ul><p><strong>Complement Rule:</strong></p><ul><li>P(not flower) = 136/144</li><li>P(first tile not flower) = 136/144</li></ul><p><strong>Specific Tiles:</strong></p><ul><li>There are 4 tiles of each numbered rank</li><li>P(drawing 1-bamboo in three draws): Complex calculation involving combinations</li><li>P ≈ 1/36</li></ul><p><strong>Practice:</strong></p><ul><li>P(both dots) = (36/144) × (35/143) = 35/572</li><li>P(not flower) = 136/144</li><li>P(1-bamboo in three draws) ≈ 1/36</li></ul>'),

(3, 'Topic 6: Sequential Draws and Combinations', '<h3>Mahjong Probability Strategies</h3><p><strong>Sequential Draws:</strong></p><ul><li>P(dragon then wind): (12/144) × (16/143) = 1/108</li><li>Order matters in sequential draws</li></ul><p><strong>Color/Type Probabilities:</strong></p><ul><li>If a tile is green, P(it''s green dragon): 4 green dragons / total green tiles</li><li>P(green dragon | green tile) = 4/144 = 1/36</li></ul><p><strong>Winning Combinations:</strong></p><ul><li>Mahjong involves creating specific tile combinations</li><li>Understanding tile probabilities helps predict opponents'' hands</li><li>Strategic play requires calculating remaining tile probabilities</li></ul><p><strong>Practice:</strong></p><ul><li>P(dragon then wind) = (12/144) × (16/143) = 1/108</li><li>P(green dragon | green tile) = 4/144 = 1/36</li><li>P(drawing a wind tile) = 16/144 = 1/9</li></ul>'),

-- MODULE 4: DICE (6 Topics)
(4, 'Topic 1: Introduction to Dice Probability', '<h2>Understanding Dice Probability</h2>

                        <p>Dice are one of the simplest tools for learning probability. A standard die has 6 faces, numbered 1 through 6, making it perfect for understanding basic probability concepts. When you roll a die, each face has an equal chance of landing face up, which means each number from 1 to 6 has a probability of 1/6 or approximately 16.67%.</p>

                        <p>Probability is fundamentally about understanding the likelihood of different outcomes. With dice, we can explore simple events like rolling a specific number, as well as more complex scenarios involving multiple dice. The beauty of dice probability lies in its simplicity - the outcomes are clear, the possibilities are finite, and the calculations are straightforward.</p>

                        <img src=''/ImgModule/dice.jpeg'' alt=''Six-sided dice'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Basic Concepts</h3>

                        <ul>

                            <li><strong>Single Die:</strong> Probability of rolling any specific number (1-6) is <strong>1/6</strong> or approximately 16.67%</li>

                            <li><strong>Even Numbers:</strong> Probability of rolling 2, 4, or 6 is <strong>3/6 = 1/2</strong> (50%)</li>

                            <li><strong>Two Dice:</strong> When rolling two dice, outcomes are independent. Total possible outcomes = 6 × 6 = 36</li>

                        </ul>

                        <h3>Common Scenarios</h3>

                        <ul>

                            <li><strong>Sum of 7:</strong> The most likely sum with two dice (6 ways: 1+6, 2+5, 3+4, 4+3, 5+2, 6+1) = <strong>6/36 = 1/6</strong></li>

                            <li><strong>Doubles:</strong> Probability of rolling the same number on both dice = <strong>6/36 = 1/6</strong></li>

                            <li><strong>At least one 6:</strong> When rolling two dice, P(at least one 6) = 1 - P(no sixes) = 1 - (5/6)² = <strong>11/36</strong></li>

                        </ul>

                        <p><strong>Key Formula:</strong> P(Event) = Number of favorable outcomes / Total possible outcomes</p>'),

(4, 'Topic 2: Single Die Outcomes', '<h2>Understanding Single Die Outcomes</h2>

                        <p>When working with a single die, the probability calculations are straightforward. Each face of a standard six-sided die has an equal probability of 1/6. This fundamental concept helps us understand basic probability theory.</p>

                        <img src=''/ImgModule/dice.jpeg'' alt=''Dice outcomes'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Key Principles</h3>

                        <ul>

                            <li><strong>Equal Probability:</strong> Each number (1-6) has probability 1/6 = 16.67%</li>

                            <li><strong>Even Numbers:</strong> Probability of 2, 4, or 6 = 3/6 = 1/2 = 50%</li>

                            <li><strong>Odd Numbers:</strong> Probability of 1, 3, or 5 = 3/6 = 1/2 = 50%</li>

                            <li><strong>Specific Range:</strong> Probability of rolling 3 or 4 = 2/6 = 1/3</li>

                        </ul>

                        <h3>Complementary Events</h3>

                        <ul>

                            <li>P(rolling 6) = 1/6, therefore P(NOT rolling 6) = 1 - 1/6 = 5/6</li>

                            <li>P(rolling at least 4) = P(4, 5, or 6) = 3/6 = 1/2</li>

                            <li>P(rolling less than 3) = P(1 or 2) = 2/6 = 1/3</li>

                        </ul>

                        <p><strong>Practice Tip:</strong> Always verify probabilities add up to 1 when covering all possible outcomes!</p>'),

(4, 'Topic 3: Multiple Dice and Sums', '<h2>Probability with Multiple Dice</h2>

                        <p>When rolling two or more dice, the probability calculations become more complex. Each die operates independently, creating a larger sample space of possible outcomes.</p>

                        <img src=''/ImgModule/dice.jpeg'' alt=''Multiple dice'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Two Dice Calculations</h3>

                        <ul>

                            <li><strong>Total Outcomes:</strong> 6 × 6 = 36 possible combinations</li>

                            <li><strong>Sum of 7:</strong> Most common sum (6 ways) = 6/36 = 1/6 ≈ 16.67%</li>

                            <li><strong>Sum of 2:</strong> Only one way (1+1) = 1/36 ≈ 2.78%</li>

                            <li><strong>Sum of 12:</strong> Only one way (6+6) = 1/36 ≈ 2.78%</li>

                        </ul>

                        <h3>Probability Distribution</h3>

                        <ul>

                            <li>Sums of 6, 7, and 8 are most likely (5, 6, and 5 ways respectively)</li>

                            <li>Extreme sums (2, 12) are least likely (1 way each)</li>

                            <li>Distribution follows a triangular pattern</li>

                        </ul>

                        <h3>Doubles Probability</h3>

                        <ul>

                            <li>P(doubles) = 6/36 = 1/6 (six possible doubles: 1-1, 2-2, 3-3, 4-4, 5-5, 6-6)</li>

                            <li>P(not doubles) = 30/36 = 5/6</li>

                            <li>Each specific double (e.g., two 3s) = 1/36</li>

                        </ul>

                        <p><strong>Key Insight:</strong> The probability distribution for sums is symmetric around 7!</p>'),

(4, 'Topic 4: Introduction to Dice Probability', '<h3>Understanding Basic Dice Probability</h3><p>A standard die has 6 faces, numbered 1 through 6. Each face has an equal probability of appearing when rolled. The probability of any specific outcome is <strong>1/6</strong>.</p><p><strong>Key Concepts:</strong></p><ul><li>Single die: Each outcome has probability 1/6</li><li>Complement rule: P(not A) = 1 - P(A)</li><li>For example, P(not 5) = 1 - 1/6 = 5/6</li><li>Even numbers: There are 3 even numbers (2, 4, 6), so P(even) = 3/6 = 1/2</li></ul><p><strong>Practice Examples:</strong></p><ul><li>What is P(rolling a 6)? Answer: 1/6</li><li>What is P(rolling an even number)? Answer: 1/2</li><li>What is P(rolling NOT a 5)? Answer: 5/6</li></ul>'),

(4, 'Topic 5: Multiple Dice and Sums', '<h3>Rolling Multiple Dice</h3><p>When rolling two dice, the total number of possible outcomes is <strong>6 × 6 = 36</strong>.</p><p><strong>Sum Probabilities:</strong></p><ul><li>Sum of 7: Most likely (6 ways) = 6/36 = 1/6</li><li>Sum of 2 or 12: Least likely (1 way each) = 1/36</li><li>Doubles: 6 ways out of 36 = 1/6</li><li>Sum of 3: 2 ways = 2/36 = 1/18</li></ul><p><strong>Example:</strong> Rolling two dice and getting a sum of 7 occurs in 6 ways: (1,6), (2,5), (3,4), (4,3), (5,2), (6,1).</p><p><strong>Practice:</strong></p><ul><li>P(sum of 12) = 1/36 (only one way: 6+6)</li><li>P(doubles) = 6/36 = 1/6</li><li>P(sum of 2 or 4) = 3/36 = 1/12</li></ul>'),

(4, 'Topic 6: Independent Events and Repeated Rolls', '<h3>Independent Events</h3><p>Each roll of a die is <strong>independent</strong> - previous rolls don''t affect future outcomes.</p><p><strong>Multiplication Rule:</strong> For independent events, P(A and B) = P(A) × P(B)</p><p><strong>Examples:</strong></p><ul><li>Rolling two 1s: (1/6) × (1/6) = 1/36</li><li>Rolling 3 dice, all showing 6: (1/6)³ = 1/216</li><li>Rolling 3 dice, at least one 6: Use complement rule</li><li>P(at least one 6) = 1 - P(no 6s) = 1 - (5/6)³ = 1 - 125/216 = 91/216</li></ul><p><strong>Complement Rule:</strong> When calculating "at least one" probabilities, use P(at least one) = 1 - P(none)</p><p><strong>Practice:</strong></p><ul><li>Roll twice, P(both are 1) = 1/36</li><li>Roll twice, P(never get 5) = (5/6)² = 25/36</li><li>Roll 3 times, P(at least one 6) = 91/216</li></ul>'),

-- MODULE 5: SLOT MACHINES (6 Topics)
(5, 'Topic 1: Independent Events in Slot Machines', '<h2>Probability with Slot Machines</h2>

                        <p>Slot machines provide an excellent example of independent probability events, where each spin is completely independent of previous spins. This fundamental concept is often misunderstood by players who believe in "hot streaks" or "due wins." Understanding that each spin has the same probability regardless of what happened before is crucial for recognizing how probability truly works.</p>

                        <p>Probability in slot machines helps us understand independent events and the multiplication rule of probability. When calculating the probability of multiple independent events occurring together, we multiply their individual probabilities. This explains why getting three specific symbols in a row is so rare - each symbol must appear independently, and the combined probability is the product of each individual probability. This principle applies to many real-world situations beyond gambling.</p>

                        <img src=''/ImgModule/slot_machine.jpeg'' alt=''Slot machine'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Independent Events</h3>

                        <ul>

                            <li><strong>Key Concept:</strong> Each spin is independent - past results do not affect future outcomes</li>

                            <li>If P(cherry) = 1/10, P(cherry) on next spin is still <strong>1/10</strong>, regardless of previous spins</li>

                            <li>The machine has no memory - "hot streaks" and "due wins" are misconceptions</li>

                        </ul>

                        <h3>Multiple Spins</h3>

                        <ul>

                            <li><strong>Three cherries in a row:</strong> If P(cherry) = 1/10 per spin, P(three cherries) = (1/10)³ = <strong>1/1000</strong></li>

                            <li><strong>NOT getting cherry in one spin:</strong> P(no cherry) = 1 - 1/10 = <strong>9/10</strong></li>

                            <li><strong>At least one jackpot in 3 tries:</strong> P(at least one) = 1 - P(none) = 1 - (249/250)³ ≈ <strong>0.012</strong></li>

                        </ul>

                        <h3>Probability Rules</h3>

                        <ul>

                            <li><strong>Multiplication Rule:</strong> For independent events, P(A and B) = P(A) × P(B)</li>

                            <li><strong>Complement Rule:</strong> P(not A) = 1 - P(A)</li>

                            <li>Understanding these rules helps calculate complex probabilities</li>

                        </ul>

                        <p><strong>Important:</strong> Slot machines are games of chance - each outcome is random and independent!</p>'),

(5, 'Topic 2: Multiplication Rule for Independent Events', '<h2>The Multiplication Rule for Independent Events</h2>

                        <p>Slot machines perfectly demonstrate the multiplication rule: when events are independent, the probability of multiple events occurring together is the product of their individual probabilities.</p>

                        <img src=''/ImgModule/slot_machine.jpeg'' alt=''Slot machine probability'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>Understanding the Rule</h3>

                        <ul>

                            <li><strong>Formula:</strong> P(A and B) = P(A) × P(B) for independent events</li>

                            <li>Each spin is independent - previous results don''t affect future spins</li>

                            <li>Probability of multiple outcomes multiplies, making rare events extremely unlikely</li>

                        </ul>

                        <h3>Practical Examples</h3>

                        <ul>

                            <li>P(three cherries) = (1/10)³ = 1/1000 = 0.1% if P(cherry) = 1/10 per slot</li>

                            <li>P(same symbol on all three slots) = (1/n)³ where n = number of symbols</li>

                            <li>P(jackpot in 3 attempts) ≠ 3 × P(jackpot) - must use complement rule!</li>

                        </ul>

                        <h3>Common Misconceptions</h3>

                        <ul>

                            <li><strong>Gambler''s Fallacy:</strong> "I''m due for a win" - FALSE!</li>

                            <li><strong>Hot Streak:</strong> Previous wins don''t increase future probability</li>

                            <li><strong>Machine Memory:</strong> Machines have no memory of past spins</li>

                        </ul>

                        <p><strong>Key Insight:</strong> Independence means past results cannot predict future outcomes!</p>'),

(5, 'Topic 3: Complement Rule and ''At Least'' Problems', '<h2>Using the Complement Rule in Slot Machine Probability</h2>

                        <p>The complement rule is essential for calculating probabilities of "at least one" scenarios, which are more complex than simple multiplication.</p>

                        <img src=''/ImgModule/slot_machine.jpeg'' alt=''Complement rule'' class=''img-fluid mb-3'' style=''max-width:300px;'' />

                        <h3>The Complement Rule</h3>

                        <ul>

                            <li><strong>Formula:</strong> P(A) = 1 - P(not A)</li>

                            <li>P(not getting cherry) = 1 - P(cherry) = 1 - 1/10 = 9/10</li>

                            <li>Useful for calculating "at least one" scenarios</li>

                        </ul>

                        <h3>''At Least One'' Calculations</h3>

                        <ul>

                            <li>P(at least one jackpot in 3 tries) = 1 - P(no jackpot in 3 tries)</li>

                            <li>If P(jackpot) = 1/250, then P(no jackpot) = 249/250</li>

                            <li>P(at least one) = 1 - (249/250)³ ≈ 0.012 = 1.2%</li>

                        </ul>

                        <h3>Multiple Attempt Scenarios</h3>

                        <ul>

                            <li>P(never getting diamond in 10 spins) = (15/16)^10 ≈ 53.7% if P(diamond) = 1/16</li>

                            <li>P(at least one diamond) = 1 - (15/16)^10 ≈ 46.3%</li>

                            <li>More attempts increase the chance of "at least one" success</li>

                        </ul>

                        <p><strong>Application:</strong> This rule applies to any independent repeated trials, not just gambling!</p>'),

(5, 'Topic 4: Independent Events and Slot Machines', '<h3>Understanding Independence</h3><p>Each spin on a slot machine is <strong>completely independent</strong> - previous spins do NOT affect future outcomes.</p><p><strong>Key Concept:</strong> The "gambler''s fallacy" is wrong - if cherries appeared once, P(cherries next spin) is still the same!</p><p><strong>Basic Probabilities:</strong></p><ul><li>If P(cherry) = 1/10 for each reel</li><li>P(three cherries) = (1/10) × (1/10) × (1/10) = 1/1000</li><li>P(not cherry) = 1 - 1/10 = 9/10</li></ul><p><strong>Multiplication Rule:</strong> For independent events: P(A and B) = P(A) × P(B)</p><p><strong>Practice:</strong></p><ul><li>P(three cherries) = (1/10)³ = 1/1000</li><li>P(not cherry) = 9/10</li><li>P(three of same symbol, 5 symbols) = (1/5)³ = 1/125</li></ul>'),

(5, 'Topic 5: Multiple Spins and Combinations', '<h3>Multiple Spins and Symbol Combinations</h3><p><strong>Equal Probability Symbols:</strong> If there are 5 symbols with equal probability:</p><ul><li>P(any symbol) = 1/5</li><li>P(three of same symbol) = (1/5)³ = 1/125</li></ul><p><strong>Multiple Spins:</strong></p><ul><li>P(bell twice in two spins): (1/20) × (1/20) = 1/400</li><li>P(cherry then orange): (1/10) × (1/10) = 1/100</li></ul><p><strong>Different Symbols:</strong></p><ul><li>With 8 symbols, P(three sevens): (1/8)³ = 1/512</li><li>P(bar, cherry, orange in any order): 6 permutations × (1/10)³ = 6/1000</li></ul><p><strong>Practice:</strong></p><ul><li>P(bell twice) = (1/20)² = 1/400</li><li>P(cherry then orange) = (1/10)² = 1/100</li><li>P(three sevens, 8 symbols) = (1/8)³ = 1/512</li></ul>'),

(5, 'Topic 6: At Least One and Repeated Trials', '<h3>"At Least One" Problems</h3><p><strong>Complement Rule:</strong> P(at least one) = 1 - P(none)</p><p><strong>Examples:</strong></p><ul><li>If P(jackpot) = 1/250, play 3 times:</li><li>P(at least one jackpot) = 1 - P(no jackpots)</li><li>P(no jackpots) = (249/250)³</li><li>P(at least one) = 1 - (249/250)³ ≈ 0.01196</li></ul><p><strong>Multiple Failures:</strong></p><ul><li>P(diamond) = 1/16, play 10 times</li><li>P(never get diamond) = (15/16)^10</li><li>Use complement: P(at least one diamond) = 1 - (15/16)^10</li></ul><p><strong>Key Takeaway:</strong> Each spin is independent - past results don''t affect future probabilities!</p><p><strong>Practice:</strong></p><ul><li>P(jackpot in 3 spins) = 1 - (249/250)³ ≈ 0.01196</li><li>P(never diamond in 10 spins) = (15/16)^10</li>                            <li>P(at least one diamond) = 1 - (15/16)^10</li></ul>');
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