# ProbFessional LMS - Probability Learning Management System

A web-based learning management system built with ASP.NET Web Forms that teaches probability through fun card and dice games.

## Features

- **User Management**: Admin, Teacher, and Learner roles
- **Learning Modules**: 5 modules covering probability concepts through games
  - Poker (card probabilities)
  - UNO (color matching probability)
  - Mahjong (sampling without replacement)
  - Dice (independent events)
  - Slot Machines (multiplication rule)
- **Interactive Quizzes**: 50 quiz questions across 5 modules
- **Progress Tracking**: Monitor learning progress per module
- **Modern UI**: Beautiful gradient design with animations

## Requirements

- Visual Studio 2019/2022
- .NET Framework 4.7.2
- SQL Server LocalDB (included with Visual Studio)
- IIS Express (for development)

## Quick Start

### 1. Database Setup

1. Open SQL Server Management Studio (SSMS)
2. Connect to `(LocalDB)\MSSQLLocalDB`
3. Open `Complete_Database_Setup.sql` and execute it
4. This will create all tables and insert sample data

### 2. Run the Application

1. Open `Probfessional.sln` in Visual Studio
2. Press `F5` to run the project
3. Navigate to `Login.aspx` in your browser

### 3. Test Login Credentials

- **Admin**: admin@gmail.com / Admin123!
  - Access: Full administrative panel
- **Teacher**: teacher@gmail.com / Teacher123!
  - Access: Module management, quiz creation
- **Learner**: learner@gmail.com / Learner123!
  - Access: View modules, take quizzes, track progress

## Database Schema

The database includes:
- **Users**: User accounts with roles
- **Modules**: 5 learning modules
- **Lessons**: 30 lessons (6 per module)
- **Quiz**: 5 quizzes (one per module)
- **QuizQuestions**: 50 questions with multiple choice answers
- **QuizAttempts**: Track quiz scores and attempts
- **UserProgress**: Progress tracking per module

## Project Structure

```
Probfessional/
├── App_Data/              # LocalDB database files
├── App_Start/             # Route and bundle configuration
├── Content/               # CSS and styling
├── Scripts/               # JavaScript libraries
├── ImgModule/             # Module images (poker, uno, etc.)
├── Logo/                  # Application logos
├── Login.aspx             # Login page with modern UI
├── Register.aspx          # User registration
├── Modules.aspx           # List learning modules
├── Default.aspx           # Home/dashboard
├── Admin.aspx             # Admin panel
├── Quizzes.aspx           # Quiz interface
├── Progress.aspx          # Progress tracking
├── Complete_Database_Setup.sql  # Full database setup script
├── Web.config             # Configuration and connection strings
└── Probfessional.csproj   # Project file
```

## Technology Stack

- **Backend**: ASP.NET Web Forms (.NET Framework 4.7.2)
- **Database**: SQL Server LocalDB
- **Frontend**: Bootstrap 5.2.3, jQuery 3.7.0
- **Styling**: Custom CSS with gradient animations
- **Authentication**: Session-based authentication

## Development

### Adding New Features

1. Update the database schema if needed
2. Create new `.aspx` pages with code-behind (`.aspx.cs`)
3. Update `Web.config` for new connection strings if needed
4. Test with different user roles

### Database Changes

When modifying the database:
1. Update `Complete_Database_Setup.sql`
2. Run the updated script in SSMS
3. Update any affected code-behind files

## Troubleshooting

### Issue: Database connection error
- Check `Web.config` connection string
- Ensure LocalDB is running
- Verify database file exists in `App_Data/`

### Issue: Roslyn compiler error
- Run `Complete_Database_Setup.sql` to ensure tables exist
- Check `bin/roslyn` folder contains compiler files
- Rebuild the solution

### Issue: Login not working
- Verify users are inserted in database
- Check passwords match exactly
- Confirm `IsActive = 1` for user accounts

## License

This is a learning project for educational purposes.

---

**Built with ❤️ for learning probability through games!**
