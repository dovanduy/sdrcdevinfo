﻿<%@ Page Title="" Language="C#" MasterPageFile="~/libraries/aspx/HomeMaster.master"
    AutoEventWireup="true" CodeFile="AboutDevInfo.aspx.cs" Inherits="libraries_aspx_AboutDevInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphHeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMainContent" runat="Server">
    <div class="content_containers">
        <div id="reg_content_containers">

                <h2>
                  <span id="langAboutInfo" style="display:block"></span>
                    <div class="adm_nav_opt pddn_bttm_nne flt_rgt">
                        <ul>
                            <li><a href="javascript:void(0);" id="EditPage" runat="server">Edit This Page</a></li>
                        </ul>
                    </div>                    
                </h2>

                <div class="clear"></div>
            <h5>
            </h5>
            <!-- Main Contact Page Content Area ...starts-->
            <div class="desc_pg_main_sec" id="div_content" runat="server">
            </div>
            <!-- Main Contact Page Content Area ...ends-->
        </div>
    </div>
    <!-- DEVELOPER CODE -->
        <script type="text/javascript">
            CookiePostfixStr = '_' + '<%=Global.CookiePostfixStr%>';    // use in hosting app
            var di_components = "Language";
            var di_component_version = '<%=Global.diuilib_version%>';
            var di_theme_css = '<%=Global.diuilib_theme_css%>';
            var di_diuilib_url = '<%=Global.diuilib_url%>';
            document.write("<script type='text/javascript' src='" + "<%=Global.diuilib_url%>" + "diuilibincludes.js'" + "><\/script>");
            document.write("<script type='text/javascript' src='" + "<%=Global.diuilib_url%>" + "diuilibcommon.js'" + "><\/script>");
    </script>

    <script type="text/javascript">
        createFormHiddenInputs("frmDevinfoFeatures", "POST");
        setPostedData('<%=hdsby%>', '<%=hdbnid%>', '<%=hselarea%>', '<%=hselind%>', '<%=hlngcode%>', '<%=hlngcodedb%>', '<%=hselindo%>', '<%=hselareao%>', 10, '<%=hLoggedInUserNId%>', '<%=hLoggedInUserName%>');
        if (GetLanguageCounts() > 1) {
            z("LanguagePipeLi").style.display = "";
            ShowLanguageComponent(getAbsURL('stock'), 'lngcode_div', '<%=hlngcode%>');
        }
    </script>
    <script type="text/javascript">
        di_jq(document).ready(function () {
            var Url = document.URL.split("?")[1];
            document.getElementById('<%=EditPage.ClientID%>').href = "EditCMSContent.aspx?" + Url;
        });	   
    </script>
</asp:Content>
