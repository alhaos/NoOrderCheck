select distinct Accession
from logtest
where [Client ID] in ('44856', '44920')
    and (rtrim(ltrim(OrderNumber)) = '' or OrderNumber is null)
    and cast ([Entry Date] as date) = cast(GETDATE() as date)