using namespace System.Data.SqlClient

Set-StrictMode -Version 'latest'

class NoOrderCheck {
    
    [string]$ConnectionString

    [SqlConnection]$Conn

    [string]$Command

    [string[]]$Results

    NoOrderCheck ([hashtable]$conf){
        
        $this.ConnectionString = $conf.ConnectionString
        $this.Command = [System.IO.File]::ReadAllText($conf.Query)
        $this.Conn = [SqlConnection]::new()
        $this.Conn.ConnectionString = $this.ConnectionString
    }

    GetResults () {
        $Global:Services.Logger.Info("GetResults")
        $comm = $this.Conn.CreateCommand()
        $comm.CommandText = $this.Command
       
        try {
            $this.Conn.Open()
            $dataReader = $comm.ExecuteReader()            
            while ($dataReader.Read()) {
                $this.Results += $dataReader.GetString(0)
            }
        }
        catch {
            throw $_
        }
        finally {
            $this.Conn.Close()
        }
    }

    SendRport (){
        $Global:Services.Logger.Info("SendReport")
        if ($this.Results -gt 0) {
            $body = $this.Results -join [System.Environment]::NewLine
            $Global:Services.Mailer.Send($body)
        }        
    }
}
