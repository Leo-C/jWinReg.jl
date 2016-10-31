### documentation build script
debug = false
JDK_HOME = "E:\\Compilatori\\Java64.180u25"
PYTHON_HOME = "E:\\Compilatori\\Python2710_64"

### step 1: create .md file from documentation mixed into source files (with Lexicon)
# set path to JDK home into JAVA_HOME environment variable
if !("JAVA_HOME" in keys(ENV))
	ENV["JAVA_HOME"] = JDK_HOME
end
pdir = Pkg.dir()
include(pdir * "/WinReg/docs/build_md.jl")


### step 2: create static html site from .md files (with MkDocs)
# get path to PYTHON 2.7.x home
if "PYTHON_HOME" in keys(ENV)
	pyhome = ENV["PYTHON_HOME"]
else
	pyhome = PYTHON_HOME
end
pdir = Pkg.dir()
mkdocs = PYTHON_HOME * "/Scripts/mkdocs"
cd(pdir * "/WinReg")

if debug
	#serve documentation with local web server
	run(`$mkdocs serve`)
else
	#generate documentation
	run(`$mkdocs build --clean`)
end
