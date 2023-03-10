using JLD2

function setPlotEnv(; logging=false, design="default", log_path=ENV["HOME"] * "/julia/log/plot.txt")
    global PlotEnvironment = PlotEnv(logging, design, log_path)
    set_design(design)
    return PlotEnvironment
end

get_date() = Dates.format(now(), "yyyy-mm-dd HH:MM")

function read_log(line, date, fig_name, plotter::PlotEnv; inFILE = false)
    log = readlines(plotter.log_path)
    log_entry = ""
    if line != 0
        log_entry = log[line]
    elseif !isempty(date)
        for log_ in log
            if date == log_["date"]
                log_entry = log_
            end
        end
    elseif !isempty(fig_name)
        for log_ in log
            if fig_name == log_entry["fig_name"]
                log_entry = log_
            end
        end
    else
        throw("No valid input")
    end
    vals = split(log_entry, ",")
    date = vals[1]
    args_path = dirname(plotter.log_path) * "/args/$date.jld2"
    fun = vals[3]
    if inFILE
        @load args_path args kwargs FILE
        return fun, args, kwargs, FILE
    else
        @load args_path args kwargs
        return fun, args, kwargs
    end
end