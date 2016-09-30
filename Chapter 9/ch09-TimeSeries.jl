
using TimeSeries

using MarketData

ohlc[1]

ohlc[[1:3;9]]

ohlc["Open","Close"]

ohlc[[Date(2000,1,3),Date(2000,2,4)]]

ohlc[Date(2000,1,10):Date(2000,2,10)]

ohlc["Open"][Date(2000,1,10)]

from(cl, Date(2001, 10, 24))

to(cl, Date(2000, 10, 24))

red = findwhen(ohlc["Close"] .< ohlc["Open"]);

ohlc[red]

green = find(ohlc["Close"] .> ohlc["Open"]);

ohlc[green]

cl[1:4]

lag(cl[1:4])

lead(cl[1:4])

lead(cl, 400)

percentchange(cl)

merge(op[1:4], cl[2:6], :left)

a = TimeArray([Date(2015, 10, 24), Date(2015, 11, 04)], [15, 16], ["Number"])

map((timestamp, values) -> (timestamp + Dates.Year(1), values), a)


