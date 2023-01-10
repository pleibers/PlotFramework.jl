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
function setPlotEnv(; logging=false, design="default", log_path=ENV["HOME"] * "/julia/log/plot.txt")
        global PlotEnironment = PlotEnv(logging, design, log_path)
        set_design(design)
        return PlotEnvironment
end

include("utils.jl")
include("design.jl")
include("logging.jl")
include("plotter.jl")

end
