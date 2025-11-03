<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Probfessional.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        /* Reset master chrome */
        header, footer, hr { display: none !important; }
        .body-content, .container { padding: 0 !important; margin: 0 !important; max-width: 100% !important; width: 100% !important; }
        .container.body-content { min-height: 100vh !important; display: flex !important; align-items: center !important; justify-content: center !important; padding: 20px !important; }
        #MainContent { width: 100% !important; display: flex !important; justify-content: center !important; align-items: center !important; }
        
        /* Sleek modern masculine gradient background */
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 20%, #1e40af 40%, #0369a1 60%, #0891b2 80%, #0e7490 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
            overflow-y: auto;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        /* Floating animated shapes */
        body::before,
        body::after {
            content: '';
            position: fixed;
            border-radius: 50%;
            pointer-events: none;
            z-index: 2;
            animation: floatShape 20s ease-in-out infinite;
            filter: blur(80px);
        }
        body::before {
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(30, 64, 175, 0.4) 0%, transparent 70%);
            top: -250px;
            left: -250px;
            animation-delay: 0s;
        }
        body::after {
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(8, 145, 178, 0.35) 0%, transparent 70%);
            bottom: -300px;
            right: -300px;
            animation-delay: 7s;
        }
        @keyframes floatShape {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(100px, 100px) rotate(120deg); }
            66% { transform: translate(-100px, 100px) rotate(240deg); }
        }
        
        /* Main register container */
        .register-wrapper {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            min-height: 550px;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,255,255,0.1), 0 0 120px rgba(30, 64, 175, 0.4), 0 0 250px rgba(8, 145, 178, 0.2);
            backdrop-filter: blur(20px);
            animation: slideUp 0.8s ease-out, pulseGlow 5s ease-in-out infinite;
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulseGlow {
            0%, 100% { box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,255,255,0.1), 0 0 120px rgba(30, 64, 175, 0.4), 0 0 250px rgba(8, 145, 178, 0.2); }
            50% { box-shadow: 0 25px 50px -12px rgba(0,0,0,0.5), 0 0 0 1px rgba(255,255,255,0.15), 0 0 180px rgba(30, 64, 175, 0.6), 0 0 350px rgba(8, 145, 178, 0.4); }
        }
        
        /* Left side - Visual */
        .register-visual {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95) 0%, rgba(30, 64, 175, 0.95) 30%, rgba(3, 105, 161, 0.95) 60%, rgba(8, 145, 178, 0.95) 100%);
            background-size: 200% 200%;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden;
            animation: gradientRotate 10s ease infinite;
        }
        @keyframes gradientRotate {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .register-visual::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.15) 2px, transparent 2px);
            background-size: 60px 60px;
            opacity: 0.4;
            animation: patternMove 20s linear infinite;
        }
        @keyframes patternMove {
            0% { transform: translate(0, 0); }
            100% { transform: translate(60px, 60px); }
        }
        .register-visual::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, transparent 70%);
            border-radius: 50%;
            top: -200px;
            right: -200px;
            animation: rotateGlow 15s linear infinite;
        }
        @keyframes rotateGlow {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .visual-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
        }
        .visual-content h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 14px;
            text-shadow: 0 2px 20px rgba(0,0,0,0.3), 0 0 30px rgba(255,255,255,0.3);
            animation: fadeInLeft 1s ease-out, textGlow 3s ease-in-out infinite;
        }
        @keyframes fadeInLeft {
            from { opacity: 0; transform: translateX(-30px); }
            to { opacity: 1; transform: translateX(0); }
        }
        @keyframes textGlow {
            0%, 100% { text-shadow: 0 2px 20px rgba(0,0,0,0.3), 0 0 30px rgba(255,255,255,0.3); }
            50% { text-shadow: 0 2px 20px rgba(0,0,0,0.3), 0 0 50px rgba(255,255,255,0.5); }
        }
        .visual-content p {
            font-size: 16px;
            opacity: 0.95;
            line-height: 1.5;
            animation: fadeInLeft 1s ease-out 0.2s both;
        }
        .visual-icon {
            margin-bottom: 24px;
        }
        .visual-icon img {
            width: 130px;
            height: auto;
            filter: drop-shadow(0 4px 20px rgba(0,0,0,0.3)) drop-shadow(0 0 30px rgba(255,255,255,0.4));
        }
        
        /* Right side - Form */
        .register-form-section {
            background: rgba(255,255,255,0.95);
            backdrop-filter: blur(20px);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow-y: visible;
            max-height: none;
        }
        .form-header {
            margin-bottom: 32px;
        }
        .form-header h2 {
            font-size: 28px;
            font-weight: 800;
            color: #1a202c;
            margin-bottom: 6px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 40%, #0891b2 80%, #0e7490 100%);
            background-size: 200% 200%;
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: textGradient 4s ease infinite;
        }
        @keyframes textGradient {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .form-header p {
            color: #718096;
            font-size: 14px;
        }
        
        /* Form fields */
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #2d3748;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .form-group label::before {
            content: '';
            width: 4px;
            height: 16px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 2px;
            animation: labelGlow 2s ease-in-out infinite;
        }
        @keyframes labelGlow {
            0%, 100% { box-shadow: 0 0 8px rgba(30, 64, 175, 0.6); }
            50% { box-shadow: 0 0 20px rgba(8, 145, 178, 0.9); }
        }
        .form-group input {
            width: 100%;
            height: 48px;
            padding: 0 16px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 15px;
            color: #1a202c;
            background: #ffffff;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        .form-group input:focus {
            outline: none;
            border-color: #0369a1;
            box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.15), 0 0 25px rgba(3, 105, 161, 0.4), 0 0 50px rgba(8, 145, 178, 0.2);
            transform: translateY(-1px);
            animation: inputPulse 1.5s ease-in-out infinite;
        }
        @keyframes inputPulse {
            0%, 100% { box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.15), 0 0 25px rgba(3, 105, 161, 0.4), 0 0 50px rgba(8, 145, 178, 0.2); }
            50% { box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.25), 0 0 40px rgba(3, 105, 161, 0.6), 0 0 80px rgba(8, 145, 178, 0.4); }
        }
        .form-group input::placeholder {
            color: #a0aec0;
        }
        
        /* Role Selection Cards */
        .role-selection-group {
            margin-bottom: 20px;
        }
        .role-selection-group label {
            display: block;
            font-weight: 600;
            font-size: 14px;
            color: #2d3748;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .role-selection-group label::before {
            content: '';
            width: 4px;
            height: 16px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 2px;
            animation: labelGlow 2s ease-in-out infinite;
        }
        .role-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .role-option {
            position: relative;
            cursor: pointer;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px 16px;
            background: #ffffff;
            transition: all 0.3s ease;
            text-align: center;
        }
        .role-option:hover {
            border-color: #0369a1;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(30, 64, 175, 0.15);
        }
        .role-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }
        .role-option.selected {
            border-color: #0369a1;
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.05) 0%, rgba(3, 105, 161, 0.05) 50%, rgba(8, 145, 178, 0.05) 100%);
            box-shadow: 0 0 0 4px rgba(30, 64, 175, 0.1), 0 4px 12px rgba(3, 105, 161, 0.2);
        }
        .role-option .role-icon {
            font-size: 32px;
            margin-bottom: 8px;
            display: block;
            transition: transform 0.3s ease;
            width: 48px;
            height: 48px;
            margin: 0 auto 8px;
            background: linear-gradient(135deg, rgba(30, 64, 175, 0.1) 0%, rgba(3, 105, 161, 0.1) 50%, rgba(8, 145, 178, 0.1) 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        /* Learner icon - stacked books */
        .role-option .role-icon.learner::before {
            content: '';
            width: 28px;
            height: 20px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 2px;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 0 -8px 0 -2px rgba(30, 64, 175, 0.6), 0 8px 0 -2px rgba(8, 145, 178, 0.6);
        }
        .role-option .role-icon.learner::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 2px;
            background: linear-gradient(90deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        /* Teacher icon - graduation cap */
        .role-option .role-icon.teacher::before {
            content: '';
            width: 28px;
            height: 16px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            clip-path: polygon(50% 0%, 100% 30%, 90% 100%, 10% 100%, 0% 30%);
            position: absolute;
            top: 40%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .role-option .role-icon.teacher::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 12px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            clip-path: polygon(0% 100%, 50% 0%, 100% 100%);
            top: 55%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
        .role-option:hover .role-icon,
        .role-option.selected .role-icon {
            transform: scale(1.1);
        }
        .role-option .role-title {
            font-weight: 700;
            font-size: 16px;
            color: #1a202c;
            margin-bottom: 4px;
            display: block;
        }
        .role-option.selected .role-title {
            color: #0369a1;
        }
        .role-option .role-description {
            font-size: 12px;
            color: #718096;
            display: block;
        }
        .role-option.selected .role-description {
            color: #4a5568;
        }
        .role-checkmark {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 24px;
            height: 24px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 50%;
            display: none;
            align-items: center;
            justify-content: center;
            animation: checkmarkPop 0.3s ease-out;
        }
        .role-option.selected .role-checkmark {
            display: flex;
        }
        @keyframes checkmarkPop {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        .role-checkmark::before {
            content: '';
            width: 6px;
            height: 10px;
            border-bottom: 2px solid white;
            border-right: 2px solid white;
            transform: rotate(45deg);
            margin-top: -2px;
        }
        
        /* Submit button */
        .btn-submit {
            width: 100%;
            height: 48px;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 30%, #0891b2 70%, #0e7490 100%);
            background-size: 200% 200%;
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(30, 64, 175, 0.5), 0 0 40px rgba(3, 105, 161, 0.3);
            z-index: 1;
            animation: buttonGradient 3s ease infinite;
        }
        @keyframes buttonGradient {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .btn-submit:hover {
            transform: translateY(-2px) scale(1.02);
            box-shadow: 0 6px 30px rgba(30, 64, 175, 0.7), 0 0 60px rgba(8, 145, 178, 0.5);
            animation: buttonGradient 1.5s ease infinite, buttonGlow 1s ease-in-out infinite;
        }
        @keyframes buttonGlow {
            0%, 100% { box-shadow: 0 6px 30px rgba(30, 64, 175, 0.7), 0 0 60px rgba(8, 145, 178, 0.5); }
            50% { box-shadow: 0 6px 40px rgba(30, 64, 175, 0.9), 0 0 80px rgba(8, 145, 178, 0.7); }
        }
        .btn-submit:active {
            transform: translateY(0) scale(0.98);
        }
        
        /* Sign in link */
        .signin-link {
            text-align: center;
            margin-top: 24px;
            color: #718096;
            font-size: 14px;
        }
        .signin-link a {
            color: #0369a1;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }
        .signin-link a:hover {
            color: #0891b2;
            text-shadow: 0 0 10px rgba(8, 145, 178, 0.6);
        }
        
        /* Validation messages */
        .validation-message {
            color: #e53e3e;
            font-size: 13px;
            margin-top: 6px;
            display: block;
        }
        .alert-danger {
            background: #fed7d7;
            color: #c53030;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #e53e3e;
        }
        
        /* Responsive */
        @media (max-width: 968px) {
            .register-wrapper {
                grid-template-columns: 1fr;
                max-width: 500px;
                margin: 20px auto;
            }
            .register-visual {
                padding: 40px 30px;
                min-height: 250px;
            }
            .register-form-section {
                padding: 40px 30px;
            }
            .visual-content h1 {
                font-size: 32px;
            }
            .visual-icon img {
                width: 120px;
            }
            .container.body-content {
                align-items: flex-start !important;
                padding-top: 20px !important;
                padding-bottom: 20px !important;
            }
            .role-options {
                grid-template-columns: 1fr;
            }
        }
    </style>
    
    <div class="register-wrapper">
        <!-- Left Visual Side -->
        <div class="register-visual">
            <div class="visual-content">
                <div class="visual-icon">
                    <img src="<%= ResolveUrl("~/Logo/probfessional-default-transparent.png") %>" alt="ProbFessional Logo" />
                </div>
                <h1>Join Us!</h1>
                <p>Start your journey learning probability through interactive parlour games.<br/>Get badges, track progress, and master mathematics!</p>
            </div>
        </div>
        
        <!-- Right Form Side -->
        <div class="register-form-section">
            <div class="form-header">
                <h2>Create Account</h2>
                <p>Enter your details to get started</p>
            </div>
            
            <asp:ValidationSummary runat="server" CssClass="alert alert-danger" DisplayMode="BulletList" />
            
            <asp:Panel runat="server" DefaultButton="btnRegister">
                <div class="form-group">
                    <label for="txtEmail">Email Address</label>
                    <asp:TextBox runat="server" ID="txtEmail" TextMode="Email" placeholder="you@example.com" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" Display="Dynamic" CssClass="validation-message" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^\S+@\S+\.\S+$" ErrorMessage="Invalid email format" CssClass="validation-message" Display="Dynamic" />
                </div>
                
                <div class="form-group">
                    <label for="txtDisplayName">Display Name</label>
                    <asp:TextBox runat="server" ID="txtDisplayName" placeholder="Your display name" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDisplayName" ErrorMessage="Display name is required" Display="Dynamic" CssClass="validation-message" />
                </div>
                
                <div class="role-selection-group">
                    <label>Account Type</label>
                    <div class="role-options">
                        <label class="role-option" for="rbLearner">
                            <asp:RadioButton runat="server" ID="rbLearner" GroupName="Role" Checked="true" />
                            <span class="role-icon learner"></span>
                            <span class="role-title">Learner</span>
                            <span class="role-description">Learn and take courses</span>
                            <span class="role-checkmark"></span>
                        </label>
                        <label class="role-option" for="rbTeacher">
                            <asp:RadioButton runat="server" ID="rbTeacher" GroupName="Role" />
                            <span class="role-icon teacher"></span>
                            <span class="role-title">Teacher</span>
                            <span class="role-description">Create and manage courses</span>
                            <span class="role-checkmark"></span>
                        </label>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" placeholder="Create a strong password" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required" Display="Dynamic" CssClass="validation-message" />
                </div>
                
                <div class="form-group">
                    <label for="txtConfirm">Confirm Password</label>
                    <asp:TextBox runat="server" ID="txtConfirm" TextMode="Password" placeholder="Confirm your password" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirm" ErrorMessage="Please confirm your password" Display="Dynamic" CssClass="validation-message" />
                    <asp:CompareValidator runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" CssClass="validation-message" Display="Dynamic" />
                </div>
                
                <asp:Button runat="server" ID="btnRegister" Text="Create Account" CssClass="btn-submit" OnClick="btnRegister_Click" />
                
                <div class="signin-link">
                    Already have an account? <a href="Login.aspx">Sign in here</a>
                </div>
            </asp:Panel>
        </div>
    </div>
    
    <script>
        // Role selection handler
        (function() {
            var learnerRadio = document.getElementById('<%= rbLearner.ClientID %>');
            var teacherRadio = document.getElementById('<%= rbTeacher.ClientID %>');
            var learnerOption = learnerRadio ? learnerRadio.closest('.role-option') : null;
            var teacherOption = teacherRadio ? teacherRadio.closest('.role-option') : null;
            
            function updateRoleSelection() {
                if (learnerRadio && learnerRadio.checked) {
                    if (learnerOption) learnerOption.classList.add('selected');
                    if (teacherOption) teacherOption.classList.remove('selected');
                } else if (teacherRadio && teacherRadio.checked) {
                    if (teacherOption) teacherOption.classList.add('selected');
                    if (learnerOption) learnerOption.classList.remove('selected');
                }
            }
            
            if (learnerRadio) {
                learnerRadio.addEventListener('change', updateRoleSelection);
                if (learnerOption) {
                    learnerOption.addEventListener('click', function(e) {
                        if (e.target !== learnerRadio) {
                            learnerRadio.checked = true;
                            updateRoleSelection();
                        }
                    });
                }
            }
            
            if (teacherRadio) {
                teacherRadio.addEventListener('change', updateRoleSelection);
                if (teacherOption) {
                    teacherOption.addEventListener('click', function(e) {
                        if (e.target !== teacherRadio) {
                            teacherRadio.checked = true;
                            updateRoleSelection();
                        }
                    });
                }
            }
            
            updateRoleSelection();
        })();
    </script>
    
</asp:Content>
