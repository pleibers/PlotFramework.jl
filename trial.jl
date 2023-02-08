using Plots 
using PlotFramework

plotter = setPlotEnv(logging=true, design=:wong)

func(x,y) = plot(rand(10))
func() = plot(rand(15))

# set_design("default")
@log func FILE=@__FILE__
# recreate_plot(plotter,@__MODULE__, line=3)