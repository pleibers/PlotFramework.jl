function set_design(design::String)
    if design == "default"
        theme(:default)
    elseif design == "master"
        theme(:wong)
    else
        throw("Not implemented yet")
    end
    default(fontfamily="Computer Modern", dpi=300, tickfontsize=10)
end