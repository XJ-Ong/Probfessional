<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Probfessional.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
        }

        .about-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .hero-section {
            text-align: center;
            padding: 60px 0;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 24px;
            margin-bottom: 60px;
            box-shadow: 0 20px 60px rgba(30, 64, 175, 0.3);
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 2px, transparent 2px);
            background-size: 60px 60px;
            animation: patternMove 20s linear infinite;
        }

        @keyframes patternMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(60px, 60px); }
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero-section h1 {
            font-size: 48px;
            font-weight: 800;
            color: white;
            margin-bottom: 20px;
            text-shadow: 0 2px 20px rgba(0,0,0,0.2);
        }

        .hero-section p {
            font-size: 20px;
            color: rgba(255,255,255,0.95);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .section {
            background: white;
            border-radius: 20px;
            padding: 50px;
            margin-bottom: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .section:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }

        .section h2 {
            font-size: 32px;
            font-weight: 800;
            color: #1e40af;
            margin-bottom: 16px;
            padding-bottom: 16px;
            border-bottom: 3px solid #0891b2;
            display: inline-block;
        }

        .mission-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .mission-list li {
            padding: 16px 20px;
            margin-bottom: 12px;
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.05) 0%, rgba(3, 105, 161, 0.05) 100%);
            border-left: 4px solid #0369a1;
            border-radius: 8px;
            font-size: 16px;
            color: #2d3748;
            transition: all 0.3s ease;
        }

        .mission-list li:hover {
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.1) 0%, rgba(3, 105, 161, 0.1) 100%);
            transform: translateX(8px);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 32px;
        }

        .feature-card {
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.03) 0%, rgba(3, 105, 161, 0.03) 100%);
            border: 2px solid rgba(3, 105, 161, 0.1);
            border-radius: 16px;
            padding: 24px 16px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-card:hover {
            border-color: #0891b2;
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(8, 145, 178, 0.2);
        }

        .feature-icon {
            font-size: 36px;
            margin-bottom: 12px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .feature-card h3 {
            font-size: 18px;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 10px;
        }

        .feature-card p {
            font-size: 14px;
            color: #4a5568;
            line-height: 1.5;
            margin: 0;
        }

        .team-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            margin-top: 8px;
        }

        .team-member {
            text-align: center;
            padding: 24px;
            border-radius: 16px;
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.02) 0%, rgba(3, 105, 161, 0.02) 100%);
            transition: all 0.3s ease;
        }

        .team-member:hover {
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.08) 0%, rgba(3, 105, 161, 0.08) 100%);
            transform: translateY(-8px);
        }

        .team-member img {
            width: 140px;
            height: 140px;
            object-fit: cover;
            border-radius: 50%;
            border: 4px solid #0891b2;
            margin-bottom: 16px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(8, 145, 178, 0.3);
        }

        .team-member:hover img {
            box-shadow: 0 8px 40px rgba(8, 145, 178, 0.5);
            transform: scale(1.05);
        }

        .team-member p {
            font-size: 16px;
            font-weight: 600;
            color: #2d3748;
            margin: 8px 0 0 0;
        }

        .team-member p br {
            display: block;
            margin-top: 4px;
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 36px;
            }

            .hero-section p {
                font-size: 18px;
            }

            .section {
                padding: 30px 20px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .team-section {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 24px;
            }

            .team-member img {
                width: 120px;
                height: 120px;
            }
        }
    </style>

    <div class="about-container">
        <main aria-labelledby="title">
            <!-- Hero Section -->
            <div class="hero-section">
                <div class="hero-content">
                    <h1>About ProbFessional</h1>
                    <p>ProbFessional is an educational web-based learning system developed by students from Asia Pacific University (APU).<br />
                        Our team's mission is to transform the way people learn probability: from something abstract and intimidating into something fun, interactive, and meaningful through parlour games like Poker, UNO, Mahjong, Dice, and Slot Machines.</p>
                </div>
            </div>

            <!-- Our Team Section -->
            <div class="section">
                <h2>Our Team</h2>
                <div class="team-section">
                    <div class="team-member">
                        <img src="TeamImage/kzx.png" alt="Kok Zhao Xiang" />
                        <p>Kok Zhao Xiang<br />TP080473</p>
                    </div>
                    <div class="team-member">
                        <img src="TeamImage/ymy.png" alt="Yang Mingyuan" />
                        <p>Yang Mingyuan<br />TP080028</p>
                    </div>
                    <div class="team-member">
                        <img src="TeamImage/sbai.png" alt="Abdellah Sbai" />
                        <p>Abdellah Sbai<br />TP078170</p>
                    </div>
                    <div class="team-member">
                        <img src="TeamImage/oxj.png" alt="Ong Xuang Jian" />
                        <p>Ong Xuang Jian<br />TP080343</p>
                    </div>
                </div>
            </div>

            <!-- Our Mission Section -->
            <div class="section">
                <h2>Our Mission</h2>
                <ul class="mission-list">
                    <li>Bridge the gap between math theories and real-life practices</li>
                    <li>Help learners experience probability through interactive simulations and real-world examples</li>
                    <li>Create a safe, stress-free learning environment that builds critical thinking and analytical skills</li>
                    <li>Support educators in making mathematics lessons more engaging, relatable, and interactive</li>
                </ul>
            </div>

            <!-- What We Offer Section -->
            <div class="section">
                <h2>What We Offer</h2>
                <div class="features-grid">
                    <div class="feature-card">
                        <div class="feature-icon">🎮</div>
                        <h3>Gamified Learning</h3>
                        <p>Earn points, badges, and progress levels as you learn probability through interactive games.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">🌍</div>
                        <h3>Real-world Scenarios</h3>
                        <p>Learn probability through examples from popular parlour games like Poker, UNO, and more.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">📚</div>
                        <h3>Structured Modules</h3>
                        <p>Lessons and quizzes tailored to teach applied probability concepts step-by-step.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">⚡</div>
                        <h3>Instant Feedback</h3>
                        <p>Check your answers and understand probability concepts with detailed explanations.</p>
                    </div>
                    <div class="feature-card">
                        <div class="feature-icon">👨‍🏫</div>
                        <h3>Educator Tools</h3>
                        <p>Use verified materials and interactive exercises to enhance classroom teaching.</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</asp:Content>
