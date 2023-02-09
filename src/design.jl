function set_design(themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, plot=())
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize, plot...)
end

function set_design!(themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, plot=())
    PlotEnvironment.design = themesym
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize,plot...)
end

function set_design!(plotter::PlotEnv, themesym::Symbol; font="Palatino", dpi=300, tickfontsize=12, plot=())
    plotter.design = themesym
    theme(themesym)
    default(fontfamily=font, dpi=dpi, tickfontsize=tickfontsize,plot...)
end