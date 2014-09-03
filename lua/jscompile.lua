local esprima = require("jscompile.esprima")
local castl = require("jscompile.castl")

local file = io.open("../code.js", "r")
local str = file:read("*all")
file:close()

local ast = esprima:parse(str)
local compiled = castl:compileAST(ast).compiled

file = io.open("compiled.lua", "w")
file:write(compiled)
file:close()
