#-----------------------------------------------------------
#-----------------------------------------------------------
# Define function to access windows registry
#
#File: jWinReg.jl
#Author: Leonardo Cocco
#Creation Date: 11-04-2016
#Last update 30-10-2016
#ver: 0.11
#----------------------------------------------------------
#----------------------------------------------------------


module jWinReg

if is_windows()
	include("wintypes.jl")
	include("commons.jl")

	include("regfunc.jl")
	export RegRead,
		   RegWrite,
		   RegCreateKey,
		   RegDelete,
		   RegKeyList,
		   RegValueList
end #windows_only

end # module
