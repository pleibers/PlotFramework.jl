using Plots 
using PlotFramework

plotter = setPlotEnv(logging=true, design="master")

func(x,y) = plot(rand(10))
func() = plot(rand(15))

# set_design("default")
@log func

# recreate_plot(plotter,@__MODULE__, line=3)