-- ==============================================
-- DATABASE: Professional
-- Sample Data Insert Script
-- ==============================================

USE Probfessional
GO

-- Clear existing data (optional - be careful!)
DELETE FROM QuizOptions;
DELETE FROM QuizQuestion;
DELETE FROM QuizAttempts;
DELETE FROM Quiz;
DELETE FROM UserProgress;
DELETE FROM Lessons;
DELETE FROM Modules;
DELETE FROM Users;
GO

-- Reset identity counters (optional)
DBCC CHECKIDENT ('Users', RESEED, 0);
DBCC CHECKIDENT ('Modules', RESEED, 0);
DBCC CHECKIDENT ('Lessons', RESEED, 0);
DBCC CHECKIDENT ('Quiz', RESEED, 0);
DBCC CHECKIDENT ('QuizQuestion', RESEED, 0);
DBCC CHECKIDENT ('QuizOptions', RESEED, 0);
DBCC CHECKIDENT ('QuizAttempts', RESEED, 0);
DBCC CHECKIDENT ('UserProgress', RESEED, 0);
GO

-- ==============================================
-- 1. Insert Users
-- ==============================================
INSERT INTO Users (Email, DisplayName, PasswordHash, Role, CreatedAt, IsActive)
VALUES
    ('admin@probfessional.com', 'System Administrator', 'AQAAAAEAACcQAAAAEExampleAdminHash1234567890abcdefghijklmnopqrstuvwxyz12345', 'Admin', GETDATE(), 1),
    ('teacher.john@probfessional.com', 'John Smith', 'AQAAAAEAACcQAAAAEExampleTeacherHash1234567890abcdefghijklmnopqrstuvwxyz12345', 'Teacher', GETDATE(), 1),
    ('teacher.mary@probfessional.com', 'Mary Johnson', 'AQAAAAEAACcQAAAAEExampleTeacherHash45678901234567890abcdefghijklmnopqrstuvwxyz12345', 'Teacher', GETDATE(), 1),
    ('learner.alice@probfessional.com', 'Alice Williams', 'AQAAAAEAACcQAAAAEExampleLearnerHash1234567890abcdefghijklmnopqrstuvwxyz12345', 'Learner', GETDATE(), 1),
    ('learner.bob@probfessional.com', 'Bob Davis', 'AQAAAAEAACcQAAAAEExampleLearnerHash45678901234567890abcdefghijklmnopqrstuvwxyz12345', 'Learner', GETDATE(), 1),
    ('learner.charlie@probfessional.com', 'Charlie Brown', 'AQAAAAEAACcQAAAAEExampleLearnerHash789012345678901234567890abcdefghijklmnopqrstuv', 'Learner', GETDATE(), 1);
GO

-- ==============================================
-- 2. Insert Modules
-- ==============================================
INSERT INTO Modules (Title, Slug, Description, CreatedAt, ImagePath)
VALUES
    ('Introduction to Web Development', 'introduction-to-web-development', 'Learn the fundamentals of building websites using HTML, CSS, and JavaScript', GETDATE(), '/images/web-dev.jpg'),
    ('ASP.NET Core Fundamentals', 'aspnet-core-fundamentals', 'Master the basics of ASP.NET Core framework for building dynamic web applications', GETDATE(), '/images/aspnet.jpg'),
    ('Database Design and SQL', 'database-design-and-sql', 'Learn how to design databases and write efficient SQL queries', GETDATE(), '/images/database.jpg'),
    ('JavaScript Advanced Concepts', 'javascript-advanced-concepts', 'Deep dive into advanced JavaScript topics including closures, promises, and async/await', GETDATE(), '/images/javascript.jpg'),
    ('Cloud Computing Basics', 'cloud-computing-basics', 'Introduction to cloud platforms like AWS, Azure, and Google Cloud', GETDATE(), '/images/cloud.jpg');
GO

