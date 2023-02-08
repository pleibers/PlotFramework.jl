function set_design(design::String)
    if design == "default"
        theme(:default)
    elseif design == "master"
        theme(:default)
    else
        throw("Not implemented yet")
    end
    default(fontfamily="Palatino", dpi=300, tickfontsize=12)
end

function set_design!(design::String)
    PlotEnvironment.design = design
    if design == "default"
        theme(:default)
    elseif design == "master"
        theme(:default)
    else
        throw("Not implemented yet")
    end
    default(fontfamily="Palatino", dpi=300, tickfontsize=12)
end

function set_design!(plotter::PlotEnv, design::String)
    plotter.design = design
    if design == "default"
        theme(:default)
    elseif design == "master"
        theme(:default)
    else
        throw("Not implemented yet")
    end
    default(fontfamily="Palatino", dpi=300, tickfontsize=12)
end