using assembly .\modules\LogProvider\NLog.dll
using assembly .\modules\MailerProvider\MailKit.dll
using assembly .\modules\MailerProvider\MimeKit.dll

using module .\modules\Services\Services.psm1
using module .\modules\LogProvider\LogProvider.psm1 
using module .\modules\MailerProvider\MailerProvider.psm1 

using module .\modules\NoOrderCheck\NoOrderCheck.psm1

using namespace System.IO
using namespace System.Text

Set-StrictMode -Version 'latest'
$DebugPreference = 'continue'
$ErrorActionPreference = 'stop'
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$True}

$conf = Import-PowerShellDataFile .\conf.psd1

$Global:Services = [Services]::new($Conf.Services)

$Logger = $Global:Services.Logger

$logger.Info('{0} session started' -f $Global:conf.Name)

$NoOrderCheck = [NoOrderCheck]::new($conf.NoOrderCheck)

$NoOrderCheck.GetResults()

$NoOrderCheck.SendRport()

$logger.Info('{0} session finished' -f $Global:conf.Name)

