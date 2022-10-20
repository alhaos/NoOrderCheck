using namespace MailKit.Net.Smtp
using namespace MimeKit

Set-StrictMode -Version 'Latest'

class MailerProvider {

    [string[]]$Body

    # Mail server username
    [string]$Username
    
    # Mail server password
    [string]$Password

    # Mail server hostname or ip
    [string]$SMTPServer

    # Mail server port
    [int]$SMTPPort

    # EMail from
    [string]$EmailFrom

    [SmtpClient]$SMTPClient

    MailerProvider ([hashtable]$conf) {
        $this.Body = [string[]]::new(0)
        $this.Password = $conf.Password
        $this.Username = $conf.Username
        $this.SMTPPort = $conf.SMTPPort
        $this.SMTPServer = $conf.SMTPServer
        $this.EmailFrom = $conf.EmailFrom
        $this.SMTPClient = [SmtpClient]::New()
    }

    AddLine([string]$Line){
        $this.Body +=, $line
    }

    ClearBody(){
        $this.Body.Clear()
    }

    Send($body) {

        if ($Body.Length -eq 0) {
            return
        }

        $Message = [MimeMessage]::new()
        $Message.Body = [TextPart]@{
            text = $body
        } 
        $Message.To.Add("interfaces@accureference.com")
        $Message.To.Add("alhaos@gmail.com")
        $Message.Subject = "Accession with empty order number found"
        $Message.From.Add($this.EmailFrom)

        try {
            $this.SMTPClient.Connect($this.SMTPServer, $this.SMTPPort, [MailKit.Security.SecureSocketOptions]::Auto)
            $this.SMTPClient.Authenticate($this.username, $this.password)
            $this.SMTPClient.Send($Message)
        }
        catch {
            throw $_
        }
        finally {
            $this.SMTPClient.Disconnect($true)
        }
    }
}

