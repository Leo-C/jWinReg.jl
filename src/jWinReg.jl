#-----------------------------------------------------------
#-----------------------------------------------------------
# Define function to access windows registry
#
#File: jWinReg.jl
#Author: Leonardo Cocco
#Creation Date: 11-04-2016
#Last update 21-11-2016
#ver: 0.12
#----------------------------------------------------------
#----------------------------------------------------------


module jWinReg

if is_windows()
	include("wintypes.jl")
	include("commons.jl")

	include("regfunc.jl")
	export regread,
		   regwrite,
		   regcreatekey,
		   regdelete,
		   regkeylist,
		   regvaluelist
end #windows_only

end # module
