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
        @log

struct PlotEnv
        logging::Bool
        design::String
        log_path::String
end


include("utils.jl")
include("design.jl")
include("logging.jl")
include("plotter.jl")

end
