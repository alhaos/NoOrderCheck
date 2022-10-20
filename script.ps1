using assembly .\modules\LogProvider\NLog.dll

using module .\modules\Services\Services.psm1
using module .\modules\LogProvider\LogProvider.psm1 
using module .\modules\MailerProvider\MailerProvider.psm1 

using module .\modules\Shima\Shima.psm1

using namespace System.IO
using namespace System.Text

Set-StrictMode -Version 'latest'
$DebugPreference = 'continue'
$ErrorActionPreference = 'stop'

$conf = Import-PowerShellDataFile .\conf.psd1

$Global:Services = [Services]::new($Conf.Services)

$Logger = $Global:Services.Logger

$logger.Info('{0} session started' -f $Global:conf.Name)

$logger.Info('{0} session finished' -f $Global:conf.Name)

