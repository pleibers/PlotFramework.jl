function set_design(themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, kwargs...)
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize, kwargs...)
end

function set_design!(themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, kwargs...)
    PlotEnvironment.design = themesym
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize,kwargs...)
end

function set_design!(plotter::PlotEnv, themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, kwargs...)
    plotter.design = themesym
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize,kwargs...)
end