using CSV
using DataFrames

df = CSV.read("Data/degrees-that-pay-back.csv")

stripChar = (s, r) -> replace(s, Regex("[$r]") => "")

names(df)

start_med = parse.(Float64, stripChar.(df[:, 2], "\$,"))
percent_change = df[:, 4]
mid_med_10 = parse.(Float64, stripChar.(df[:, 5], "\$,"))
mid_med_25 = parse.(Float64, stripChar.(df[:, 6], "\$,")) .- mid_med_10
mid_med = parse.(Float64, stripChar.(df[:, 3], "\$,")) .- mid_med_25 .- mid_med_10
mid_med_75 = parse.(Float64, stripChar.(df[:, 7], "\$,")) .- mid_med .- mid_med_25 .- mid_med_10
mid_med_90 = parse.(Float64, stripChar.(df[:, 8], "\$,")) .- mid_med_75 .- mid_med .- mid_med_25 .- mid_med_10

major_df = DataFrame(Dict("Major" => df[:, 1], "Starting Median Salary"=>start_med, "Mid-Career 10th Percentile"=>mid_med_10, "Mid-Career 25th Percentile"=>mid_med_25, "Mid-Career 50th Percentile"=>mid_med, "Mid-Career 75th Percentile"=>mid_med_75, "Mid-Career 90th Percentile"=>mid_med_90))

names(major_df)

CSV.write("Data/degrees_processed_data.csv", major_df)
