using CSV
using DataFrames

df = CSV.read("Data/master_data.csv")

names(df)

stripChar = (s, r) -> replace(s, Regex("[$r]") => "")

states = Dict()
for i = 1:nrow(df)
    if df[i, 2] in keys(states)
        states[df[i,2]][1] += parse(Float64, stripChar(df[i, 6], "\$,"))
        states[df[i,2]][2] += 1
    else
        states[df[i,2]] = [parse(Float64, stripChar(df[i, 6], "\$,")), 1]
    end
end

means = Dict()
for key in keys(states)
    means[key] = states[key][1] / states[key][2]
end

abbr = [i[1] for i in collect(means)]
mean_vals = [i[2] for i in collect(means)]
data = [abbr, mean_vals]

means_df = DataFrame(data) 
rename!(means_df, :x1 => Symbol("State"))
rename!(means_df, :x2 => Symbol("Mean"))
means_df

CSV.write("Data/state_means.csv", means_df)
