module PlotFramework
using Plots
using PlotThemes
using Dates

export set_design,
        set_design!,
        PlotEnv,
        setPlotEnv,
        recreate_plot,
        get_date,
        set_size_in_points,
        @log,
        @logtolib

struct PlotEnv
        logging::Bool
        design::Symbol
        log_path::String
end
function PlotEnv(; logging=false, design=:default, log_path=ENV["HOME"] * "/julia/log/plot.txt")
        return PlotEnv(logging, design, log_path)
end

include("utils.jl")
include("design.jl")
include("logging.jl")
include("plotter.jl")

end
