using JLD2

function log_plot(f::Symbol, args, kwargs; log_path, fig_name="")
    mkpath(dirname(log_path))
    date = get_date()
    arg_path = dirname(log_path)*"/args/$date.jld2"
    mkpath(dirname(arg_path))
    @save arg_path args kwargs
    open(log_path, "a+") do io
        log_entry = "$date,$fig_name,$f,$(args)\n"
        write(io, log_entry)
    end
end
function log_plot(f::Symbol, args, kwargs, FILE::Nothing; log_path, fig_name="")
    log_plot(f,args,kwargs;log_path,fig_name)
end


function log_plot(f::Symbol, args, kwargs, FILE::String; log_path, fig_name="")
    mkpath(dirname(log_path))
    date = get_date()
    arg_path = dirname(log_path) * "/args/$date.jld2"
    mkpath(dirname(arg_path))
    @save arg_path args kwargs FILE
    open(log_path, "a+") do io
        log_entry = "$date,$fig_name,$f,$(args)\n"
        write(io, log_entry)
    end
end

macro log(f)
    log_plot(f, (), (); log_path=PlotEnvironment.log_path)
    return :($(esc(f))())
end

macro log(f, args...)
    aargs = []
    aakws = Pair{Symbol,Any}[]
    FILE = nothing
    for el in args
        if Meta.isexpr(el, :(=))
            kwarg = Pair(el.args...)
            if kwarg.first == :FILE
                FILE = eval(kwarg.second)
            else
                push!(aakws, kwarg)
            end
        else
            push!(aargs, esc(el))
        end
    end
    log_plot(f, aargs, aakws, FILE, log_path=PlotEnvironment.log_path)
    return :($(esc(f))($(aargs...); $aakws...))
end