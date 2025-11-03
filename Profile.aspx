<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Probfessional.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 20%, #1e40af 40%, #0369a1 60%, #0891b2 80%, #0e7490 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
        }
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .profile-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* Profile Header Card */
        .profile-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            display: flex;
            align-items: center;
            gap: 30px;
            animation: slideUp 0.6s ease-out;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 30%, #0891b2 70%, #0e7490 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: white;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 10px 30px rgba(30, 64, 175, 0.4);
            border: 4px solid white;
        }
        
        .profile-info h1 {
            margin: 0 0 8px 0;
            font-size: 32px;
            color: #1a202c;
            font-weight: 700;
        }
        
        .profile-info .profile-email {
            color: #718096;
            font-size: 16px;
            margin-bottom: 12px;
        }
        
        .profile-badges-preview {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .badge-preview {
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .profile-role {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            margin-top: 8px;
        }
        .profile-role.learner {
            background: rgba(30, 64, 175, 0.1);
            color: #1e40af;
        }
        .profile-role.teacher {
            background: rgba(234, 179, 8, 0.1);
            color: #d97706;
        }
        .profile-role.admin {
            background: rgba(220, 38, 38, 0.1);
            color: #dc2626;
        }
        
        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: slideUp 0.6s ease-out;
            animation-fill-mode: both;
        }
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
        }
        
        .stat-card .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 16px;
            position: relative;
        }
        
        /* Modules Completed Icon - Stacked Books */
        .stat-card:nth-child(1) .stat-icon::before {
            content: '';
            width: 28px;
            height: 20px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 2px;
            position: absolute;
            box-shadow: 0 -8px 0 -2px rgba(30, 64, 175, 0.6),
                        0 8px 0 -2px rgba(8, 145, 178, 0.6);
        }
        
        /* Quizzes Taken Icon - Document */
        .stat-card:nth-child(2) .stat-icon::before {
            content: '';
            width: 20px;
            height: 24px;
            background: linear-gradient(135deg, #f59e0b 0%, #fbbf24 100%);
            border-radius: 2px;
            position: absolute;
            box-shadow: 2px 0 0 -1px rgba(234, 179, 8, 0.5);
        }
        .stat-card:nth-child(2) .stat-icon::after {
            content: '';
            width: 10px;
            height: 2px;
            background: rgba(234, 179, 8, 0.8);
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border-radius: 1px;
        }
        
        /* Average Score Icon - Star */
        .stat-card:nth-child(3) .stat-icon::before {
            content: '';
            width: 24px;
            height: 24px;
            background: linear-gradient(135deg, #22c55e 0%, #34d399 100%);
            clip-path: polygon(50% 0%, 61% 35%, 98% 35%, 68% 57%, 79% 91%, 50% 70%, 21% 91%, 32% 57%, 2% 35%, 39% 35%);
            position: absolute;
        }
        
        /* Badges Earned Icon - Trophy */
        .stat-card:nth-child(4) .stat-icon::before {
            content: '';
            width: 24px;
            height: 20px;
            background: linear-gradient(135deg, #a855f7 0%, #c084fc 100%);
            clip-path: polygon(50% 0%, 100% 30%, 90% 100%, 10% 100%, 0% 30%);
            position: absolute;
            top: 30%;
        }
        .stat-card:nth-child(4) .stat-icon::after {
            content: '';
            width: 16px;
            height: 8px;
            background: linear-gradient(135deg, #a855f7 0%, #c084fc 100%);
            border-radius: 0 0 4px 4px;
            position: absolute;
            top: 60%;
            left: 50%;
            transform: translateX(-50%);
        }
        .stat-card:nth-child(1) .stat-icon {
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.2) 0%, rgba(3, 105, 161, 0.2) 100%);
        }
        .stat-card:nth-child(2) .stat-icon {
            background: linear-gradient(135deg, rgba(234, 179, 8, 0.2) 0%, rgba(251, 191, 36, 0.2) 100%);
        }
        .stat-card:nth-child(3) .stat-icon {
            background: linear-gradient(135deg, rgba(34, 197, 94, 0.2) 0%, rgba(52, 211, 153, 0.2) 100%);
        }
        .stat-card:nth-child(4) .stat-icon {
            background: linear-gradient(135deg, rgba(168, 85, 247, 0.2) 0%, rgba(192, 132, 252, 0.2) 100%);
        }
        
        .stat-card .stat-value {
            font-size: 36px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 4px;
        }
        
        .stat-card .stat-label {
            font-size: 14px;
            color: #718096;
            font-weight: 600;
        }
        
        /* Progress Section */
        .section-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.8s ease-out;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .section-title::before {
            content: '';
            width: 4px;
            height: 24px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 2px;
        }
        
        /* Module Progress */
        .module-progress-item {
            padding: 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 16px;
            transition: all 0.3s ease;
        }
        .module-progress-item:hover {
            border-color: #0369a1;
            box-shadow: 0 4px 12px rgba(30, 64, 175, 0.15);
        }
        
        .module-progress-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .module-progress-name {
            font-weight: 600;
            font-size: 16px;
            color: #1a202c;
        }
        
        .module-progress-percent {
            font-weight: 700;
            font-size: 18px;
            color: #0369a1;
        }
        
        .progress-bar-container {
            height: 8px;
            background: #e2e8f0;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(90deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 4px;
            transition: width 0.6s ease;
        }
        
        /* Badges Section */
        .badges-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
            gap: 20px;
        }
        
        .badge-card {
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.9) 100%);
            border-radius: 16px;
            padding: 24px;
            text-align: center;
            border: 2px solid #e2e8f0;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .badge-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        .badge-card.earned::before {
            transform: scaleX(1);
        }
        .badge-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            border-color: #0369a1;
        }
        .badge-card.locked {
            opacity: 0.5;
            filter: grayscale(100%);
        }
        
        .badge-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 12px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.1) 0%, rgba(3, 105, 161, 0.1) 100%);
            border: 3px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        .badge-card.earned .badge-icon {
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-color: #0369a1;
            box-shadow: 0 4px 15px rgba(30, 64, 175, 0.4);
        }
        
        .badge-name {
            font-weight: 600;
            font-size: 14px;
            color: #1a202c;
            margin-bottom: 4px;
        }
        
        .badge-description {
            font-size: 12px;
            color: #718096;
        }
        
        /* Quiz History */
        .quiz-history-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
        }
        .quiz-history-item:hover {
            border-color: #0369a1;
            box-shadow: 0 4px 12px rgba(30, 64, 175, 0.15);
        }
        
        .quiz-info {
            flex: 1;
        }
        
        .quiz-name {
            font-weight: 600;
            font-size: 16px;
            color: #1a202c;
            margin-bottom: 4px;
        }
        
        .quiz-date {
            font-size: 12px;
            color: #718096;
        }
        
        .quiz-score {
            font-size: 24px;
            font-weight: 700;
            color: #0369a1;
        }
        
        .quiz-score.passing {
            color: #10b981;
        }
        .quiz-score.failing {
            color: #ef4444;
        }
        
        /* Account Info Section */
        .account-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }
        
        .info-item {
            padding: 16px;
            background: #f7fafc;
            border-radius: 12px;
            border-left: 4px solid #0369a1;
        }
        
        .info-label {
            font-size: 12px;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 4px;
        }
        
        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: #1a202c;
        }
        
        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .badges-grid {
                grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
            }
        }
    </style>
    
    <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar" id="avatarInitials" runat="server">U</div>
            <div class="profile-info" style="flex: 1;">
                <h1 id="profileName" runat="server">User Name</h1>
                <div class="profile-email" id="profileEmail" runat="server">user@example.com</div>
                <div>
                    <span class="profile-role" id="profileRole" runat="server">Learner</span>
                </div>
                <div class="profile-badges-preview" id="badgesPreview" runat="server">
                    <!-- Badges will be populated here -->
                </div>
            </div>
        </div>
        
        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"></div>
                <div class="stat-value" id="statModulesCompleted" runat="server">0</div>
                <div class="stat-label">Modules Completed</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"></div>
                <div class="stat-value" id="statQuizzesTaken" runat="server">0</div>
                <div class="stat-label">Quizzes Taken</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"></div>
                <div class="stat-value" id="statAverageScore" runat="server">0%</div>
                <div class="stat-label">Average Score</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"></div>
                <div class="stat-value" id="statBadgesEarned" runat="server">0</div>
                <div class="stat-label">Badges Earned</div>
            </div>
        </div>
        
        <!-- Module Progress -->
        <div class="section-card">
            <h2 class="section-title">Learning Progress</h2>
            <div id="moduleProgressList" runat="server">
                <!-- Module progress items will be populated here -->
            </div>
        </div>
        
        <!-- Badges Section -->
        <div class="section-card">
            <h2 class="section-title">Achievements & Badges</h2>
            <div class="badges-grid" id="badgesGrid" runat="server">
                <!-- Badges will be populated here -->
            </div>
        </div>
        
        <!-- Quiz History -->
        <div class="section-card">
            <h2 class="section-title">Quiz History</h2>
            <div id="quizHistoryList" runat="server">
                <!-- Quiz history items will be populated here -->
            </div>
        </div>
        
        <!-- Account Information -->
        <div class="section-card">
            <h2 class="section-title">Account Information</h2>
            <div class="account-info-grid">
                <div class="info-item">
                    <div class="info-label">Member Since</div>
                    <div class="info-value" id="memberSince" runat="server">-</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Account Status</div>
                    <div class="info-value" id="accountStatus" runat="server">Active</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Total Progress</div>
                    <div class="info-value" id="totalProgressValue" runat="server">0%</div>
                </div>
                <div class="info-item">
                    <div class="info-label">Last Activity</div>
                    <div class="info-value" id="lastActivity" runat="server">-</div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
