# WinReg

## Exported

---

<a id="method__regcreatekey.1" class="lexicon_definition"></a>
#### RegCreateKey(key::AbstractString) [¶](#method__regcreatekey.1)
Recursively create specified key. 
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
Return 0 if key is existent, 1 if successful, -1 otherwise

*source:*
[WinReg\src\regfunc.jl:190](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regdelete.1" class="lexicon_definition"></a>
#### RegDelete(key::AbstractString) [¶](#method__regdelete.1)
Delete specified `key`. 
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
`view64` specifies if key is 64 or 32 bit view (default); see https://msdn.microsoft.com/en-us/library/aa384129.aspx  
If operation has success is returned `true`, `false` otherwise

*source:*
[WinReg\src\regfunc.jl:80](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regdelete.2" class="lexicon_definition"></a>
#### RegDelete(key::AbstractString,  valuename::AbstractString) [¶](#method__regdelete.2)
Delete specified `valuename` under specified `key`.  
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
If operation has success is returned `true`, `false` otherwise

*source:*
[WinReg\src\regfunc.jl:106](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regdelete.3" class="lexicon_definition"></a>
#### RegDelete(key::AbstractString,  view64::Bool) [¶](#method__regdelete.3)
Delete specified `key`. 
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
`view64` specifies if key is 64 or 32 bit view (default); see https://msdn.microsoft.com/en-us/library/aa384129.aspx  
If operation has success is returned `true`, `false` otherwise

*source:*
[WinReg\src\regfunc.jl:80](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regkeylist.1" class="lexicon_definition"></a>
#### RegKeyList(key::AbstractString) [¶](#method__regkeylist.1)
Return all sukbeys of specified `key` as string array. 
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
If operation fails is returned `nothing` (type is `Void`)

*source:*
[WinReg\src\regfunc.jl:243](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regread.1" class="lexicon_definition"></a>
#### RegRead(key::AbstractString,  valuename::AbstractString) [¶](#method__regread.1)
Read a value with `valuename` into `key`. 
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').
Return type in Julia is based onto value type stored in registry; returns `nothing` (type is `Void`) if key not found

*source:*
[WinReg\src\regfunc.jl:18](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regvaluelist.1" class="lexicon_definition"></a>
#### RegValueList(key::AbstractString) [¶](#method__regvaluelist.1)
Return all value names of specified `key` as tuple array (name, Julia-type).  
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
If operation fails is returned `nothing` (type is `Void`)

*source:*
[WinReg\src\regfunc.jl:294](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

---

<a id="method__regwrite.1" class="lexicon_definition"></a>
#### RegWrite(key::AbstractString,  valuename::AbstractString,  value) [¶](#method__regwrite.1)
Write `value` to `valuename` under specified `key`.  
`key` can be specified using abbreviated form (e.g. 'HKEY_LOCAL_MACHINE' -> 'HKLM').  
Return `true` if successful, `false` otherwise

*source:*
[WinReg\src\regfunc.jl:132](file://C:\Users\Leonardo\.julia\v0.4\WinReg\src\regfunc.jl)

