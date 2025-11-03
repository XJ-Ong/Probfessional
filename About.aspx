<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Probfessional.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <!-- Hero Section -->
        <div class="card bg-primary text-white mb-4">
            <div class="card-body text-center py-5">
                <h1>About ProbFessional</h1>
                <p class="lead">ProbFessional is an educational web-based learning system developed by students from Asia Pacific University (APU).</p>
                <p>Our team's mission is to transform the way people learn probability: from something abstract and intimidating into something fun, interactive, and meaningful through parlour games like Poker, UNO, Mahjong, Dice, and Slot Machines.</p>
            </div>
        </div>

        <!-- Our Team Section -->
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title text-primary border-bottom pb-2 mb-4">Our Team</h2>
                <div class="row">
                    <div class="col-md-3 mb-3 text-center">
                        <img src="TeamImage/kzx.png" alt="Kok Zhao Xiang" class="rounded-circle mb-3" style="width: 140px; height: 140px; object-fit: cover;" />
                        <p class="fw-bold">Kok Zhao Xiang<br />TP080473</p>
                    </div>
                    <div class="col-md-3 mb-3 text-center">
                        <img src="TeamImage/ymy.png" alt="Yang Mingyuan" class="rounded-circle mb-3" style="width: 140px; height: 140px; object-fit: cover;" />
                        <p class="fw-bold">Yang Mingyuan<br />TP080028</p>
                    </div>
                    <div class="col-md-3 mb-3 text-center">
                        <img src="TeamImage/sbai.png" alt="Abdellah Sbai" class="rounded-circle mb-3" style="width: 140px; height: 140px; object-fit: cover;" />
                        <p class="fw-bold">Abdellah Sbai<br />TP078170</p>
                    </div>
                    <div class="col-md-3 mb-3 text-center">
                        <img src="TeamImage/oxj.png" alt="Ong Xuang Jian" class="rounded-circle mb-3" style="width: 140px; height: 140px; object-fit: cover;" />
                        <p class="fw-bold">Ong Xuang Jian<br />TP080343</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Our Mission Section -->
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title text-primary border-bottom pb-2 mb-4">Our Mission</h2>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">Bridge the gap between math theories and real-life practices</li>
                    <li class="list-group-item">Help learners experience probability through interactive simulations and real-world examples</li>
                    <li class="list-group-item">Create a safe, stress-free learning environment that builds critical thinking and analytical skills</li>
                    <li class="list-group-item">Support educators in making mathematics lessons more engaging, relatable, and interactive</li>
                </ul>
            </div>
        </div>

        <!-- What We Offer Section -->
        <div class="card mb-5">
            <div class="card-body">
                <h2 class="card-title text-primary border-bottom pb-2 mb-4">What We Offer</h2>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h2>🎮</h2>
                                <h5>Gamified Learning</h5>
                                <p>Earn points, badges, and progress levels as you learn probability through interactive games.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h2>🌍</h2>
                                <h5>Real-world Scenarios</h5>
                                <p>Learn probability through examples from popular parlour games like Poker, UNO, and more.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h2>📚</h2>
                                <h5>Structured Modules</h5>
                                <p>Lessons and quizzes tailored to teach applied probability concepts step-by-step.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h2>⚡</h2>
                                <h5>Instant Feedback</h5>
                                <p>Check your answers and understand probability concepts with detailed explanations.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h2>👨‍🏫</h2>
                                <h5>Educator Tools</h5>
                                <p>Use verified materials and interactive exercises to enhance classroom teaching.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
