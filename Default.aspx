<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Probfessional._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .hero-section {
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 24px;
            padding: 60px 40px;
            margin-bottom: 40px;
            color: white;
            text-align: center;
        }
        .hero-section h1 {
            font-size: 48px;
            font-weight: 800;
            margin-bottom: 20px;
        }
        .hero-section p {
            font-size: 20px;
            opacity: 0.95;
            margin-bottom: 30px;
        }
        .btn-hero {
            background: white;
            color: #1e40af;
            padding: 12px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-hero:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 20px rgba(255,255,255,0.3);
            color: #1e40af;
            text-decoration: none;
        }
        .features-section {
            padding: 40px 0;
        }
        .feature-box {
            text-align: center;
            padding: 30px 20px;
        }
        .feature-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }
        .feature-box h3 {
            font-size: 24px;
            color: #1e40af;
            margin-bottom: 12px;
        }
        .feature-box p {
            color: #4a5568;
            line-height: 1.6;
        }
    </style>

    <main>
        <div class="hero-section">
            <h1>Welcome to ProbFessional</h1>
            <p>Learn probability through interactive parlour games and real-world examples</p>
            <a href="Modules.aspx" class="btn-hero">Explore Modules</a>
        </div>

        <div class="features-section">
            <div class="row">
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">🎲</div>
                        <h3>Interactive Learning</h3>
                        <p>Master probability concepts through engaging games like Poker, UNO, Mahjong, Dice, and Slot Machines</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">📚</div>
                        <h3>Structured Modules</h3>
                        <p>Follow our carefully designed curriculum that builds your understanding step by step</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">🏆</div>
                        <h3>Track Progress</h3>
                        <p>Monitor your learning journey with quizzes, badges, and progress tracking</p>
                    </div>
                </div>
            </div>
        </div>
    </main>

</asp:Content>