-- ==============================================
-- 3. Insert Lessons
-- ==============================================
INSERT INTO Lessons (ModuleID, Title, Content, [Order])
VALUES
    -- Introduction to Web Development lessons
    (1, 'HTML Basics', '<h1>Welcome to HTML</h1><p>HTML (HyperText Markup Language) is the foundation of web development...</p>', 1),
    (1, 'CSS Styling', '<h1>CSS Styling</h1><p>CSS (Cascading Style Sheets) allows you to style and layout your web pages...</p>', 2),
    (1, 'JavaScript Introduction', '<h1>JavaScript Introduction</h1><p>JavaScript is a programming language that enables interactive web pages...</p>', 3),
    
    -- ASP.NET Core Fundamentals lessons
    (2, 'Setting Up Your First Project', '<h1>ASP.NET Core Setup</h1><p>Learn how to create and configure your first ASP.NET Core application...</p>', 1),
    (2, 'Controllers and Routing', '<h1>Controllers</h1><p>Understanding MVC pattern and routing in ASP.NET Core...</p>', 2),
    (2, 'Working with Views', '<h1>Views and Razor</h1><p>Creating dynamic views using Razor syntax...</p>', 3),
    
    -- Database Design lessons
    (3, 'Introduction to Databases', '<h1>Database Fundamentals</h1><p>Learn what databases are and why they are important...</p>', 1),
    (3, 'Designing Tables and Relationships', '<h1>Table Design</h1><p>Understanding normalization and establishing relationships...</p>', 2),
    (3, 'SQL Queries', '<h1>SQL Basics</h1><p>Writing SELECT, INSERT, UPDATE, and DELETE statements...</p>', 3),
    
    -- JavaScript Advanced lessons
    (4, 'Functions and Closures', '<h1>Functions</h1><p>Understanding function scope, hoisting, and closures...</p>', 1),
    (4, 'Promises and Async/Await', '<h1>Asynchronous Programming</h1><p>Handling asynchronous operations in JavaScript...</p>', 2),
    (4, 'ES6+ Features', '<h1>Modern JavaScript</h1><p>Exploring arrow functions, destructuring, and modules...</p>', 3),
    
    -- Cloud Computing lessons
    (5, 'Cloud Platforms Overview', '<h1>Cloud Overview</h1><p>Introduction to major cloud service providers...</p>', 1),
    (5, 'AWS Services', '<h1>AWS Introduction</h1><p>Working with Amazon Web Services...</p>', 2),
    (5, 'Azure Basics', '<h1>Microsoft Azure</h1><p>Getting started with Azure cloud services...</p>', 3);
GO

-- ==============================================
-- 4. Insert Quiz
-- ==============================================
INSERT INTO Quiz (ModuleID, Title, UserID)
VALUES
    (1, 'Web Development Fundamentals Quiz', 2),
    (1, 'HTML and CSS Assessment', 2),
    (2, 'ASP.NET Core Knowledge Test', 2),
    (3, 'Database Design Quiz', 3),
    (4, 'JavaScript Advanced Concepts Test', 2);
GO

-- ==============================================
-- 5. Insert QuizQuestion
-- ==============================================
INSERT INTO QuizQuestion (QuizID, [Text])
VALUES
    -- Quiz 1: Web Development Fundamentals
    (1, 'What does HTML stand for?'),
    (1, 'Which CSS property is used to change text color?'),
    (1, 'What is the correct way to include JavaScript in an HTML page?'),
    (1, 'Which HTML tag is used for creating links?'),
    (1, 'What is the purpose of CSS?'),
    
    -- Quiz 2: HTML and CSS
    (2, 'Which HTML5 semantic element is used for navigation?'),
    (2, 'What does the CSS box model consist of?'),
    (2, 'Which CSS property is used to control spacing between elements?'),
    
    -- Quiz 3: ASP.NET Core
    (3, 'What is ASP.NET Core?'),
    (3, 'Which HTTP verb is typically used for retrieving data?'),
    (3, 'What does MVC stand for?'),
    
    -- Quiz 4: Database Design
    (4, 'What is a primary key?'),
    (4, 'What is normalization?'),
    (4, 'Which SQL statement is used to delete data?'),
    
    -- Quiz 5: JavaScript Advanced
    (5, 'What is a closure in JavaScript?'),
    (5, 'What is the difference between let, const, and var?');
GO

