@{
    Name         = "NoOrderCheck"
    NoOrderCheck = @{
        ConnectionString = "Data Source=192.168.101.222;Database=FINANCE;User Id=acif;Password=cipher-84T9u"
        Query            = '.\resources\query.sql'
    }
    Services     = @{
        LogProvider = @{
            LogDirectory      = ".\logs"
            LogFilenameFormat = '${shortdate}.log'
        } 
        Mail        = @{
            Username   = "accu-note@ac.com"
            Password   = "widen-qmgBMw#"
            SMTPServer = "webmail.accureference.com"
            SMTPPort   = 587
            EmailFrom  = "accu-note@accureference.com"
        }
    }
}