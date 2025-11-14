<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Probfessional._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <!-- Hero Section -->
        <div class="card bg-primary text-white mb-4">
            <div class="card-body text-center py-5">
                <h1>ProbFessional</h1>
                <p class="lead">Exploring Probability in Parlour Games</p>
                <p>Learn mathematics through interactive gaming experiences with Poker, UNO, Mahjong, Dice, and Slot Machines.</p>
                <div class="mt-4">
                    <asp:HyperLink ID="lnkGetStarted" runat="server" CssClass="btn btn-light me-2" Text="Get Started" NavigateUrl="~/Register.aspx" />
                    <asp:HyperLink ID="lnkExploreModules" runat="server" CssClass="btn btn-outline-light" Text="Explore Modules" NavigateUrl="~/Modules.aspx" />
                </div>
            </div>
        </div>

        <!-- Statistics Section -->
        <div class="row text-center mb-5">
            <div class="col-md-3 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h2>🎓</h2>
                        <h3>5</h3>
                        <p>Interactive Modules</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h2>📊</h2>
                        <h3>50+</h3>
                        <p>Practice Quizzes</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h2>🏆</h2>
                        <h3>Unlimited</h3>
                        <p>Digital Badges</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h2>📈</h2>
                        <h3>Real-time</h3>
                        <p>Progress Tracking</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- How It Works Section -->
        <h2 class="text-center mb-4">How It Works</h2>
        <div class="row align-items-stretch mb-5">
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="badge bg-primary rounded-circle p-3 mb-3">1</div>
                        <h5>Sign Up Free</h5>
                        <p>Create your account in seconds. No payment required - learning probability is completely free!</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="badge bg-primary rounded-circle p-3 mb-3">2</div>
                        <h5>Choose a Game</h5>
                        <p>Select from 5 parlour games: Poker, UNO, Mahjong, Dice, or Slot Machines. Each teaches different probability concepts.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="badge bg-primary rounded-circle p-3 mb-3">3</div>
                        <h5>Learn & Practice</h5>
                        <p>Complete interactive lessons and solve real-world scenarios. Take quizzes to test your understanding.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <div class="badge bg-primary rounded-circle p-3 mb-3">4</div>
                        <h5>Earn & Progress</h5>
                        <p>Unlock badges, track your progress, and master probability concepts through gamified learning!</p>
                    </div>
                </div>
            </div>
        </div>


        <!-- Game Modules Preview Section -->
        <h2 class="text-center mb-2">Explore Our Game Modules</h2>
        <p class="text-center text-muted mb-4">Learn probability through fun, interactive parlour games</p>
        <div class="row align-items-stretch mb-5">

            <div class="col-md-4 mb-3">
                <div class="card h-100 d-flex flex-column">
                    <div class="card-body text-center d-flex flex-column">
                        <h2>🃏</h2>
                        <h5>Poker</h5>
                        <p>Master probability of hands and winning combinations. Calculate odds of royal flushes and pairs.</p>
                        <asp:HyperLink ID="lnkPokerLearnMore" runat="server" 
                            CssClass="btn btn-sm btn-primary mt-auto" 
                            Text="Learn More" NavigateUrl="~/Topics.aspx?id=1" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 d-flex flex-column">
                    <div class="card-body text-center d-flex flex-column">
                        <h2>🎴</h2>
                        <h5>UNO</h5>
                        <p>Understand card distribution and color combinations. Explore probability in card matching.</p>
                        <asp:HyperLink ID="lnkUnoLearnMore" runat="server" 
                            CssClass="btn btn-sm btn-primary mt-auto" 
                            Text="Learn More" NavigateUrl="~/Topics.aspx?id=2" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 d-flex flex-column">
                    <div class="card-body text-center d-flex flex-column">
                        <h2>🀄</h2>
                        <h5>Mahjong</h5>
                        <p>Discover tile probability patterns and winning combinations. Learn strategic probability.</p>
                        <asp:HyperLink ID="lnkMahjongLearnMore" runat="server" 
                            CssClass="btn btn-sm btn-primary mt-auto" 
                            Text="Learn More" NavigateUrl="~/Topics.aspx?id=3" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 d-flex flex-column">
                    <div class="card-body text-center d-flex flex-column">
                        <h2>🎲</h2>
                        <h5>Dice</h5>
                        <p>Study rolling outcomes and independent events. Calculate probabilities of sums.</p>
                        <asp:HyperLink ID="lnkDiceLearnMore" runat="server" 
                            CssClass="btn btn-sm btn-primary mt-auto" 
                            Text="Learn More" NavigateUrl="~/Topics.aspx?id=4" />
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-3">
                <div class="card h-100 d-flex flex-column">
                    <div class="card-body text-center d-flex flex-column">
                        <h2>🎰</h2>
                        <h5>Slot Machines</h5>
                        <p>Explore independent event probability and outcome calculations. Understand random chance.</p>
                        <asp:HyperLink ID="lnkSlotsLearnMore" runat="server" 
                            CssClass="btn btn-sm btn-primary mt-auto" 
                            Text="Learn More" NavigateUrl="~/Topics.aspx?id=5" />
                    </div>
                </div>
            </div>

        </div>

        <!-- Content Preview Section -->
        <div class="card bg-light mb-5">
            <div class="card-body">
                <span class="badge bg-info mb-3">Example Question</span>
                <h4>What's the probability of getting a royal flush in Poker?</h4>
                <p>
                    A royal flush is the highest possible hand in poker, consisting of A, K, Q, J, 10, all of the same suit. 
                    The probability is approximately <strong>0.000154%</strong> or 1 in 649,740 hands.
                </p>
                <p>
                    Through our interactive modules, you'll learn to calculate such probabilities step-by-step, 
                    understand combinatorics, and apply mathematical principles to real game scenarios.
                </p>
                <asp:HyperLink ID="lnkTryItYourself" runat="server" CssClass="btn btn-primary" Text="Try It Yourself" NavigateUrl="~/Quizzes.aspx?moduleId=1" />
            </div>
        </div>

        <!-- Enhanced Feature Cards -->
        <div class="row mb-5">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h2>📚</h2>
                        <h5>Interactive Learning</h5>
                        <p>
                            Experience probability through engaging parlour games. Structured modules make mathematics fun and practical.
                        </p>
                        <asp:HyperLink ID="lnkExploreModulesBottom" runat="server" CssClass="btn btn-outline-primary" Text="Explore Modules" NavigateUrl="~/Modules.aspx" />
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h2>🎮</h2>
                        <h5>Gamification</h5>
                        <p>
                            Earn digital badges, track progress, and unlock achievements. Stay motivated throughout your learning journey.
                        </p>
                        <asp:HyperLink ID="lnkStartLearning" runat="server" CssClass="btn btn-outline-primary" Text="Start Learning" NavigateUrl="~/Modules.aspx" />
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body text-center">
                        <h2>✏️</h2>
                        <h5>Practice & Quizzes</h5>
                        <p>
                            Test understanding with interactive quizzes. Get instant feedback and build confidence in game scenarios.
                        </p>
                        <asp:HyperLink ID="lnkTakeQuiz" runat="server" CssClass="btn btn-outline-primary" Text="Take a Quiz" NavigateUrl="~/Quizzes.aspx" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
