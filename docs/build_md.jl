using Lexicon, Docile
using jWinReg


myfilter(m::Module; files = [""], categories = [:comment, :module, :function, :method, :type, :typealias, :macro, :global]) = 
  Lexicon.filter(Docile.Interface.metadata(m), files = files, categories = categories)
myfilter(m::Docile.Interface.Metadata; files = [""], categories = [:comment, :module, :function, :method, :type, :typealias, :macro, :global]) = 
  Lexicon.filter(m, files = files, categories = categories)

  #=
# Stuff from Lexicon.jl:
writeobj(any) = string(any)
writeobj(m::Method) = first(split(string(m), "("))
# from base/methodshow.jl
function url(m)
    line, file = m
    try
        d = dirname(file)
        u = Pkg.Git.readchomp(`config remote.origin.url`, dir=d)
        u = match(Pkg.Git.GITHUB_REGEX,u).captures[1]
        root = cd(d) do # dir=d confuses --show-toplevel, apparently
            Pkg.Git.readchomp(`rev-parse --show-toplevel`)
        end
        if beginswith(file, root)
            commit = Pkg.Git.readchomp(`rev-parse HEAD`, dir=d)
            return "https://github.com/$u/tree/$commit/"*file[length(root)+2:end]*"#L$line"
        else
            return Base.fileurl(file)
        end
    catch
        return Base.fileurl(file)
    end
end


function mysave(file::AbstractString, m::Module, order = [:source])
    mysave(file, Docile.Interface.documentation(m), order)
end
function mysave(file::AbstractString, docs::Docile.Interface.Metadata, order = [:source])
    isfile(file) || mkpath(dirname(file))
    open(file, "w") do io
        info("writing documentation to $(file)")
        println(io)
        for (k,v) in EachEntry(docs, order = order)
            name = writeobj(k)
            source = v.data[:source]
            catgory = Docile.Interface.category(v)
            comment = catgory == :comment
            println(io)
            println(io)
            !comment && println(io, "## $name")
            println(io)
            println(io, v.docs.data)
            path = last(split(source[2], r"v[\d\.]+(/|\\)"))
            !comment && println(io, "[$(path):$(source[1])]($(url(source)))")
            println(io)
        end
    end
end
=#


function signature(k::Method, v::Docile.Legacy.Entry)
	n = first(split(string(k), " at "))
	name = first(split(n, "("))
	name = first(split(n, "{"))
	if name == "call"
		t = string(k.sig)
		t = t[7:(end-1)] #delete "Tuple{" and "}"
		t = first(split(t, ","))
		t = t[6:(end-1)] #delete "Type{" and "}"
		comma = search(n, ',')
		
		return t * (comma == 0 ? "()" : "(" * n[comma+2:end]) #delete "call" and 1st argument
	end
	
	return n
end
function signature(k::DataType, v::Docile.Legacy.Entry)
	return first(split(string(k), " at "))
end
function signature(k::Function, v::Docile.Legacy.Entry)
	return string(v.data[:signature])
end
function signature(k::Any, v::Docile.Legacy.Entry)
	return string(k)
end

function mysave(file::AbstractString, m::Module, order = [:source])
    mysave(file, Docile.Interface.documentation(m), order)
end
function mysave(file::AbstractString, docs::Docile.Interface.Metadata, order = [:source])
    isfile(file) || mkpath(dirname(file))
    open(file, "w") do io
        info("writing documentation to $(file)")
        println(io)
		entries = [(k, v) for (k,v) in EachEntry(docs, order = order)]
        for (k, v) in entries
			sign = signature(k, v)
            name = first(split(sign, "("))
            source = v.data[:source]
            catgory = Docile.Interface.category(v)
            comment = catgory == :comment
            println(io)
            println(io)
            !comment && println(io, "## $name")
            println(io)
			println(io, "**$sign**")
            println(io)
            println(io, v.docs.data)
            path = last(split(source[2], r"v[\d\.]+(/|\\)"))
            !comment && println(io)
            !comment && println(io, "at $(path):$(source[1])")
            println(io)
        end
    end
end




outdir = dirname(@__FILE__)

#index
save(joinpath(outdir, "api-index.md"), jWinReg)
