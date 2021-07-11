local esprima = require("castl.jscompile.esprima_jit")
local castl = require("castl.jscompile.castl_jit")

local file = io.open(arg[1], "r")
local str = file:read("*all")
file:close()

local ast = esprima:parse(str)
local compiled = castl:compileAST(ast).compiled

file = io.open("compiled.lua", "w")
file:write(compiled)
file:close()
