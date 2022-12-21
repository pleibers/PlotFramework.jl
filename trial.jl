using Plots 
using PlotFramework

plotter = PlotEnv(logging=true, design="master")

func(x,y) = plot(rand(10))
func() = plot(rand(15))
# plotter(func,(),fig_name="test")

# recreate_plot(plotter,@__MODULE__, line=3)