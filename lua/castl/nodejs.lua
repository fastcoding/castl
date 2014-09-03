--[[
    Copyright (c) 2014, Paul Bernier
    
    CASTL is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    CASTL is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public License
    along with CASTL. If not, see <http://www.gnu.org/licenses/>.
--]]

-- [[ CASTL NodeJS basic support submodule]] --

local nodejs = {}

local coreObject = require("castl.core_objects")
local require = require

_ENV = nil

nodejs.module = coreObject.obj({exports = coreObject.obj({})})
nodejs.exports = nodejs.module.exports

nodejs.require = function(this, packagename)
    return require(packagename)
end

return nodejs
