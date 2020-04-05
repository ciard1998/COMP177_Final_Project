using CSV
using DataFrames
using Statistics

df = readtable("Data/salaries-by-college-type.csv", nastrings=["N/A"],eltypes=[String, String, Float64, Float64, Float64, Float64, Float64, Float64])

groups = groupby(df, :School_Type)
types = Dict()
for i = 1:length(groups)
    types[groups[i][1,2]] = [mean(skipmissing(groups[i][:, 3])), 
                            mean(skipmissing(groups[i][:, 4])), 
                            mean(skipmissing(groups[i][:, 5])), 
                            mean(skipmissing(groups[i][:, 6])), 
                            mean(skipmissing(groups[i][:, 7])), 
                            mean(skipmissing(groups[i][:, 8]))]
end

school_type = [i[1] for i in collect(types)]
mean_vals = [i[2] for i in collect(types)]
sms = [i[1] for i in mean_vals]
mc_50 = [i[2] for i in mean_vals]
mc_10 = [i[3] for i in mean_vals]
mc_25 = [i[4] for i in mean_vals]
mc_75 = [i[5] for i in mean_vals]
mc_90 = [i[6] for i in mean_vals]
data = [school_type, sms, mc_50, mc_10, mc_25, mc_75, mc_90]

means_df = DataFrame(data)
rename!(means_df, :x1 => Symbol("school_type"))
rename!(means_df, :x2 => Symbol("sms"))
rename!(means_df, :x3 => Symbol("mc_50"))
rename!(means_df, :x4 => Symbol("mc_10"))
rename!(means_df, :x5 => Symbol("mc_25"))
rename!(means_df, :x6 => Symbol("mc_75"))
rename!(means_df, :x7 => Symbol("mc_90"))

CSV.write("Data/type_means.csv", means_df)
