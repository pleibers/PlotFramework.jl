using JLD2

function setPlotEnv(; logging=false, design=:default, log_path=ENV["HOME"] * "/julia/log/plot.txt")
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

function clear_log(;path="")
    if isempty(path)
        home = ENV["HOME"]
        try
            rm(home*"julia/log/",recursive=true)
        catch
            println("Log not found")
        end
    else
        rm(path,recursive=true)
    end
end
        
function set_size_in_points(;width_pts = 469.0, height=0,dpi=300)
    inches_per_pt = 1.0 / 72.27
    width_inches = width_pts * inches_per_points
    width_px = width_inches * dpi

    height_px = 0
    if height != 0
        height_inches = height * inches_per_points
        height_px = height_inches * dpi
    else
        # Golden ratio to set aesthetic figure height
        golden_ratio = (sqrt(5) - 1.0) / 2.0
        # Height in inches
        height_inches = width*golden_ratio * inches_per_pt
        # Set the size!
        height_px = height_inches * dpi
    end
    default(size=(width_px, height_px))
end