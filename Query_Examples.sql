-- =============================================
-- SQL Queries to Extract Data from Tables
-- =============================================

-- =============================================
-- 1. Get ALL data from Users table
-- =============================================
SELECT * FROM Users;

-- =============================================
-- 2. Get ALL data from Modules table
-- =============================================
SELECT * FROM Modules;

-- =============================================
-- 3. Get ALL data from Lessons table
-- =============================================
SELECT * FROM Lessons;

-- =============================================
-- 4. Get ALL data from Quiz table
-- =============================================
SELECT * FROM Quiz;

-- =============================================
-- 5. Get ALL data from QuizQuestion table
-- =============================================
SELECT * FROM QuizQuestion;

-- =============================================
-- 6. Get ALL data from QuizOptions table
-- =============================================
SELECT * FROM QuizOptions;

-- =============================================
-- 7. Get ALL data from QuizAttempts table
-- =============================================
SELECT * FROM QuizAttempts;

-- =============================================
-- 8. Get ALL data from UserProgress table
-- =============================================
SELECT * FROM UserProgress;

-- =============================================
-- USEFUL QUERIES WITH JOINED DATA
-- =============================================

-- Get all quizzes with module and creator info
SELECT 
    q.ID AS QuizID,
    q.Title AS QuizTitle,
    m.Title AS ModuleTitle,
    u.DisplayName AS CreatedBy,
    u.Email AS CreatorEmail
FROM Quiz q
INNER JOIN Modules m ON q.ModuleID = m.ID
INNER JOIN Users u ON q.UserID = u.ID;

-- Get all questions with their quiz info
SELECT 
    qq.ID AS QuestionID,
    qq.Text AS QuestionText,
    q.Title AS QuizTitle,
    m.Title AS ModuleTitle
FROM QuizQuestion qq
INNER JOIN Quiz q ON qq.QuizID = q.ID
INNER JOIN Modules m ON q.ModuleID = m.ID;

-- Get all quiz options with question details
SELECT 
    qo.ID AS OptionID,
    qo.Text AS OptionText,
    qo.IsCorrect,
    qq.Text AS QuestionText,
    q.Title AS QuizTitle
FROM QuizOptions qo
INNER JOIN QuizQuestion qq ON qo.QuizQuestionID = qq.ID
INNER JOIN Quiz q ON qq.QuizID = q.ID;

-- Get all quiz attempts with user and quiz info
SELECT 
    qa.ID AS AttemptID,
    u.DisplayName AS UserName,
    u.Email AS UserEmail,
    q.Title AS QuizTitle,
    m.Title AS ModuleTitle,
    qa.Score,
    qa.TakenTime
FROM QuizAttempts qa
INNER JOIN Users u ON qa.UserID = u.ID
INNER JOIN Quiz q ON qa.QuizID = q.ID
INNER JOIN Modules m ON q.ModuleID = m.ID
ORDER BY qa.TakenTime DESC;

-- Get all user progress with user and module info
SELECT 
    up.ID AS ProgressID,
    u.DisplayName AS UserName,
    u.Email AS UserEmail,
    m.Title AS ModuleTitle,
    up.ProgressPercent,
    up.UpdatedAt
FROM UserProgress up
INNER JOIN Users u ON up.UserID = u.ID
INNER JOIN Modules m ON up.ModuleID = m.ID
ORDER BY up.UpdatedAt DESC;

-- Get all lessons with module info
SELECT 
    l.ID AS LessonID,
    l.Title AS LessonTitle,
    l.[Order] AS LessonOrder,
    m.Title AS ModuleTitle,
    l.HtmlContent
FROM Lessons l
INNER JOIN Modules m ON l.ModuleID = m.ID
ORDER BY l.[Order];

-- Get complete quiz structure (Quiz -> Questions -> Options)
SELECT 
    q.ID AS QuizID,
    q.Title AS QuizTitle,
    qq.ID AS QuestionID,
    qq.Text AS QuestionText,
    qo.ID AS OptionID,
    qo.Text AS OptionText,
    qo.IsCorrect
FROM Quiz q
INNER JOIN QuizQuestion qq ON q.ID = qq.QuizID
LEFT JOIN QuizOptions qo ON qq.ID = qo.QuizQuestionID
ORDER BY q.ID, qq.ID, qo.ID;

-- =============================================
-- EXPORT DATA TO CSV (SSMS/TSQL)
-- =============================================

-- Note: You can use SQL Server Import/Export Wizard or bcp command:
-- bcp "SELECT * FROM Users" queryout "Users.csv" -c -t, -T -S localhost

-- =============================================
-- COUNT RECORDS IN EACH TABLE
-- =============================================
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

-- =============================================
-- CHECK FOR DATA INTEGRITY
-- =============================================

-- Find orphaned lessons (without parent module)
SELECT * FROM Lessons l
LEFT JOIN Modules m ON l.ModuleID = m.ID
WHERE m.ID IS NULL;

-- Find quiz questions without options
SELECT qq.* FROM QuizQuestion qq
LEFT JOIN QuizOptions qo ON qq.ID = qo.QuizQuestionID
WHERE qo.ID IS NULL;

-- Find users with no progress
SELECT u.* FROM Users u
LEFT JOIN UserProgress up ON u.ID = up.UserID
WHERE up.ID IS NULL AND u.Role = 'Learner';

GO

