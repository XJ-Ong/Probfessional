<%@ Page Title="Modules" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="Probfessional.Modules" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .modules-container {
            padding: 20px 0;
        }
        .modules-hero {
            text-align: center;
            padding: 50px 0;
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border-radius: 24px;
            margin-bottom: 50px;
            box-shadow: 0 20px 60px rgba(30, 64, 175, 0.3);
            position: relative;
            overflow: hidden;
        }
        .modules-hero::before {
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
        .modules-hero-content {
            position: relative;
            z-index: 1;
        }
        .modules-hero h1 {
            font-size: 42px;
            font-weight: 800;
            color: white;
            margin-bottom: 16px;
            text-shadow: 0 2px 20px rgba(0,0,0,0.2);
        }
        .modules-hero p {
            font-size: 18px;
            color: rgba(255,255,255,0.95);
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }
        .module-card {
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            background: white;
        }
        .module-card:hover {
            border-color: #0891b2;
            transform: translateY(-8px);
            box-shadow: 0 12px 40px rgba(8, 145, 178, 0.2);
        }
        .module-image {
            width: 100%;
            height: 180px;
            object-fit: contain;
            background: #f8f9fa;
        }
        .module-body {
            padding: 24px;
        }
        .module-title {
            font-size: 24px;
            font-weight: 700;
            color: #1e40af;
            margin-bottom: 12px;
        }
        .module-description {
            color: #4a5568;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .btn-view-module {
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            border: none;
            color: white;
            padding: 10px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .btn-view-module:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 20px rgba(8, 145, 178, 0.4);
            color: white;
            text-decoration: none;
        }
    </style>

    <main>
        <div class="modules-container">
            <div class="modules-hero">
                <div class="modules-hero-content">
                    <h1>Learning Modules</h1>
                    <p>Explore probability through interactive parlour games and master key concepts</p>
                </div>
            </div>
            
            <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />
            
            <div class="row" id="modulesGrid" runat="server">
                <!-- Modules will be loaded here -->
            </div>
        </div>
    </main>

</asp:Content>
