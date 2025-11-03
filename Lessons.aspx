<%@ Page Title="Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="Probfessional.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Back Button -->
    <div class="mb-3">
        <a href="javascript:history.back()" class="btn-back-lesson">
            <span>&laquo;</span> Back
        </a>
    </div>

    <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

    <style>
        .btn-back-lesson {
            display: inline-block;
            padding: 10px 20px;
            background-color: #f8f9fa;
            color: #495057;
            border: 2px solid #dee2e6;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-back-lesson span {
            margin-right: 8px;
        }
        .btn-back-lesson:hover {
            background-color: #e9ecef;
            border-color: #adb5bd;
            color: #212529;
            text-decoration: none;
            transform: translateX(-2px);
        }
        .lesson-container {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }
        .lesson-title {
            font-size: 36px;
            font-weight: 800;
            color: #1e40af;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 3px solid #0891b2;
        }
        .lesson-content {
            font-size: 16px;
            line-height: 1.8;
            color: #2d3748;
        }
        .lesson-content h2 {
            font-size: 28px;
            font-weight: 700;
            color: #1e40af;
            margin-top: 32px;
            margin-bottom: 16px;
        }
        .lesson-content h3 {
            font-size: 22px;
            font-weight: 700;
            color: #0369a1;
            margin-top: 24px;
            margin-bottom: 12px;
        }
        .lesson-content ul, .lesson-content ol {
            margin: 16px 0;
            padding-left: 30px;
        }
        .lesson-content li {
            margin-bottom: 8px;
        }
        .lesson-content p {
            margin-bottom: 16px;
        }
        .lesson-content img {
            display: none !important;
        }
        .btn-navigation {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 16px;
        }
        .btn-prev {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            color: white;
        }
        .btn-prev:hover {
            background: linear-gradient(135deg, #5a6268 0%, #343a40 100%);
            color: white;
            text-decoration: none;
            transform: translateX(-4px);
        }
        .btn-next {
            background: linear-gradient(135deg, #1e40af 0%, #0369a1 50%, #0891b2 100%);
            color: white;
        }
        .btn-next:hover {
            background: linear-gradient(135deg, #1e3a8a 0%, #075985 50%, #0e7490 100%);
            color: white;
            text-decoration: none;
            transform: translateX(4px);
        }
        .navigation-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 40px;
            padding-top: 24px;
            border-top: 2px solid #e2e8f0;
            gap: 16px;
        }
    </style>

    <div class="lesson-container">
        <h1 class="lesson-title" id="lessonTitle" runat="server"></h1>
        <div class="lesson-content" id="lessonContent" runat="server"></div>
        <div class="navigation-controls">
            <span id="prevLesson" runat="server"></span>
            <span id="nextLesson" runat="server"></span>
        </div>
    </div>
</asp:Content>
