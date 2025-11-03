<%@ Page Title="Rankings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rank.aspx.cs" Inherits="Probfessional.Rank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="rank-wrapper">
        <!-- Header -->
        <div class="rank-header">
            <h1 class="rank-title">Quiz Rankings</h1>
            <p class="rank-subtitle">Top 100 players per module</p>
        </div>
        
        <!-- Module Selection -->
        <div class="rank-module-selector">
            <label for="<%= ddlModules.ClientID %>" class="module-select-label">Select Module:</label>
            <asp:DropDownList ID="ddlModules" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlModules_SelectedIndexChanged" CssClass="module-select-dropdown" />
        </div>
        
        <!-- Rankings Table -->
        <div class="rank-content">
            <asp:Repeater ID="rptRankings" runat="server">
                <HeaderTemplate>
                    <div class="rank-table-header">
                        <div class="rank-col rank-col-position">Rank</div>
                        <div class="rank-col rank-col-user">User</div>
                        <div class="rank-col rank-col-score">Score</div>
                        <div class="rank-col rank-col-date">Date</div>
                    </div>
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="rank-item <%# (int)Eval("Rank") <= 3 ? "rank-top-" + Eval("Rank").ToString() : "" %>">
                        <div class="rank-col rank-col-position">
                            <span class="rank-number"><%# Eval("Rank") %></span>
                            <%# (int)Eval("Rank") <= 3 ? "<span class='rank-medal'>" + ((int)Eval("Rank") == 1 ? "🥇" : (int)Eval("Rank") == 2 ? "🥈" : "🥉") + "</span>" : "" %>
                        </div>
                        <div class="rank-col rank-col-user">
                            <span class="rank-user-name"><%# Eval("UserName") %></span>
                        </div>
                        <div class="rank-col rank-col-score">
                            <span class="rank-score"><%# Eval("Score") %>%</span>
                        </div>
                        <div class="rank-col rank-col-date">
                            <span class="rank-date"><%# Eval("TakenAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:Label ID="lblNoData" runat="server" Visible="false" CssClass="rank-no-data">
                No rankings available for this module yet.
            </asp:Label>
        </div>
    </div>
    
    <style>
        .rank-wrapper {
            max-width: 1000px;
            margin: 0 auto;
            padding: 25px;
        }
        
        /* Header */
        .rank-header {
            text-align: center;
            margin-bottom: 30px;
            padding: 30px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.25);
            color: white;
        }
        
        .rank-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: white;
            margin: 0 0 10px 0;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .rank-subtitle {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.9);
            margin: 0;
        }
        
        /* Module Selector */
        .rank-module-selector {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
        }
        
        .module-select-label {
            font-size: 1.15rem;
            font-weight: 600;
            color: #2d3748;
            margin: 0;
            white-space: nowrap;
        }
        
        .module-select-dropdown {
            flex: 1;
            padding: 12px 16px;
            font-size: 1.05rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            background: white;
            color: #2d3748;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .module-select-dropdown:hover {
            border-color: #cbd5e0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .module-select-dropdown:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }
        
        /* Rankings Table */
        .rank-content {
            background: white;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .rank-table-header {
            display: grid;
            grid-template-columns: 80px 1fr 120px 150px;
            gap: 15px;
            padding: 20px;
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-bottom: 2px solid #e2e8f0;
            font-weight: 700;
            color: #2d3748;
            font-size: 1rem;
        }
        
        .rank-item {
            display: grid;
            grid-template-columns: 80px 1fr 120px 150px;
            gap: 15px;
            padding: 18px 20px;
            border-bottom: 1px solid #e2e8f0;
            transition: all 0.2s ease;
            align-items: center;
        }
        
        .rank-item:hover {
            background: #f7fafc;
        }
        
        .rank-item:last-child {
            border-bottom: none;
        }
        
        .rank-item.rank-top-1 {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            border-left: 4px solid #f59e0b;
        }
        
        .rank-item.rank-top-2 {
            background: linear-gradient(135deg, #e5e7eb 0%, #d1d5db 100%);
            border-left: 4px solid #6b7280;
        }
        
        .rank-item.rank-top-3 {
            background: linear-gradient(135deg, #fed7aa 0%, #fdba74 100%);
            border-left: 4px solid #f97316;
        }
        
        .rank-col {
            display: flex;
            align-items: center;
        }
        
        .rank-col-position {
            font-weight: 700;
            font-size: 1rem;
            color: #2d3748;
        }
        
        .rank-number {
            display: inline-block;
            min-width: 30px;
        }
        
        .rank-medal {
            margin-left: 8px;
            font-size: 1.3rem;
        }
        
        .rank-col-user {
            font-size: 1rem;
            color: #4a5568;
        }
        
        .rank-user-name {
            font-weight: 500;
        }
        
        .rank-col-score {
            font-size: 1rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .rank-col-date {
            font-size: 1rem;
            color: #718096;
        }
        
        .rank-no-data {
            display: block;
            text-align: center;
            padding: 60px 20px;
            color: #718096;
            font-size: 1.1rem;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .rank-wrapper {
                padding: 15px;
            }
            
            .rank-title {
                font-size: 2rem;
            }
            
            .rank-table-header,
            .rank-item {
                grid-template-columns: 60px 1fr 100px 120px;
                gap: 10px;
                padding: 15px;
                font-size: 0.9rem;
            }
            
            .rank-module-selector {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .module-select-dropdown {
                width: 100%;
            }
        }
    </style>
</asp:Content>
