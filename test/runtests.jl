using jWinReg
using Base.Test

#set test values
parentkey = "HKCU\\Julia"
subkey1 = "test1"
subkey2 = "test2"
dwName = "dwTest"
dwValue = convert(Int32, 2205)
strName = "strTest"
strValue = "Hello!"
mstrName = "mstrTest"
mstrValue = ["Some", "Vectorized", "Words"]
defaValue = "def"

info("RegCreateKey - test #1: recursive creation of keys")
res = RegCreateKey(parentkey * "\\" * subkey1)
@test res == 1
res = RegCreateKey(parentkey * "\\" * subkey2)
@test res == 1
res = RegCreateKey(parentkey * "\\" * subkey1)
@test res == 0

info("RegWrite - test #2.1: write values")
res = RegWrite(parentkey, dwName, dwValue)
@test res
res = RegWrite(parentkey, strName, strValue)
@test res
res = RegWrite(parentkey, mstrName, mstrValue)
@test res

info("RegWrite - test #2.2: write default value")
res = RegWrite(parentkey * "\\" * subkey1, "", defaValue)
@test res

info("... dumping values on file ...")
path = joinpath(Pkg.dir("WinReg"), "test", "regdump.reg")
cmd = `cmd /c regedit /e ""$path"" HKEY_CURRENT_USER\\Julia`
#run(cmd)

info("RegWrite - test #3.1: read existent values")
res = RegRead(parentkey, dwName)
@test res == dwValue
res = RegRead(parentkey, strName)
@test res == strValue
res = RegRead(parentkey, mstrName)
@test length(res) == length(mstrValue)
for w in res
	@test (w in mstrValue)
end

info("RegWrite - test #3.2: read default value")
res = RegRead(parentkey * "\\" * subkey1, "")
@test res == defaValue

info("RegWrite - test #3.3: read not-existent value")
res = RegRead(parentkey, "noval")
@test res == nothing

info("RegKeyList - test #4.1: list existent subkeys of existent key")
res = RegKeyList(parentkey)
@test subkey1 in res
@test subkey2 in res

info("RegKeyList - test #4.2: list not-existent subkeys of existent key")
res = RegKeyList(parentkey * "\\" * subkey2)
@test length(res) == 0

info("RegKeyList - test #4.3: list subkeys of not-existent key")
res = RegKeyList(parentkey * "\\nokey")
@test res == nothing

info("RegValueList - test #5.1: list existent values of existent key")
res = RegValueList(parentkey)
@test length(res) == 3
@test (dwName, UInt32) in res
@test (strName, AbstractString) in res
@test (mstrName, Vector{AbstractString}) in res

info("RegValueList - test #5.2: list default value of existent key")
res = RegValueList(parentkey * "\\" * subkey1)
@test ("", AbstractString) in res

info("RegValueList - test #5.3: list not-existent values of existent key")
res = RegValueList(parentkey * "\\" * subkey2)
@test length(res) == 0

info("RegValueList - test #5.4: list values of not-existent key")
res = RegValueList(parentkey * "\\nokey")
@test res == nothing

info("RegDelete - test #6.1: delete key")
res = RegDelete(parentkey * "\\" * subkey2)
@test res

info("RegDelete - test #6.2: delete not-existent value")
res = RegDelete(parentkey * "\\" * subkey1, dwName)
@test !res

info("RegDelete - test #6.3: delete value")
res = RegDelete(parentkey, dwName)
@test res

info("RegDelete - test #6.4: delete default value")
res = RegDelete(parentkey * "\\" * subkey1, "")
@test res

info("RegDelete - test #6.5: delete keys recursively (error)")
res = RegDelete(parentkey)
@test !res

info("RegDelete - test #6.6: delete test subkey")
res = RegDelete(parentkey * "\\" * subkey1)
@test res

info("RegDelete - test #6.7: delete test key with subvalues")
res = RegDelete(parentkey)
@test res
