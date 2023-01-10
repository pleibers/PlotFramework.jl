macro log(f, args, kwargs...)
    x = [esc(a) for a in kwargs]
    y = [esc(a) for a in args]
    log_plot($(f), $(y...); log_path=PlotEnvironment.log_path, fig_name)
    return :($(f)($(y...); $(x...)))
end

function recreate_plot(plotter::PlotEnv,mod::Module;line=0, date="")
    try
        fun, args = read_log(    line, date, fig_name, plotter)
        f = @eval mod $(Symbol(fun)) 
    catch
        fun, args, FILE = read_log(line, date, fig_name, plotter, inFILE=true)
        include(FILE)
        f = @eval $(Symbol(fun))
    end

    if plotter.logging
        log_plot(f, args; log_path=plotter.log_path, fig_name)
    end
    plotter(f, args)
end



    