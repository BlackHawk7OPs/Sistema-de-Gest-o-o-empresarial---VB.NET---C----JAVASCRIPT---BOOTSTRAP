<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false" CodeFile="emailsenviados.aspx.vb" Inherits="Relatorios_EmailsEnviados_emailsenviados" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 87px;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="conteudo">

            <asp:TabContainer ID="TabContainer1" runat="server" 
    ActiveTabIndex="1" Width="94%">
                <asp:TabPanel runat="server" HeaderText="TabPanel3" ID="TabPanel3">
                                    

                    <HeaderTemplate>Cadastro</HeaderTemplate>
                                    

                
<ContentTemplate><table width="100%" border="0" cellspacing="0" cellpadding="3"><tr><td class="style1"><span class="conteudo_interno_titulo">
    Emails Enviados</span></td></tr><tr><td><img src="../App_Themes/SISTEC_WEB_THEME/imagens/line_01.gif" width="100%" height="1" /></td></tr></table>
    <asp:FormView ID="FormView1" runat="server" 
             Font-Size="Small" Width="864px" style="margin-right: 0px">
                                    <EmptyDataTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                ForeColor="#333333" GridLines="None" PageSize="15" Width="100%" 
                DataSourceID="SqlDataSource1">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField HeaderText="Destinatário" />
                    <asp:BoundField HeaderText="Título" />
                    <asp:BoundField HeaderText="Data" />
                    <asp:BoundField HeaderText="Email do Remetente" />
                    <asp:BoundField HeaderText="GAS" />
                    <asp:BoundField HeaderText="Orçamento" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" Font-Size="Medium" ForeColor="White" 
                    HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <br />
            <table class="style1">
                <tr>
                    <td class="style2">
                        CC:</td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        CCC:</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        Anexos:</td>
                    <td>
                        <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" >
                        Mensagem:<br />
                        <asp:TextBox ID="TextBox4" runat="server" Rows="10" TextMode="MultiLine" 
                            Width="790px"></asp:TextBox>
                    </td>
                </tr>
            </table>
                                    </EmptyDataTemplate>
        <ItemTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                ForeColor="#333333" GridLines="None" PageSize="15" Width="100%">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField HeaderText="Destinatário" />
                    <asp:BoundField HeaderText="Título" />
                    <asp:BoundField HeaderText="Data" />
                    <asp:BoundField HeaderText="Email do Remetente" />
                    <asp:BoundField HeaderText="GAS" />
                    <asp:BoundField HeaderText="Orçamento" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" Font-Size="Medium" ForeColor="White" 
                    HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <br />
            <table class="style1">
                <tr>
                    <td class="style2">
                        CC:</td>
                    <td>
                        <asp:TextBox ID="TextBox1" runat="server" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        CCC:</td>
                    <td>
                        <asp:TextBox ID="TextBox2" runat="server" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        Anexos:</td>
                    <td>
                        <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="700px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" >
                        Mensagem:<br />
                        <asp:TextBox ID="TextBox4" runat="server" Rows="10" TextMode="MultiLine" 
                            Width="790px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
                                    <PagerTemplate>
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                                            DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" 
                                            PageSize="15" Width="100%">
                                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                            <Columns>
                                                <asp:BoundField HeaderText="Destinatário" />
                                                <asp:BoundField HeaderText="Título" />
                                                <asp:BoundField HeaderText="Data" />
                                                <asp:BoundField HeaderText="Email do Remetente" />
                                                <asp:BoundField HeaderText="GAS" />
                                                <asp:BoundField HeaderText="Orçamento" />
                                            </Columns>
                                            <EditRowStyle BackColor="#999999" />
                                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                            <PagerStyle BackColor="#284775" Font-Size="Medium" ForeColor="White" 
                                                HorizontalAlign="Center" />
                                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                                        </asp:GridView>
                                        <br />
                                        <table class="style1">
                                            <tr>
                                                <td class="style2">
                                                    CC:</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox1" runat="server" Width="700px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style2">
                                                    CCC:</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox2" runat="server" Width="700px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style2">
                                                    Anexos:</td>
                                                <td>
                                                    <asp:TextBox ID="TextBox3" runat="server" TextMode="MultiLine" Width="700px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    Mensagem:<br />
                                                    <asp:TextBox ID="TextBox4" runat="server" Rows="10" TextMode="MultiLine" 
                                                        Width="790px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </PagerTemplate>
    </asp:FormView></ContentTemplate>
                   
</asp:TabPanel>
            </asp:TabContainer>
       
       
   </div>  
  
    </asp:Content>




