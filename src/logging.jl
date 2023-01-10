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

function log_plot(f::Symbol, args, kwargs, FILE; log_path, fig_name="")
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