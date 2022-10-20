@{
    Name     = "NoOrderCheck"
    Services = @{
        LogProvider = @{
            LogDirectory      = ".\logs"
            LogFilenameFormat = '${shortdate}.log'
        } 
    }
}