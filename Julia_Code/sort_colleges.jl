using CSV
df = CSV.read("Data/college_top5.csv")

df = sort(df)

CSV.write("Data/sorted_college_top5.csv", df)
