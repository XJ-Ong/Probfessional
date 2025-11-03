<%@ Page Title="Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="Probfessional.Lessons" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <div class="mb-3">
            <a href="javascript:history.back()" class="btn btn-secondary">
                <span>&laquo;</span> Back
            </a>
        </div>

        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false" />

        <div class="card">
            <div class="card-body">
                <h2 class="card-title mb-4" id="lessonTitle" runat="server"></h2>
                <div id="lessonContent" runat="server"></div>
                <div class="d-flex justify-content-between mt-4 pt-3 border-top">
                    <span id="prevLesson" runat="server"></span>
                    <span id="nextLesson" runat="server"></span>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
