module PlotFramework
using Plots
using PlotThemes
using Dates

export set_design,
        PlotEnv,
        recreate_plot,
        get_date

struct PlotEnv
        logging::Bool
        design::String
        log_path::String
end
function PlotEnv(; logging=false, design="default", log_path=ENV["HOME"] * "/julia/log/plot.txt")
        PlotEnv(logging, design, log_path)
end

include("utils.jl")
include("design.jl")
include("logging.jl")
include("plotter.jl")

end
