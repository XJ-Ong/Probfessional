<%@ Page Title="Your Progress" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Progress.aspx.cs" Inherits="Probfessional.Progress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- SqlDataSource for Modules with Progress -->
    <asp:SqlDataSource ID="sqlModulesProgress" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
        SelectCommand="
            SELECT 
                m.ID as Id,
                m.Title,
                m.ImagePath,
                ISNULL(up.ProgressPercent, 0) as ProgressPercent
            FROM Modules m
            LEFT JOIN UserProgress up ON m.ID = up.ModuleID AND up.UserID = @UserID
            ORDER BY m.ID">
        <SelectParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <h1 style="font-size: 2.5rem; font-weight: 700; margin-bottom: 30px;">Your Learning Progress</h1>

    <asp:Repeater ID="rptModules" runat="server" OnItemDataBound="rptModules_ItemDataBound">
        <ItemTemplate>
            <div class="card mb-4" style="margin-bottom: 20px; padding: 20px; border-left: 2px solid #007bff;">
                <div class="d-flex align-items-start">
                    <div style="width: 100px; margin-right: 20px; flex-shrink: 0; margin-top: 1rem; margin-bottom: 2rem;">
                        <%# !string.IsNullOrEmpty(Eval("ImagePath")?.ToString()) ? 
                            "<img src='" + ResolveUrl("~/" + Eval("ImagePath").ToString()) + "' alt='" + Server.HtmlEncode(Eval("Title").ToString()) + "' style='width: 100px; height: 100px; object-fit: cover; border-radius: 8px; border: 2px solid #e2e8f0;' />" : 
                            "<div class='bg-light d-flex align-items-center justify-content-center' style='width: 100px; height: 100px; border-radius: 8px; border: 2px solid #e2e8f0;'><span style='color: #999; font-size: 12px;'>No image</span></div>" %>
                    </div>
                    <div style="flex: 1; margin-top: 1rem;">
                        <h4><%# Eval("Title") %></h4>
                        
                        <!-- Progress Bar -->
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-1">
                                <small class="text-muted">Overall Progress</small>
                                <small class="text-muted"><strong><%# Eval("ProgressPercent") %>%</strong></small>
                            </div>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar" role="progressbar" data-progress="<%# Eval("ProgressPercent") %>"></div>
                            </div>
                        </div>
                        
                        <!-- Topics Progress (Collapsible) -->
                        <div class="mt-3 topics-section" id="topicsSection_<%# Eval("Id") %>" style="display: none;">
                            <strong class="small">Topics:</strong>
                            <asp:Repeater ID="rptLessons" runat="server">
                                <ItemTemplate>
                                    <div class="mb-2" style="font-size: 14px;">
                                        <span class="<%# Convert.ToBoolean(Eval("IsCompleted")) ? "text-success" : "text-muted" %>">
                                            <%# Eval("Title") %>
                                        </span>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="mt-3 d-flex gap-2">
                            <button type="button" class="btn btn-primary btn-sm expand-btn" data-module-id="<%# Eval("Id") %>">
                                <span class="expand-text">Show Topics</span>
                            </button>
                            <a class="btn btn-primary btn-sm" href="<%# ResolveUrl("~/Topics.aspx?id=" + Eval("Id")) %>">View Module</a>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
    
    <style>
        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .gap-2 {
            gap: 0.75rem;
        }
        .topics-section {
            padding-top: 10px;
            border-top: 1px solid #e0e0e0;
            margin-top: 10px;
        }
    </style>
    
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            // Set progress bar widths
            document.querySelectorAll('.progress-bar[data-progress]').forEach(function(bar) {
                var progress = bar.getAttribute('data-progress');
                bar.style.width = progress + '%';
            });
            
            // Expand/collapse topics
            var expandButtons = document.querySelectorAll('.expand-btn');
            expandButtons.forEach(function(btn) {
                btn.addEventListener('click', function() {
                    var moduleId = this.getAttribute('data-module-id');
                    var topicsSection = document.getElementById('topicsSection_' + moduleId);
                    var expandText = this.querySelector('.expand-text');
                    
                    if (topicsSection.style.display === 'none') {
                        topicsSection.style.display = 'block';
                        expandText.textContent = 'Hide Topics';
                    } else {
                        topicsSection.style.display = 'none';
                        expandText.textContent = 'Show Topics';
                    }
                });
            });
        });
    </script>
</asp:Content>