-- ==============================================
-- 6. Insert QuizOptions
-- ==============================================
INSERT INTO QuizOptions (QuizQuestionID, [Text], IsCorrect)
VALUES
    -- Questions for Quiz 1
    (1, 'HyperText Markup Language', 1),
    (1, 'High-level Text Markup Language', 0),
    (1, 'HyperText Machine Language', 0),
    (1, 'Home Tool Markup Language', 0),
    
    (2, 'color', 1),
    (2, 'text-color', 0),
    (2, 'font-color', 0),
    (2, 'foreground', 0),
    
    (3, '<script src="file.js"></script>', 1),
    (3, '<javascript src="file.js"></javascript>', 0),
    (3, '<script>src="file.js"</script>', 0),
    (3, '<js href="file.js"></js>', 0),
    
    (4, '<a>', 1),
    (4, '<link>', 0),
    (4, '<href>', 0),
    (4, '<url>', 0),
    
    (5, 'To style and layout web pages', 1),
    (5, 'To create web page structure', 0),
    (5, 'To add interactivity', 0),
    (5, 'To connect to databases', 0),
    
    -- Questions for Quiz 2
    (6, '<nav>', 1),
    (6, '<navigation>', 0),
    (6, '<menu>', 0),
    (6, '<navigate>', 0),
    
    (7, 'Content, padding, border, margin', 1),
    (7, 'Width, height, depth', 0),
    (7, 'Top, right, bottom, left', 0),
    (7, 'Color, size, position, alignment', 0),
    
    (8, 'margin', 1),
    (8, 'spacing', 0),
    (8, 'gap', 0),
    (8, 'distance', 0),
    
    -- Questions for Quiz 3
    (9, 'A cross-platform web framework', 1),
    (9, 'A database management system', 0),
    (9, 'A text editor', 0),
    (9, 'A programming language', 0),
    
    (10, 'GET', 1),
    (10, 'POST', 0),
    (10, 'PUT', 0),
    (10, 'DELETE', 0),
    
    (11, 'Model-View-Controller', 1),
    (11, 'Multiple-View-Configuration', 0),
    (11, 'Main-Validation-Component', 0),
    (11, 'Maximum-Value-Controller', 0),
    
    -- Questions for Quiz 4
    (12, 'A unique identifier for each row', 1),
    (12, 'A foreign key', 0),
    (12, 'A column that stores dates', 0),
    (12, 'A backup of the table', 0),
    
    (13, 'The process of organizing data in a database', 1),
    (13, 'Creating indexes', 0),
    (13, 'Deleting duplicate records', 0),
    (13, 'Encrypting sensitive data', 0),
    
    (14, 'DELETE', 1),
    (14, 'REMOVE', 0),
    (14, 'DROP', 0),
    (14, 'CLEAR', 0),
    
    -- Questions for Quiz 5
    (15, 'A function that has access to variables in its outer scope', 1),
    (15, 'A way to close a browser window', 0),
    (15, 'A database term', 0),
    (15, 'A CSS property', 0),
    
    (16, 'let and const are block-scoped, var is function-scoped', 1),
    (16, 'They are all the same', 0),
    (16, 'let is for numbers, const is for strings', 0),
    (16, 'var is newer than let and const', 0);
GO

-- ==============================================
-- 7. Insert QuizAttempts
-- ==============================================
INSERT INTO QuizAttempts (UserID, QuizID, TakenTime, Score)
VALUES
    (4, 1, DATEADD(day, -5, GETDATE()), 85.50),
    (4, 1, DATEADD(day, -4, GETDATE()), 92.00),
    (5, 1, DATEADD(day, -3, GETDATE()), 78.00),
    (4, 2, DATEADD(day, -2, GETDATE()), 88.50),
    (5, 2, DATEADD(day, -1, GETDATE()), 75.00),
    (6, 1, GETDATE(), 90.00),
    (6, 3, DATEADD(day, -2, GETDATE()), 70.00),
    (5, 3, GETDATE(), 82.50);
GO

-- ==============================================
-- 8. Insert UserProgress
-- ==============================================
INSERT INTO UserProgress (UserID, ModuleID, ProgressPercent, UpdatedAt)
VALUES
    (4, 1, 100.00, DATEADD(day, -2, GETDATE())),
    (4, 2, 75.00, DATEADD(day, -1, GETDATE())),
    (4, 3, 50.00, DATEADD(day, -3, GETDATE())),
    (5, 1, 90.00, DATEADD(day, -1, GETDATE())),
    (5, 3, 30.00, DATEADD(day, -4, GETDATE())),
    (6, 1, 100.00, GETDATE()),
    (6, 2, 60.00, DATEADD(day, -2, GETDATE())),
    (6, 4, 25.00, DATEADD(day, -5, GETDATE()));
GO

-- ==============================================
-- Verification Queries
-- ==============================================
PRINT '======================================================='
PRINT 'Sample data inserted successfully!'
PRINT '======================================================='
PRINT ''

SELECT 'Users' AS TableName, COUNT(*) AS RecordCount FROM Users
UNION ALL
SELECT 'Modules', COUNT(*) FROM Modules
UNION ALL
SELECT 'Lessons', COUNT(*) FROM Lessons
UNION ALL
SELECT 'Quiz', COUNT(*) FROM Quiz
UNION ALL
SELECT 'QuizQuestion', COUNT(*) FROM QuizQuestion
UNION ALL
SELECT 'QuizOptions', COUNT(*) FROM QuizOptions
UNION ALL
SELECT 'QuizAttempts', COUNT(*) FROM QuizAttempts
UNION ALL
SELECT 'UserProgress', COUNT(*) FROM UserProgress;

PRINT ''
PRINT 'Sample data summary:'
PRINT '- 6 Users (1 Admin, 2 Teachers, 3 Learners)'
PRINT '- 5 Modules (Web Dev, ASP.NET, Database, JavaScript, Cloud)'
PRINT '- 15 Lessons (3 lessons per module)'
PRINT '- 5 Quizzes (covering different modules)'
PRINT '- 16 Quiz Questions (multiple choice)'
PRINT '- 48 Quiz Options (3-4 options per question)'
PRINT '- 8 Quiz Attempts (various scores)'
PRINT '- 8 User Progress records (tracking learner progress)'
PRINT '======================================================='

GO

