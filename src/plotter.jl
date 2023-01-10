macro log(f)
    log_plot(f, (), (); log_path=PlotEnvironment.log_path)
    return :($(esc(f))())
end

macro log(f, args...)
    aargs = []
    aakws = Pair{Symbol,Any}[]
    for el in args
        if Meta.isexpr(el, :(=))
            push!(aakws, Pair(el.args...))
        else
            push!(aargs, esc(el))
        end
    end
    log_plot(f, aargs, aakws, log_path=PlotEnvironment.log_path)
    return :($(esc(f))($(aargs...); $aakws...))
end

function (plotter::PlotEnv)(f::Function, args; kwargs=(), fig_name="")
    if plotter.logging
        log_plot(f, args, kwargs; log_path=plotter.log_path, fig_name)
    end
    set_design(plotter.design)
    f(args...)
end

function (plotter::PlotEnv)(f::Function, args, FILE; kwargs=(), fig_name="")
    if plotter.logging
        log_plot(f, args, kwargs, FILE; log_path=plotter.log_path, fig_name)
    end
    set_design(plotter.design)
    f(args...)
end

function recreate_plot(plotter::PlotEnv, mod::Module; line=0, date="", fig_name="")
    try
        fun, args, kwargs = read_log(line, date, fig_name, plotter)
        f = @eval mod $(Symbol(fun))
    catch
        fun, args, kwargs, FILE = read_log(line, date, fig_name, plotter, inFILE=true)
        include(FILE)
        f = @eval $(Symbol(fun))
    end

    if plotter.logging
        log_plot(f, args, kwargs; log_path=plotter.log_path, fig_name)
    end
    plotter(f, args; kwargs)
end