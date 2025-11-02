<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Probfessional.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .team-section {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
        }

        .team-member {
            text-align: center;
        }

            .team-member img {
                width: 120px;
                height: 120px;
                object-fit: cover;
            }
    </style>
    <main aria-labelledby="title">
        <h2><strong>What is ProbFessional?</strong></h2>
    <p>ProbFessional is an educational web-based learning system developed by students from Asia Pacific University (APU).<br data-end="506" data-start="503" />
        Our team’s mission is to transform the way people learn probability: from something abstract and intimidating into something fun, interactive, and meaningful through parlour games like Poker, UNO, Mahjong, Dice, and Slot Machines.</p>
        <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <h2><strong>Our Mission</strong></h2>
    <p>- Bridge the gap between math theories and real-life practices</p>
    <p>- Help learners experience probability through interactive simulations and real-world examples</p>
    <p>- Create a safe, stress-free learning environment that builds critical thinking and analytical skills</p>
    <p>- Support educators in making mathematics lessons more engaging, relatable, and interactive</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <h2><span style="font-weight: normal"><strong>What We Offer</strong></span></h2>
    <li>
        <p>Gamified Learning Experience – Earn points, badges, and progress levels as you learn.</p>
    </li>
    <li>
        <p>Real-world Scenarios – Learn probability through examples from popular games.</p>
    </li>
    <li>
        <p>Structured Learning Modules – Lessons and quizzes tailored to teach applied probability.</p>
    </li>
    <li>
        <p>Instant Feedback – Check your answers and understand probability step-by-step.</p>
    </li>
    <li>
        <p>Educator Tools – Use verified materials and interactive exercises to enhance classroom teaching.</p>
        <p>&nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </li>

    <h2><strong>Our Team</strong></h2>
        <div class="team-section">
            <div class="team-member">
                <img src="TeamImage/kzx.png" alt="Zhao Xiang" />
                <p>Kok Zhao Xiang<br />TP080473</p>
            </div>
            <div class="team-member">
                <img src="TeamImage/ymy.png" alt="Ming Yuan" />
                <p>Yang Mingyuan<br />TP080028</p>
            </div>
            <div class="team-member">
                <img src="TeamImage/sbai.png" alt="Sbai" />
                <p>Abdellah Sbai<br />TP078170</p>
            </div>
            <div class="team-member">
                <img src="TeamImage/oxj.png" alt="Xuang Jian" />
                <p>Ong Xuang Jian<br />TP080343</p>
            </div>
        </div>

    <p>
        &nbsp;</p>
    </main>
</asp:Content>
