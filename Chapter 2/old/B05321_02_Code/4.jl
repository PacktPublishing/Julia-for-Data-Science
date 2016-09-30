using DataFrames
df2 = DataFrame()
df2[:X] = 1:10
df2[:Y] = ["Head", "Tail", "Head", "Head", "Tail", "Head", "Tail", "Tail", "Head", "Tail"]
df2
size(df2)
head(df2)
tail(df2)
describe(df2)
