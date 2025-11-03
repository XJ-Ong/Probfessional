<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Probfessional._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <link href="<%= ResolveUrl("~/Content/Site.css") %>" rel="stylesheet" type="text/css" />

    <main>
        <!-- Hero Section -->
        <section class="hero-section-enhanced" aria-labelledby="aspnetTitle">
            <div class="hero-content">
                <h1 id="aspnetTitle">ProbFessional</h1>
                <p class="hero-subtitle">Exploring Probability in Parlour Games</p>
                <p class="hero-description">Learn mathematics through interactive gaming experiences with Poker, UNO, Mahjong, Dice, and Slot Machines.</p>
                <div class="hero-buttons">
                    <asp:HyperLink ID="lnkGetStarted" runat="server" CssClass="btn-hero-primary" Text="Get Started" NavigateUrl="~/Register.aspx" />
                    <asp:HyperLink ID="lnkExploreModules" runat="server" CssClass="btn-hero-secondary" Text="Explore Modules" NavigateUrl="~/Modules.aspx" />
                </div>
            </div>
        </section>

        <!-- Statistics Section -->
        <section class="stats-section" aria-label="Platform Statistics">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">🎓</div>
                    <div class="stat-number">5</div>
                    <div class="stat-label">Interactive Modules</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📊</div>
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Practice Quizzes</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">🏆</div>
                    <div class="stat-number">Unlimited</div>
                    <div class="stat-label">Digital Badges</div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon">📈</div>
                    <div class="stat-number">Real-time</div>
                    <div class="stat-label">Progress Tracking</div>
                </div>
            </div>
        </section>

        <!-- How It Works Section -->
        <section class="how-it-works" aria-label="How ProbFessional Works">
            <h2 class="section-title">How It Works</h2>
            <div class="steps-grid">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <h3>Sign Up Free</h3>
                    <p>Create your account in seconds. No payment required - learning probability is completely free!</p>
                </div>
                <div class="step-card">
                    <div class="step-number">2</div>
                    <h3>Choose a Game</h3>
                    <p>Select from 5 parlour games: Poker, UNO, Mahjong, Dice, or Slot Machines. Each teaches different probability concepts.</p>
                </div>
                <div class="step-card">
                    <div class="step-number">3</div>
                    <h3>Learn & Practice</h3>
                    <p>Complete interactive lessons and solve real-world scenarios. Take quizzes to test your understanding.</p>
                </div>
                <div class="step-card">
                    <div class="step-number">4</div>
                    <h3>Earn & Progress</h3>
                    <p>Unlock badges, track your progress, and master probability concepts through gamified learning!</p>
                </div>
            </div>
        </section>

        <!-- Game Modules Preview Section -->
        <section class="games-section" aria-label="Available Game Modules">
            <h2 class="section-title">Explore Our Game Modules</h2>
            <p class="section-subtitle">Learn probability through fun, interactive parlour games</p>
            <div class="games-grid">
                <article class="game-card" data-game="poker">
                    <div class="game-icon">🃏</div>
                    <h3>Poker</h3>
                    <p>Master probability of hands and winning combinations. Calculate odds of royal flushes and pairs.</p>
                    <asp:HyperLink ID="lnkPokerLearnMore" runat="server" CssClass="game-link" Text="Learn More" NavigateUrl="~/Topics.aspx?id=1" />
                </article>
                <article class="game-card" data-game="uno">
                    <div class="game-icon">🎴</div>
                    <h3>UNO</h3>
                    <p>Understand card distribution and color combinations. Explore probability in card matching.</p>
                    <asp:HyperLink ID="lnkUnoLearnMore" runat="server" CssClass="game-link" Text="Learn More" NavigateUrl="~/Topics.aspx?id=2" />
                </article>
                <article class="game-card" data-game="mahjong">
                    <div class="game-icon">🀄</div>
                    <h3>Mahjong</h3>
                    <p>Discover tile probability patterns and winning combinations. Learn strategic probability.</p>
                    <asp:HyperLink ID="lnkMahjongLearnMore" runat="server" CssClass="game-link" Text="Learn More" NavigateUrl="~/Topics.aspx?id=3" />
                </article>
                <article class="game-card" data-game="dice">
                    <div class="game-icon">🎲</div>
                    <h3>Dice</h3>
                    <p>Study rolling outcomes and independent events. Calculate probabilities of sums.</p>
                    <asp:HyperLink ID="lnkDiceLearnMore" runat="server" CssClass="game-link" Text="Learn More" NavigateUrl="~/Topics.aspx?id=4" />
                </article>
                <article class="game-card" data-game="slots">
                    <div class="game-icon">🎰</div>
                    <h3>Slot Machines</h3>
                    <p>Explore independent event probability and outcome calculations. Understand random chance.</p>
                    <asp:HyperLink ID="lnkSlotsLearnMore" runat="server" CssClass="game-link" Text="Learn More" NavigateUrl="~/Topics.aspx?id=5" />
                </article>
            </div>
        </section>

        <!-- Content Preview Section -->
        <section class="preview-section" aria-label="Learning Example">
            <div class="preview-card">
                <div class="preview-badge">Example Question</div>
                <h3>What's the probability of getting a royal flush in Poker?</h3>
                <p class="preview-explaination">
                    A royal flush is the highest possible hand in poker, consisting of A, K, Q, J, 10, all of the same suit. 
                    The probability is approximately <strong>0.000154%</strong> or 1 in 649,740 hands.
                </p>
                <p class="preview-description">
                    Through our interactive modules, you'll learn to calculate such probabilities step-by-step, 
                    understand combinatorics, and apply mathematical principles to real game scenarios.
                </p>
                <asp:HyperLink ID="lnkTryItYourself" runat="server" CssClass="btn btn-primary" Text="Try It Yourself" NavigateUrl="~/Quizzes.aspx?moduleId=1" />
            </div>
        </section>

        <!-- Enhanced Feature Cards -->
        <div class="row">
            <section class="col-md-4" aria-labelledby="gettingStartedTitle">
                <div class="feature-icon">📚</div>
                <h2 id="gettingStartedTitle">Interactive Learning</h2>
                <p>
                    Experience probability through engaging parlour games. Structured modules make mathematics fun and practical.
                </p>
                <p>
                    <asp:HyperLink ID="lnkExploreModulesBottom" runat="server" CssClass="btn btn-default" Text="Explore Modules" NavigateUrl="~/Modules.aspx" />
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="librariesTitle">
                <div class="feature-icon">🎮</div>
                <h2 id="librariesTitle">Gamification</h2>
                <p>
                    Earn digital badges, track progress, and unlock achievements. Stay motivated throughout your learning journey.
                </p>
                <p>
                    <asp:HyperLink ID="lnkStartLearning" runat="server" CssClass="btn btn-default" Text="Start Learning" NavigateUrl="~/Modules.aspx" />
                </p>
            </section>
            <section class="col-md-4" aria-labelledby="hostingTitle">
                <div class="feature-icon">✏️</div>
                <h2 id="hostingTitle">Practice & Quizzes</h2>
                <p>
                    Test understanding with interactive quizzes. Get instant feedback and build confidence in game scenarios.
                </p>
                <p>
                    <asp:HyperLink ID="lnkTakeQuiz" runat="server" CssClass="btn btn-default" Text="Take a Quiz" NavigateUrl="~/Quizzes.aspx" />
                </p>
        </section>
        </div>

        <style>
            /* Hero Section Enhanced */
            .hero-section-enhanced {
                background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
                border-radius: 24px;
                padding: 80px 40px;
                margin: 40px 0;
                text-align: center;
                color: white;
                position: relative;
                overflow: hidden;
            }
            .hero-section-enhanced::before {
                content: '';
                position: absolute;
                top: -50%;
                right: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
                background-size: 50px 50px;
                animation: float 20s infinite linear;
                opacity: 0.3;
            }
            @keyframes float {
                0% { transform: translateY(0); }
                100% { transform: translateY(-50px); }
            }
            .hero-content {
                position: relative;
                z-index: 1;
                max-width: 800px;
                margin: 0 auto;
            }
            #aspnetTitle {
                font-size: 56px;
                font-weight: 800;
                margin-bottom: 16px;
                text-shadow: 0 2px 10px rgba(0,0,0,0.2);
            }
            .hero-subtitle {
                font-size: 24px;
                font-weight: 600;
                margin-bottom: 16px;
                opacity: 0.95;
            }
            .hero-description {
                font-size: 18px;
                line-height: 1.8;
                margin-bottom: 40px;
                opacity: 0.9;
            }
            .hero-buttons {
                display: flex;
                gap: 20px;
                justify-content: center;
                flex-wrap: wrap;
            }
            .btn-hero-primary {
                background: white;
                color: #1e40af;
                padding: 16px 40px;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 700;
                font-size: 18px;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            }
            .btn-hero-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.3);
                background: #f0f9ff;
                color: #1e40af;
                text-decoration: none;
            }
            .btn-hero-secondary {
                background: rgba(255,255,255,0.2);
                color: white;
                border: 2px solid white;
                padding: 16px 40px;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 700;
                font-size: 18px;
                transition: all 0.3s ease;
                backdrop-filter: blur(10px);
            }
            .btn-hero-secondary:hover {
                background: white;
                color: #1e40af;
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(0,0,0,0.3);
                text-decoration: none;
            }

            /* Stats Section */
            .stats-section {
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                padding: 60px 20px;
                margin: 40px 0;
            }
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 30px;
                max-width: 1200px;
                margin: 0 auto;
            }
            .stat-card {
                background: white;
                padding: 30px;
                border-radius: 16px;
                text-align: center;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            }
            .stat-icon {
                font-size: 48px;
                margin-bottom: 16px;
                animation: pulse 2s infinite;
            }
            @keyframes pulse {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.1); }
            }
            .stat-number {
                font-size: 36px;
                font-weight: 700;
                color: #1e40af;
                margin-bottom: 8px;
            }
            .stat-label {
                color: #718096;
                font-size: 16px;
            }

            /* How It Works Section */
            main {
                padding: 20px 0;
            }
            .how-it-works {
                padding: 60px 20px;
                max-width: 1200px;
                margin: 40px auto;
            }
            .section-title {
                font-size: 32px;
                font-weight: 700;
                color: #1a202c;
                text-align: center;
                margin-bottom: 48px;
            }
            .steps-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 30px;
            }
            .step-card {
                background: white;
                padding: 30px;
                border-radius: 16px;
                text-align: center;
                border: 2px solid #e2e8f0;
                transition: all 0.3s ease;
            }
            .step-card:hover {
                border-color: #0369a1;
                box-shadow: 0 8px 16px rgba(3, 105, 161, 0.1);
            }
            .step-number {
                width: 50px;
                height: 50px;
                background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 24px;
                font-weight: 700;
                margin: 0 auto 20px;
            }
            .step-card h3 {
                font-size: 20px;
                color: #1a202c;
                margin-bottom: 12px;
            }
            .step-card p {
                color: #718096;
                line-height: 1.6;
            }

            /* Games Section */
            .games-section {
                padding: 60px 20px;
                background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
                margin: 40px 0;
            }
            .section-subtitle {
                text-align: center;
                color: #718096;
                font-size: 18px;
                margin-bottom: 40px;
            }
            .games-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 30px;
                max-width: 1200px;
                margin: 0 auto;
            }
            .game-card {
                background: white;
                padding: 30px;
                border-radius: 16px;
                text-align: center;
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }
            .game-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.1);
                border-color: #0369a1;
            }
            .game-icon {
                font-size: 64px;
                margin-bottom: 20px;
            }
            .game-card h3 {
                font-size: 24px;
                color: #1a202c;
                margin-bottom: 16px;
            }
            .game-card p {
                color: #718096;
                line-height: 1.6;
                margin-bottom: 20px;
            }
            .game-link {
                color: #0369a1;
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }
            .game-link:hover {
                color: #1e40af;
            }

            /* Preview Section */
            .preview-section {
                padding: 60px 20px;
                max-width: 1000px;
                margin: 40px auto;
            }
            .preview-card {
                background: linear-gradient(135deg, #1e40af 0%, #0369a1 100%);
                color: white;
                padding: 40px;
                border-radius: 16px;
                position: relative;
                overflow: hidden;
            }
            .preview-badge {
                background: rgba(255,255,255,0.2);
                display: inline-block;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
                margin-bottom: 20px;
            }
            .preview-card h3 {
                font-size: 28px;
                margin-bottom: 16px;
            }
            .preview-explaination {
                font-size: 18px;
                line-height: 1.8;
                margin-bottom: 16px;
                opacity: 0.95;
            }
            .preview-description {
                font-size: 16px;
                line-height: 1.6;
                margin-bottom: 30px;
                opacity: 0.9;
            }
            .preview-card .btn-primary {
                background: white;
                color: #1e40af;
            }
            .preview-card .btn-primary:hover {
                background: #f0f0f0;
            }

            /* Feature Cards Section */
            .row {
                display: flex;
                flex-wrap: wrap;
                margin: 60px 0;
                max-width: 1200px;
                margin-left: auto;
                margin-right: auto;
                padding: 0 20px;
            }
            .row section {
                flex: 1;
                min-width: 300px;
                padding: 30px;
                background: white;
                border-radius: 16px;
                margin: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }
            .row section:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                border-color: #0369a1;
            }
            .row section h2 {
                font-size: 24px;
                color: #1a202c;
                margin-bottom: 16px;
                text-align: center;
            }
            .row section p {
                color: #718096;
                line-height: 1.8;
                margin-bottom: 20px;
                text-align: center;
            }
            .row section .btn-default {
                border: 2px solid #0369a1;
                background: transparent;
                color: #0369a1;
                padding: 12px 24px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                display: inline-block;
            }
            .row section .btn-default:hover {
                background: #0369a1;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(3, 105, 161, 0.3);
                text-decoration: none;
            }
            .feature-icon {
                font-size: 64px;
                text-align: center;
                margin-bottom: 20px;
            }

            @media (max-width: 768px) {
                .stats-grid, .steps-grid, .games-grid {
                    grid-template-columns: 1fr;
                }
                #aspnetTitle {
                    font-size: 40px;
                }
                .hero-subtitle {
                    font-size: 20px;
                }
                .hero-description {
                    font-size: 16px;
                }
                .hero-section-enhanced {
                    padding: 60px 20px;
                }
                .row section {
                    min-width: 100%;
                    margin: 10px 0;
                }
            }
        </style>
    </main>

</asp:Content>
