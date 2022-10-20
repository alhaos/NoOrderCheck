using module ../LogProvider/LogProvider.psm1

Set-StrictMode -Version "Latest"

class Services {
    [LogProvider]$Logger
    [MailerProvider]$Mailer

    Services($Conf){
        $this.Mailer = [MailerProvider]::New($conf.Mail)
        $this.Logger = [LogProvider]::new($Conf.LogProvider)
    }
}