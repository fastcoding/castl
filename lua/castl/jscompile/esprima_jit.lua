_nodejs = true;
local _ENV = require("castl.runtime");
return setfenv(function(...)
local module = _obj({exports = _obj({})});
local exports = module.exports;
(function(this,root,factory)
if _bool(((function() local _lev=(_type(define) == "function"); if _bool(_lev) then return define.amd; else return _lev; end end)())) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif (_type(exports) ~= "undefined") then
factory(_ENV,exports);
else
factory(_ENV,(function() root.esprima = _obj({}); return root.esprima end)());
end

end)(_ENV,this,(function(this,exports)
local _local2 = {};
assert =((function(this,condition,message)
if not _bool(condition) then
_throw(_new(Error,(_addStr1("ASSERT: ",message))),0)
end

end));
isDecimalDigit =((function(this,ch)
do return ((function() local _lev=(_ge(ch,48)); if _bool(_lev) then return (_le(ch,57)); else return _lev; end end)()); end
end));
isHexDigit =((function(this,ch)
do return (_ge(("0123456789abcdefABCDEF"):indexOf(ch),0)); end
end));
isOctalDigit =((function(this,ch)
do return (_ge(("01234567"):indexOf(ch),0)); end
end));
octalToDecimal =((function(this,ch)
local _local3 = {};
_local3.octal = (ch ~= "0");
_local3.code = ("01234567"):indexOf(ch);
if _bool(((function() local _lev=(_lt(_local2.index,_local2.length)); if _bool(_lev) then return isOctalDigit(_ENV,_local2.source[_local2.index]); else return _lev; end end)())) then
_local3.octal = true;
_local3.code = (_addNum1((_local3.code * 8),("01234567"):indexOf(_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()])));
if _bool(((function() local _lev=((function() local _lev=(_ge(("0123"):indexOf(ch),0)); if _bool(_lev) then return (_lt(_local2.index,_local2.length)); else return _lev; end end)()); if _bool(_lev) then return isOctalDigit(_ENV,_local2.source[_local2.index]); else return _lev; end end)())) then
_local3.code = (_addNum1((_local3.code * 8),("01234567"):indexOf(_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()])));
end

end

do return _obj({
["code"] = _local3.code,
["octal"] = _local3.octal
}); end
end));
isWhiteSpace =((function(this,ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 32); return _bool(_lev) and _lev or (ch == 9) end)()); return _bool(_lev) and _lev or (ch == 11) end)()); return _bool(_lev) and _lev or (ch == 12) end)()); return _bool(_lev) and _lev or (ch == 160) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,5760)); if _bool(_lev) then return (_ge(_arr({[0]=5760,6158,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8239,8287,12288,65279},17):indexOf(ch),0)); else return _lev; end end)()) end)()); end
end));
isLineTerminator =((function(this,ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(ch == 10); return _bool(_lev) and _lev or (ch == 13) end)()); return _bool(_lev) and _lev or (ch == 8232) end)()); return _bool(_lev) and _lev or (ch == 8233) end)()); end
end));
fromCodePoint =((function(this,cp)
do return (function() if (_lt(cp,65536)) then return String:fromCharCode(cp); else return (_add(String:fromCharCode((55296 + (_arshift((cp - 65536),10)))),String:fromCharCode((56320 + (_band((cp - 65536),1023)))))); end end)(); end
end));
isIdentifierStart =((function(this,ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 36); return _bool(_lev) and _lev or (ch == 95) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,65)); if _bool(_lev) then return (_le(ch,90)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,97)); if _bool(_lev) then return (_le(ch,122)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or (ch == 92) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,128)); if _bool(_lev) then return _local2.Regex.NonAsciiIdentifierStart:test(fromCodePoint(_ENV,ch)); else return _lev; end end)()) end)()); end
end));
isIdentifierPart =((function(this,ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 36); return _bool(_lev) and _lev or (ch == 95) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,65)); if _bool(_lev) then return (_le(ch,90)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,97)); if _bool(_lev) then return (_le(ch,122)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,48)); if _bool(_lev) then return (_le(ch,57)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or (ch == 92) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,128)); if _bool(_lev) then return _local2.Regex.NonAsciiIdentifierPart:test(fromCodePoint(_ENV,ch)); else return _lev; end end)()) end)()); end
end));
isFutureReservedWord =((function(this,id)
repeat
local _into = false;
local _cases = {["enum"] = true,["export"] = true,["import"] = true,["super"] = true};
local _v = id;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "enum") then

_into = true;
end
if _into or (_v == "export") then

_into = true;
end
if _into or (_v == "import") then

_into = true;
end
if _into or (_v == "super") then
do return true; end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end));
isStrictModeReservedWord =((function(this,id)
repeat
local _into = false;
local _cases = {["implements"] = true,["interface"] = true,["package"] = true,["private"] = true,["protected"] = true,["public"] = true,["static"] = true,["yield"] = true,["let"] = true};
local _v = id;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "implements") then

_into = true;
end
if _into or (_v == "interface") then

_into = true;
end
if _into or (_v == "package") then

_into = true;
end
if _into or (_v == "private") then

_into = true;
end
if _into or (_v == "protected") then

_into = true;
end
if _into or (_v == "public") then

_into = true;
end
if _into or (_v == "static") then

_into = true;
end
if _into or (_v == "yield") then

_into = true;
end
if _into or (_v == "let") then
do return true; end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end));
isRestrictedWord =((function(this,id)
do return ((function() local _lev=(id == "eval"); return _bool(_lev) and _lev or (id == "arguments") end)()); end
end));
isKeyword =((function(this,id)
repeat
local _into = false;
local _cases = {[2] = true,[3] = true,[4] = true,[5] = true,[6] = true,[7] = true,[8] = true,[10] = true};
local _v = id.length;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == 2) then
do return ((function() local _lev=((function() local _lev=(id == "if"); return _bool(_lev) and _lev or (id == "in") end)()); return _bool(_lev) and _lev or (id == "do") end)()); end
_into = true;
end
if _into or (_v == 3) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "var"); return _bool(_lev) and _lev or (id == "for") end)()); return _bool(_lev) and _lev or (id == "new") end)()); return _bool(_lev) and _lev or (id == "try") end)()); return _bool(_lev) and _lev or (id == "let") end)()); end
_into = true;
end
if _into or (_v == 4) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "this"); return _bool(_lev) and _lev or (id == "else") end)()); return _bool(_lev) and _lev or (id == "case") end)()); return _bool(_lev) and _lev or (id == "void") end)()); return _bool(_lev) and _lev or (id == "with") end)()); return _bool(_lev) and _lev or (id == "enum") end)()); end
_into = true;
end
if _into or (_v == 5) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "while"); return _bool(_lev) and _lev or (id == "break") end)()); return _bool(_lev) and _lev or (id == "catch") end)()); return _bool(_lev) and _lev or (id == "throw") end)()); return _bool(_lev) and _lev or (id == "const") end)()); return _bool(_lev) and _lev or (id == "yield") end)()); return _bool(_lev) and _lev or (id == "class") end)()); return _bool(_lev) and _lev or (id == "super") end)()); end
_into = true;
end
if _into or (_v == 6) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "return"); return _bool(_lev) and _lev or (id == "typeof") end)()); return _bool(_lev) and _lev or (id == "delete") end)()); return _bool(_lev) and _lev or (id == "switch") end)()); return _bool(_lev) and _lev or (id == "export") end)()); return _bool(_lev) and _lev or (id == "import") end)()); end
_into = true;
end
if _into or (_v == 7) then
do return ((function() local _lev=((function() local _lev=(id == "default"); return _bool(_lev) and _lev or (id == "finally") end)()); return _bool(_lev) and _lev or (id == "extends") end)()); end
_into = true;
end
if _into or (_v == 8) then
do return ((function() local _lev=((function() local _lev=(id == "function"); return _bool(_lev) and _lev or (id == "continue") end)()); return _bool(_lev) and _lev or (id == "debugger") end)()); end
_into = true;
end
if _into or (_v == 10) then
do return (id == "instanceof"); end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end));
addComment =((function(this,type,value,start,_g_end,loc)
local _local3 = {};
assert(_ENV,(_type(start) == "number"),"Comment must have valid position");
_local2.state.lastCommentStart = start;
_local3.comment = _obj({
["type"] = type,
["value"] = value
});
if _bool(_local2.extra.range) then
_local3.comment.range = _arr({[0]=start,_g_end},2);
end

if _bool(_local2.extra.loc) then
_local3.comment.loc = loc;
end

_local2.extra.comments:push(_local3.comment);
if _bool(_local2.extra.attachComment) then
_local2.extra.leadingComments:push(_local3.comment);
_local2.extra.trailingComments:push(_local3.comment);
end

if _bool(_local2.extra.tokenize) then
_local3.comment.type = (_addStr2(_local3.comment.type,"Comment"));
if _bool(_local2.extra.delegate) then
_local3.comment = _local2.extra:delegate(_local3.comment);
end

_local2.extra.tokens:push(_local3.comment);
end

end));
skipSingleLineComment =((function(this,offset)
local _local3 = {};
_local3.start = (_local2.index - offset);
_local3.loc = _obj({
["start"] = _obj({
["line"] = _local2.lineNumber,
["column"] = ((_local2.index - _local2.lineStart) - offset)
})
});
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source:charCodeAt(_local2.index);
_local2.index = _inc(_local2.index);
if _bool(isLineTerminator(_ENV,_local3.ch)) then
_local2.hasLineTerminator = true;
if _bool(_local2.extra.comments) then
_local3.comment = _local2.source:slice((_add(_local3.start,offset)),(_local2.index - 1));
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = ((_local2.index - _local2.lineStart) - 1)
});
addComment(_ENV,"Line",_local3.comment,_local3.start,(_local2.index - 1),_local3.loc);
end

if ((function() local _lev=(_local3.ch == 13); if _bool(_lev) then return (_local2.source:charCodeAt(_local2.index) == 10); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.lineNumber = _inc(_local2.lineNumber);
_local2.lineStart = _local2.index;
do return end
end

::_continue::
end

if _bool(_local2.extra.comments) then
_local3.comment = _local2.source:slice((_add(_local3.start,offset)),_local2.index);
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
});
addComment(_ENV,"Line",_local3.comment,_local3.start,_local2.index,_local3.loc);
end

end));
skipMultiLineComment =((function(this)
local _local3 = {};
if _bool(_local2.extra.comments) then
_local3.start = (_local2.index - 2);
_local3.loc = _obj({
["start"] = _obj({
["line"] = _local2.lineNumber,
["column"] = ((_local2.index - _local2.lineStart) - 2)
})
});
end

while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source:charCodeAt(_local2.index);
if _bool(isLineTerminator(_ENV,_local3.ch)) then
if ((function() local _lev=(_local3.ch == 13); if _bool(_lev) then return (_local2.source:charCodeAt((_addNum2(_local2.index,1))) == 10); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.hasLineTerminator = true;
_local2.lineNumber = _inc(_local2.lineNumber);
_local2.index = _inc(_local2.index);
_local2.lineStart = _local2.index;
elseif (_local3.ch == 42) then
if (_local2.source:charCodeAt((_addNum2(_local2.index,1))) == 47) then
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
if _bool(_local2.extra.comments) then
_local3.comment = _local2.source:slice((_addNum2(_local3.start,2)),(_local2.index - 2));
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
});
addComment(_ENV,"Block",_local3.comment,_local3.start,_local2.index,_local3.loc);
end

do return end
end

_local2.index = _inc(_local2.index);
else
_local2.index = _inc(_local2.index);
end

::_continue::
end

if _bool(_local2.extra.comments) then
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
});
_local3.comment = _local2.source:slice((_addNum2(_local3.start,2)),_local2.index);
addComment(_ENV,"Block",_local3.comment,_local3.start,_local2.index,_local3.loc);
end

tolerateUnexpectedToken(_ENV);
end));
skipComment =((function(this)
local _local3 = {};
_local2.hasLineTerminator = false;
_local3.start = (_local2.index == 0);
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source:charCodeAt(_local2.index);
if _bool(isWhiteSpace(_ENV,_local3.ch)) then
_local2.index = _inc(_local2.index);
elseif _bool(isLineTerminator(_ENV,_local3.ch)) then
_local2.hasLineTerminator = true;
_local2.index = _inc(_local2.index);
if ((function() local _lev=(_local3.ch == 13); if _bool(_lev) then return (_local2.source:charCodeAt(_local2.index) == 10); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.lineNumber = _inc(_local2.lineNumber);
_local2.lineStart = _local2.index;
_local3.start = true;
elseif (_local3.ch == 47) then
_local3.ch = _local2.source:charCodeAt((_addNum2(_local2.index,1)));
if (_local3.ch == 47) then
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
skipSingleLineComment(_ENV,2);
_local3.start = true;
elseif (_local3.ch == 42) then
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
skipMultiLineComment(_ENV);
else
do break end;
end

elseif _bool(((function() if _bool(_local3.start) then return (_local3.ch == 45); else return _local3.start; end end)())) then
if ((function() local _lev=(_local2.source:charCodeAt((_addNum2(_local2.index,1))) == 45); if _bool(_lev) then return (_local2.source:charCodeAt((_addNum2(_local2.index,2))) == 62); else return _lev; end end)()) then
_local2.index = (_addNum2(_local2.index,3));
skipSingleLineComment(_ENV,3);
else
do break end;
end

elseif (_local3.ch == 60) then
if (_local2.source:slice((_addNum2(_local2.index,1)),(_addNum2(_local2.index,4))) == "!--") then
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
_local2.index = _inc(_local2.index);
skipSingleLineComment(_ENV,4);
else
do break end;
end

else
do break end;
end

::_continue::
end

end));
scanHexEscape =((function(this,prefix)
local _local3 = {};
_local3.code = 0;
_local3.len = (function() if (prefix == "u") then return 4; else return 2; end end)();
_local3.i = 0;
while (_lt(_local3.i,_local3.len)) do
if _bool(((function() local _lev=(_lt(_local2.index,_local2.length)); if _bool(_lev) then return isHexDigit(_ENV,_local2.source[_local2.index]); else return _lev; end end)())) then
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
_local3.code = (_addNum1((_local3.code * 16),("0123456789abcdef"):indexOf(_local3.ch:toLowerCase())));
else
do return ""; end
end

_local3.i = _inc(_local3.i);
end

do return String:fromCharCode(_local3.code); end
end));
scanUnicodeCodePointEscape =((function(this)
local _local3 = {};
_local3.ch = _local2.source[_local2.index];
_local3.code = 0;
if (_local3.ch == "}") then
throwUnexpectedToken(_ENV);
end

while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if not _bool(isHexDigit(_ENV,_local3.ch)) then
do break end;
end

_local3.code = (_addNum1((_local3.code * 16),("0123456789abcdef"):indexOf(_local3.ch:toLowerCase())));
::_continue::
end

if ((function() local _lev=(_gt(_local3.code,1114111)); return _bool(_lev) and _lev or (_local3.ch ~= "}") end)()) then
throwUnexpectedToken(_ENV);
end

do return fromCodePoint(_ENV,_local3.code); end
end));
codePointAt =((function(this,i)
local _local3 = {};
_local3.cp = _local2.source:charCodeAt(i);
if ((function() local _lev=(_ge(_local3.cp,55296)); if _bool(_lev) then return (_le(_local3.cp,56319)); else return _lev; end end)()) then
_local3.second = _local2.source:charCodeAt((_addNum2(i,1)));
if ((function() local _lev=(_ge(_local3.second,56320)); if _bool(_lev) then return (_le(_local3.second,57343)); else return _lev; end end)()) then
_local3.first = _local3.cp;
_local3.cp = (((_addNum1(((_local3.first - 55296) * 1024),_local3.second)) - 56320) + 65536);
end

end

do return _local3.cp; end
end));
getComplexIdentifier =((function(this)
local _local3 = {};
_local3.cp = codePointAt(_ENV,_local2.index);
_local3.id = fromCodePoint(_ENV,_local3.cp);
_local2.index = (_add(_local2.index,_local3.id.length));
if (_local3.cp == 92) then
if (_local2.source:charCodeAt(_local2.index) ~= 117) then
throwUnexpectedToken(_ENV);
end

_local2.index = _inc(_local2.index);
if (_local2.source[_local2.index] == "{") then
_local2.index = _inc(_local2.index);
_local3.ch = scanUnicodeCodePointEscape(_ENV);
else
_local3.ch = scanHexEscape(_ENV,"u");
_local3.cp = _local3.ch:charCodeAt(0);
if ((function() local _lev=((function() local _lev=not _bool(_local3.ch); return _bool(_lev) and _lev or (_local3.ch == "\\") end)()); return _bool(_lev) and _lev or not _bool(isIdentifierStart(_ENV,_local3.cp)) end)()) then
throwUnexpectedToken(_ENV);
end

end

_local3.id = _local3.ch;
end

while (_lt(_local2.index,_local2.length)) do
_local3.cp = codePointAt(_ENV,_local2.index);
if not _bool(isIdentifierPart(_ENV,_local3.cp)) then
do break end;
end

_local3.ch = fromCodePoint(_ENV,_local3.cp);
_local3.id = (_add(_local3.id,_local3.ch));
_local2.index = (_add(_local2.index,_local3.ch.length));
if (_local3.cp == 92) then
_local3.id = _local3.id:substr(0,(_local3.id.length - 1));
if (_local2.source:charCodeAt(_local2.index) ~= 117) then
throwUnexpectedToken(_ENV);
end

_local2.index = _inc(_local2.index);
if (_local2.source[_local2.index] == "{") then
_local2.index = _inc(_local2.index);
_local3.ch = scanUnicodeCodePointEscape(_ENV);
else
_local3.ch = scanHexEscape(_ENV,"u");
_local3.cp = _local3.ch:charCodeAt(0);
if ((function() local _lev=((function() local _lev=not _bool(_local3.ch); return _bool(_lev) and _lev or (_local3.ch == "\\") end)()); return _bool(_lev) and _lev or not _bool(isIdentifierPart(_ENV,_local3.cp)) end)()) then
throwUnexpectedToken(_ENV);
end

end

_local3.id = (_add(_local3.id,_local3.ch));
end

::_continue::
end

do return _local3.id; end
end));
getIdentifier =((function(this)
local _local3 = {};
_local3.start = (function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)();
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source:charCodeAt(_local2.index);
if (_local3.ch == 92) then
_local2.index = _local3.start;
do return getComplexIdentifier(_ENV); end
elseif ((function() local _lev=(_ge(_local3.ch,55296)); if _bool(_lev) then return (_lt(_local3.ch,57343)); else return _lev; end end)()) then
_local2.index = _local3.start;
do return getComplexIdentifier(_ENV); end
end

if _bool(isIdentifierPart(_ENV,_local3.ch)) then
_local2.index = _inc(_local2.index);
else
do break end;
end

::_continue::
end

do return _local2.source:slice(_local3.start,_local2.index); end
end));
scanIdentifier =((function(this)
local _local3 = {};
_local3.start = _local2.index;
_local3.id = (function() if (_local2.source:charCodeAt(_local2.index) == 92) then return getComplexIdentifier(_ENV); else return getIdentifier(_ENV); end end)();
if (_local3.id.length == 1) then
_local3.type = _local2.Token.Identifier;
elseif _bool(isKeyword(_ENV,_local3.id)) then
_local3.type = _local2.Token.Keyword;
elseif (_local3.id == "null") then
_local3.type = _local2.Token.NullLiteral;
elseif ((function() local _lev=(_local3.id == "true"); return _bool(_lev) and _lev or (_local3.id == "false") end)()) then
_local3.type = _local2.Token.BooleanLiteral;
else
_local3.type = _local2.Token.Identifier;
end

do return _obj({
["type"] = _local3.type,
["value"] = _local3.id,
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local3.start,
["end"] = _local2.index
}); end
end));
scanPunctuator =((function(this)
local _local3 = {};
_local3.token = _obj({
["type"] = _local2.Token.Punctuator,
["value"] = "",
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local2.index,
["end"] = _local2.index
});
_local3.str = _local2.source[_local2.index];
repeat
local _into = false;
local _cases = {["("] = true,["{"] = true,["."] = true,["}"] = true,[")"] = true,[";"] = true,[","] = true,["["] = true,["]"] = true,[":"] = true,["?"] = true,["~"] = true};
local _v = _local3.str;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "(") then
if _bool(_local2.extra.tokenize) then
_local2.extra.openParenToken = _local2.extra.tokenValues.length;
end

_local2.index = _inc(_local2.index);
do break end;
_into = true;
end
if _into or (_v == "{") then
if _bool(_local2.extra.tokenize) then
_local2.extra.openCurlyToken = _local2.extra.tokenValues.length;
end

_local2.state.curlyStack:push("{");
_local2.index = _inc(_local2.index);
do break end;
_into = true;
end
if _into or (_v == ".") then
_local2.index = _inc(_local2.index);
if ((function() local _lev=(_local2.source[_local2.index] == "."); if _bool(_lev) then return (_local2.source[(_addNum2(_local2.index,1))] == "."); else return _lev; end end)()) then
_local2.index = (_addNum2(_local2.index,2));
_local3.str = "...";
end

do break end;
_into = true;
end
if _into or (_v == "}") then
_local2.index = _inc(_local2.index);
_local2.state.curlyStack:pop();
do break end;
_into = true;
end
if _into or (_v == ")") then

_into = true;
end
if _into or (_v == ";") then

_into = true;
end
if _into or (_v == ",") then

_into = true;
end
if _into or (_v == "[") then

_into = true;
end
if _into or (_v == "]") then

_into = true;
end
if _into or (_v == ":") then

_into = true;
end
if _into or (_v == "?") then

_into = true;
end
if _into or (_v == "~") then
_local2.index = _inc(_local2.index);
do break end;
_into = true;
end
::_default::
if _into then
_local3.str = _local2.source:substr(_local2.index,4);
if (_local3.str == ">>>=") then
_local2.index = (_addNum2(_local2.index,4));
else
_local3.str = _local3.str:substr(0,3);
if ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(_local3.str == "==="); return _bool(_lev) and _lev or (_local3.str == "!==") end)()); return _bool(_lev) and _lev or (_local3.str == ">>>") end)()); return _bool(_lev) and _lev or (_local3.str == "<<=") end)()); return _bool(_lev) and _lev or (_local3.str == ">>=") end)()) then
_local2.index = (_addNum2(_local2.index,3));
else
_local3.str = _local3.str:substr(0,2);
if ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(_local3.str == "&&"); return _bool(_lev) and _lev or (_local3.str == "||") end)()); return _bool(_lev) and _lev or (_local3.str == "==") end)()); return _bool(_lev) and _lev or (_local3.str == "!=") end)()); return _bool(_lev) and _lev or (_local3.str == "+=") end)()); return _bool(_lev) and _lev or (_local3.str == "-=") end)()); return _bool(_lev) and _lev or (_local3.str == "*=") end)()); return _bool(_lev) and _lev or (_local3.str == "/=") end)()); return _bool(_lev) and _lev or (_local3.str == "++") end)()); return _bool(_lev) and _lev or (_local3.str == "--") end)()); return _bool(_lev) and _lev or (_local3.str == "<<") end)()); return _bool(_lev) and _lev or (_local3.str == ">>") end)()); return _bool(_lev) and _lev or (_local3.str == "&=") end)()); return _bool(_lev) and _lev or (_local3.str == "|=") end)()); return _bool(_lev) and _lev or (_local3.str == "^=") end)()); return _bool(_lev) and _lev or (_local3.str == "%=") end)()); return _bool(_lev) and _lev or (_local3.str == "<=") end)()); return _bool(_lev) and _lev or (_local3.str == ">=") end)()); return _bool(_lev) and _lev or (_local3.str == "=>") end)()) then
_local2.index = (_addNum2(_local2.index,2));
else
_local3.str = _local2.source[_local2.index];
if (_ge(("<>=!+-*%&|^/"):indexOf(_local3.str),0)) then
_local2.index = _inc(_local2.index);
end

end

end

end

_into = true;
end
until true
if (_local2.index == _local3.token.start) then
throwUnexpectedToken(_ENV);
end

_local3.token["end"] = _local2.index;
_local3.token.value = _local3.str;
do return _local3.token; end
end));
scanHexLiteral =((function(this,start)
local _local3 = {};
_local3.number = "";
while (_lt(_local2.index,_local2.length)) do
if not _bool(isHexDigit(_ENV,_local2.source[_local2.index])) then
do break end;
end

_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if (_local3.number.length == 0) then
throwUnexpectedToken(_ENV);
end

if _bool(isIdentifierStart(_ENV,_local2.source:charCodeAt(_local2.index))) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = _local2.Token.NumericLiteral,
["value"] = parseInt(_ENV,(_addStr1("0x",_local3.number)),16),
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = start,
["end"] = _local2.index
}); end
end));
scanBinaryLiteral =((function(this,start)
local _local3 = {};
_local3.number = "";
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[_local2.index];
if ((function() local _lev=(_local3.ch ~= "0"); if _bool(_lev) then return (_local3.ch ~= "1"); else return _lev; end end)()) then
do break end;
end

_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if (_local3.number.length == 0) then
throwUnexpectedToken(_ENV);
end

if (_lt(_local2.index,_local2.length)) then
_local3.ch = _local2.source:charCodeAt(_local2.index);
if _bool(((function() local _lev=isIdentifierStart(_ENV,_local3.ch); return _bool(_lev) and _lev or isDecimalDigit(_ENV,_local3.ch) end)())) then
throwUnexpectedToken(_ENV);
end

end

do return _obj({
["type"] = _local2.Token.NumericLiteral,
["value"] = parseInt(_ENV,_local3.number,2),
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = start,
["end"] = _local2.index
}); end
end));
scanOctalLiteral =((function(this,prefix,start)
local _local3 = {};
if _bool(isOctalDigit(_ENV,prefix)) then
_local3.octal = true;
_local3.number = (_addStr1("0",_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
else
_local3.octal = false;
_local2.index = _inc(_local2.index);
_local3.number = "";
end

while (_lt(_local2.index,_local2.length)) do
if not _bool(isOctalDigit(_ENV,_local2.source[_local2.index])) then
do break end;
end

_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if ((function() local _lev=not _bool(_local3.octal); if _bool(_lev) then return (_local3.number.length == 0); else return _lev; end end)()) then
throwUnexpectedToken(_ENV);
end

if _bool(((function() local _lev=isIdentifierStart(_ENV,_local2.source:charCodeAt(_local2.index)); return _bool(_lev) and _lev or isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index)) end)())) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = _local2.Token.NumericLiteral,
["value"] = parseInt(_ENV,_local3.number,8),
["octal"] = _local3.octal,
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = start,
["end"] = _local2.index
}); end
end));
isImplicitOctalLiteral =((function(this)
local _local3 = {};
_local3.i = (_addNum2(_local2.index,1));
while (_lt(_local3.i,_local2.length)) do
_local3.ch = _local2.source[_local3.i];
if ((function() local _lev=(_local3.ch == "8"); return _bool(_lev) and _lev or (_local3.ch == "9") end)()) then
do return false; end
end

if not _bool(isOctalDigit(_ENV,_local3.ch)) then
do return true; end
end

_local3.i = _inc(_local3.i);
end

do return true; end
end));
scanNumericLiteral =((function(this)
local _local3 = {};
_local3.ch = _local2.source[_local2.index];
assert(_ENV,((function() local _lev=isDecimalDigit(_ENV,_local3.ch:charCodeAt(0)); return _bool(_lev) and _lev or (_local3.ch == ".") end)()),"Numeric literal must start with a decimal digit or a decimal point");
_local3.start = _local2.index;
_local3.number = "";
if (_local3.ch ~= ".") then
_local3.number = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
_local3.ch = _local2.source[_local2.index];
if (_local3.number == "0") then
if ((function() local _lev=(_local3.ch == "x"); return _bool(_lev) and _lev or (_local3.ch == "X") end)()) then
_local2.index = _inc(_local2.index);
do return scanHexLiteral(_ENV,_local3.start); end
end

if ((function() local _lev=(_local3.ch == "b"); return _bool(_lev) and _lev or (_local3.ch == "B") end)()) then
_local2.index = _inc(_local2.index);
do return scanBinaryLiteral(_ENV,_local3.start); end
end

if ((function() local _lev=(_local3.ch == "o"); return _bool(_lev) and _lev or (_local3.ch == "O") end)()) then
do return scanOctalLiteral(_ENV,_local3.ch,_local3.start); end
end

if _bool(isOctalDigit(_ENV,_local3.ch)) then
if _bool(isImplicitOctalLiteral(_ENV)) then
do return scanOctalLiteral(_ENV,_local3.ch,_local3.start); end
end

end

end

while _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index))) do
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

_local3.ch = _local2.source[_local2.index];
end

if (_local3.ch == ".") then
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
while _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index))) do
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

_local3.ch = _local2.source[_local2.index];
end

if ((function() local _lev=(_local3.ch == "e"); return _bool(_lev) and _lev or (_local3.ch == "E") end)()) then
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
_local3.ch = _local2.source[_local2.index];
if ((function() local _lev=(_local3.ch == "+"); return _bool(_lev) and _lev or (_local3.ch == "-") end)()) then
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
end

if _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index))) then
while _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index))) do
_local3.number = (_add(_local3.number,_local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

else
throwUnexpectedToken(_ENV);
end

end

if _bool(isIdentifierStart(_ENV,_local2.source:charCodeAt(_local2.index))) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = _local2.Token.NumericLiteral,
["value"] = parseFloat(_ENV,_local3.number),
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local3.start,
["end"] = _local2.index
}); end
end));
scanStringLiteral =((function(this)
local _local3 = {};
_local3.str = "";
_local3.octal = false;
_local3.quote = _local2.source[_local2.index];
assert(_ENV,((function() local _lev=(_local3.quote == "'"); return _bool(_lev) and _lev or (_local3.quote == "\"") end)()),"String literal must starts with a quote");
_local3.start = _local2.index;
_local2.index = _inc(_local2.index);
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if (_local3.ch == _local3.quote) then
_local3.quote = "";
do break end;
elseif (_local3.ch == "\\") then
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if ((function() local _lev=not _bool(_local3.ch); return _bool(_lev) and _lev or not _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) end)()) then
repeat
local _into = false;
local _cases = {["u"] = true,["x"] = true,["n"] = true,["r"] = true,["t"] = true,["b"] = true,["f"] = true,["v"] = true,["8"] = true,["9"] = true};
local _v = _local3.ch;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "u") then

_into = true;
end
if _into or (_v == "x") then
if (_local2.source[_local2.index] == "{") then
_local2.index = _inc(_local2.index);
_local3.str = (_add(_local3.str,scanUnicodeCodePointEscape(_ENV)));
else
_local3.unescaped = scanHexEscape(_ENV,_local3.ch);
if not _bool(_local3.unescaped) then
_throw(throwUnexpectedToken(_ENV),0)
end

_local3.str = (_add(_local3.str,_local3.unescaped));
end

do break end;
_into = true;
end
if _into or (_v == "n") then
_local3.str = (_addStr2(_local3.str,"\10"));
do break end;
_into = true;
end
if _into or (_v == "r") then
_local3.str = (_addStr2(_local3.str,"\13"));
do break end;
_into = true;
end
if _into or (_v == "t") then
_local3.str = (_addStr2(_local3.str,"\9"));
do break end;
_into = true;
end
if _into or (_v == "b") then
_local3.str = (_addStr2(_local3.str,"\8"));
do break end;
_into = true;
end
if _into or (_v == "f") then
_local3.str = (_addStr2(_local3.str,"\12"));
do break end;
_into = true;
end
if _into or (_v == "v") then
_local3.str = (_addStr2(_local3.str,"\11"));
do break end;
_into = true;
end
if _into or (_v == "8") then

_into = true;
end
if _into or (_v == "9") then
_local3.str = (_add(_local3.str,_local3.ch));
tolerateUnexpectedToken(_ENV);
do break end;
_into = true;
end
::_default::
if _into then
if _bool(isOctalDigit(_ENV,_local3.ch)) then
_local3.octToDec = octalToDecimal(_ENV,_local3.ch);
_local3.octal = ((function() local _lev=_local3.octToDec.octal; return _bool(_lev) and _lev or _local3.octal end)());
_local3.str = (_add(_local3.str,String:fromCharCode(_local3.octToDec.code)));
else
_local3.str = (_add(_local3.str,_local3.ch));
end

do break end;
_into = true;
end
until true
else
_local2.lineNumber = _inc(_local2.lineNumber);
if ((function() local _lev=(_local3.ch == "\13"); if _bool(_lev) then return (_local2.source[_local2.index] == "\10"); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.lineStart = _local2.index;
end

elseif _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) then
do break end;
else
_local3.str = (_add(_local3.str,_local3.ch));
end

::_continue::
end

if (_local3.quote ~= "") then
_local2.index = _local3.start;
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = _local2.Token.StringLiteral,
["value"] = _local3.str,
["octal"] = _local3.octal,
["lineNumber"] = _local2.startLineNumber,
["lineStart"] = _local2.startLineStart,
["start"] = _local3.start,
["end"] = _local2.index
}); end
end));
scanTemplate =((function(this)
local _local3 = {};
_local3.cooked = "";
_local3.terminated = false;
_local3.tail = false;
_local3.start = _local2.index;
_local3.head = (_local2.source[_local2.index] == "`");
_local3.rawOffset = 2;
_local2.index = _inc(_local2.index);
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if (_local3.ch == "`") then
_local3.rawOffset = 1;
_local3.tail = true;
_local3.terminated = true;
do break end;
elseif (_local3.ch == "$") then
if (_local2.source[_local2.index] == "{") then
_local2.state.curlyStack:push("${");
_local2.index = _inc(_local2.index);
_local3.terminated = true;
do break end;
end

_local3.cooked = (_add(_local3.cooked,_local3.ch));
elseif (_local3.ch == "\\") then
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if not _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) then
repeat
local _into = false;
local _cases = {["n"] = true,["r"] = true,["t"] = true,["u"] = true,["x"] = true,["b"] = true,["f"] = true,["v"] = true};
local _v = _local3.ch;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "n") then
_local3.cooked = (_addStr2(_local3.cooked,"\10"));
do break end;
_into = true;
end
if _into or (_v == "r") then
_local3.cooked = (_addStr2(_local3.cooked,"\13"));
do break end;
_into = true;
end
if _into or (_v == "t") then
_local3.cooked = (_addStr2(_local3.cooked,"\9"));
do break end;
_into = true;
end
if _into or (_v == "u") then

_into = true;
end
if _into or (_v == "x") then
if (_local2.source[_local2.index] == "{") then
_local2.index = _inc(_local2.index);
_local3.cooked = (_add(_local3.cooked,scanUnicodeCodePointEscape(_ENV)));
else
_local3.restore = _local2.index;
_local3.unescaped = scanHexEscape(_ENV,_local3.ch);
if _bool(_local3.unescaped) then
_local3.cooked = (_add(_local3.cooked,_local3.unescaped));
else
_local2.index = _local3.restore;
_local3.cooked = (_add(_local3.cooked,_local3.ch));
end

end

do break end;
_into = true;
end
if _into or (_v == "b") then
_local3.cooked = (_addStr2(_local3.cooked,"\8"));
do break end;
_into = true;
end
if _into or (_v == "f") then
_local3.cooked = (_addStr2(_local3.cooked,"\12"));
do break end;
_into = true;
end
if _into or (_v == "v") then
_local3.cooked = (_addStr2(_local3.cooked,"\11"));
do break end;
_into = true;
end
::_default::
if _into then
if (_local3.ch == "0") then
if _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt(_local2.index))) then
throwError(_ENV,_local2.Messages.TemplateOctalLiteral);
end

_local3.cooked = (_addStr2(_local3.cooked,"\0"));
elseif _bool(isOctalDigit(_ENV,_local3.ch)) then
throwError(_ENV,_local2.Messages.TemplateOctalLiteral);
else
_local3.cooked = (_add(_local3.cooked,_local3.ch));
end

do break end;
_into = true;
end
until true
else
_local2.lineNumber = _inc(_local2.lineNumber);
if ((function() local _lev=(_local3.ch == "\13"); if _bool(_lev) then return (_local2.source[_local2.index] == "\10"); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.lineStart = _local2.index;
end

elseif _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) then
_local2.lineNumber = _inc(_local2.lineNumber);
if ((function() local _lev=(_local3.ch == "\13"); if _bool(_lev) then return (_local2.source[_local2.index] == "\10"); else return _lev; end end)()) then
_local2.index = _inc(_local2.index);
end

_local2.lineStart = _local2.index;
_local3.cooked = (_addStr2(_local3.cooked,"\10"));
else
_local3.cooked = (_add(_local3.cooked,_local3.ch));
end

::_continue::
end

if not _bool(_local3.terminated) then
throwUnexpectedToken(_ENV);
end

if not _bool(_local3.head) then
_local2.state.curlyStack:pop();
end

do return _obj({
["type"] = _local2.Token.Template,
["value"] = _obj({
["cooked"] = _local3.cooked,
["raw"] = _local2.source:slice((_addNum2(_local3.start,1)),(_local2.index - _local3.rawOffset))
}),
["head"] = _local3.head,
["tail"] = _local3.tail,
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local3.start,
["end"] = _local2.index
}); end
end));
testRegExp =((function(this,pattern,flags)
local _local3 = {};
_local3.astralSubstitute = "￿";
_local3.tmp = pattern;
if (_ge(flags:indexOf("u"),0)) then
_local3.tmp = _local3.tmp:replace(_regexp("\\\\u\\{([0-9a-fA-F]+)\\}|\\\\u([a-fA-F0-9]{4})","g"),(function(this,S0,S1,S2)
local _local4 = {};
_local4.codePoint = parseInt(_ENV,(_bool(S1) and S1 or S2),16);
if (_gt(_local4.codePoint,1114111)) then
throwUnexpectedToken(_ENV,null,_local2.Messages.InvalidRegExp);
end

if (_le(_local4.codePoint,65535)) then
do return String:fromCharCode(_local4.codePoint); end
end

do return _local3.astralSubstitute; end
end)):replace(_regexp("[\240\144\128\128-\244\143\176\128][\240\144\128\128-\244\143\176\128]","g"),_local3.astralSubstitute);
end

local _status, _return = _pcall(function()
RegExp(_ENV,_local3.tmp);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local e = _return;
throwUnexpectedToken(_ENV,null,_local2.Messages.InvalidRegExp);
end);
if _cstatus then
else _throw(_creturn,0); end
end

local _status, _return = _pcall(function()
do return _new(RegExp,pattern,flags); end
end);
if _status then
if _return ~= nil then return _return; end
else
local _cstatus, _creturn = _pcall(function()
local exception = _return;
do return null; end
end);
if _cstatus then
if _creturn ~= nil then return _creturn; end
else _throw(_creturn,0); end
end

end));
scanRegExpBody =((function(this)
local _local3 = {};
_local3.ch = _local2.source[_local2.index];
assert(_ENV,(_local3.ch == "/"),"Regular expression literal must start with a slash");
_local3.str = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
_local3.classMarker = false;
_local3.terminated = false;
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
_local3.str = (_add(_local3.str,_local3.ch));
if (_local3.ch == "\\") then
_local3.ch = _local2.source[(function () local _tmp = _local2.index; _local2.index = _inc(_tmp); return _tmp; end)()];
if _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) then
throwUnexpectedToken(_ENV,null,_local2.Messages.UnterminatedRegExp);
end

_local3.str = (_add(_local3.str,_local3.ch));
elseif _bool(isLineTerminator(_ENV,_local3.ch:charCodeAt(0))) then
throwUnexpectedToken(_ENV,null,_local2.Messages.UnterminatedRegExp);
elseif _bool(_local3.classMarker) then
if (_local3.ch == "]") then
_local3.classMarker = false;
end

else
if (_local3.ch == "/") then
_local3.terminated = true;
do break end;
elseif (_local3.ch == "[") then
_local3.classMarker = true;
end

end

::_continue::
end

if not _bool(_local3.terminated) then
throwUnexpectedToken(_ENV,null,_local2.Messages.UnterminatedRegExp);
end

_local3.body = _local3.str:substr(1,(_local3.str.length - 2));
do return _obj({
["value"] = _local3.body,
["literal"] = _local3.str
}); end
end));
scanRegExpFlags =((function(this)
local _local3 = {};
_local3.str = "";
_local3.flags = "";
while (_lt(_local2.index,_local2.length)) do
_local3.ch = _local2.source[_local2.index];
if not _bool(isIdentifierPart(_ENV,_local3.ch:charCodeAt(0))) then
do break end;
end

_local2.index = _inc(_local2.index);
if ((function() local _lev=(_local3.ch == "\\"); if _bool(_lev) then return (_lt(_local2.index,_local2.length)); else return _lev; end end)()) then
_local3.ch = _local2.source[_local2.index];
if (_local3.ch == "u") then
_local2.index = _inc(_local2.index);
_local3.restore = _local2.index;
_local3.ch = scanHexEscape(_ENV,"u");
if _bool(_local3.ch) then
_local3.flags = (_add(_local3.flags,_local3.ch));
_local3.str = (_addStr2(_local3.str,"\\u"));
while (_lt(_local3.restore,_local2.index)) do
_local3.str = (_add(_local3.str,_local2.source[_local3.restore]));
_local3.restore = _inc(_local3.restore);
end

else
_local2.index = _local3.restore;
_local3.flags = (_addStr2(_local3.flags,"u"));
_local3.str = (_addStr2(_local3.str,"\\u"));
end

tolerateUnexpectedToken(_ENV);
else
_local3.str = (_addStr2(_local3.str,"\\"));
tolerateUnexpectedToken(_ENV);
end

else
_local3.flags = (_add(_local3.flags,_local3.ch));
_local3.str = (_add(_local3.str,_local3.ch));
end

::_continue::
end

do return _obj({
["value"] = _local3.flags,
["literal"] = _local3.str
}); end
end));
scanRegExp =((function(this)
local _local3 = {};
_local2.scanning = true;
_local2.lookahead = null;
skipComment(_ENV);
_local3.start = _local2.index;
_local3.body = scanRegExpBody(_ENV);
_local3.flags = scanRegExpFlags(_ENV);
_local3.value = testRegExp(_ENV,_local3.body.value,_local3.flags.value);
_local2.scanning = false;
if _bool(_local2.extra.tokenize) then
do return _obj({
["type"] = _local2.Token.RegularExpression,
["value"] = _local3.value,
["regex"] = _obj({
["pattern"] = _local3.body.value,
["flags"] = _local3.flags.value
}),
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local3.start,
["end"] = _local2.index
}); end
end

do return _obj({
["literal"] = (_add(_local3.body.literal,_local3.flags.literal)),
["value"] = _local3.value,
["regex"] = _obj({
["pattern"] = _local3.body.value,
["flags"] = _local3.flags.value
}),
["start"] = _local3.start,
["end"] = _local2.index
}); end
end));
collectRegex =((function(this)
local _local3 = {};
skipComment(_ENV);
_local3.pos = _local2.index;
_local3.loc = _obj({
["start"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
})
});
_local3.regex = scanRegExp(_ENV);
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
});
if not _bool(_local2.extra.tokenize) then
if (_gt(_local2.extra.tokens.length,0)) then
_local3.token = _local2.extra.tokens[(_local2.extra.tokens.length - 1)];
if ((function() local _lev=(_local3.token.range[0] == _local3.pos); if _bool(_lev) then return (_local3.token.type == "Punctuator"); else return _lev; end end)()) then
if ((function() local _lev=(_local3.token.value == "/"); return _bool(_lev) and _lev or (_local3.token.value == "/=") end)()) then
_local2.extra.tokens:pop();
end

end

end

_local2.extra.tokens:push(_obj({
["type"] = "RegularExpression",
["value"] = _local3.regex.literal,
["regex"] = _local3.regex.regex,
["range"] = _arr({[0]=_local3.pos,_local2.index},2),
["loc"] = _local3.loc
}));
end

do return _local3.regex; end
end));
isIdentifierName =((function(this,token)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(token.type == _local2.Token.Identifier); return _bool(_lev) and _lev or (token.type == _local2.Token.Keyword) end)()); return _bool(_lev) and _lev or (token.type == _local2.Token.BooleanLiteral) end)()); return _bool(_lev) and _lev or (token.type == _local2.Token.NullLiteral) end)()); end
end));
advanceSlash =((function(this)
local _local3 = {};
testKeyword =((function(this,value)
do return ((function() local _lev=((function() local _lev=((function() if _bool(value) then return (_gt(value.length,1)); else return value; end end)()); if _bool(_lev) then return (_ge(value[0],"a")); else return _lev; end end)()); if _bool(_lev) then return (_le(value[0],"z")); else return _lev; end end)()); end
end));_local3.previous = _local2.extra.tokenValues[(_local2.extra.tokens.length - 1)];
_local3.regex = (_local3.previous ~= null);
repeat
local _into = false;
local _cases = {["this"] = true,["]"] = true,[")"] = true,["}"] = true};
local _v = _local3.previous;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "this") then

_into = true;
end
if _into or (_v == "]") then
_local3.regex = false;
do break end;
_into = true;
end
if _into or (_v == ")") then
_local3.check = _local2.extra.tokenValues[(_local2.extra.openParenToken - 1)];
_local3.regex = ((function() local _lev=((function() local _lev=((function() local _lev=(_local3.check == "if"); return _bool(_lev) and _lev or (_local3.check == "while") end)()); return _bool(_lev) and _lev or (_local3.check == "for") end)()); return _bool(_lev) and _lev or (_local3.check == "with") end)());
do break end;
_into = true;
end
if _into or (_v == "}") then
_local3.regex = false;
if _bool(testKeyword(_ENV,_local2.extra.tokenValues[(_local2.extra.openCurlyToken - 3)])) then
_local3.check = _local2.extra.tokenValues[(_local2.extra.openCurlyToken - 4)];
_local3.regex = (function() if _bool(_local3.check) then return (_lt(_local2.FnExprTokens:indexOf(_local3.check),0)); else return false; end end)();
elseif _bool(testKeyword(_ENV,_local2.extra.tokenValues[(_local2.extra.openCurlyToken - 4)])) then
_local3.check = _local2.extra.tokenValues[(_local2.extra.openCurlyToken - 5)];
_local3.regex = (function() if _bool(_local3.check) then return (_lt(_local2.FnExprTokens:indexOf(_local3.check),0)); else return true; end end)();
end

_into = true;
end
::_default::
until true
do return (function() if _bool(_local3.regex) then return collectRegex(_ENV); else return scanPunctuator(_ENV); end end)(); end
end));
advance =((function(this)
local _local3 = {};
if (_ge(_local2.index,_local2.length)) then
do return _obj({
["type"] = _local2.Token.EOF,
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["start"] = _local2.index,
["end"] = _local2.index
}); end
end

_local3.cp = _local2.source:charCodeAt(_local2.index);
if _bool(isIdentifierStart(_ENV,_local3.cp)) then
_local3.token = scanIdentifier(_ENV);
if _bool(((function() if _bool(_local2.strict) then return isStrictModeReservedWord(_ENV,_local3.token.value); else return _local2.strict; end end)())) then
_local3.token.type = _local2.Token.Keyword;
end

do return _local3.token; end
end

if ((function() local _lev=((function() local _lev=(_local3.cp == 40); return _bool(_lev) and _lev or (_local3.cp == 41) end)()); return _bool(_lev) and _lev or (_local3.cp == 59) end)()) then
do return scanPunctuator(_ENV); end
end

if ((function() local _lev=(_local3.cp == 39); return _bool(_lev) and _lev or (_local3.cp == 34) end)()) then
do return scanStringLiteral(_ENV); end
end

if (_local3.cp == 46) then
if _bool(isDecimalDigit(_ENV,_local2.source:charCodeAt((_addNum2(_local2.index,1))))) then
do return scanNumericLiteral(_ENV); end
end

do return scanPunctuator(_ENV); end
end

if _bool(isDecimalDigit(_ENV,_local3.cp)) then
do return scanNumericLiteral(_ENV); end
end

if _bool(((function() local _lev=_local2.extra.tokenize; if _bool(_lev) then return (_local3.cp == 47); else return _lev; end end)())) then
do return advanceSlash(_ENV); end
end

if ((function() local _lev=(_local3.cp == 96); return _bool(_lev) and _lev or ((function() local _lev=(_local3.cp == 125); if _bool(_lev) then return (_local2.state.curlyStack[(_local2.state.curlyStack.length - 1)] == "${"); else return _lev; end end)()) end)()) then
do return scanTemplate(_ENV); end
end

if ((function() local _lev=(_ge(_local3.cp,55296)); if _bool(_lev) then return (_lt(_local3.cp,57343)); else return _lev; end end)()) then
_local3.cp = codePointAt(_ENV,_local2.index);
if _bool(isIdentifierStart(_ENV,_local3.cp)) then
do return scanIdentifier(_ENV); end
end

end

do return scanPunctuator(_ENV); end
end));
collectToken =((function(this)
local _local3 = {};
_local3.loc = _obj({
["start"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
})
});
_local3.token = advance(_ENV);
_local3.loc["end"] = _obj({
["line"] = _local2.lineNumber,
["column"] = (_local2.index - _local2.lineStart)
});
if (_local3.token.type ~= _local2.Token.EOF) then
_local3.value = _local2.source:slice(_local3.token.start,_local3.token["end"]);
_local3.entry = _obj({
["type"] = _local2.TokenName[_local3.token.type],
["value"] = _local3.value,
["range"] = _arr({[0]=_local3.token.start,_local3.token["end"]},2),
["loc"] = _local3.loc
});
if _bool(_local3.token.regex) then
_local3.entry.regex = _obj({
["pattern"] = _local3.token.regex.pattern,
["flags"] = _local3.token.regex.flags
});
end

if _bool(_local2.extra.tokenValues) then
_local2.extra.tokenValues:push((function() if ((function() local _lev=(_local3.entry.type == "Punctuator"); return _bool(_lev) and _lev or (_local3.entry.type == "Keyword") end)()) then return _local3.entry.value; else return null; end end)());
end

if _bool(_local2.extra.tokenize) then
if not _bool(_local2.extra.range) then
(function () local _r = false; local _g, _s = _local3.entry["_g" .. "range"], _local3.entry["_s" .. "range"]; _local3.entry["_g" .. "range"], _local3.entry["_s" .. "range"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.entry.range; _local3.entry.range = nil; return _r or _v ~= nil; end)();
end

if not _bool(_local2.extra.loc) then
(function () local _r = false; local _g, _s = _local3.entry["_g" .. "loc"], _local3.entry["_s" .. "loc"]; _local3.entry["_g" .. "loc"], _local3.entry["_s" .. "loc"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.entry.loc; _local3.entry.loc = nil; return _r or _v ~= nil; end)();
end

if _bool(_local2.extra.delegate) then
_local3.entry = _local2.extra:delegate(_local3.entry);
end

end

_local2.extra.tokens:push(_local3.entry);
end

do return _local3.token; end
end));
lex =((function(this)
local _local3 = {};
_local2.scanning = true;
_local2.lastIndex = _local2.index;
_local2.lastLineNumber = _local2.lineNumber;
_local2.lastLineStart = _local2.lineStart;
skipComment(_ENV);
_local3.token = _local2.lookahead;
_local2.startIndex = _local2.index;
_local2.startLineNumber = _local2.lineNumber;
_local2.startLineStart = _local2.lineStart;
_local2.lookahead = (function() if (_type(_local2.extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
_local2.scanning = false;
do return _local3.token; end
end));
peek =((function(this)
_local2.scanning = true;
skipComment(_ENV);
_local2.lastIndex = _local2.index;
_local2.lastLineNumber = _local2.lineNumber;
_local2.lastLineStart = _local2.lineStart;
_local2.startIndex = _local2.index;
_local2.startLineNumber = _local2.lineNumber;
_local2.startLineStart = _local2.lineStart;
_local2.lookahead = (function() if (_type(_local2.extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
_local2.scanning = false;
end));
Position =((function(this)
this.line = _local2.startLineNumber;
this.column = (_local2.startIndex - _local2.startLineStart);
end));
SourceLocation =((function(this)
this.start = _new(Position);
this["end"] = null;
end));
WrappingSourceLocation =((function(this,startToken)
this.start = _obj({
["line"] = startToken.lineNumber,
["column"] = (startToken.start - startToken.lineStart)
});
this["end"] = null;
end));
Node =((function(this)
if _bool(_local2.extra.range) then
this.range = _arr({[0]=_local2.startIndex,0},2);
end

if _bool(_local2.extra.loc) then
this.loc = _new(SourceLocation);
end

end));
WrappingNode =((function(this,startToken)
if _bool(_local2.extra.range) then
this.range = _arr({[0]=startToken.start,0},2);
end

if _bool(_local2.extra.loc) then
this.loc = _new(WrappingSourceLocation,startToken);
end

end));
recordError =((function(this,error)
local _local3 = {};
_local3.e = 0;
while (_lt(_local3.e,_local2.extra.errors.length)) do
_local3.existing = _local2.extra.errors[_local3.e];
if ((function() local _lev=(_local3.existing.index == error.index); if _bool(_lev) then return (_local3.existing.message == error.message); else return _lev; end end)()) then
do return end
end

_local3.e = _inc(_local3.e);
end

_local2.extra.errors:push(error);
end));
constructError =((function(this,msg,column)
local _local3 = {};
_local3.error = _new(Error,msg);
local _status, _return = _pcall(function()
_throw(_local3.error,0)
end);
if _status then
do return _local3.error; end
else
local _cstatus, _creturn = _pcall(function()
local base = _return;
if _bool(((function() local _lev=Object.create; if _bool(_lev) then return Object.defineProperty; else return _lev; end end)())) then
_local3.error = Object:create(base);
Object:defineProperty(_local3.error,"column",_obj({
["value"] = column
}));
end

end);
do return _local3.error; end
if _cstatus then
else _throw(_creturn,0); end
end

end));
createError =((function(this,line,pos,description)
local _local3 = {};
_local3.msg = (_addStr1(((_addStr1("Line ",line)) .. ": "),description));
_local3.column = ((pos - (function() if _bool(_local2.scanning) then return _local2.lineStart; else return _local2.lastLineStart; end end)()) + 1);
_local3.error = constructError(_ENV,_local3.msg,_local3.column);
_local3.error.lineNumber = line;
_local3.error.description = description;
_local3.error.index = pos;
do return _local3.error; end
end));
throwError =((function(...)
local this,messageFormat,arguments = ...;
local arguments = _args(...);
local _local3 = {};
_local3.args = Array.prototype.slice:call(arguments,1);
_local3.msg = messageFormat:replace(_regexp("%(\\d)","g"),(function(this,whole,idx)
assert(_ENV,(_lt(idx,_local3.args.length)),"Message reference must be in range");
do return _local3.args[idx]; end
end));
_throw(createError(_ENV,_local2.lastLineNumber,_local2.lastIndex,_local3.msg),0)
end));
tolerateError =((function(...)
local this,messageFormat,arguments = ...;
local arguments = _args(...);
local _local3 = {};
_local3.args = Array.prototype.slice:call(arguments,1);
_local3.msg = messageFormat:replace(_regexp("%(\\d)","g"),(function(this,whole,idx)
assert(_ENV,(_lt(idx,_local3.args.length)),"Message reference must be in range");
do return _local3.args[idx]; end
end));
_local3.error = createError(_ENV,_local2.lineNumber,_local2.lastIndex,_local3.msg);
if _bool(_local2.extra.errors) then
recordError(_ENV,_local3.error);
else
_throw(_local3.error,0)
end

end));
unexpectedTokenError =((function(this,token,message)
local _local3 = {};
_local3.msg = (_bool(message) and message or _local2.Messages.UnexpectedToken);
if _bool(token) then
if not _bool(message) then
_local3.msg = (function() if (token.type == _local2.Token.EOF) then return _local2.Messages.UnexpectedEOS; else return (function() if (token.type == _local2.Token.Identifier) then return _local2.Messages.UnexpectedIdentifier; else return (function() if (token.type == _local2.Token.NumericLiteral) then return _local2.Messages.UnexpectedNumber; else return (function() if (token.type == _local2.Token.StringLiteral) then return _local2.Messages.UnexpectedString; else return (function() if (token.type == _local2.Token.Template) then return _local2.Messages.UnexpectedTemplate; else return _local2.Messages.UnexpectedToken; end end)(); end end)(); end end)(); end end)(); end end)();
if (token.type == _local2.Token.Keyword) then
if _bool(isFutureReservedWord(_ENV,token.value)) then
_local3.msg = _local2.Messages.UnexpectedReserved;
elseif _bool(((function() if _bool(_local2.strict) then return isStrictModeReservedWord(_ENV,token.value); else return _local2.strict; end end)())) then
_local3.msg = _local2.Messages.StrictReservedWord;
end

end

end

_local3.value = (function() if (token.type == _local2.Token.Template) then return token.value.raw; else return token.value; end end)();
else
_local3.value = "ILLEGAL";
end

_local3.msg = _local3.msg:replace("%0",_local3.value);
do return (function() if _bool(((function() if _bool(token) then return (_type(token.lineNumber) == "number"); else return token; end end)())) then return createError(_ENV,token.lineNumber,token.start,_local3.msg); else return createError(_ENV,(function() if _bool(_local2.scanning) then return _local2.lineNumber; else return _local2.lastLineNumber; end end)(),(function() if _bool(_local2.scanning) then return _local2.index; else return _local2.lastIndex; end end)(),_local3.msg); end end)(); end
end));
throwUnexpectedToken =((function(this,token,message)
_throw(unexpectedTokenError(_ENV,token,message),0)
end));
tolerateUnexpectedToken =((function(this,token,message)
local _local3 = {};
_local3.error = unexpectedTokenError(_ENV,token,message);
if _bool(_local2.extra.errors) then
recordError(_ENV,_local3.error);
else
_throw(_local3.error,0)
end

end));
expect =((function(this,value)
local _local3 = {};
_local3.token = lex(_ENV);
if ((function() local _lev=(_local3.token.type ~= _local2.Token.Punctuator); return _bool(_lev) and _lev or (_local3.token.value ~= value) end)()) then
throwUnexpectedToken(_ENV,_local3.token);
end

end));
expectCommaSeparator =((function(this)
local _local3 = {};
if _bool(_local2.extra.errors) then
_local3.token = _local2.lookahead;
if ((function() local _lev=(_local3.token.type == _local2.Token.Punctuator); if _bool(_lev) then return (_local3.token.value == ","); else return _lev; end end)()) then
lex(_ENV);
elseif ((function() local _lev=(_local3.token.type == _local2.Token.Punctuator); if _bool(_lev) then return (_local3.token.value == ";"); else return _lev; end end)()) then
lex(_ENV);
tolerateUnexpectedToken(_ENV,_local3.token);
else
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.UnexpectedToken);
end

else
expect(_ENV,",");
end

end));
expectKeyword =((function(this,keyword)
local _local3 = {};
_local3.token = lex(_ENV);
if ((function() local _lev=(_local3.token.type ~= _local2.Token.Keyword); return _bool(_lev) and _lev or (_local3.token.value ~= keyword) end)()) then
throwUnexpectedToken(_ENV,_local3.token);
end

end));
match =((function(this,value)
do return ((function() local _lev=(_local2.lookahead.type == _local2.Token.Punctuator); if _bool(_lev) then return (_local2.lookahead.value == value); else return _lev; end end)()); end
end));
matchKeyword =((function(this,keyword)
do return ((function() local _lev=(_local2.lookahead.type == _local2.Token.Keyword); if _bool(_lev) then return (_local2.lookahead.value == keyword); else return _lev; end end)()); end
end));
matchContextualKeyword =((function(this,keyword)
do return ((function() local _lev=(_local2.lookahead.type == _local2.Token.Identifier); if _bool(_lev) then return (_local2.lookahead.value == keyword); else return _lev; end end)()); end
end));
matchAssign =((function(this)
local _local3 = {};
if (_local2.lookahead.type ~= _local2.Token.Punctuator) then
do return false; end
end

_local3.op = _local2.lookahead.value;
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(_local3.op == "="); return _bool(_lev) and _lev or (_local3.op == "*=") end)()); return _bool(_lev) and _lev or (_local3.op == "/=") end)()); return _bool(_lev) and _lev or (_local3.op == "%=") end)()); return _bool(_lev) and _lev or (_local3.op == "+=") end)()); return _bool(_lev) and _lev or (_local3.op == "-=") end)()); return _bool(_lev) and _lev or (_local3.op == "<<=") end)()); return _bool(_lev) and _lev or (_local3.op == ">>=") end)()); return _bool(_lev) and _lev or (_local3.op == ">>>=") end)()); return _bool(_lev) and _lev or (_local3.op == "&=") end)()); return _bool(_lev) and _lev or (_local3.op == "^=") end)()); return _bool(_lev) and _lev or (_local3.op == "|=") end)()); end
end));
consumeSemicolon =((function(this)
if _bool(((function() local _lev=(_local2.source:charCodeAt(_local2.startIndex) == 59); return _bool(_lev) and _lev or match(_ENV,";") end)())) then
lex(_ENV);
do return end
end

if _bool(_local2.hasLineTerminator) then
do return end
end

_local2.lastIndex = _local2.startIndex;
_local2.lastLineNumber = _local2.startLineNumber;
_local2.lastLineStart = _local2.startLineStart;
if ((function() local _lev=(_local2.lookahead.type ~= _local2.Token.EOF); if _bool(_lev) then return not _bool(match(_ENV,"}")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

end));
isolateCoverGrammar =((function(this,parser)
local _local3 = {};
_local3.oldIsBindingElement = _local2.isBindingElement;
_local3.oldIsAssignmentTarget = _local2.isAssignmentTarget;
_local3.oldFirstCoverInitializedNameError = _local2.firstCoverInitializedNameError;
_local2.isBindingElement = true;
_local2.isAssignmentTarget = true;
_local2.firstCoverInitializedNameError = null;
_local3.result = parser(_ENV);
if (_local2.firstCoverInitializedNameError ~= null) then
throwUnexpectedToken(_ENV,_local2.firstCoverInitializedNameError);
end

_local2.isBindingElement = _local3.oldIsBindingElement;
_local2.isAssignmentTarget = _local3.oldIsAssignmentTarget;
_local2.firstCoverInitializedNameError = _local3.oldFirstCoverInitializedNameError;
do return _local3.result; end
end));
inheritCoverGrammar =((function(this,parser)
local _local3 = {};
_local3.oldIsBindingElement = _local2.isBindingElement;
_local3.oldIsAssignmentTarget = _local2.isAssignmentTarget;
_local3.oldFirstCoverInitializedNameError = _local2.firstCoverInitializedNameError;
_local2.isBindingElement = true;
_local2.isAssignmentTarget = true;
_local2.firstCoverInitializedNameError = null;
_local3.result = parser(_ENV);
_local2.isBindingElement = ((function() if _bool(_local2.isBindingElement) then return _local3.oldIsBindingElement; else return _local2.isBindingElement; end end)());
_local2.isAssignmentTarget = ((function() if _bool(_local2.isAssignmentTarget) then return _local3.oldIsAssignmentTarget; else return _local2.isAssignmentTarget; end end)());
_local2.firstCoverInitializedNameError = (_bool(_local3.oldFirstCoverInitializedNameError) and _local3.oldFirstCoverInitializedNameError or _local2.firstCoverInitializedNameError);
do return _local3.result; end
end));
parseArrayPattern =((function(this,params,kind)
local _local3 = {};
_local3.node = _new(Node);
_local3.elements = _arr({},0);
expect(_ENV,"[");
while not _bool(match(_ENV,"]")) do
if _bool(match(_ENV,",")) then
lex(_ENV);
_local3.elements:push(null);
else
if _bool(match(_ENV,"...")) then
_local3.restNode = _new(Node);
lex(_ENV);
params:push(_local2.lookahead);
_local3.rest = parseVariableIdentifier(_ENV,kind);
_local3.elements:push(_local3.restNode:finishRestElement(_local3.rest));
do break end;
else
_local3.elements:push(parsePatternWithDefault(_ENV,params,kind));
end

if not _bool(match(_ENV,"]")) then
expect(_ENV,",");
end

end

::_continue::
end

expect(_ENV,"]");
do return _local3.node:finishArrayPattern(_local3.elements); end
end));
parsePropertyPattern =((function(this,params,kind)
local _local3 = {};
_local3.node = _new(Node);
_local3.computed = match(_ENV,"[");
if (_local2.lookahead.type == _local2.Token.Identifier) then
_local3.keyToken = _local2.lookahead;
_local3.key = parseVariableIdentifier(_ENV);
if _bool(match(_ENV,"=")) then
params:push(_local3.keyToken);
lex(_ENV);
_local3.init = parseAssignmentExpression(_ENV);
do return _local3.node:finishProperty("init",_local3.key,false,_new(WrappingNode,_local3.keyToken):finishAssignmentPattern(_local3.key,_local3.init),false,true); end
elseif not _bool(match(_ENV,":")) then
params:push(_local3.keyToken);
do return _local3.node:finishProperty("init",_local3.key,false,_local3.key,false,true); end
end

else
_local3.key = parseObjectPropertyKey(_ENV);
end

expect(_ENV,":");
_local3.init = parsePatternWithDefault(_ENV,params,kind);
do return _local3.node:finishProperty("init",_local3.key,_local3.computed,_local3.init,false,false); end
end));
parseObjectPattern =((function(this,params,kind)
local _local3 = {};
_local3.node = _new(Node);
_local3.properties = _arr({},0);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
_local3.properties:push(parsePropertyPattern(_ENV,params,kind));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
end

::_continue::
end

lex(_ENV);
do return _local3.node:finishObjectPattern(_local3.properties); end
end));
parsePattern =((function(this,params,kind)
if _bool(match(_ENV,"[")) then
do return parseArrayPattern(_ENV,params,kind); end
elseif _bool(match(_ENV,"{")) then
do return parseObjectPattern(_ENV,params,kind); end
elseif _bool(matchKeyword(_ENV,"let")) then
if ((function() local _lev=(kind == "const"); return _bool(_lev) and _lev or (kind == "let") end)()) then
tolerateUnexpectedToken(_ENV,_local2.lookahead,_local2.Messages.UnexpectedToken);
end

end

params:push(_local2.lookahead);
do return parseVariableIdentifier(_ENV,kind); end
end));
parsePatternWithDefault =((function(this,params,kind)
local _local3 = {};
_local3.startToken = _local2.lookahead;
_local3.pattern = parsePattern(_ENV,params,kind);
if _bool(match(_ENV,"=")) then
lex(_ENV);
_local3.previousAllowYield = _local2.state.allowYield;
_local2.state.allowYield = true;
_local3.right = isolateCoverGrammar(_ENV,parseAssignmentExpression);
_local2.state.allowYield = _local3.previousAllowYield;
_local3.pattern = _new(WrappingNode,_local3.startToken):finishAssignmentPattern(_local3.pattern,_local3.right);
end

do return _local3.pattern; end
end));
parseArrayInitializer =((function(this)
local _local3 = {};
_local3.elements = _arr({},0);
_local3.node = _new(Node);
expect(_ENV,"[");
while not _bool(match(_ENV,"]")) do
if _bool(match(_ENV,",")) then
lex(_ENV);
_local3.elements:push(null);
elseif _bool(match(_ENV,"...")) then
_local3.restSpread = _new(Node);
lex(_ENV);
_local3.restSpread:finishSpreadElement(inheritCoverGrammar(_ENV,parseAssignmentExpression));
if not _bool(match(_ENV,"]")) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
expect(_ENV,",");
end

_local3.elements:push(_local3.restSpread);
else
_local3.elements:push(inheritCoverGrammar(_ENV,parseAssignmentExpression));
if not _bool(match(_ENV,"]")) then
expect(_ENV,",");
end

end

::_continue::
end

lex(_ENV);
do return _local3.node:finishArrayExpression(_local3.elements); end
end));
parsePropertyFunction =((function(this,node,paramInfo,isGenerator)
local _local3 = {};
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.previousStrict = _local2.strict;
_local3.body = isolateCoverGrammar(_ENV,parseFunctionSourceElements);
if _bool(((function() if _bool(_local2.strict) then return paramInfo.firstRestricted; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,paramInfo.firstRestricted,paramInfo.message);
end

if _bool(((function() if _bool(_local2.strict) then return paramInfo.stricted; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,paramInfo.stricted,paramInfo.message);
end

_local2.strict = _local3.previousStrict;
do return node:finishFunctionExpression(null,paramInfo.params,paramInfo.defaults,_local3.body,isGenerator); end
end));
parsePropertyMethodFunction =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3.previousAllowYield = _local2.state.allowYield;
_local2.state.allowYield = false;
_local3.params = parseParams(_ENV);
_local2.state.allowYield = _local3.previousAllowYield;
_local2.state.allowYield = false;
_local3.method = parsePropertyFunction(_ENV,_local3.node,_local3.params,false);
_local2.state.allowYield = _local3.previousAllowYield;
do return _local3.method; end
end));
parseObjectPropertyKey =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3.token = lex(_ENV);
repeat
local _into = false;
local _cases = {[_local2.Token.StringLiteral] = true,[_local2.Token.NumericLiteral] = true,[_local2.Token.Identifier] = true,[_local2.Token.BooleanLiteral] = true,[_local2.Token.NullLiteral] = true,[_local2.Token.Keyword] = true,[_local2.Token.Punctuator] = true};
local _v = _local3.token.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Token.StringLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.NumericLiteral) then
if _bool(((function() if _bool(_local2.strict) then return _local3.token.octal; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictOctalLiteral);
end

do return _local3.node:finishLiteral(_local3.token); end
_into = true;
end
if _into or (_v == _local2.Token.Identifier) then

_into = true;
end
if _into or (_v == _local2.Token.BooleanLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.NullLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.Keyword) then
do return _local3.node:finishIdentifier(_local3.token.value); end
_into = true;
end
if _into or (_v == _local2.Token.Punctuator) then
if (_local3.token.value == "[") then
_local3.expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
expect(_ENV,"]");
do return _local3.expr; end
end

do break end;
_into = true;
end
::_default::
until true
throwUnexpectedToken(_ENV,_local3.token);
end));
lookaheadPropertyName =((function(this)
repeat
local _into = false;
local _cases = {[_local2.Token.Identifier] = true,[_local2.Token.StringLiteral] = true,[_local2.Token.BooleanLiteral] = true,[_local2.Token.NullLiteral] = true,[_local2.Token.NumericLiteral] = true,[_local2.Token.Keyword] = true,[_local2.Token.Punctuator] = true};
local _v = _local2.lookahead.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Token.Identifier) then

_into = true;
end
if _into or (_v == _local2.Token.StringLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.BooleanLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.NullLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.NumericLiteral) then

_into = true;
end
if _into or (_v == _local2.Token.Keyword) then
do return true; end
_into = true;
end
if _into or (_v == _local2.Token.Punctuator) then
do return (_local2.lookahead.value == "["); end
_into = true;
end
::_default::
until true
do return false; end
end));
tryParseMethodDefinition =((function(this,token,key,computed,node)
local _local3 = {};
_local3.previousAllowYield = _local2.state.allowYield;
if (token.type == _local2.Token.Identifier) then
if _bool(((function() local _lev=(token.value == "get"); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
_local3.methodNode = _new(Node);
expect(_ENV,"(");
expect(_ENV,")");
_local2.state.allowYield = false;
_local3.value = parsePropertyFunction(_ENV,_local3.methodNode,_obj({
["params"] = _arr({},0),
["defaults"] = _arr({},0),
["stricted"] = null,
["firstRestricted"] = null,
["message"] = null
}),false);
_local2.state.allowYield = _local3.previousAllowYield;
do return node:finishProperty("get",key,computed,_local3.value,false,false); end
elseif _bool(((function() local _lev=(token.value == "set"); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
_local3.methodNode = _new(Node);
expect(_ENV,"(");
_local3.options = _obj({
["params"] = _arr({},0),
["defaultCount"] = 0,
["defaults"] = _arr({},0),
["firstRestricted"] = null,
["paramSet"] = _obj({})
});
if _bool(match(_ENV,")")) then
tolerateUnexpectedToken(_ENV,_local2.lookahead);
else
_local2.state.allowYield = false;
parseParam(_ENV,_local3.options);
_local2.state.allowYield = _local3.previousAllowYield;
if (_local3.options.defaultCount == 0) then
_local3.options.defaults = _arr({},0);
end

end

expect(_ENV,")");
_local2.state.allowYield = false;
_local3.value = parsePropertyFunction(_ENV,_local3.methodNode,_local3.options,false);
_local2.state.allowYield = _local3.previousAllowYield;
do return node:finishProperty("set",key,computed,_local3.value,false,false); end
end

elseif _bool(((function() local _lev=((function() local _lev=(token.type == _local2.Token.Punctuator); if _bool(_lev) then return (token.value == "*"); else return _lev; end end)()); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
_local3.methodNode = _new(Node);
_local2.state.allowYield = true;
_local3.params = parseParams(_ENV);
_local2.state.allowYield = _local3.previousAllowYield;
_local2.state.allowYield = false;
_local3.value = parsePropertyFunction(_ENV,_local3.methodNode,_local3.params,true);
_local2.state.allowYield = _local3.previousAllowYield;
do return node:finishProperty("init",key,computed,_local3.value,true,false); end
end

if _bool(((function() if _bool(key) then return match(_ENV,"("); else return key; end end)())) then
_local3.value = parsePropertyMethodFunction(_ENV);
do return node:finishProperty("init",key,computed,_local3.value,true,false); end
end

do return null; end
end));
parseObjectProperty =((function(this,hasProto)
local _local3 = {};
_local3.token = _local2.lookahead;
_local3.node = _new(Node);
_local3.computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
_local3.key = parseObjectPropertyKey(_ENV);
end

_local3.maybeMethod = tryParseMethodDefinition(_ENV,_local3.token,_local3.key,_local3.computed,_local3.node);
if _bool(_local3.maybeMethod) then
do return _local3.maybeMethod; end
end

if not _bool(_local3.key) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

if not _bool(_local3.computed) then
_local3.proto = ((function() local _lev=((function() local _lev=(_local3.key.type == _local2.Syntax.Identifier); if _bool(_lev) then return (_local3.key.name == "__proto__"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(_local3.key.type == _local2.Syntax.Literal); if _bool(_lev) then return (_local3.key.value == "__proto__"); else return _lev; end end)()) end)());
if _bool(((function() local _lev=hasProto.value; if _bool(_lev) then return _local3.proto; else return _lev; end end)())) then
tolerateError(_ENV,_local2.Messages.DuplicateProtoProperty);
end

hasProto.value = (_bor(hasProto.value,_local3.proto));
end

if _bool(match(_ENV,":")) then
lex(_ENV);
_local3.value = inheritCoverGrammar(_ENV,parseAssignmentExpression);
do return _local3.node:finishProperty("init",_local3.key,_local3.computed,_local3.value,false,false); end
end

if (_local3.token.type == _local2.Token.Identifier) then
if _bool(match(_ENV,"=")) then
_local2.firstCoverInitializedNameError = _local2.lookahead;
lex(_ENV);
_local3.value = isolateCoverGrammar(_ENV,parseAssignmentExpression);
do return _local3.node:finishProperty("init",_local3.key,_local3.computed,_new(WrappingNode,_local3.token):finishAssignmentPattern(_local3.key,_local3.value),false,true); end
end

do return _local3.node:finishProperty("init",_local3.key,_local3.computed,_local3.key,false,true); end
end

throwUnexpectedToken(_ENV,_local2.lookahead);
end));
parseObjectInitializer =((function(this)
local _local3 = {};
_local3.properties = _arr({},0);
_local3.hasProto = _obj({
["value"] = false
});
_local3.node = _new(Node);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
_local3.properties:push(parseObjectProperty(_ENV,_local3.hasProto));
if not _bool(match(_ENV,"}")) then
expectCommaSeparator(_ENV);
end

::_continue::
end

expect(_ENV,"}");
do return _local3.node:finishObjectExpression(_local3.properties); end
end));
reinterpretExpressionAsPattern =((function(this,expr)
local _local3 = {};
repeat
local _into = false;
local _cases = {[_local2.Syntax.Identifier] = true,[_local2.Syntax.MemberExpression] = true,[_local2.Syntax.RestElement] = true,[_local2.Syntax.AssignmentPattern] = true,[_local2.Syntax.SpreadElement] = true,[_local2.Syntax.ArrayExpression] = true,[_local2.Syntax.ObjectExpression] = true,[_local2.Syntax.AssignmentExpression] = true};
local _v = expr.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Syntax.Identifier) then

_into = true;
end
if _into or (_v == _local2.Syntax.MemberExpression) then

_into = true;
end
if _into or (_v == _local2.Syntax.RestElement) then

_into = true;
end
if _into or (_v == _local2.Syntax.AssignmentPattern) then
do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.SpreadElement) then
expr.type = _local2.Syntax.RestElement;
reinterpretExpressionAsPattern(_ENV,expr.argument);
do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.ArrayExpression) then
expr.type = _local2.Syntax.ArrayPattern;
_local3.i = 0;
while (_lt(_local3.i,expr.elements.length)) do
if (expr.elements[_local3.i] ~= null) then
reinterpretExpressionAsPattern(_ENV,expr.elements[_local3.i]);
end

_local3.i = _inc(_local3.i);
end

do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.ObjectExpression) then
expr.type = _local2.Syntax.ObjectPattern;
_local3.i = 0;
while (_lt(_local3.i,expr.properties.length)) do
reinterpretExpressionAsPattern(_ENV,expr.properties[_local3.i].value);
_local3.i = _inc(_local3.i);
end

do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.AssignmentExpression) then
expr.type = _local2.Syntax.AssignmentPattern;
reinterpretExpressionAsPattern(_ENV,expr.left);
do break end;
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
end));
parseTemplateElement =((function(this,option)
local _local3 = {};
if _bool(((function() local _lev=(_local2.lookahead.type ~= _local2.Token.Template); return _bool(_lev) and _lev or ((function() local _lev=option.head; if _bool(_lev) then return not _bool(_local2.lookahead.head); else return _lev; end end)()) end)())) then
throwUnexpectedToken(_ENV);
end

_local3.node = _new(Node);
_local3.token = lex(_ENV);
do return _local3.node:finishTemplateElement(_obj({
["raw"] = _local3.token.value.raw,
["cooked"] = _local3.token.value.cooked
}),_local3.token.tail); end
end));
parseTemplateLiteral =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3.quasi = parseTemplateElement(_ENV,_obj({
["head"] = true
}));
_local3.quasis = _arr({[0]=_local3.quasi},1);
_local3.expressions = _arr({},0);
while not _bool(_local3.quasi.tail) do
_local3.expressions:push(parseExpression(_ENV));
_local3.quasi = parseTemplateElement(_ENV,_obj({
["head"] = false
}));
_local3.quasis:push(_local3.quasi);
::_continue::
end

do return _local3.node:finishTemplateLiteral(_local3.quasis,_local3.expressions); end
end));
parseGroupExpression =((function(this)
local _local3 = {};
_local3.params = _arr({},0);
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
lex(_ENV);
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

do return _obj({
["type"] = _local2.PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({},0),
["rawParams"] = _arr({},0)
}); end
end

_local3.startToken = _local2.lookahead;
if _bool(match(_ENV,"...")) then
_local3.expr = parseRestElement(_ENV,_local3.params);
expect(_ENV,")");
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

do return _obj({
["type"] = _local2.PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({[0]=_local3.expr},1)
}); end
end

_local2.isBindingElement = true;
_local3.expr = inheritCoverGrammar(_ENV,parseAssignmentExpression);
if _bool(match(_ENV,",")) then
_local2.isAssignmentTarget = false;
_local3.expressions = _arr({[0]=_local3.expr},1);
while (_lt(_local2.startIndex,_local2.length)) do
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
if _bool(match(_ENV,"...")) then
if not _bool(_local2.isBindingElement) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.expressions:push(parseRestElement(_ENV,_local3.params));
expect(_ENV,")");
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

_local2.isBindingElement = false;
_local3.i = 0;
while (_lt(_local3.i,_local3.expressions.length)) do
reinterpretExpressionAsPattern(_ENV,_local3.expressions[_local3.i]);
_local3.i = _inc(_local3.i);
end

do return _obj({
["type"] = _local2.PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _local3.expressions
}); end
end

_local3.expressions:push(inheritCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

_local3.expr = _new(WrappingNode,_local3.startToken):finishSequenceExpression(_local3.expressions);
end

expect(_ENV,")");
if _bool(match(_ENV,"=>")) then
if ((function() local _lev=(_local3.expr.type == _local2.Syntax.Identifier); if _bool(_lev) then return (_local3.expr.name == "yield"); else return _lev; end end)()) then
do return _obj({
["type"] = _local2.PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({[0]=_local3.expr},1)
}); end
end

if not _bool(_local2.isBindingElement) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

if (_local3.expr.type == _local2.Syntax.SequenceExpression) then
_local3.i = 0;
while (_lt(_local3.i,_local3.expr.expressions.length)) do
reinterpretExpressionAsPattern(_ENV,_local3.expr.expressions[_local3.i]);
_local3.i = _inc(_local3.i);
end

else
reinterpretExpressionAsPattern(_ENV,_local3.expr);
end

_local3.expr = _obj({
["type"] = _local2.PlaceHolders.ArrowParameterPlaceHolder,
["params"] = (function() if (_local3.expr.type == _local2.Syntax.SequenceExpression) then return _local3.expr.expressions; else return _arr({[0]=_local3.expr},1); end end)()
});
end

_local2.isBindingElement = false;
do return _local3.expr; end
end));
parsePrimaryExpression =((function(this)
local _local3 = {};
if _bool(match(_ENV,"(")) then
_local2.isBindingElement = false;
do return inheritCoverGrammar(_ENV,parseGroupExpression); end
end

if _bool(match(_ENV,"[")) then
do return inheritCoverGrammar(_ENV,parseArrayInitializer); end
end

if _bool(match(_ENV,"{")) then
do return inheritCoverGrammar(_ENV,parseObjectInitializer); end
end

_local3.type = _local2.lookahead.type;
_local3.node = _new(Node);
if (_local3.type == _local2.Token.Identifier) then
if ((function() local _lev=(_local2.state.sourceType == "module"); if _bool(_lev) then return (_local2.lookahead.value == "await"); else return _lev; end end)()) then
tolerateUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.expr = _local3.node:finishIdentifier(lex(_ENV).value);
elseif ((function() local _lev=(_local3.type == _local2.Token.StringLiteral); return _bool(_lev) and _lev or (_local3.type == _local2.Token.NumericLiteral) end)()) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
if _bool(((function() if _bool(_local2.strict) then return _local2.lookahead.octal; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,_local2.lookahead,_local2.Messages.StrictOctalLiteral);
end

_local3.expr = _local3.node:finishLiteral(lex(_ENV));
elseif (_local3.type == _local2.Token.Keyword) then
if _bool(((function() local _lev=((function() local _lev=not _bool(_local2.strict); if _bool(_lev) then return _local2.state.allowYield; else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then
do return parseNonComputedProperty(_ENV); end
end

if _bool(((function() local _lev=not _bool(_local2.strict); if _bool(_lev) then return matchKeyword(_ENV,"let"); else return _lev; end end)())) then
do return _local3.node:finishIdentifier(lex(_ENV).value); end
end

_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
if _bool(matchKeyword(_ENV,"function")) then
do return parseFunctionExpression(_ENV); end
end

if _bool(matchKeyword(_ENV,"this")) then
lex(_ENV);
do return _local3.node:finishThisExpression(); end
end

if _bool(matchKeyword(_ENV,"class")) then
do return parseClassExpression(_ENV); end
end

throwUnexpectedToken(_ENV,lex(_ENV));
elseif (_local3.type == _local2.Token.BooleanLiteral) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.token = lex(_ENV);
_local3.token.value = (_local3.token.value == "true");
_local3.expr = _local3.node:finishLiteral(_local3.token);
elseif (_local3.type == _local2.Token.NullLiteral) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.token = lex(_ENV);
_local3.token.value = null;
_local3.expr = _local3.node:finishLiteral(_local3.token);
elseif _bool(((function() local _lev=match(_ENV,"/"); return _bool(_lev) and _lev or match(_ENV,"/=") end)())) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local2.index = _local2.startIndex;
if (_type(_local2.extra.tokens) ~= "undefined") then
_local3.token = collectRegex(_ENV);
else
_local3.token = scanRegExp(_ENV);
end

lex(_ENV);
_local3.expr = _local3.node:finishLiteral(_local3.token);
elseif (_local3.type == _local2.Token.Template) then
_local3.expr = parseTemplateLiteral(_ENV);
else
throwUnexpectedToken(_ENV,lex(_ENV));
end

do return _local3.expr; end
end));
parseArguments =((function(this)
local _local3 = {};
_local3.args = _arr({},0);
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
while (_lt(_local2.startIndex,_local2.length)) do
if _bool(match(_ENV,"...")) then
_local3.expr = _new(Node);
lex(_ENV);
_local3.expr:finishSpreadElement(isolateCoverGrammar(_ENV,parseAssignmentExpression));
else
_local3.expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

_local3.args:push(_local3.expr);
if _bool(match(_ENV,")")) then
do break end;
end

expectCommaSeparator(_ENV);
::_continue::
end

end

expect(_ENV,")");
do return _local3.args; end
end));
parseNonComputedProperty =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3.token = lex(_ENV);
if not _bool(isIdentifierName(_ENV,_local3.token)) then
throwUnexpectedToken(_ENV,_local3.token);
end

do return _local3.node:finishIdentifier(_local3.token.value); end
end));
parseNonComputedMember =((function(this)
expect(_ENV,".");
do return parseNonComputedProperty(_ENV); end
end));
parseComputedMember =((function(this)
local _local3 = {};
expect(_ENV,"[");
_local3.expr = isolateCoverGrammar(_ENV,parseExpression);
expect(_ENV,"]");
do return _local3.expr; end
end));
parseNewExpression =((function(this)
local _local3 = {};
_local3.node = _new(Node);
expectKeyword(_ENV,"new");
if _bool(match(_ENV,".")) then
lex(_ENV);
if ((function() local _lev=(_local2.lookahead.type == _local2.Token.Identifier); if _bool(_lev) then return (_local2.lookahead.value == "target"); else return _lev; end end)()) then
if _bool(_local2.state.inFunctionBody) then
lex(_ENV);
do return _local3.node:finishMetaProperty("new","target"); end
end

end

throwUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.callee = isolateCoverGrammar(_ENV,parseLeftHandSideExpression);
_local3.args = (function() if _bool(match(_ENV,"(")) then return parseArguments(_ENV); else return _arr({},0); end end)();
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
do return _local3.node:finishNewExpression(_local3.callee,_local3.args); end
end));
parseLeftHandSideExpressionAllowCall =((function(this)
local _local3 = {};
_local3.previousAllowIn = _local2.state.allowIn;
_local3.startToken = _local2.lookahead;
_local2.state.allowIn = true;
if _bool(((function() local _lev=matchKeyword(_ENV,"super"); if _bool(_lev) then return _local2.state.inFunctionBody; else return _lev; end end)())) then
_local3.expr = _new(Node);
lex(_ENV);
_local3.expr = _local3.expr:finishSuper();
if ((function() local _lev=((function() local _lev=not _bool(match(_ENV,"(")); if _bool(_lev) then return not _bool(match(_ENV,".")); else return _lev; end end)()); if _bool(_lev) then return not _bool(match(_ENV,"[")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

else
_local3.expr = inheritCoverGrammar(_ENV,(function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression; else return parsePrimaryExpression; end end)());
end

while true do
if _bool(match(_ENV,".")) then
_local2.isBindingElement = false;
_local2.isAssignmentTarget = true;
_local3.property = parseNonComputedMember(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishMemberExpression(".",_local3.expr,_local3.property);
elseif _bool(match(_ENV,"(")) then
_local2.isBindingElement = false;
_local2.isAssignmentTarget = false;
_local3.args = parseArguments(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishCallExpression(_local3.expr,_local3.args);
elseif _bool(match(_ENV,"[")) then
_local2.isBindingElement = false;
_local2.isAssignmentTarget = true;
_local3.property = parseComputedMember(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishMemberExpression("[",_local3.expr,_local3.property);
elseif _bool(((function() local _lev=(_local2.lookahead.type == _local2.Token.Template); if _bool(_lev) then return _local2.lookahead.head; else return _lev; end end)())) then
_local3.quasi = parseTemplateLiteral(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishTaggedTemplateExpression(_local3.expr,_local3.quasi);
else
do break end;
end

end

_local2.state.allowIn = _local3.previousAllowIn;
do return _local3.expr; end
end));
parseLeftHandSideExpression =((function(this)
local _local3 = {};
assert(_ENV,_local2.state.allowIn,"callee of new expression always allow in keyword.");
_local3.startToken = _local2.lookahead;
if _bool(((function() local _lev=matchKeyword(_ENV,"super"); if _bool(_lev) then return _local2.state.inFunctionBody; else return _lev; end end)())) then
_local3.expr = _new(Node);
lex(_ENV);
_local3.expr = _local3.expr:finishSuper();
if ((function() local _lev=not _bool(match(_ENV,"[")); if _bool(_lev) then return not _bool(match(_ENV,".")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

else
_local3.expr = inheritCoverGrammar(_ENV,(function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression; else return parsePrimaryExpression; end end)());
end

while true do
if _bool(match(_ENV,"[")) then
_local2.isBindingElement = false;
_local2.isAssignmentTarget = true;
_local3.property = parseComputedMember(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishMemberExpression("[",_local3.expr,_local3.property);
elseif _bool(match(_ENV,".")) then
_local2.isBindingElement = false;
_local2.isAssignmentTarget = true;
_local3.property = parseNonComputedMember(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishMemberExpression(".",_local3.expr,_local3.property);
elseif _bool(((function() local _lev=(_local2.lookahead.type == _local2.Token.Template); if _bool(_lev) then return _local2.lookahead.head; else return _lev; end end)())) then
_local3.quasi = parseTemplateLiteral(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishTaggedTemplateExpression(_local3.expr,_local3.quasi);
else
do break end;
end

end

do return _local3.expr; end
end));
parsePostfixExpression =((function(this)
local _local3 = {};
_local3.startToken = _local2.lookahead;
_local3.expr = inheritCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
if ((function() local _lev=not _bool(_local2.hasLineTerminator); if _bool(_lev) then return (_local2.lookahead.type == _local2.Token.Punctuator); else return _lev; end end)()) then
if _bool(((function() local _lev=match(_ENV,"++"); return _bool(_lev) and _lev or match(_ENV,"--") end)())) then
if _bool(((function() local _lev=((function() if _bool(_local2.strict) then return (_local3.expr.type == _local2.Syntax.Identifier); else return _local2.strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,_local3.expr.name); else return _lev; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictLHSPostfix);
end

if not _bool(_local2.isAssignmentTarget) then
tolerateError(_ENV,_local2.Messages.InvalidLHSInAssignment);
end

_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.token = lex(_ENV);
_local3.expr = _new(WrappingNode,_local3.startToken):finishPostfixExpression(_local3.token.value,_local3.expr);
end

end

do return _local3.expr; end
end));
parseUnaryExpression =((function(this)
local _local3 = {};
if ((function() local _lev=(_local2.lookahead.type ~= _local2.Token.Punctuator); if _bool(_lev) then return (_local2.lookahead.type ~= _local2.Token.Keyword); else return _lev; end end)()) then
_local3.expr = parsePostfixExpression(_ENV);
elseif _bool(((function() local _lev=match(_ENV,"++"); return _bool(_lev) and _lev or match(_ENV,"--") end)())) then
_local3.startToken = _local2.lookahead;
_local3.token = lex(_ENV);
_local3.expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
if _bool(((function() local _lev=((function() if _bool(_local2.strict) then return (_local3.expr.type == _local2.Syntax.Identifier); else return _local2.strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,_local3.expr.name); else return _lev; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictLHSPrefix);
end

if not _bool(_local2.isAssignmentTarget) then
tolerateError(_ENV,_local2.Messages.InvalidLHSInAssignment);
end

_local3.expr = _new(WrappingNode,_local3.startToken):finishUnaryExpression(_local3.token.value,_local3.expr);
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
elseif _bool(((function() local _lev=((function() local _lev=((function() local _lev=match(_ENV,"+"); return _bool(_lev) and _lev or match(_ENV,"-") end)()); return _bool(_lev) and _lev or match(_ENV,"~") end)()); return _bool(_lev) and _lev or match(_ENV,"!") end)())) then
_local3.startToken = _local2.lookahead;
_local3.token = lex(_ENV);
_local3.expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
_local3.expr = _new(WrappingNode,_local3.startToken):finishUnaryExpression(_local3.token.value,_local3.expr);
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
elseif _bool(((function() local _lev=((function() local _lev=matchKeyword(_ENV,"delete"); return _bool(_lev) and _lev or matchKeyword(_ENV,"void") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"typeof") end)())) then
_local3.startToken = _local2.lookahead;
_local3.token = lex(_ENV);
_local3.expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
_local3.expr = _new(WrappingNode,_local3.startToken):finishUnaryExpression(_local3.token.value,_local3.expr);
if _bool(((function() local _lev=((function() if _bool(_local2.strict) then return (_local3.expr.operator == "delete"); else return _local2.strict; end end)()); if _bool(_lev) then return (_local3.expr.argument.type == _local2.Syntax.Identifier); else return _lev; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictDelete);
end

_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
else
_local3.expr = parsePostfixExpression(_ENV);
end

do return _local3.expr; end
end));
binaryPrecedence =((function(this,token,allowIn)
local _local3 = {};
_local3.prec = 0;
if ((function() local _lev=(token.type ~= _local2.Token.Punctuator); if _bool(_lev) then return (token.type ~= _local2.Token.Keyword); else return _lev; end end)()) then
do return 0; end
end

repeat
local _into = false;
local _cases = {["||"] = true,["&&"] = true,["|"] = true,["^"] = true,["&"] = true,["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,[">"] = true,["<="] = true,[">="] = true,["instanceof"] = true,["in"] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true};
local _v = token.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "||") then
_local3.prec = 1;
do break end;
_into = true;
end
if _into or (_v == "&&") then
_local3.prec = 2;
do break end;
_into = true;
end
if _into or (_v == "|") then
_local3.prec = 3;
do break end;
_into = true;
end
if _into or (_v == "^") then
_local3.prec = 4;
do break end;
_into = true;
end
if _into or (_v == "&") then
_local3.prec = 5;
do break end;
_into = true;
end
if _into or (_v == "==") then

_into = true;
end
if _into or (_v == "!=") then

_into = true;
end
if _into or (_v == "===") then

_into = true;
end
if _into or (_v == "!==") then
_local3.prec = 6;
do break end;
_into = true;
end
if _into or (_v == "<") then

_into = true;
end
if _into or (_v == ">") then

_into = true;
end
if _into or (_v == "<=") then

_into = true;
end
if _into or (_v == ">=") then

_into = true;
end
if _into or (_v == "instanceof") then
_local3.prec = 7;
do break end;
_into = true;
end
if _into or (_v == "in") then
_local3.prec = (function() if _bool(allowIn) then return 7; else return 0; end end)();
do break end;
_into = true;
end
if _into or (_v == "<<") then

_into = true;
end
if _into or (_v == ">>") then

_into = true;
end
if _into or (_v == ">>>") then
_local3.prec = 8;
do break end;
_into = true;
end
if _into or (_v == "+") then

_into = true;
end
if _into or (_v == "-") then
_local3.prec = 9;
do break end;
_into = true;
end
if _into or (_v == "*") then

_into = true;
end
if _into or (_v == "/") then

_into = true;
end
if _into or (_v == "%") then
_local3.prec = 11;
do break end;
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
do return _local3.prec; end
end));
parseBinaryExpression =((function(this)
local _local3 = {};
_local3.marker = _local2.lookahead;
_local3.left = inheritCoverGrammar(_ENV,parseUnaryExpression);
_local3.token = _local2.lookahead;
_local3.prec = binaryPrecedence(_ENV,_local3.token,_local2.state.allowIn);
if (_local3.prec == 0) then
do return _local3.left; end
end

_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.token.prec = _local3.prec;
lex(_ENV);
_local3.markers = _arr({[0]=_local3.marker,_local2.lookahead},2);
_local3.right = isolateCoverGrammar(_ENV,parseUnaryExpression);
_local3.stack = _arr({[0]=_local3.left,_local3.token,_local3.right},3);
while (_gt((function() _local3.prec = binaryPrecedence(_ENV,_local2.lookahead,_local2.state.allowIn); return _local3.prec end)(),0)) do
while ((function() local _lev=(_gt(_local3.stack.length,2)); if _bool(_lev) then return (_le(_local3.prec,_local3.stack[(_local3.stack.length - 2)].prec)); else return _lev; end end)()) do
_local3.right = _local3.stack:pop();
_local3.operator = _local3.stack:pop().value;
_local3.left = _local3.stack:pop();
_local3.markers:pop();
_local3.expr = _new(WrappingNode,_local3.markers[(_local3.markers.length - 1)]):finishBinaryExpression(_local3.operator,_local3.left,_local3.right);
_local3.stack:push(_local3.expr);
::_continue::
end

_local3.token = lex(_ENV);
_local3.token.prec = _local3.prec;
_local3.stack:push(_local3.token);
_local3.markers:push(_local2.lookahead);
_local3.expr = isolateCoverGrammar(_ENV,parseUnaryExpression);
_local3.stack:push(_local3.expr);
::_continue::
end

_local3.i = (_local3.stack.length - 1);
_local3.expr = _local3.stack[_local3.i];
_local3.markers:pop();
while (_gt(_local3.i,1)) do
_local3.expr = _new(WrappingNode,_local3.markers:pop()):finishBinaryExpression(_local3.stack[(_local3.i - 1)].value,_local3.stack[(_local3.i - 2)],_local3.expr);
_local3.i = (_local3.i - 2);
::_continue::
end

do return _local3.expr; end
end));
parseConditionalExpression =((function(this)
local _local3 = {};
_local3.startToken = _local2.lookahead;
_local3.expr = inheritCoverGrammar(_ENV,parseBinaryExpression);
if _bool(match(_ENV,"?")) then
lex(_ENV);
_local3.previousAllowIn = _local2.state.allowIn;
_local2.state.allowIn = true;
_local3.consequent = isolateCoverGrammar(_ENV,parseAssignmentExpression);
_local2.state.allowIn = _local3.previousAllowIn;
expect(_ENV,":");
_local3.alternate = isolateCoverGrammar(_ENV,parseAssignmentExpression);
_local3.expr = _new(WrappingNode,_local3.startToken):finishConditionalExpression(_local3.expr,_local3.consequent,_local3.alternate);
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
end

do return _local3.expr; end
end));
parseConciseBody =((function(this)
if _bool(match(_ENV,"{")) then
do return parseFunctionSourceElements(_ENV); end
end

do return isolateCoverGrammar(_ENV,parseAssignmentExpression); end
end));
checkPatternParam =((function(this,options,param)
local _local3 = {};
repeat
local _into = false;
local _cases = {[_local2.Syntax.Identifier] = true,[_local2.Syntax.RestElement] = true,[_local2.Syntax.AssignmentPattern] = true,[_local2.Syntax.ArrayPattern] = true,[_local2.Syntax.YieldExpression] = true};
local _v = param.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Syntax.Identifier) then
validateParam(_ENV,options,param,param.name);
do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.RestElement) then
checkPatternParam(_ENV,options,param.argument);
do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.AssignmentPattern) then
checkPatternParam(_ENV,options,param.left);
do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.ArrayPattern) then
_local3.i = 0;
while (_lt(_local3.i,param.elements.length)) do
if (param.elements[_local3.i] ~= null) then
checkPatternParam(_ENV,options,param.elements[_local3.i]);
end

_local3.i = _inc(_local3.i);
end

do break end;
_into = true;
end
if _into or (_v == _local2.Syntax.YieldExpression) then
do break end;
_into = true;
end
::_default::
if _into then
assert(_ENV,(param.type == _local2.Syntax.ObjectPattern),"Invalid type");
_local3.i = 0;
while (_lt(_local3.i,param.properties.length)) do
checkPatternParam(_ENV,options,param.properties[_local3.i].value);
_local3.i = _inc(_local3.i);
end

do break end;
_into = true;
end
until true
end));
reinterpretAsCoverFormalsList =((function(this,expr)
local _local3 = {};
_local3.defaults = _arr({},0);
_local3.defaultCount = 0;
_local3.params = _arr({[0]=expr},1);
repeat
local _into = false;
local _cases = {[_local2.Syntax.Identifier] = true,[_local2.PlaceHolders.ArrowParameterPlaceHolder] = true};
local _v = expr.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Syntax.Identifier) then
do break end;
_into = true;
end
if _into or (_v == _local2.PlaceHolders.ArrowParameterPlaceHolder) then
_local3.params = expr.params;
do break end;
_into = true;
end
::_default::
if _into then
do return null; end
_into = true;
end
until true
_local3.options = _obj({
["paramSet"] = _obj({})
});
_seq({(function() _local3.i = 0; return _local3.i end)(),(function() _local3.len = _local3.params.length; return _local3.len end)()});
while (_lt(_local3.i,_local3.len)) do
_local3.param = _local3.params[_local3.i];
repeat
local _into = false;
local _cases = {[_local2.Syntax.AssignmentPattern] = true};
local _v = _local3.param.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == _local2.Syntax.AssignmentPattern) then
_local3.params[_local3.i] = _local3.param.left;
if (_local3.param.right.type == _local2.Syntax.YieldExpression) then
if _bool(_local3.param.right.argument) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.param.right.type = _local2.Syntax.Identifier;
_local3.param.right.name = "yield";
(function () local _r = false; local _g, _s = _local3.param.right["_g" .. "argument"], _local3.param.right["_s" .. "argument"]; _local3.param.right["_g" .. "argument"], _local3.param.right["_s" .. "argument"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.param.right.argument; _local3.param.right.argument = nil; return _r or _v ~= nil; end)();
(function () local _r = false; local _g, _s = _local3.param.right["_g" .. "delegate"], _local3.param.right["_s" .. "delegate"]; _local3.param.right["_g" .. "delegate"], _local3.param.right["_s" .. "delegate"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.param.right.delegate; _local3.param.right.delegate = nil; return _r or _v ~= nil; end)();
end

_local3.defaults:push(_local3.param.right);
_local3.defaultCount = _inc(_local3.defaultCount);
checkPatternParam(_ENV,_local3.options,_local3.param.left);
do break end;
_into = true;
end
::_default::
if _into then
checkPatternParam(_ENV,_local3.options,_local3.param);
_local3.params[_local3.i] = _local3.param;
_local3.defaults:push(null);
do break end;
_into = true;
end
until true
_local3.i = (_addNum2(_local3.i,1));
end

if _bool((_bool(_local2.strict) and _local2.strict or not _bool(_local2.state.allowYield))) then
_seq({(function() _local3.i = 0; return _local3.i end)(),(function() _local3.len = _local3.params.length; return _local3.len end)()});
while (_lt(_local3.i,_local3.len)) do
_local3.param = _local3.params[_local3.i];
if (_local3.param.type == _local2.Syntax.YieldExpression) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.i = (_addNum2(_local3.i,1));
end

end

if (_local3.options.message == _local2.Messages.StrictParamDupe) then
_local3.token = (function() if _bool(_local2.strict) then return _local3.options.stricted; else return _local3.options.firstRestricted; end end)();
throwUnexpectedToken(_ENV,_local3.token,_local3.options.message);
end

if (_local3.defaultCount == 0) then
_local3.defaults = _arr({},0);
end

do return _obj({
["params"] = _local3.params,
["defaults"] = _local3.defaults,
["stricted"] = _local3.options.stricted,
["firstRestricted"] = _local3.options.firstRestricted,
["message"] = _local3.options.message
}); end
end));
parseArrowFunctionExpression =((function(this,options,node)
local _local3 = {};
if _bool(_local2.hasLineTerminator) then
tolerateUnexpectedToken(_ENV,_local2.lookahead);
end

expect(_ENV,"=>");
_local3.previousStrict = _local2.strict;
_local3.previousAllowYield = _local2.state.allowYield;
_local2.state.allowYield = true;
_local3.body = parseConciseBody(_ENV);
if _bool(((function() if _bool(_local2.strict) then return options.firstRestricted; else return _local2.strict; end end)())) then
throwUnexpectedToken(_ENV,options.firstRestricted,options.message);
end

if _bool(((function() if _bool(_local2.strict) then return options.stricted; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,options.stricted,options.message);
end

_local2.strict = _local3.previousStrict;
_local2.state.allowYield = _local3.previousAllowYield;
do return node:finishArrowFunctionExpression(options.params,options.defaults,_local3.body,(_local3.body.type ~= _local2.Syntax.BlockStatement)); end
end));
parseYieldExpression =((function(this)
local _local3 = {};
_local3.argument = null;
_local3.expr = _new(Node);
_local3.delegate = false;
expectKeyword(_ENV,"yield");
if not _bool(_local2.hasLineTerminator) then
_local3.previousAllowYield = _local2.state.allowYield;
_local2.state.allowYield = false;
_local3.delegate = match(_ENV,"*");
if _bool(_local3.delegate) then
lex(_ENV);
_local3.argument = parseAssignmentExpression(_ENV);
else
if ((function() local _lev=((function() local _lev=((function() local _lev=not _bool(match(_ENV,";")); if _bool(_lev) then return not _bool(match(_ENV,"}")); else return _lev; end end)()); if _bool(_lev) then return not _bool(match(_ENV,")")); else return _lev; end end)()); if _bool(_lev) then return (_local2.lookahead.type ~= _local2.Token.EOF); else return _lev; end end)()) then
_local3.argument = parseAssignmentExpression(_ENV);
end

end

_local2.state.allowYield = _local3.previousAllowYield;
end

do return _local3.expr:finishYieldExpression(_local3.argument,_local3.delegate); end
end));
parseAssignmentExpression =((function(this)
local _local3 = {};
_local3.startToken = _local2.lookahead;
_local3.token = _local2.lookahead;
if _bool(((function() local _lev=not _bool(_local2.state.allowYield); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then
do return parseYieldExpression(_ENV); end
end

_local3.expr = parseConditionalExpression(_ENV);
if _bool(((function() local _lev=(_local3.expr.type == _local2.PlaceHolders.ArrowParameterPlaceHolder); return _bool(_lev) and _lev or match(_ENV,"=>") end)())) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
_local3.list = reinterpretAsCoverFormalsList(_ENV,_local3.expr);
if _bool(_local3.list) then
_local2.firstCoverInitializedNameError = null;
do return parseArrowFunctionExpression(_ENV,_local3.list,_new(WrappingNode,_local3.startToken)); end
end

do return _local3.expr; end
end

if _bool(matchAssign(_ENV)) then
if not _bool(_local2.isAssignmentTarget) then
tolerateError(_ENV,_local2.Messages.InvalidLHSInAssignment);
end

if _bool(((function() if _bool(_local2.strict) then return (_local3.expr.type == _local2.Syntax.Identifier); else return _local2.strict; end end)())) then
if _bool(isRestrictedWord(_ENV,_local3.expr.name)) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictLHSAssignment);
end

if _bool(isStrictModeReservedWord(_ENV,_local3.expr.name)) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictReservedWord);
end

end

if not _bool(match(_ENV,"=")) then
_local2.isAssignmentTarget = (function() _local2.isBindingElement = false; return _local2.isBindingElement end)();
else
reinterpretExpressionAsPattern(_ENV,_local3.expr);
end

_local3.token = lex(_ENV);
_local3.right = isolateCoverGrammar(_ENV,parseAssignmentExpression);
_local3.expr = _new(WrappingNode,_local3.startToken):finishAssignmentExpression(_local3.token.value,_local3.expr,_local3.right);
_local2.firstCoverInitializedNameError = null;
end

do return _local3.expr; end
end));
parseExpression =((function(this)
local _local3 = {};
_local3.startToken = _local2.lookahead;
_local3.expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
if _bool(match(_ENV,",")) then
_local3.expressions = _arr({[0]=_local3.expr},1);
while (_lt(_local2.startIndex,_local2.length)) do
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
_local3.expressions:push(isolateCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

_local3.expr = _new(WrappingNode,_local3.startToken):finishSequenceExpression(_local3.expressions);
end

do return _local3.expr; end
end));
parseStatementListItem =((function(this)
if (_local2.lookahead.type == _local2.Token.Keyword) then
repeat
local _into = false;
local _cases = {["export"] = true,["import"] = true,["const"] = true,["function"] = true,["class"] = true};
local _v = _local2.lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "export") then
if (_local2.state.sourceType ~= "module") then
tolerateUnexpectedToken(_ENV,_local2.lookahead,_local2.Messages.IllegalExportDeclaration);
end

do return parseExportDeclaration(_ENV); end
_into = true;
end
if _into or (_v == "import") then
if (_local2.state.sourceType ~= "module") then
tolerateUnexpectedToken(_ENV,_local2.lookahead,_local2.Messages.IllegalImportDeclaration);
end

do return parseImportDeclaration(_ENV); end
_into = true;
end
if _into or (_v == "const") then
do return parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
})); end
_into = true;
end
if _into or (_v == "function") then
do return parseFunctionDeclaration(_ENV,_new(Node)); end
_into = true;
end
if _into or (_v == "class") then
do return parseClassDeclaration(_ENV); end
_into = true;
end
::_default::
until true
end

if _bool(((function() local _lev=matchKeyword(_ENV,"let"); if _bool(_lev) then return isLexicalDeclaration(_ENV); else return _lev; end end)())) then
do return parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
})); end
end

do return parseStatement(_ENV); end
end));
parseStatementList =((function(this)
local _local3 = {};
_local3.list = _arr({},0);
while (_lt(_local2.startIndex,_local2.length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

_local3.list:push(parseStatementListItem(_ENV));
::_continue::
end

do return _local3.list; end
end));
parseBlock =((function(this)
local _local3 = {};
_local3.node = _new(Node);
expect(_ENV,"{");
_local3.block = parseStatementList(_ENV);
expect(_ENV,"}");
do return _local3.node:finishBlockStatement(_local3.block); end
end));
parseVariableIdentifier =((function(this,kind)
local _local3 = {};
_local3.node = _new(Node);
_local3.token = lex(_ENV);
if ((function() local _lev=(_local3.token.type == _local2.Token.Keyword); if _bool(_lev) then return (_local3.token.value == "yield"); else return _lev; end end)()) then
if _bool(_local2.strict) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictReservedWord);
end

if not _bool(_local2.state.allowYield) then
throwUnexpectedToken(_ENV,_local3.token);
end

elseif (_local3.token.type ~= _local2.Token.Identifier) then
if _bool(((function() local _lev=((function() if _bool(_local2.strict) then return (_local3.token.type == _local2.Token.Keyword); else return _local2.strict; end end)()); if _bool(_lev) then return isStrictModeReservedWord(_ENV,_local3.token.value); else return _lev; end end)())) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictReservedWord);
else
if _bool(((function() local _lev=(_bool(_local2.strict) and _local2.strict or (_local3.token.value ~= "let")); return _bool(_lev) and _lev or (kind ~= "var") end)())) then
throwUnexpectedToken(_ENV,_local3.token);
end

end

elseif ((function() local _lev=((function() local _lev=(_local2.state.sourceType == "module"); if _bool(_lev) then return (_local3.token.type == _local2.Token.Identifier); else return _lev; end end)()); if _bool(_lev) then return (_local3.token.value == "await"); else return _lev; end end)()) then
tolerateUnexpectedToken(_ENV,_local3.token);
end

do return _local3.node:finishIdentifier(_local3.token.value); end
end));
parseVariableDeclaration =((function(this,options)
local _local3 = {};
_local3.init = null;
_local3.node = _new(Node);
_local3.params = _arr({},0);
_local3.id = parsePattern(_ENV,_local3.params,"var");
if _bool(((function() if _bool(_local2.strict) then return isRestrictedWord(_ENV,_local3.id.name); else return _local2.strict; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictVarName);
end

if _bool(match(_ENV,"=")) then
lex(_ENV);
_local3.init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
elseif ((function() local _lev=(_local3.id.type ~= _local2.Syntax.Identifier); if _bool(_lev) then return not _bool(options.inFor); else return _lev; end end)()) then
expect(_ENV,"=");
end

do return _local3.node:finishVariableDeclarator(_local3.id,_local3.init); end
end));
parseVariableDeclarationList =((function(this,options)
local _local3 = {};
_local3.opt = _obj({
["inFor"] = options.inFor
});
_local3.list = _arr({[0]=parseVariableDeclaration(_ENV,_local3.opt)},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
_local3.list:push(parseVariableDeclaration(_ENV,_local3.opt));
::_continue::
end

do return _local3.list; end
end));
parseVariableStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"var");
_local3.declarations = parseVariableDeclarationList(_ENV,_obj({
["inFor"] = false
}));
consumeSemicolon(_ENV);
do return node:finishVariableDeclaration(_local3.declarations); end
end));
parseLexicalBinding =((function(this,kind,options)
local _local3 = {};
_local3.init = null;
_local3.node = _new(Node);
_local3.params = _arr({},0);
_local3.id = parsePattern(_ENV,_local3.params,kind);
if _bool(((function() local _lev=((function() if _bool(_local2.strict) then return (_local3.id.type == _local2.Syntax.Identifier); else return _local2.strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,_local3.id.name); else return _lev; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictVarName);
end

if (kind == "const") then
if ((function() local _lev=not _bool(matchKeyword(_ENV,"in")); if _bool(_lev) then return not _bool(matchContextualKeyword(_ENV,"of")); else return _lev; end end)()) then
expect(_ENV,"=");
_local3.init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

elseif _bool(((function() local _lev=((function() local _lev=not _bool(options.inFor); if _bool(_lev) then return (_local3.id.type ~= _local2.Syntax.Identifier); else return _lev; end end)()); return _bool(_lev) and _lev or match(_ENV,"=") end)())) then
expect(_ENV,"=");
_local3.init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

do return _local3.node:finishVariableDeclarator(_local3.id,_local3.init); end
end));
parseBindingList =((function(this,kind,options)
local _local3 = {};
_local3.list = _arr({[0]=parseLexicalBinding(_ENV,kind,options)},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
_local3.list:push(parseLexicalBinding(_ENV,kind,options));
::_continue::
end

do return _local3.list; end
end));
tokenizerState =((function(this)
do return _obj({
["index"] = _local2.index,
["lineNumber"] = _local2.lineNumber,
["lineStart"] = _local2.lineStart,
["hasLineTerminator"] = _local2.hasLineTerminator,
["lastIndex"] = _local2.lastIndex,
["lastLineNumber"] = _local2.lastLineNumber,
["lastLineStart"] = _local2.lastLineStart,
["startIndex"] = _local2.startIndex,
["startLineNumber"] = _local2.startLineNumber,
["startLineStart"] = _local2.startLineStart,
["lookahead"] = _local2.lookahead,
["tokenCount"] = (function() if _bool(_local2.extra.tokens) then return _local2.extra.tokens.length; else return 0; end end)()
}); end
end));
resetTokenizerState =((function(this,ts)
_local2.index = ts.index;
_local2.lineNumber = ts.lineNumber;
_local2.lineStart = ts.lineStart;
_local2.hasLineTerminator = ts.hasLineTerminator;
_local2.lastIndex = ts.lastIndex;
_local2.lastLineNumber = ts.lastLineNumber;
_local2.lastLineStart = ts.lastLineStart;
_local2.startIndex = ts.startIndex;
_local2.startLineNumber = ts.startLineNumber;
_local2.startLineStart = ts.startLineStart;
_local2.lookahead = ts.lookahead;
if _bool(_local2.extra.tokens) then
_local2.extra.tokens:splice(ts.tokenCount,_local2.extra.tokens.length);
end

end));
isLexicalDeclaration =((function(this)
local _local3 = {};
_local3.ts = tokenizerState(_ENV);
lex(_ENV);
_local3.lexical = ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(_local2.lookahead.type == _local2.Token.Identifier); return _bool(_lev) and _lev or match(_ENV,"[") end)()); return _bool(_lev) and _lev or match(_ENV,"{") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"let") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"yield") end)());
resetTokenizerState(_ENV,_local3.ts);
do return _local3.lexical; end
end));
parseLexicalDeclaration =((function(this,options)
local _local3 = {};
_local3.node = _new(Node);
_local3.kind = lex(_ENV).value;
assert(_ENV,((function() local _lev=(_local3.kind == "let"); return _bool(_lev) and _lev or (_local3.kind == "const") end)()),"Lexical declaration must be either let or const");
_local3.declarations = parseBindingList(_ENV,_local3.kind,options);
consumeSemicolon(_ENV);
do return _local3.node:finishLexicalDeclaration(_local3.declarations,_local3.kind); end
end));
parseRestElement =((function(this,params)
local _local3 = {};
_local3.node = _new(Node);
lex(_ENV);
if _bool(match(_ENV,"{")) then
throwError(_ENV,_local2.Messages.ObjectPatternAsRestParameter);
end

params:push(_local2.lookahead);
_local3.param = parseVariableIdentifier(_ENV);
if _bool(match(_ENV,"=")) then
throwError(_ENV,_local2.Messages.DefaultRestParameter);
end

if not _bool(match(_ENV,")")) then
throwError(_ENV,_local2.Messages.ParameterAfterRestParameter);
end

do return _local3.node:finishRestElement(_local3.param); end
end));
parseEmptyStatement =((function(this,node)
expect(_ENV,";");
do return node:finishEmptyStatement(); end
end));
parseExpressionStatement =((function(this,node)
local _local3 = {};
_local3.expr = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishExpressionStatement(_local3.expr); end
end));
parseIfStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"if");
expect(_ENV,"(");
_local3.test = parseExpression(_ENV);
expect(_ENV,")");
_local3.consequent = parseStatement(_ENV);
if _bool(matchKeyword(_ENV,"else")) then
lex(_ENV);
_local3.alternate = parseStatement(_ENV);
else
_local3.alternate = null;
end

do return node:finishIfStatement(_local3.test,_local3.consequent,_local3.alternate); end
end));
parseDoWhileStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"do");
_local3.oldInIteration = _local2.state.inIteration;
_local2.state.inIteration = true;
_local3.body = parseStatement(_ENV);
_local2.state.inIteration = _local3.oldInIteration;
expectKeyword(_ENV,"while");
expect(_ENV,"(");
_local3.test = parseExpression(_ENV);
expect(_ENV,")");
if _bool(match(_ENV,";")) then
lex(_ENV);
end

do return node:finishDoWhileStatement(_local3.body,_local3.test); end
end));
parseWhileStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"while");
expect(_ENV,"(");
_local3.test = parseExpression(_ENV);
expect(_ENV,")");
_local3.oldInIteration = _local2.state.inIteration;
_local2.state.inIteration = true;
_local3.body = parseStatement(_ENV);
_local2.state.inIteration = _local3.oldInIteration;
do return node:finishWhileStatement(_local3.test,_local3.body); end
end));
parseForStatement =((function(this,node)
local _local3 = {};
_local3.previousAllowIn = _local2.state.allowIn;
_local3.init = (function() _local3.test = (function() _local3.update = null; return _local3.update end)(); return _local3.test end)();
_local3.forIn = true;
expectKeyword(_ENV,"for");
expect(_ENV,"(");
if _bool(match(_ENV,";")) then
lex(_ENV);
else
if _bool(matchKeyword(_ENV,"var")) then
_local3.init = _new(Node);
lex(_ENV);
_local2.state.allowIn = false;
_local3.declarations = parseVariableDeclarationList(_ENV,_obj({
["inFor"] = true
}));
_local2.state.allowIn = _local3.previousAllowIn;
if _bool(((function() local _lev=(_local3.declarations.length == 1); if _bool(_lev) then return matchKeyword(_ENV,"in"); else return _lev; end end)())) then
_local3.init = _local3.init:finishVariableDeclaration(_local3.declarations);
lex(_ENV);
_local3.left = _local3.init;
_local3.right = parseExpression(_ENV);
_local3.init = null;
elseif _bool(((function() local _lev=((function() local _lev=(_local3.declarations.length == 1); if _bool(_lev) then return (_local3.declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchContextualKeyword(_ENV,"of"); else return _lev; end end)())) then
_local3.init = _local3.init:finishVariableDeclaration(_local3.declarations);
lex(_ENV);
_local3.left = _local3.init;
_local3.right = parseAssignmentExpression(_ENV);
_local3.init = null;
_local3.forIn = false;
else
_local3.init = _local3.init:finishVariableDeclaration(_local3.declarations);
expect(_ENV,";");
end

elseif _bool(((function() local _lev=matchKeyword(_ENV,"const"); return _bool(_lev) and _lev or matchKeyword(_ENV,"let") end)())) then
_local3.init = _new(Node);
_local3.kind = lex(_ENV).value;
if ((function() local _lev=not _bool(_local2.strict); if _bool(_lev) then return (_local2.lookahead.value == "in"); else return _lev; end end)()) then
_local3.init = _local3.init:finishIdentifier(_local3.kind);
lex(_ENV);
_local3.left = _local3.init;
_local3.right = parseExpression(_ENV);
_local3.init = null;
else
_local2.state.allowIn = false;
_local3.declarations = parseBindingList(_ENV,_local3.kind,_obj({
["inFor"] = true
}));
_local2.state.allowIn = _local3.previousAllowIn;
if _bool(((function() local _lev=((function() local _lev=(_local3.declarations.length == 1); if _bool(_lev) then return (_local3.declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"in"); else return _lev; end end)())) then
_local3.init = _local3.init:finishLexicalDeclaration(_local3.declarations,_local3.kind);
lex(_ENV);
_local3.left = _local3.init;
_local3.right = parseExpression(_ENV);
_local3.init = null;
elseif _bool(((function() local _lev=((function() local _lev=(_local3.declarations.length == 1); if _bool(_lev) then return (_local3.declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchContextualKeyword(_ENV,"of"); else return _lev; end end)())) then
_local3.init = _local3.init:finishLexicalDeclaration(_local3.declarations,_local3.kind);
lex(_ENV);
_local3.left = _local3.init;
_local3.right = parseAssignmentExpression(_ENV);
_local3.init = null;
_local3.forIn = false;
else
consumeSemicolon(_ENV);
_local3.init = _local3.init:finishLexicalDeclaration(_local3.declarations,_local3.kind);
end

end

else
_local3.initStartToken = _local2.lookahead;
_local2.state.allowIn = false;
_local3.init = inheritCoverGrammar(_ENV,parseAssignmentExpression);
_local2.state.allowIn = _local3.previousAllowIn;
if _bool(matchKeyword(_ENV,"in")) then
if not _bool(_local2.isAssignmentTarget) then
tolerateError(_ENV,_local2.Messages.InvalidLHSInForIn);
end

lex(_ENV);
reinterpretExpressionAsPattern(_ENV,_local3.init);
_local3.left = _local3.init;
_local3.right = parseExpression(_ENV);
_local3.init = null;
elseif _bool(matchContextualKeyword(_ENV,"of")) then
if not _bool(_local2.isAssignmentTarget) then
tolerateError(_ENV,_local2.Messages.InvalidLHSInForLoop);
end

lex(_ENV);
reinterpretExpressionAsPattern(_ENV,_local3.init);
_local3.left = _local3.init;
_local3.right = parseAssignmentExpression(_ENV);
_local3.init = null;
_local3.forIn = false;
else
if _bool(match(_ENV,",")) then
_local3.initSeq = _arr({[0]=_local3.init},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
_local3.initSeq:push(isolateCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

_local3.init = _new(WrappingNode,_local3.initStartToken):finishSequenceExpression(_local3.initSeq);
end

expect(_ENV,";");
end

end

end

if (_type(_local3.left) == "undefined") then
if not _bool(match(_ENV,";")) then
_local3.test = parseExpression(_ENV);
end

expect(_ENV,";");
if not _bool(match(_ENV,")")) then
_local3.update = parseExpression(_ENV);
end

end

expect(_ENV,")");
_local3.oldInIteration = _local2.state.inIteration;
_local2.state.inIteration = true;
_local3.body = isolateCoverGrammar(_ENV,parseStatement);
_local2.state.inIteration = _local3.oldInIteration;
do return (function() if (_type(_local3.left) == "undefined") then return node:finishForStatement(_local3.init,_local3.test,_local3.update,_local3.body); else return (function() if _bool(_local3.forIn) then return node:finishForInStatement(_local3.left,_local3.right,_local3.body); else return node:finishForOfStatement(_local3.left,_local3.right,_local3.body); end end)(); end end)(); end
end));
parseContinueStatement =((function(this,node)
local _local3 = {};
_local3.label = null;
expectKeyword(_ENV,"continue");
if (_local2.source:charCodeAt(_local2.startIndex) == 59) then
lex(_ENV);
if not _bool(_local2.state.inIteration) then
throwError(_ENV,_local2.Messages.IllegalContinue);
end

do return node:finishContinueStatement(null); end
end

if _bool(_local2.hasLineTerminator) then
if not _bool(_local2.state.inIteration) then
throwError(_ENV,_local2.Messages.IllegalContinue);
end

do return node:finishContinueStatement(null); end
end

if (_local2.lookahead.type == _local2.Token.Identifier) then
_local3.label = parseVariableIdentifier(_ENV);
_local3.key = (_addStr1("$",_local3.label.name));
if not _bool(Object.prototype.hasOwnProperty:call(_local2.state.labelSet,_local3.key)) then
throwError(_ENV,_local2.Messages.UnknownLabel,_local3.label.name);
end

end

consumeSemicolon(_ENV);
if ((function() local _lev=(_local3.label == null); if _bool(_lev) then return not _bool(_local2.state.inIteration); else return _lev; end end)()) then
throwError(_ENV,_local2.Messages.IllegalContinue);
end

do return node:finishContinueStatement(_local3.label); end
end));
parseBreakStatement =((function(this,node)
local _local3 = {};
_local3.label = null;
expectKeyword(_ENV,"break");
if (_local2.source:charCodeAt(_local2.lastIndex) == 59) then
lex(_ENV);
if not _bool(((function() local _lev=_local2.state.inIteration; return _bool(_lev) and _lev or _local2.state.inSwitch end)())) then
throwError(_ENV,_local2.Messages.IllegalBreak);
end

do return node:finishBreakStatement(null); end
end

if _bool(_local2.hasLineTerminator) then
if not _bool(((function() local _lev=_local2.state.inIteration; return _bool(_lev) and _lev or _local2.state.inSwitch end)())) then
throwError(_ENV,_local2.Messages.IllegalBreak);
end

elseif (_local2.lookahead.type == _local2.Token.Identifier) then
_local3.label = parseVariableIdentifier(_ENV);
_local3.key = (_addStr1("$",_local3.label.name));
if not _bool(Object.prototype.hasOwnProperty:call(_local2.state.labelSet,_local3.key)) then
throwError(_ENV,_local2.Messages.UnknownLabel,_local3.label.name);
end

end

consumeSemicolon(_ENV);
if ((function() local _lev=(_local3.label == null); if _bool(_lev) then return not _bool(((function() local _lev=_local2.state.inIteration; return _bool(_lev) and _lev or _local2.state.inSwitch end)())); else return _lev; end end)()) then
throwError(_ENV,_local2.Messages.IllegalBreak);
end

do return node:finishBreakStatement(_local3.label); end
end));
parseReturnStatement =((function(this,node)
local _local3 = {};
_local3.argument = null;
expectKeyword(_ENV,"return");
if not _bool(_local2.state.inFunctionBody) then
tolerateError(_ENV,_local2.Messages.IllegalReturn);
end

if (_local2.source:charCodeAt(_local2.lastIndex) == 32) then
if _bool(isIdentifierStart(_ENV,_local2.source:charCodeAt((_addNum2(_local2.lastIndex,1))))) then
_local3.argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishReturnStatement(_local3.argument); end
end

end

if _bool(_local2.hasLineTerminator) then
do return node:finishReturnStatement(null); end
end

if not _bool(match(_ENV,";")) then
if ((function() local _lev=not _bool(match(_ENV,"}")); if _bool(_lev) then return (_local2.lookahead.type ~= _local2.Token.EOF); else return _lev; end end)()) then
_local3.argument = parseExpression(_ENV);
end

end

consumeSemicolon(_ENV);
do return node:finishReturnStatement(_local3.argument); end
end));
parseWithStatement =((function(this,node)
local _local3 = {};
if _bool(_local2.strict) then
tolerateError(_ENV,_local2.Messages.StrictModeWith);
end

expectKeyword(_ENV,"with");
expect(_ENV,"(");
_local3.object = parseExpression(_ENV);
expect(_ENV,")");
_local3.body = parseStatement(_ENV);
do return node:finishWithStatement(_local3.object,_local3.body); end
end));
parseSwitchCase =((function(this)
local _local3 = {};
_local3.consequent = _arr({},0);
_local3.node = _new(Node);
if _bool(matchKeyword(_ENV,"default")) then
lex(_ENV);
_local3.test = null;
else
expectKeyword(_ENV,"case");
_local3.test = parseExpression(_ENV);
end

expect(_ENV,":");
while (_lt(_local2.startIndex,_local2.length)) do
if _bool(((function() local _lev=((function() local _lev=match(_ENV,"}"); return _bool(_lev) and _lev or matchKeyword(_ENV,"default") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"case") end)())) then
do break end;
end

_local3.statement = parseStatementListItem(_ENV);
_local3.consequent:push(_local3.statement);
::_continue::
end

do return _local3.node:finishSwitchCase(_local3.test,_local3.consequent); end
end));
parseSwitchStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"switch");
expect(_ENV,"(");
_local3.discriminant = parseExpression(_ENV);
expect(_ENV,")");
expect(_ENV,"{");
_local3.cases = _arr({},0);
if _bool(match(_ENV,"}")) then
lex(_ENV);
do return node:finishSwitchStatement(_local3.discriminant,_local3.cases); end
end

_local3.oldInSwitch = _local2.state.inSwitch;
_local2.state.inSwitch = true;
_local3.defaultFound = false;
while (_lt(_local2.startIndex,_local2.length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

_local3.clause = parseSwitchCase(_ENV);
if (_local3.clause.test == null) then
if _bool(_local3.defaultFound) then
throwError(_ENV,_local2.Messages.MultipleDefaultsInSwitch);
end

_local3.defaultFound = true;
end

_local3.cases:push(_local3.clause);
::_continue::
end

_local2.state.inSwitch = _local3.oldInSwitch;
expect(_ENV,"}");
do return node:finishSwitchStatement(_local3.discriminant,_local3.cases); end
end));
parseThrowStatement =((function(this,node)
local _local3 = {};
expectKeyword(_ENV,"throw");
if _bool(_local2.hasLineTerminator) then
throwError(_ENV,_local2.Messages.NewlineAfterThrow);
end

_local3.argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishThrowStatement(_local3.argument); end
end));
parseCatchClause =((function(this)
local _local3 = {};
_local3.params = _arr({},0);
_local3.paramMap = _obj({});
_local3.node = _new(Node);
expectKeyword(_ENV,"catch");
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

_local3.param = parsePattern(_ENV,_local3.params);
_local3.i = 0;
while (_lt(_local3.i,_local3.params.length)) do
_local3.key = (_addStr1("$",_local3.params[_local3.i].value));
if _bool(Object.prototype.hasOwnProperty:call(_local3.paramMap,_local3.key)) then
tolerateError(_ENV,_local2.Messages.DuplicateBinding,_local3.params[_local3.i].value);
end

_local3.paramMap[_local3.key] = true;
_local3.i = _inc(_local3.i);
end

if _bool(((function() if _bool(_local2.strict) then return isRestrictedWord(_ENV,_local3.param.name); else return _local2.strict; end end)())) then
tolerateError(_ENV,_local2.Messages.StrictCatchVariable);
end

expect(_ENV,")");
_local3.body = parseBlock(_ENV);
do return _local3.node:finishCatchClause(_local3.param,_local3.body); end
end));
parseTryStatement =((function(this,node)
local _local3 = {};
_local3.handler = null;
_local3.finalizer = null;
expectKeyword(_ENV,"try");
_local3.block = parseBlock(_ENV);
if _bool(matchKeyword(_ENV,"catch")) then
_local3.handler = parseCatchClause(_ENV);
end

if _bool(matchKeyword(_ENV,"finally")) then
lex(_ENV);
_local3.finalizer = parseBlock(_ENV);
end

if ((function() local _lev=not _bool(_local3.handler); if _bool(_lev) then return not _bool(_local3.finalizer); else return _lev; end end)()) then
throwError(_ENV,_local2.Messages.NoCatchOrFinally);
end

do return node:finishTryStatement(_local3.block,_local3.handler,_local3.finalizer); end
end));
parseDebuggerStatement =((function(this,node)
expectKeyword(_ENV,"debugger");
consumeSemicolon(_ENV);
do return node:finishDebuggerStatement(); end
end));
parseStatement =((function(this)
local _local3 = {};
_local3.type = _local2.lookahead.type;
if (_local3.type == _local2.Token.EOF) then
throwUnexpectedToken(_ENV,_local2.lookahead);
end

if ((function() local _lev=(_local3.type == _local2.Token.Punctuator); if _bool(_lev) then return (_local2.lookahead.value == "{"); else return _lev; end end)()) then
do return parseBlock(_ENV); end
end

_local2.isAssignmentTarget = (function() _local2.isBindingElement = true; return _local2.isBindingElement end)();
_local3.node = _new(Node);
if (_local3.type == _local2.Token.Punctuator) then
repeat
local _into = false;
local _cases = {[";"] = true,["("] = true};
local _v = _local2.lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == ";") then
do return parseEmptyStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "(") then
do return parseExpressionStatement(_ENV,_local3.node); end
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
elseif (_local3.type == _local2.Token.Keyword) then
repeat
local _into = false;
local _cases = {["break"] = true,["continue"] = true,["debugger"] = true,["do"] = true,["for"] = true,["function"] = true,["if"] = true,["return"] = true,["switch"] = true,["throw"] = true,["try"] = true,["var"] = true,["while"] = true,["with"] = true};
local _v = _local2.lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "break") then
do return parseBreakStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "continue") then
do return parseContinueStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "debugger") then
do return parseDebuggerStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "do") then
do return parseDoWhileStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "for") then
do return parseForStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "function") then
do return parseFunctionDeclaration(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "if") then
do return parseIfStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "return") then
do return parseReturnStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "switch") then
do return parseSwitchStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "throw") then
do return parseThrowStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "try") then
do return parseTryStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "var") then
do return parseVariableStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "while") then
do return parseWhileStatement(_ENV,_local3.node); end
_into = true;
end
if _into or (_v == "with") then
do return parseWithStatement(_ENV,_local3.node); end
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
end

_local3.expr = parseExpression(_ENV);
if _bool(((function() local _lev=(_local3.expr.type == _local2.Syntax.Identifier); if _bool(_lev) then return match(_ENV,":"); else return _lev; end end)())) then
lex(_ENV);
_local3.key = (_addStr1("$",_local3.expr.name));
if _bool(Object.prototype.hasOwnProperty:call(_local2.state.labelSet,_local3.key)) then
throwError(_ENV,_local2.Messages.Redeclaration,"Label",_local3.expr.name);
end

_local2.state.labelSet[_local3.key] = true;
_local3.labeledBody = parseStatement(_ENV);
(function () local _r = false; local _g, _s = _local2.state.labelSet["_g" .. _local3.key], _local2.state.labelSet["_s" .. _local3.key]; _local2.state.labelSet["_g" .. _local3.key], _local2.state.labelSet["_s" .. _local3.key] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local2.state.labelSet[_local3.key]; _local2.state.labelSet[_local3.key] = nil; return _r or _v ~= nil; end)();
do return _local3.node:finishLabeledStatement(_local3.expr,_local3.labeledBody); end
end

consumeSemicolon(_ENV);
do return _local3.node:finishExpressionStatement(_local3.expr); end
end));
parseFunctionSourceElements =((function(this)
local _local3 = {};
_local3.body = _arr({},0);
_local3.node = _new(Node);
expect(_ENV,"{");
while (_lt(_local2.startIndex,_local2.length)) do
if (_local2.lookahead.type ~= _local2.Token.StringLiteral) then
do break end;
end

_local3.token = _local2.lookahead;
_local3.statement = parseStatementListItem(_ENV);
_local3.body:push(_local3.statement);
if (_local3.statement.expression.type ~= _local2.Syntax.Literal) then
do break end;
end

_local3.directive = _local2.source:slice((_addNum2(_local3.token.start,1)),(_local3.token["end"] - 1));
if (_local3.directive == "use strict") then
_local2.strict = true;
if _bool(_local3.firstRestricted) then
tolerateUnexpectedToken(_ENV,_local3.firstRestricted,_local2.Messages.StrictOctalLiteral);
end

else
if _bool(((function() local _lev=not _bool(_local3.firstRestricted); if _bool(_lev) then return _local3.token.octal; else return _lev; end end)())) then
_local3.firstRestricted = _local3.token;
end

end

::_continue::
end

_local3.oldLabelSet = _local2.state.labelSet;
_local3.oldInIteration = _local2.state.inIteration;
_local3.oldInSwitch = _local2.state.inSwitch;
_local3.oldInFunctionBody = _local2.state.inFunctionBody;
_local2.state.labelSet = _obj({});
_local2.state.inIteration = false;
_local2.state.inSwitch = false;
_local2.state.inFunctionBody = true;
while (_lt(_local2.startIndex,_local2.length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

_local3.body:push(parseStatementListItem(_ENV));
::_continue::
end

expect(_ENV,"}");
_local2.state.labelSet = _local3.oldLabelSet;
_local2.state.inIteration = _local3.oldInIteration;
_local2.state.inSwitch = _local3.oldInSwitch;
_local2.state.inFunctionBody = _local3.oldInFunctionBody;
do return _local3.node:finishBlockStatement(_local3.body); end
end));
validateParam =((function(this,options,param,name)
local _local3 = {};
_local3.key = (_addStr1("$",name));
if _bool(_local2.strict) then
if _bool(isRestrictedWord(_ENV,name)) then
options.stricted = param;
options.message = _local2.Messages.StrictParamName;
end

if _bool(Object.prototype.hasOwnProperty:call(options.paramSet,_local3.key)) then
options.stricted = param;
options.message = _local2.Messages.StrictParamDupe;
end

elseif not _bool(options.firstRestricted) then
if _bool(isRestrictedWord(_ENV,name)) then
options.firstRestricted = param;
options.message = _local2.Messages.StrictParamName;
elseif _bool(isStrictModeReservedWord(_ENV,name)) then
options.firstRestricted = param;
options.message = _local2.Messages.StrictReservedWord;
elseif _bool(Object.prototype.hasOwnProperty:call(options.paramSet,_local3.key)) then
options.stricted = param;
options.message = _local2.Messages.StrictParamDupe;
end

end

options.paramSet[_local3.key] = true;
end));
parseParam =((function(this,options)
local _local3 = {};
_local3.params = _arr({},0);
_local3.token = _local2.lookahead;
if (_local3.token.value == "...") then
_local3.param = parseRestElement(_ENV,_local3.params);
validateParam(_ENV,options,_local3.param.argument,_local3.param.argument.name);
options.params:push(_local3.param);
options.defaults:push(null);
do return false; end
end

_local3.param = parsePatternWithDefault(_ENV,_local3.params);
_local3.i = 0;
while (_lt(_local3.i,_local3.params.length)) do
validateParam(_ENV,options,_local3.params[_local3.i],_local3.params[_local3.i].value);
_local3.i = _inc(_local3.i);
end

if (_local3.param.type == _local2.Syntax.AssignmentPattern) then
_local3.def = _local3.param.right;
_local3.param = _local3.param.left;
options.defaultCount = _inc(options.defaultCount);
end

options.params:push(_local3.param);
options.defaults:push(_local3.def);
do return not _bool(match(_ENV,")")); end
end));
parseParams =((function(this,firstRestricted)
local _local3 = {};
_local3.options = _obj({
["params"] = _arr({},0),
["defaultCount"] = 0,
["defaults"] = _arr({},0),
["firstRestricted"] = firstRestricted
});
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
_local3.options.paramSet = _obj({});
while (_lt(_local2.startIndex,_local2.length)) do
if not _bool(parseParam(_ENV,_local3.options)) then
do break end;
end

expect(_ENV,",");
::_continue::
end

end

expect(_ENV,")");
if (_local3.options.defaultCount == 0) then
_local3.options.defaults = _arr({},0);
end

do return _obj({
["params"] = _local3.options.params,
["defaults"] = _local3.options.defaults,
["stricted"] = _local3.options.stricted,
["firstRestricted"] = _local3.options.firstRestricted,
["message"] = _local3.options.message
}); end
end));
parseFunctionDeclaration =((function(this,node,identifierIsOptional)
local _local3 = {};
_local3.id = null;
_local3.params = _arr({},0);
_local3.defaults = _arr({},0);
_local3.previousAllowYield = _local2.state.allowYield;
expectKeyword(_ENV,"function");
_local3.isGenerator = match(_ENV,"*");
if _bool(_local3.isGenerator) then
lex(_ENV);
end

if ((function() local _lev=not _bool(identifierIsOptional); return _bool(_lev) and _lev or not _bool(match(_ENV,"(")) end)()) then
_local3.token = _local2.lookahead;
_local3.id = parseVariableIdentifier(_ENV);
if _bool(_local2.strict) then
if _bool(isRestrictedWord(_ENV,_local3.token.value)) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,_local3.token.value)) then
_local3.firstRestricted = _local3.token;
_local3.message = _local2.Messages.StrictFunctionName;
elseif _bool(isStrictModeReservedWord(_ENV,_local3.token.value)) then
_local3.firstRestricted = _local3.token;
_local3.message = _local2.Messages.StrictReservedWord;
end

end

end

_local2.state.allowYield = not _bool(_local3.isGenerator);
_local3.tmp = parseParams(_ENV,_local3.firstRestricted);
_local3.params = _local3.tmp.params;
_local3.defaults = _local3.tmp.defaults;
_local3.stricted = _local3.tmp.stricted;
_local3.firstRestricted = _local3.tmp.firstRestricted;
if _bool(_local3.tmp.message) then
_local3.message = _local3.tmp.message;
end

_local3.previousStrict = _local2.strict;
_local3.body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(_local2.strict) then return _local3.firstRestricted; else return _local2.strict; end end)())) then
throwUnexpectedToken(_ENV,_local3.firstRestricted,_local3.message);
end

if _bool(((function() if _bool(_local2.strict) then return _local3.stricted; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,_local3.stricted,_local3.message);
end

_local2.strict = _local3.previousStrict;
_local2.state.allowYield = _local3.previousAllowYield;
do return node:finishFunctionDeclaration(_local3.id,_local3.params,_local3.defaults,_local3.body,_local3.isGenerator); end
end));
parseFunctionExpression =((function(this)
local _local3 = {};
_local3.id = null;
_local3.params = _arr({},0);
_local3.defaults = _arr({},0);
_local3.node = _new(Node);
_local3.previousAllowYield = _local2.state.allowYield;
expectKeyword(_ENV,"function");
_local3.isGenerator = match(_ENV,"*");
if _bool(_local3.isGenerator) then
lex(_ENV);
end

_local2.state.allowYield = not _bool(_local3.isGenerator);
if not _bool(match(_ENV,"(")) then
_local3.token = _local2.lookahead;
_local3.id = (function() if _bool(((function() local _lev=((function() local _lev=not _bool(_local2.strict); if _bool(_lev) then return not _bool(_local3.isGenerator); else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then return parseNonComputedProperty(_ENV); else return parseVariableIdentifier(_ENV); end end)();
if _bool(_local2.strict) then
if _bool(isRestrictedWord(_ENV,_local3.token.value)) then
tolerateUnexpectedToken(_ENV,_local3.token,_local2.Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,_local3.token.value)) then
_local3.firstRestricted = _local3.token;
_local3.message = _local2.Messages.StrictFunctionName;
elseif _bool(isStrictModeReservedWord(_ENV,_local3.token.value)) then
_local3.firstRestricted = _local3.token;
_local3.message = _local2.Messages.StrictReservedWord;
end

end

end

_local3.tmp = parseParams(_ENV,_local3.firstRestricted);
_local3.params = _local3.tmp.params;
_local3.defaults = _local3.tmp.defaults;
_local3.stricted = _local3.tmp.stricted;
_local3.firstRestricted = _local3.tmp.firstRestricted;
if _bool(_local3.tmp.message) then
_local3.message = _local3.tmp.message;
end

_local3.previousStrict = _local2.strict;
_local3.body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(_local2.strict) then return _local3.firstRestricted; else return _local2.strict; end end)())) then
throwUnexpectedToken(_ENV,_local3.firstRestricted,_local3.message);
end

if _bool(((function() if _bool(_local2.strict) then return _local3.stricted; else return _local2.strict; end end)())) then
tolerateUnexpectedToken(_ENV,_local3.stricted,_local3.message);
end

_local2.strict = _local3.previousStrict;
_local2.state.allowYield = _local3.previousAllowYield;
do return _local3.node:finishFunctionExpression(_local3.id,_local3.params,_local3.defaults,_local3.body,_local3.isGenerator); end
end));
parseClassBody =((function(this)
local _local3 = {};
_local3.hasConstructor = false;
_local3.classBody = _new(Node);
expect(_ENV,"{");
_local3.body = _arr({},0);
while not _bool(match(_ENV,"}")) do
if _bool(match(_ENV,";")) then
lex(_ENV);
else
_local3.method = _new(Node);
_local3.token = _local2.lookahead;
_local3.isStatic = false;
_local3.computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
_local3.key = parseObjectPropertyKey(_ENV);
if _bool(((function() local _lev=(_local3.key.name == "static"); if _bool(_lev) then return ((function() local _lev=lookaheadPropertyName(_ENV); return _bool(_lev) and _lev or match(_ENV,"*") end)()); else return _lev; end end)())) then
_local3.token = _local2.lookahead;
_local3.isStatic = true;
_local3.computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
_local3.key = parseObjectPropertyKey(_ENV);
end

end

end

_local3.method = tryParseMethodDefinition(_ENV,_local3.token,_local3.key,_local3.computed,_local3.method);
if _bool(_local3.method) then
_local3.method["static"] = _local3.isStatic;
if (_local3.method.kind == "init") then
_local3.method.kind = "method";
end

if not _bool(_local3.isStatic) then
if ((function() local _lev=not _bool(_local3.method.computed); if _bool(_lev) then return (((function() local _lev=_local3.method.key.name; return _bool(_lev) and _lev or _local3.method.key.value:toString() end)()) == "constructor"); else return _lev; end end)()) then
if _bool(((function() local _lev=((function() local _lev=(_local3.method.kind ~= "method"); return _bool(_lev) and _lev or not _bool(_local3.method.method) end)()); return _bool(_lev) and _lev or _local3.method.value.generator end)())) then
throwUnexpectedToken(_ENV,_local3.token,_local2.Messages.ConstructorSpecialMethod);
end

if _bool(_local3.hasConstructor) then
throwUnexpectedToken(_ENV,_local3.token,_local2.Messages.DuplicateConstructor);
else
_local3.hasConstructor = true;
end

_local3.method.kind = "constructor";
end

else
if ((function() local _lev=not _bool(_local3.method.computed); if _bool(_lev) then return (((function() local _lev=_local3.method.key.name; return _bool(_lev) and _lev or _local3.method.key.value:toString() end)()) == "prototype"); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,_local3.token,_local2.Messages.StaticPrototype);
end

end

_local3.method.type = _local2.Syntax.MethodDefinition;
(function () local _r = false; local _g, _s = _local3.method["_g" .. "method"], _local3.method["_s" .. "method"]; _local3.method["_g" .. "method"], _local3.method["_s" .. "method"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.method.method; _local3.method.method = nil; return _r or _v ~= nil; end)();
(function () local _r = false; local _g, _s = _local3.method["_g" .. "shorthand"], _local3.method["_s" .. "shorthand"]; _local3.method["_g" .. "shorthand"], _local3.method["_s" .. "shorthand"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.method.shorthand; _local3.method.shorthand = nil; return _r or _v ~= nil; end)();
_local3.body:push(_local3.method);
else
throwUnexpectedToken(_ENV,_local2.lookahead);
end

end

::_continue::
end

lex(_ENV);
do return _local3.classBody:finishClassBody(_local3.body); end
end));
parseClassDeclaration =((function(this,identifierIsOptional)
local _local3 = {};
_local3.id = null;
_local3.superClass = null;
_local3.classNode = _new(Node);
_local3.previousStrict = _local2.strict;
_local2.strict = true;
expectKeyword(_ENV,"class");
if ((function() local _lev=not _bool(identifierIsOptional); return _bool(_lev) and _lev or (_local2.lookahead.type == _local2.Token.Identifier) end)()) then
_local3.id = parseVariableIdentifier(_ENV);
end

if _bool(matchKeyword(_ENV,"extends")) then
lex(_ENV);
_local3.superClass = isolateCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
end

_local3.classBody = parseClassBody(_ENV);
_local2.strict = _local3.previousStrict;
do return _local3.classNode:finishClassDeclaration(_local3.id,_local3.superClass,_local3.classBody); end
end));
parseClassExpression =((function(this)
local _local3 = {};
_local3.id = null;
_local3.superClass = null;
_local3.classNode = _new(Node);
_local3.previousStrict = _local2.strict;
_local2.strict = true;
expectKeyword(_ENV,"class");
if (_local2.lookahead.type == _local2.Token.Identifier) then
_local3.id = parseVariableIdentifier(_ENV);
end

if _bool(matchKeyword(_ENV,"extends")) then
lex(_ENV);
_local3.superClass = isolateCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
end

_local3.classBody = parseClassBody(_ENV);
_local2.strict = _local3.previousStrict;
do return _local3.classNode:finishClassExpression(_local3.id,_local3.superClass,_local3.classBody); end
end));
parseModuleSpecifier =((function(this)
local _local3 = {};
_local3.node = _new(Node);
if (_local2.lookahead.type ~= _local2.Token.StringLiteral) then
throwError(_ENV,_local2.Messages.InvalidModuleSpecifier);
end

do return _local3.node:finishLiteral(lex(_ENV)); end
end));
parseExportSpecifier =((function(this)
local _local3 = {};
_local3.node = _new(Node);
if _bool(matchKeyword(_ENV,"default")) then
_local3.def = _new(Node);
lex(_ENV);
_local3._g_local = _local3.def:finishIdentifier("default");
else
_local3._g_local = parseVariableIdentifier(_ENV);
end

if _bool(matchContextualKeyword(_ENV,"as")) then
lex(_ENV);
_local3.exported = parseNonComputedProperty(_ENV);
end

do return _local3.node:finishExportSpecifier(_local3._g_local,_local3.exported); end
end));
parseExportNamedDeclaration =((function(this,node)
local _local3 = {};
_local3.declaration = null;
_local3.src = null;
_local3.specifiers = _arr({},0);
if (_local2.lookahead.type == _local2.Token.Keyword) then
repeat
local _into = false;
local _cases = {["let"] = true,["const"] = true,["var"] = true,["class"] = true,["function"] = true};
local _v = _local2.lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "let") then

_into = true;
end
if _into or (_v == "const") then
_local3.declaration = parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
}));
do return node:finishExportNamedDeclaration(_local3.declaration,_local3.specifiers,null); end
_into = true;
end
if _into or (_v == "var") then

_into = true;
end
if _into or (_v == "class") then

_into = true;
end
if _into or (_v == "function") then
_local3.declaration = parseStatementListItem(_ENV);
do return node:finishExportNamedDeclaration(_local3.declaration,_local3.specifiers,null); end
_into = true;
end
::_default::
until true
end

expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
_local3.isExportFromIdentifier = (_bool(_local3.isExportFromIdentifier) and _local3.isExportFromIdentifier or matchKeyword(_ENV,"default"));
_local3.specifiers:push(parseExportSpecifier(_ENV));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
if _bool(match(_ENV,"}")) then
do break end;
end

end

::_continue::
end

expect(_ENV,"}");
if _bool(matchContextualKeyword(_ENV,"from")) then
lex(_ENV);
_local3.src = parseModuleSpecifier(_ENV);
consumeSemicolon(_ENV);
elseif _bool(_local3.isExportFromIdentifier) then
throwError(_ENV,(function() if _bool(_local2.lookahead.value) then return _local2.Messages.UnexpectedToken; else return _local2.Messages.MissingFromClause; end end)(),_local2.lookahead.value);
else
consumeSemicolon(_ENV);
end

do return node:finishExportNamedDeclaration(_local3.declaration,_local3.specifiers,_local3.src); end
end));
parseExportDefaultDeclaration =((function(this,node)
local _local3 = {};
_local3.declaration = null;
_local3.expression = null;
expectKeyword(_ENV,"default");
if _bool(matchKeyword(_ENV,"function")) then
_local3.declaration = parseFunctionDeclaration(_ENV,_new(Node),true);
do return node:finishExportDefaultDeclaration(_local3.declaration); end
end

if _bool(matchKeyword(_ENV,"class")) then
_local3.declaration = parseClassDeclaration(_ENV,true);
do return node:finishExportDefaultDeclaration(_local3.declaration); end
end

if _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,_local2.Messages.UnexpectedToken,_local2.lookahead.value);
end

if _bool(match(_ENV,"{")) then
_local3.expression = parseObjectInitializer(_ENV);
elseif _bool(match(_ENV,"[")) then
_local3.expression = parseArrayInitializer(_ENV);
else
_local3.expression = parseAssignmentExpression(_ENV);
end

consumeSemicolon(_ENV);
do return node:finishExportDefaultDeclaration(_local3.expression); end
end));
parseExportAllDeclaration =((function(this,node)
local _local3 = {};
expect(_ENV,"*");
if not _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,(function() if _bool(_local2.lookahead.value) then return _local2.Messages.UnexpectedToken; else return _local2.Messages.MissingFromClause; end end)(),_local2.lookahead.value);
end

lex(_ENV);
_local3.src = parseModuleSpecifier(_ENV);
consumeSemicolon(_ENV);
do return node:finishExportAllDeclaration(_local3.src); end
end));
parseExportDeclaration =((function(this)
local _local3 = {};
_local3.node = _new(Node);
if _bool(_local2.state.inFunctionBody) then
throwError(_ENV,_local2.Messages.IllegalExportDeclaration);
end

expectKeyword(_ENV,"export");
if _bool(matchKeyword(_ENV,"default")) then
do return parseExportDefaultDeclaration(_ENV,_local3.node); end
end

if _bool(match(_ENV,"*")) then
do return parseExportAllDeclaration(_ENV,_local3.node); end
end

do return parseExportNamedDeclaration(_ENV,_local3.node); end
end));
parseImportSpecifier =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3.imported = parseNonComputedProperty(_ENV);
if _bool(matchContextualKeyword(_ENV,"as")) then
lex(_ENV);
_local3._g_local = parseVariableIdentifier(_ENV);
end

do return _local3.node:finishImportSpecifier(_local3._g_local,_local3.imported); end
end));
parseNamedImports =((function(this)
local _local3 = {};
_local3.specifiers = _arr({},0);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
_local3.specifiers:push(parseImportSpecifier(_ENV));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
if _bool(match(_ENV,"}")) then
do break end;
end

end

::_continue::
end

expect(_ENV,"}");
do return _local3.specifiers; end
end));
parseImportDefaultSpecifier =((function(this)
local _local3 = {};
_local3.node = _new(Node);
_local3._g_local = parseNonComputedProperty(_ENV);
do return _local3.node:finishImportDefaultSpecifier(_local3._g_local); end
end));
parseImportNamespaceSpecifier =((function(this)
local _local3 = {};
_local3.node = _new(Node);
expect(_ENV,"*");
if not _bool(matchContextualKeyword(_ENV,"as")) then
throwError(_ENV,_local2.Messages.NoAsAfterImportNamespace);
end

lex(_ENV);
_local3._g_local = parseNonComputedProperty(_ENV);
do return _local3.node:finishImportNamespaceSpecifier(_local3._g_local); end
end));
parseImportDeclaration =((function(this)
local _local3 = {};
_local3.specifiers = _arr({},0);
_local3.node = _new(Node);
if _bool(_local2.state.inFunctionBody) then
throwError(_ENV,_local2.Messages.IllegalImportDeclaration);
end

expectKeyword(_ENV,"import");
if (_local2.lookahead.type == _local2.Token.StringLiteral) then
_local3.src = parseModuleSpecifier(_ENV);
else
if _bool(match(_ENV,"{")) then
_local3.specifiers = _local3.specifiers:concat(parseNamedImports(_ENV));
elseif _bool(match(_ENV,"*")) then
_local3.specifiers:push(parseImportNamespaceSpecifier(_ENV));
elseif _bool(((function() local _lev=isIdentifierName(_ENV,_local2.lookahead); if _bool(_lev) then return not _bool(matchKeyword(_ENV,"default")); else return _lev; end end)())) then
_local3.specifiers:push(parseImportDefaultSpecifier(_ENV));
if _bool(match(_ENV,",")) then
lex(_ENV);
if _bool(match(_ENV,"*")) then
_local3.specifiers:push(parseImportNamespaceSpecifier(_ENV));
elseif _bool(match(_ENV,"{")) then
_local3.specifiers = _local3.specifiers:concat(parseNamedImports(_ENV));
else
throwUnexpectedToken(_ENV,_local2.lookahead);
end

end

else
throwUnexpectedToken(_ENV,lex(_ENV));
end

if not _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,(function() if _bool(_local2.lookahead.value) then return _local2.Messages.UnexpectedToken; else return _local2.Messages.MissingFromClause; end end)(),_local2.lookahead.value);
end

lex(_ENV);
_local3.src = parseModuleSpecifier(_ENV);
end

consumeSemicolon(_ENV);
do return _local3.node:finishImportDeclaration(_local3.specifiers,_local3.src); end
end));
parseScriptBody =((function(this)
local _local3 = {};
_local3.body = _arr({},0);
while (_lt(_local2.startIndex,_local2.length)) do
_local3.token = _local2.lookahead;
if (_local3.token.type ~= _local2.Token.StringLiteral) then
do break end;
end

_local3.statement = parseStatementListItem(_ENV);
_local3.body:push(_local3.statement);
if (_local3.statement.expression.type ~= _local2.Syntax.Literal) then
do break end;
end

_local3.directive = _local2.source:slice((_addNum2(_local3.token.start,1)),(_local3.token["end"] - 1));
if (_local3.directive == "use strict") then
_local2.strict = true;
if _bool(_local3.firstRestricted) then
tolerateUnexpectedToken(_ENV,_local3.firstRestricted,_local2.Messages.StrictOctalLiteral);
end

else
if _bool(((function() local _lev=not _bool(_local3.firstRestricted); if _bool(_lev) then return _local3.token.octal; else return _lev; end end)())) then
_local3.firstRestricted = _local3.token;
end

end

::_continue::
end

while (_lt(_local2.startIndex,_local2.length)) do
_local3.statement = parseStatementListItem(_ENV);
if (_type(_local3.statement) == "undefined") then
do break end;
end

_local3.body:push(_local3.statement);
::_continue::
end

do return _local3.body; end
end));
parseProgram =((function(this)
local _local3 = {};
peek(_ENV);
_local3.node = _new(Node);
_local3.body = parseScriptBody(_ENV);
do return _local3.node:finishProgram(_local3.body,_local2.state.sourceType); end
end));
filterTokenLocation =((function(this)
local _local3 = {};
_local3.tokens = _arr({},0);
_local3.i = 0;
while (_lt(_local3.i,_local2.extra.tokens.length)) do
_local3.entry = _local2.extra.tokens[_local3.i];
_local3.token = _obj({
["type"] = _local3.entry.type,
["value"] = _local3.entry.value
});
if _bool(_local3.entry.regex) then
_local3.token.regex = _obj({
["pattern"] = _local3.entry.regex.pattern,
["flags"] = _local3.entry.regex.flags
});
end

if _bool(_local2.extra.range) then
_local3.token.range = _local3.entry.range;
end

if _bool(_local2.extra.loc) then
_local3.token.loc = _local3.entry.loc;
end

_local3.tokens:push(_local3.token);
_local3.i = _inc(_local3.i);
end

_local2.extra.tokens = _local3.tokens;
end));
tokenize =((function(this,code,options,delegate)
local _local3 = {};
_local3.toString = String;
if ((function() local _lev=(_type(code) ~= "string"); if _bool(_lev) then return not (_instanceof(code,String)); else return _lev; end end)()) then
code = _local3.toString(_ENV,code);
end

_local2.source = code;
_local2.index = 0;
_local2.lineNumber = (function() if (_gt(_local2.source.length,0)) then return 1; else return 0; end end)();
_local2.lineStart = 0;
_local2.startIndex = _local2.index;
_local2.startLineNumber = _local2.lineNumber;
_local2.startLineStart = _local2.lineStart;
_local2.length = _local2.source.length;
_local2.lookahead = null;
_local2.state = _obj({
["allowIn"] = true,
["allowYield"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1,
["curlyStack"] = _arr({},0)
});
_local2.extra = _obj({});
options = (_bool(options) and options or _obj({}));
options.tokens = true;
_local2.extra.tokens = _arr({},0);
_local2.extra.tokenValues = _arr({},0);
_local2.extra.tokenize = true;
_local2.extra.delegate = delegate;
_local2.extra.openParenToken = -1;
_local2.extra.openCurlyToken = -1;
_local2.extra.range = ((function() local _lev=(_type(options.range) == "boolean"); if _bool(_lev) then return options.range; else return _lev; end end)());
_local2.extra.loc = ((function() local _lev=(_type(options.loc) == "boolean"); if _bool(_lev) then return options.loc; else return _lev; end end)());
if _bool(((function() local _lev=(_type(options.comment) == "boolean"); if _bool(_lev) then return options.comment; else return _lev; end end)())) then
_local2.extra.comments = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.tolerant) == "boolean"); if _bool(_lev) then return options.tolerant; else return _lev; end end)())) then
_local2.extra.errors = _arr({},0);
end

local _status, _return = _pcall(function()
peek(_ENV);
if (_local2.lookahead.type == _local2.Token.EOF) then
do return _local2.extra.tokens; end
end

lex(_ENV);
while (_local2.lookahead.type ~= _local2.Token.EOF) do
local _status, _return = _pcall(function()
lex(_ENV);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local lexError = _return;
if _bool(_local2.extra.errors) then
recordError(_ENV,lexError);
do return _break; end
else
_throw(lexError,0)
end

end);
if _cstatus then
if _creturn == _break then break; end
else _throw(_creturn,0); end
end

::_continue::
end

_local3.tokens = _local2.extra.tokens;
if (_type(_local2.extra.errors) ~= "undefined") then
_local3.tokens.errors = _local2.extra.errors;
end

end);
if _status then
_local2.extra = _obj({});
if _return ~= nil then return _return; end
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
_local2.extra = _obj({});
if _cstatus then
else _throw(_creturn,0); end
end

do return _local3.tokens; end
end));
parse =((function(this,code,options)
local _local3 = {};
_local3.toString = String;
if ((function() local _lev=(_type(code) ~= "string"); if _bool(_lev) then return not (_instanceof(code,String)); else return _lev; end end)()) then
code = _local3.toString(_ENV,code);
end

_local2.source = code;
_local2.index = 0;
_local2.lineNumber = (function() if (_gt(_local2.source.length,0)) then return 1; else return 0; end end)();
_local2.lineStart = 0;
_local2.startIndex = _local2.index;
_local2.startLineNumber = _local2.lineNumber;
_local2.startLineStart = _local2.lineStart;
_local2.length = _local2.source.length;
_local2.lookahead = null;
_local2.state = _obj({
["allowIn"] = true,
["allowYield"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1,
["curlyStack"] = _arr({},0),
["sourceType"] = "script"
});
_local2.strict = false;
_local2.extra = _obj({});
if (_type(options) ~= "undefined") then
_local2.extra.range = ((function() local _lev=(_type(options.range) == "boolean"); if _bool(_lev) then return options.range; else return _lev; end end)());
_local2.extra.loc = ((function() local _lev=(_type(options.loc) == "boolean"); if _bool(_lev) then return options.loc; else return _lev; end end)());
_local2.extra.attachComment = ((function() local _lev=(_type(options.attachComment) == "boolean"); if _bool(_lev) then return options.attachComment; else return _lev; end end)());
if _bool(((function() local _lev=((function() local _lev=_local2.extra.loc; if _bool(_lev) then return (options.source ~= null); else return _lev; end end)()); if _bool(_lev) then return (options.source ~= undefined); else return _lev; end end)())) then
_local2.extra.source = _local3.toString(_ENV,options.source);
end

if _bool(((function() local _lev=(_type(options.tokens) == "boolean"); if _bool(_lev) then return options.tokens; else return _lev; end end)())) then
_local2.extra.tokens = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.comment) == "boolean"); if _bool(_lev) then return options.comment; else return _lev; end end)())) then
_local2.extra.comments = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.tolerant) == "boolean"); if _bool(_lev) then return options.tolerant; else return _lev; end end)())) then
_local2.extra.errors = _arr({},0);
end

if _bool(_local2.extra.attachComment) then
_local2.extra.range = true;
_local2.extra.comments = _arr({},0);
_local2.extra.bottomRightStack = _arr({},0);
_local2.extra.trailingComments = _arr({},0);
_local2.extra.leadingComments = _arr({},0);
end

if (options.sourceType == "module") then
_local2.state.sourceType = options.sourceType;
_local2.strict = true;
end

end

local _status, _return = _pcall(function()
_local3.program = parseProgram(_ENV);
if (_type(_local2.extra.comments) ~= "undefined") then
_local3.program.comments = _local2.extra.comments;
end

if (_type(_local2.extra.tokens) ~= "undefined") then
filterTokenLocation(_ENV);
_local3.program.tokens = _local2.extra.tokens;
end

if (_type(_local2.extra.errors) ~= "undefined") then
_local3.program.errors = _local2.extra.errors;
end

end);
if _status then
_local2.extra = _obj({});
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
_local2.extra = _obj({});
if _cstatus then
else _throw(_creturn,0); end
end

do return _local3.program; end
end));_local2.Token = _obj({
["BooleanLiteral"] = 1,
["EOF"] = 2,
["Identifier"] = 3,
["Keyword"] = 4,
["NullLiteral"] = 5,
["NumericLiteral"] = 6,
["Punctuator"] = 7,
["StringLiteral"] = 8,
["RegularExpression"] = 9,
["Template"] = 10
});
_local2.TokenName = _obj({});
_local2.TokenName[_local2.Token.BooleanLiteral] = "Boolean";
_local2.TokenName[_local2.Token.EOF] = "<end>";
_local2.TokenName[_local2.Token.Identifier] = "Identifier";
_local2.TokenName[_local2.Token.Keyword] = "Keyword";
_local2.TokenName[_local2.Token.NullLiteral] = "Null";
_local2.TokenName[_local2.Token.NumericLiteral] = "Numeric";
_local2.TokenName[_local2.Token.Punctuator] = "Punctuator";
_local2.TokenName[_local2.Token.StringLiteral] = "String";
_local2.TokenName[_local2.Token.RegularExpression] = "RegularExpression";
_local2.TokenName[_local2.Token.Template] = "Template";
_local2.FnExprTokens = _arr({[0]="(","{","[","in","typeof","instanceof","new","return","case","delete","throw","void","=","+=","-=","*=","/=","%=","<<=",">>=",">>>=","&=","|=","^=",",","+","-","*","/","%","++","--","<<",">>",">>>","&","|","^","!","~","&&","||","?",":","===","==",">=","<=","<",">","!=","!=="},52);
_local2.Syntax = _obj({
["AssignmentExpression"] = "AssignmentExpression",
["AssignmentPattern"] = "AssignmentPattern",
["ArrayExpression"] = "ArrayExpression",
["ArrayPattern"] = "ArrayPattern",
["ArrowFunctionExpression"] = "ArrowFunctionExpression",
["BlockStatement"] = "BlockStatement",
["BinaryExpression"] = "BinaryExpression",
["BreakStatement"] = "BreakStatement",
["CallExpression"] = "CallExpression",
["CatchClause"] = "CatchClause",
["ClassBody"] = "ClassBody",
["ClassDeclaration"] = "ClassDeclaration",
["ClassExpression"] = "ClassExpression",
["ConditionalExpression"] = "ConditionalExpression",
["ContinueStatement"] = "ContinueStatement",
["DoWhileStatement"] = "DoWhileStatement",
["DebuggerStatement"] = "DebuggerStatement",
["EmptyStatement"] = "EmptyStatement",
["ExportAllDeclaration"] = "ExportAllDeclaration",
["ExportDefaultDeclaration"] = "ExportDefaultDeclaration",
["ExportNamedDeclaration"] = "ExportNamedDeclaration",
["ExportSpecifier"] = "ExportSpecifier",
["ExpressionStatement"] = "ExpressionStatement",
["ForStatement"] = "ForStatement",
["ForOfStatement"] = "ForOfStatement",
["ForInStatement"] = "ForInStatement",
["FunctionDeclaration"] = "FunctionDeclaration",
["FunctionExpression"] = "FunctionExpression",
["Identifier"] = "Identifier",
["IfStatement"] = "IfStatement",
["ImportDeclaration"] = "ImportDeclaration",
["ImportDefaultSpecifier"] = "ImportDefaultSpecifier",
["ImportNamespaceSpecifier"] = "ImportNamespaceSpecifier",
["ImportSpecifier"] = "ImportSpecifier",
["Literal"] = "Literal",
["LabeledStatement"] = "LabeledStatement",
["LogicalExpression"] = "LogicalExpression",
["MemberExpression"] = "MemberExpression",
["MetaProperty"] = "MetaProperty",
["MethodDefinition"] = "MethodDefinition",
["NewExpression"] = "NewExpression",
["ObjectExpression"] = "ObjectExpression",
["ObjectPattern"] = "ObjectPattern",
["Program"] = "Program",
["Property"] = "Property",
["RestElement"] = "RestElement",
["ReturnStatement"] = "ReturnStatement",
["SequenceExpression"] = "SequenceExpression",
["SpreadElement"] = "SpreadElement",
["Super"] = "Super",
["SwitchCase"] = "SwitchCase",
["SwitchStatement"] = "SwitchStatement",
["TaggedTemplateExpression"] = "TaggedTemplateExpression",
["TemplateElement"] = "TemplateElement",
["TemplateLiteral"] = "TemplateLiteral",
["ThisExpression"] = "ThisExpression",
["ThrowStatement"] = "ThrowStatement",
["TryStatement"] = "TryStatement",
["UnaryExpression"] = "UnaryExpression",
["UpdateExpression"] = "UpdateExpression",
["VariableDeclaration"] = "VariableDeclaration",
["VariableDeclarator"] = "VariableDeclarator",
["WhileStatement"] = "WhileStatement",
["WithStatement"] = "WithStatement",
["YieldExpression"] = "YieldExpression"
});
_local2.PlaceHolders = _obj({
["ArrowParameterPlaceHolder"] = "ArrowParameterPlaceHolder"
});
_local2.Messages = _obj({
["UnexpectedToken"] = "Unexpected token %0",
["UnexpectedNumber"] = "Unexpected number",
["UnexpectedString"] = "Unexpected string",
["UnexpectedIdentifier"] = "Unexpected identifier",
["UnexpectedReserved"] = "Unexpected reserved word",
["UnexpectedTemplate"] = "Unexpected quasi %0",
["UnexpectedEOS"] = "Unexpected end of input",
["NewlineAfterThrow"] = "Illegal newline after throw",
["InvalidRegExp"] = "Invalid regular expression",
["UnterminatedRegExp"] = "Invalid regular expression: missing /",
["InvalidLHSInAssignment"] = "Invalid left-hand side in assignment",
["InvalidLHSInForIn"] = "Invalid left-hand side in for-in",
["InvalidLHSInForLoop"] = "Invalid left-hand side in for-loop",
["MultipleDefaultsInSwitch"] = "More than one default clause in switch statement",
["NoCatchOrFinally"] = "Missing catch or finally after try",
["UnknownLabel"] = "Undefined label '%0'",
["Redeclaration"] = "%0 '%1' has already been declared",
["IllegalContinue"] = "Illegal continue statement",
["IllegalBreak"] = "Illegal break statement",
["IllegalReturn"] = "Illegal return statement",
["StrictModeWith"] = "Strict mode code may not include a with statement",
["StrictCatchVariable"] = "Catch variable may not be eval or arguments in strict mode",
["StrictVarName"] = "Variable name may not be eval or arguments in strict mode",
["StrictParamName"] = "Parameter name eval or arguments is not allowed in strict mode",
["StrictParamDupe"] = "Strict mode function may not have duplicate parameter names",
["StrictFunctionName"] = "Function name may not be eval or arguments in strict mode",
["StrictOctalLiteral"] = "Octal literals are not allowed in strict mode.",
["StrictDelete"] = "Delete of an unqualified identifier in strict mode.",
["StrictLHSAssignment"] = "Assignment to eval or arguments is not allowed in strict mode",
["StrictLHSPostfix"] = "Postfix increment/decrement may not have eval or arguments operand in strict mode",
["StrictLHSPrefix"] = "Prefix increment/decrement may not have eval or arguments operand in strict mode",
["StrictReservedWord"] = "Use of future reserved word in strict mode",
["TemplateOctalLiteral"] = "Octal literals are not allowed in template strings.",
["ParameterAfterRestParameter"] = "Rest parameter must be last formal parameter",
["DefaultRestParameter"] = "Unexpected token =",
["ObjectPatternAsRestParameter"] = "Unexpected token {",
["DuplicateProtoProperty"] = "Duplicate __proto__ fields are not allowed in object literals",
["ConstructorSpecialMethod"] = "Class constructor may not be an accessor",
["DuplicateConstructor"] = "A class may only have one constructor",
["StaticPrototype"] = "Classes may not have static property named prototype",
["MissingFromClause"] = "Unexpected token",
["NoAsAfterImportNamespace"] = "Unexpected token",
["InvalidModuleSpecifier"] = "Unexpected token",
["IllegalImportDeclaration"] = "Unexpected token",
["IllegalExportDeclaration"] = "Unexpected token",
["DuplicateBinding"] = "Duplicate binding %0"
});
_local2.Regex = _obj({
["NonAsciiIdentifierStart"] = _regexp("[\\xAA\\xB5\\xBA\\xC0-\\xD6\\xD8-\\xF6\\xF8-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\205\176-\205\180\205\182\205\183\205\186-\205\189\205\191\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\138-\212\175\212\177-\213\150\213\153\213\161-\214\135\215\144-\215\170\215\176-\215\178\216\160-\217\138\217\174\217\175\217\177-\219\147\219\149\219\165\219\166\219\174\219\175\219\186-\219\188\219\191\220\144\220\146-\220\175\221\141-\222\165\222\177\223\138-\223\170\223\180\223\181\223\186\224\160\128-\224\160\149\224\160\154\224\160\164\224\160\168\224\161\128-\224\161\152\224\162\160-\224\162\178\224\164\132-\224\164\185\224\164\189\224\165\144\224\165\152-\224\165\161\224\165\177-\224\166\128\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\189\224\167\142\224\167\156\224\167\157\224\167\159-\224\167\161\224\167\176\224\167\177\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\169\153-\224\169\156\224\169\158\224\169\178-\224\169\180\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\189\224\171\144\224\171\160\224\171\161\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\189\224\173\156\224\173\157\224\173\159-\224\173\161\224\173\177\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\175\144\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\185\224\176\189\224\177\152\224\177\153\224\177\160\224\177\161\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\189\224\179\158\224\179\160\224\179\161\224\179\177\224\179\178\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189\224\181\142\224\181\160\224\181\161\224\181\186-\224\181\191\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\184\129-\224\184\176\224\184\178\224\184\179\224\185\128-\224\185\134\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\176\224\186\178\224\186\179\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\156-\224\187\159\224\188\128\224\189\128-\224\189\135\224\189\137-\224\189\172\224\190\136-\224\190\140\225\128\128-\225\128\170\225\128\191\225\129\144-\225\129\149\225\129\154-\225\129\157\225\129\161\225\129\165\225\129\166\225\129\174-\225\129\176\225\129\181-\225\130\129\225\130\142\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\184\225\156\128-\225\156\140\225\156\142-\225\156\145\225\156\160-\225\156\177\225\157\128-\225\157\145\225\157\160-\225\157\172\225\157\174-\225\157\176\225\158\128-\225\158\179\225\159\151\225\159\156\225\160\160-\225\161\183\225\162\128-\225\162\168\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\158\225\165\144-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\167\129-\225\167\135\225\168\128-\225\168\150\225\168\160-\225\169\148\225\170\167\225\172\133-\225\172\179\225\173\133-\225\173\139\225\174\131-\225\174\160\225\174\174\225\174\175\225\174\186-\225\175\165\225\176\128-\225\176\163\225\177\141-\225\177\143\225\177\154-\225\177\189\225\179\169-\225\179\172\225\179\174-\225\179\177\225\179\181\225\179\182\225\180\128-\225\182\191\225\184\128-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\129\177\226\129\191\226\130\144-\226\130\156\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\152-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\174\226\179\178\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\182\128-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\227\128\133-\227\128\135\227\128\161-\227\128\169\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\155-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\159\234\152\170\234\152\171\234\153\128-\234\153\174\234\153\191-\234\154\157\234\154\160-\234\155\175\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\173\234\158\176\234\158\177\234\159\183-\234\160\129\234\160\131-\234\160\133\234\160\135-\234\160\138\234\160\140-\234\160\162\234\161\128-\234\161\179\234\162\130-\234\162\179\234\163\178-\234\163\183\234\163\187\234\164\138-\234\164\165\234\164\176-\234\165\134\234\165\160-\234\165\188\234\166\132-\234\166\178\234\167\143\234\167\160-\234\167\164\234\167\166-\234\167\175\234\167\186-\234\167\190\234\168\128-\234\168\168\234\169\128-\234\169\130\234\169\132-\234\169\139\234\169\160-\234\169\182\234\169\186\234\169\190-\234\170\175\234\170\177\234\170\181\234\170\182\234\170\185-\234\170\189\234\171\128\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\170\234\171\178-\234\171\180\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\172\176-\234\173\154\234\173\156-\234\173\159\234\173\164\234\173\165\234\175\128-\234\175\162\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157\239\172\159-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\161-\239\188\186\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]|\240\144\128\128[\240\144\128\128-\240\146\176\128\240\147\144\128-\240\153\160\128\240\154\128\128-\240\158\160\128\240\159\128\128\240\159\144\128\240\159\176\128-\240\163\144\128\240\164\128\128-\240\167\144\128\240\176\128\128-\241\142\160\128\241\160\128\128-\241\173\128\128\242\176\128\128-\242\183\128\128\242\184\128\128-\243\132\128\128\243\144\128\128-\243\151\176\128\243\156\128\128-\243\162\160\128\243\164\128\128-\243\173\144\128\243\176\128\128-\243\183\144\128\243\184\128\128-\244\128\176\128\244\130\128\128-\244\131\176\128\244\132\144\128-\244\133\144\128]|\240\144\144\128[\240\144\128\128-\240\183\144\128\241\144\128\128-\241\153\176\128\241\156\128\128-\241\168\176\128\242\144\128\128-\243\157\160\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\169\176\128]|\240\144\160\128[\240\144\128\128-\240\145\144\128\240\146\128\128\240\146\160\128-\240\157\144\128\240\157\176\128\240\158\128\128\240\159\128\128\240\159\176\128-\240\165\144\128\240\168\128\128-\240\173\160\128\240\176\128\128-\240\183\160\128\241\144\128\128-\241\149\144\128\241\152\128\128-\241\158\144\128\241\176\128\128-\241\189\176\128\241\191\160\128\241\191\176\128\242\144\128\128\242\148\128\128-\242\148\176\128\242\149\144\128-\242\149\176\128\242\150\144\128-\242\156\176\128\242\168\128\128-\242\175\128\128\242\176\128\128-\242\183\128\128\243\128\128\128-\243\129\176\128\243\130\144\128-\243\137\128\128\243\144\128\128-\243\157\144\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\172\160\128\243\176\128\128-\243\180\144\128]|\240\144\176\128[\240\144\128\128-\240\162\128\128]|\240\145\128\128[\240\144\176\128-\240\157\176\128\240\176\176\128-\240\187\176\128\241\132\128\128-\241\138\128\128\241\144\176\128-\241\153\160\128\241\164\128\128-\241\172\160\128\241\173\160\128\241\176\176\128-\241\188\160\128\242\128\144\128-\242\129\128\128\242\134\160\128\242\144\128\128-\242\148\144\128\242\148\176\128-\242\154\176\128\242\188\128\128-\243\135\160\128\243\145\144\128-\243\147\128\128\243\147\176\128\243\148\128\128\243\148\176\128-\243\154\128\128\243\154\160\128-\243\156\128\128\243\156\160\128\243\156\176\128\243\157\144\128-\243\158\144\128\243\159\144\128\243\167\144\128-\243\168\144\128]|\240\145\144\128[\240\176\128\128-\240\187\176\128\241\129\128\128\241\129\144\128\241\129\176\128\241\176\128\128-\241\187\160\128\242\144\128\128-\242\155\176\128\242\161\128\128\242\176\128\128-\242\186\160\128]|\240\145\160\128[\240\184\128\128-\241\135\176\128\241\143\176\128\243\128\128\128-\243\142\128\128]|\240\146\128\128[\240\144\128\128-\243\182\128\128]|\240\146\144\128[\240\144\128\128-\240\171\160\128]|[\240\147\128\128\240\160\128\128-\240\170\128\128\240\170\160\128-\240\171\128\128][\240\144\128\128-\244\143\176\128]|\240\147\144\128[\240\144\128\128-\240\155\160\128]|\240\150\160\128[\240\144\128\128-\242\158\128\128\242\160\128\128-\242\167\160\128\243\132\128\128-\243\139\144\128\243\144\128\128-\243\155\176\128\243\160\128\128-\243\160\176\128\243\168\176\128-\243\173\176\128\243\175\144\128-\243\179\176\128]|\240\150\176\128[\243\144\128\128-\243\161\128\128\243\164\128\128\243\180\176\128-\243\183\176\128]|\240\155\128\128[\240\144\128\128\240\144\144\128]|\240\155\176\128[\240\144\128\128-\240\170\160\128\240\172\128\128-\240\175\128\128\240\176\128\128-\240\178\128\128\240\180\128\128-\240\182\144\128]|\240\157\144\128[\240\144\128\128-\240\165\128\128\240\165\160\128-\240\183\128\128\240\183\160\128\240\183\176\128\240\184\160\128\240\185\144\128\240\185\160\128\240\186\144\128-\240\187\128\128\240\187\160\128-\240\190\144\128\240\190\176\128\240\191\144\128-\241\128\176\128\241\129\144\128-\241\145\144\128\241\145\176\128-\241\146\160\128\241\147\144\128-\241\149\128\128\241\149\160\128-\241\151\128\128\241\151\160\128-\241\158\144\128\241\158\176\128-\241\159\160\128\241\160\128\128-\241\161\128\128\241\161\160\128\241\162\160\128-\241\164\128\128\241\164\160\128-\242\185\144\128\242\186\128\128-\243\128\128\128\243\128\160\128-\243\134\160\128\243\135\128\128-\243\142\160\128\243\143\128\128-\243\149\128\128\243\149\160\128-\243\157\128\128\243\157\160\128-\243\163\160\128\243\164\128\128-\243\171\160\128\243\172\128\128-\243\178\128\128\243\178\160\128-\243\186\128\128\243\186\160\128-\244\128\160\128\244\129\128\128-\244\130\176\128]|\240\158\160\128[\240\144\128\128-\241\129\128\128]|\240\158\176\128[\242\144\128\128-\242\144\176\128\242\145\144\128-\242\151\176\128\242\152\144\128\242\152\160\128\242\153\128\128\242\153\176\128\242\154\144\128-\242\156\160\128\242\157\128\128-\242\157\176\128\242\158\144\128\242\158\176\128\242\160\160\128\242\161\176\128\242\162\144\128\242\162\176\128\242\163\144\128-\242\163\176\128\242\164\144\128\242\164\160\128\242\165\128\128\242\165\176\128\242\166\144\128\242\166\176\128\242\167\144\128\242\167\176\128\242\168\144\128\242\168\160\128\242\169\128\128\242\169\176\128-\242\170\160\128\242\171\128\128-\242\172\160\128\242\173\128\128-\242\173\176\128\242\174\144\128-\242\175\128\128\242\175\160\128\242\176\128\128-\242\178\144\128\242\178\176\128-\242\182\176\128\242\184\144\128-\242\184\176\128\242\185\144\128-\242\186\144\128\242\186\176\128-\242\190\176\128]|\240\170\144\128[\240\144\128\128-\243\133\160\128\243\144\128\128-\244\143\176\128]|\240\171\144\128[\240\144\128\128-\243\157\128\128\243\160\128\128-\244\143\176\128]|\240\171\160\128[\240\144\128\128-\240\151\144\128]|\240\175\160\128[\240\144\128\128-\242\151\144\128]",""),
["NonAsciiIdentifierPart"] = _regexp("[\\xAA\\xB5\\xB7\\xBA\\xC0-\\xD6\\xD8-\\xF6\\xF8-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\204\128-\205\180\205\182\205\183\205\186-\205\189\205\191\206\134-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\131-\210\135\210\138-\212\175\212\177-\213\150\213\153\213\161-\214\135\214\145-\214\189\214\191\215\129\215\130\215\132\215\133\215\135\215\144-\215\170\215\176-\215\178\216\144-\216\154\216\160-\217\169\217\174-\219\147\219\149-\219\156\219\159-\219\168\219\170-\219\188\219\191\220\144-\221\138\221\141-\222\177\223\128-\223\181\223\186\224\160\128-\224\160\173\224\161\128-\224\161\155\224\162\160-\224\162\178\224\163\164-\224\165\163\224\165\166-\224\165\175\224\165\177-\224\166\131\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\188-\224\167\132\224\167\135\224\167\136\224\167\139-\224\167\142\224\167\151\224\167\156\224\167\157\224\167\159-\224\167\163\224\167\166-\224\167\177\224\168\129-\224\168\131\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\168\188\224\168\190-\224\169\130\224\169\135\224\169\136\224\169\139-\224\169\141\224\169\145\224\169\153-\224\169\156\224\169\158\224\169\166-\224\169\181\224\170\129-\224\170\131\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\188-\224\171\133\224\171\135-\224\171\137\224\171\139-\224\171\141\224\171\144\224\171\160-\224\171\163\224\171\166-\224\171\175\224\172\129-\224\172\131\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\188-\224\173\132\224\173\135\224\173\136\224\173\139-\224\173\141\224\173\150\224\173\151\224\173\156\224\173\157\224\173\159-\224\173\163\224\173\166-\224\173\175\224\173\177\224\174\130\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\174\190-\224\175\130\224\175\134-\224\175\136\224\175\138-\224\175\141\224\175\144\224\175\151\224\175\166-\224\175\175\224\176\128-\224\176\131\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\185\224\176\189-\224\177\132\224\177\134-\224\177\136\224\177\138-\224\177\141\224\177\149\224\177\150\224\177\152\224\177\153\224\177\160-\224\177\163\224\177\166-\224\177\175\224\178\129-\224\178\131\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\188-\224\179\132\224\179\134-\224\179\136\224\179\138-\224\179\141\224\179\149\224\179\150\224\179\158\224\179\160-\224\179\163\224\179\166-\224\179\175\224\179\177\224\179\178\224\180\129-\224\180\131\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189-\224\181\132\224\181\134-\224\181\136\224\181\138-\224\181\142\224\181\151\224\181\160-\224\181\163\224\181\166-\224\181\175\224\181\186-\224\181\191\224\182\130\224\182\131\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\183\138\224\183\143-\224\183\148\224\183\150\224\183\152-\224\183\159\224\183\166-\224\183\175\224\183\178\224\183\179\224\184\129-\224\184\186\224\185\128-\224\185\142\224\185\144-\224\185\153\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\185\224\186\187-\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\136-\224\187\141\224\187\144-\224\187\153\224\187\156-\224\187\159\224\188\128\224\188\152\224\188\153\224\188\160-\224\188\169\224\188\181\224\188\183\224\188\185\224\188\190-\224\189\135\224\189\137-\224\189\172\224\189\177-\224\190\132\224\190\134-\224\190\151\224\190\153-\224\190\188\224\191\134\225\128\128-\225\129\137\225\129\144-\225\130\157\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\141\157-\225\141\159\225\141\169-\225\141\177\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\184\225\156\128-\225\156\140\225\156\142-\225\156\148\225\156\160-\225\156\180\225\157\128-\225\157\147\225\157\160-\225\157\172\225\157\174-\225\157\176\225\157\178\225\157\179\225\158\128-\225\159\147\225\159\151\225\159\156\225\159\157\225\159\160-\225\159\169\225\160\139-\225\160\141\225\160\144-\225\160\153\225\160\160-\225\161\183\225\162\128-\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\158\225\164\160-\225\164\171\225\164\176-\225\164\187\225\165\134-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\166\176-\225\167\137\225\167\144-\225\167\154\225\168\128-\225\168\155\225\168\160-\225\169\158\225\169\160-\225\169\188\225\169\191-\225\170\137\225\170\144-\225\170\153\225\170\167\225\170\176-\225\170\189\225\172\128-\225\173\139\225\173\144-\225\173\153\225\173\171-\225\173\179\225\174\128-\225\175\179\225\176\128-\225\176\183\225\177\128-\225\177\137\225\177\141-\225\177\189\225\179\144-\225\179\146\225\179\148-\225\179\182\225\179\184\225\179\185\225\180\128-\225\183\181\225\183\188-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\128\140\226\128\141\226\128\191\226\129\128\226\129\148\226\129\177\226\129\191\226\130\144-\226\130\156\226\131\144-\226\131\156\226\131\161\226\131\165-\226\131\176\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\152-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\181\191-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\183\160-\226\183\191\227\128\133-\227\128\135\227\128\161-\227\128\175\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\153-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\171\234\153\128-\234\153\175\234\153\180-\234\153\189\234\153\191-\234\154\157\234\154\159-\234\155\177\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\173\234\158\176\234\158\177\234\159\183-\234\160\167\234\161\128-\234\161\179\234\162\128-\234\163\132\234\163\144-\234\163\153\234\163\160-\234\163\183\234\163\187\234\164\128-\234\164\173\234\164\176-\234\165\147\234\165\160-\234\165\188\234\166\128-\234\167\128\234\167\143-\234\167\153\234\167\160-\234\167\190\234\168\128-\234\168\182\234\169\128-\234\169\141\234\169\144-\234\169\153\234\169\160-\234\169\182\234\169\186-\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\175\234\171\178-\234\171\182\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\172\176-\234\173\154\234\173\156-\234\173\159\234\173\164\234\173\165\234\175\128-\234\175\170\234\175\172\234\175\173\234\175\176-\234\175\185\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\184\128-\239\184\143\239\184\160-\239\184\173\239\184\179\239\184\180\239\185\141-\239\185\143\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\144-\239\188\153\239\188\161-\239\188\186\239\188\191\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]|\240\144\128\128[\240\144\128\128-\240\146\176\128\240\147\144\128-\240\153\160\128\240\154\128\128-\240\158\160\128\240\159\128\128\240\159\144\128\240\159\176\128-\240\163\144\128\240\164\128\128-\240\167\144\128\240\176\128\128-\241\142\160\128\241\160\128\128-\241\173\128\128\242\143\144\128\242\176\128\128-\242\183\128\128\242\184\128\128-\243\132\128\128\243\136\128\128\243\144\128\128-\243\151\176\128\243\156\128\128-\243\162\160\128\243\164\128\128-\243\174\160\128\243\176\128\128-\243\183\144\128\243\184\128\128-\244\128\176\128\244\130\128\128-\244\131\176\128\244\132\144\128-\244\133\144\128]|\240\144\144\128[\240\144\128\128-\240\183\144\128\240\184\128\128-\240\186\144\128\241\144\128\128-\241\153\176\128\241\156\128\128-\241\168\176\128\242\144\128\128-\243\157\160\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\169\176\128]|\240\144\160\128[\240\144\128\128-\240\145\144\128\240\146\128\128\240\146\160\128-\240\157\144\128\240\157\176\128\240\158\128\128\240\159\128\128\240\159\176\128-\240\165\144\128\240\168\128\128-\240\173\160\128\240\176\128\128-\240\183\160\128\241\144\128\128-\241\149\144\128\241\152\128\128-\241\158\144\128\241\176\128\128-\241\189\176\128\241\191\160\128\241\191\176\128\242\144\128\128-\242\144\176\128\242\145\144\128\242\145\160\128\242\147\128\128-\242\148\176\128\242\149\144\128-\242\149\176\128\242\150\144\128-\242\156\176\128\242\158\128\128-\242\158\160\128\242\159\176\128\242\168\128\128-\242\175\128\128\242\176\128\128-\242\183\128\128\243\128\128\128-\243\129\176\128\243\130\144\128-\243\137\160\128\243\144\128\128-\243\157\144\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\172\160\128\243\176\128\128-\243\180\144\128]|\240\144\176\128[\240\144\128\128-\240\162\128\128]|\240\145\128\128[\240\144\128\128-\240\161\160\128\240\169\160\128-\240\171\176\128\240\175\176\128-\240\190\160\128\241\132\128\128-\241\138\128\128\241\140\128\128-\241\142\144\128\241\144\128\128-\241\157\128\128\241\157\160\128-\241\159\176\128\241\164\128\128-\241\172\176\128\241\173\160\128\241\176\128\128-\242\129\128\128\242\132\128\128-\242\134\160\128\242\144\128\128-\242\148\144\128\242\148\176\128-\242\157\176\128\242\188\128\128-\243\138\160\128\243\140\128\128-\243\142\144\128\243\144\144\128-\243\144\176\128\243\145\144\128-\243\147\128\128\243\147\176\128\243\148\128\128\243\148\176\128-\243\154\128\128\243\154\160\128-\243\156\128\128\243\156\160\128\243\156\176\128\243\157\144\128-\243\158\144\128\243\159\128\128-\243\161\128\128\243\161\176\128\243\162\128\128\243\162\176\128-\243\163\144\128\243\165\176\128\243\167\144\128-\243\168\176\128\243\169\160\128-\243\171\128\128\243\172\128\128-\243\173\128\128]|\240\145\144\128[\240\176\128\128-\241\129\144\128\241\129\176\128\241\132\128\128-\241\134\144\128\241\176\128\128-\241\189\144\128\241\190\128\128-\242\128\128\128\242\144\128\128-\242\160\128\128\242\161\128\128\242\164\128\128-\242\166\144\128\242\176\128\128-\242\189\176\128\243\128\128\128-\243\130\144\128]|\240\145\160\128[\240\184\128\128-\241\138\144\128\241\143\176\128\243\128\128\128-\243\142\128\128]|\240\146\128\128[\240\144\128\128-\243\182\128\128]|\240\146\144\128[\240\144\128\128-\240\171\160\128]|[\240\147\128\128\240\160\128\128-\240\170\128\128\240\170\160\128-\240\171\128\128][\240\144\128\128-\244\143\176\128]|\240\147\144\128[\240\144\128\128-\240\155\160\128]|\240\150\160\128[\240\144\128\128-\242\158\128\128\242\160\128\128-\242\167\160\128\242\168\128\128-\242\170\144\128\243\132\128\128-\243\139\144\128\243\140\128\128-\243\141\128\128\243\144\128\128-\243\157\160\128\243\160\128\128-\243\160\176\128\243\164\128\128-\243\166\144\128\243\168\176\128-\243\173\176\128\243\175\144\128-\243\179\176\128]|\240\150\176\128[\243\144\128\128-\243\161\128\128\243\164\128\128-\243\175\160\128\243\179\176\128-\243\183\176\128]|\240\155\128\128[\240\144\128\128\240\144\144\128]|\240\155\176\128[\240\144\128\128-\240\170\160\128\240\172\128\128-\240\175\128\128\240\176\128\128-\240\178\128\128\240\180\128\128-\240\182\144\128\240\183\144\128\240\183\160\128]|\240\157\128\128[\241\169\144\128-\241\170\144\128\241\171\144\128-\241\172\160\128\241\174\176\128-\241\176\160\128\241\177\144\128-\241\178\176\128\241\186\160\128-\241\187\144\128\242\160\160\128-\242\161\128\128]|\240\157\144\128[\240\144\128\128-\240\165\128\128\240\165\160\128-\240\183\128\128\240\183\160\128\240\183\176\128\240\184\160\128\240\185\144\128\240\185\160\128\240\186\144\128-\240\187\128\128\240\187\160\128-\240\190\144\128\240\190\176\128\240\191\144\128-\241\128\176\128\241\129\144\128-\241\145\144\128\241\145\176\128-\241\146\160\128\241\147\144\128-\241\149\128\128\241\149\160\128-\241\151\128\128\241\151\160\128-\241\158\144\128\241\158\176\128-\241\159\160\128\241\160\128\128-\241\161\128\128\241\161\160\128\241\162\160\128-\241\164\128\128\241\164\160\128-\242\185\144\128\242\186\128\128-\243\128\128\128\243\128\160\128-\243\134\160\128\243\135\128\128-\243\142\160\128\243\143\128\128-\243\149\128\128\243\149\160\128-\243\157\128\128\243\157\160\128-\243\163\160\128\243\164\128\128-\243\171\160\128\243\172\128\128-\243\178\128\128\243\178\160\128-\243\186\128\128\243\186\160\128-\244\128\160\128\244\129\128\128-\244\130\176\128\244\131\160\128-\244\143\176\128]|\240\158\160\128[\240\144\128\128-\241\129\128\128\241\132\128\128-\241\133\160\128]|\240\158\176\128[\242\144\128\128-\242\144\176\128\242\145\144\128-\242\151\176\128\242\152\144\128\242\152\160\128\242\153\128\128\242\153\176\128\242\154\144\128-\242\156\160\128\242\157\128\128-\242\157\176\128\242\158\144\128\242\158\176\128\242\160\160\128\242\161\176\128\242\162\144\128\242\162\176\128\242\163\144\128-\242\163\176\128\242\164\144\128\242\164\160\128\242\165\128\128\242\165\176\128\242\166\144\128\242\166\176\128\242\167\144\128\242\167\176\128\242\168\144\128\242\168\160\128\242\169\128\128\242\169\176\128-\242\170\160\128\242\171\128\128-\242\172\160\128\242\173\128\128-\242\173\176\128\242\174\144\128-\242\175\128\128\242\175\160\128\242\176\128\128-\242\178\144\128\242\178\176\128-\242\182\176\128\242\184\144\128-\242\184\176\128\242\185\144\128-\242\186\144\128\242\186\176\128-\242\190\176\128]|\240\170\144\128[\240\144\128\128-\243\133\160\128\243\144\128\128-\244\143\176\128]|\240\171\144\128[\240\144\128\128-\243\157\128\128\243\160\128\128-\244\143\176\128]|\240\171\160\128[\240\144\128\128-\240\151\144\128]|\240\175\160\128[\240\144\128\128-\242\151\144\128]|\243\160\128\128[\241\144\128\128-\242\139\176\128]","")
});
WrappingNode.prototype = (function() Node.prototype = _obj({
["processComment"] = (function(this)
local _local3 = {};
_local3.bottomRight = _local2.extra.bottomRightStack;
_local3.last = _local3.bottomRight[(_local3.bottomRight.length - 1)];
if (this.type == _local2.Syntax.Program) then
if (_gt(this.body.length,0)) then
do return end
end

end

if ((function() local _lev=(this.type == _local2.Syntax.BlockStatement); if _bool(_lev) then return (this.body.length == 0); else return _lev; end end)()) then
_local3.innerComments = _arr({},0);
_local3.i = (_local2.extra.leadingComments.length - 1);
while (_ge(_local3.i,0)) do
_local3.comment = _local2.extra.leadingComments[_local3.i];
if (_ge(this.range[1],_local3.comment.range[1])) then
_local3.innerComments:unshift(_local3.comment);
_local2.extra.leadingComments:splice(_local3.i,1);
_local2.extra.trailingComments:splice(_local3.i,1);
end

_local3.i = _dec(_local3.i);
end

if _bool(_local3.innerComments.length) then
this.innerComments = _local3.innerComments;
do return end
end

end

if (_gt(_local2.extra.trailingComments.length,0)) then
_local3.trailingComments = _arr({},0);
_local3.i = (_local2.extra.trailingComments.length - 1);
while (_ge(_local3.i,0)) do
_local3.comment = _local2.extra.trailingComments[_local3.i];
if (_ge(_local3.comment.range[0],this.range[1])) then
_local3.trailingComments:unshift(_local3.comment);
_local2.extra.trailingComments:splice(_local3.i,1);
end

_local3.i = _dec(_local3.i);
end

_local2.extra.trailingComments = _arr({},0);
else
if _bool(((function() local _lev=((function() if _bool(_local3.last) then return _local3.last.trailingComments; else return _local3.last; end end)()); if _bool(_lev) then return (_ge(_local3.last.trailingComments[0].range[0],this.range[1])); else return _lev; end end)())) then
_local3.trailingComments = _local3.last.trailingComments;
(function () local _r = false; local _g, _s = _local3.last["_g" .. "trailingComments"], _local3.last["_s" .. "trailingComments"]; _local3.last["_g" .. "trailingComments"], _local3.last["_s" .. "trailingComments"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local3.last.trailingComments; _local3.last.trailingComments = nil; return _r or _v ~= nil; end)();
end

end

while _bool(((function() if _bool(_local3.last) then return (_ge(_local3.last.range[0],this.range[0])); else return _local3.last; end end)())) do
_local3.lastChild = _local3.bottomRight:pop();
_local3.last = _local3.bottomRight[(_local3.bottomRight.length - 1)];
::_continue::
end

if _bool(_local3.lastChild) then
if _bool(_local3.lastChild.leadingComments) then
_local3.leadingComments = _arr({},0);
_local3.i = (_local3.lastChild.leadingComments.length - 1);
while (_ge(_local3.i,0)) do
_local3.comment = _local3.lastChild.leadingComments[_local3.i];
if (_le(_local3.comment.range[1],this.range[0])) then
_local3.leadingComments:unshift(_local3.comment);
_local3.lastChild.leadingComments:splice(_local3.i,1);
end

_local3.i = _dec(_local3.i);
end

if not _bool(_local3.lastChild.leadingComments.length) then
_local3.lastChild.leadingComments = undefined;
end

end

elseif (_gt(_local2.extra.leadingComments.length,0)) then
_local3.leadingComments = _arr({},0);
_local3.i = (_local2.extra.leadingComments.length - 1);
while (_ge(_local3.i,0)) do
_local3.comment = _local2.extra.leadingComments[_local3.i];
if (_le(_local3.comment.range[1],this.range[0])) then
_local3.leadingComments:unshift(_local3.comment);
_local2.extra.leadingComments:splice(_local3.i,1);
end

_local3.i = _dec(_local3.i);
end

end

if _bool(((function() if _bool(_local3.leadingComments) then return (_gt(_local3.leadingComments.length,0)); else return _local3.leadingComments; end end)())) then
this.leadingComments = _local3.leadingComments;
end

if _bool(((function() if _bool(_local3.trailingComments) then return (_gt(_local3.trailingComments.length,0)); else return _local3.trailingComments; end end)())) then
this.trailingComments = _local3.trailingComments;
end

_local3.bottomRight:push(this);
end),
["finish"] = (function(this)
if _bool(_local2.extra.range) then
this.range[1] = _local2.lastIndex;
end

if _bool(_local2.extra.loc) then
this.loc["end"] = _obj({
["line"] = _local2.lastLineNumber,
["column"] = (_local2.lastIndex - _local2.lastLineStart)
});
if _bool(_local2.extra.source) then
this.loc.source = _local2.extra.source;
end

end

if _bool(_local2.extra.attachComment) then
this:processComment();
end

end),
["finishArrayExpression"] = (function(this,elements)
this.type = _local2.Syntax.ArrayExpression;
this.elements = elements;
this:finish();
do return this; end
end),
["finishArrayPattern"] = (function(this,elements)
this.type = _local2.Syntax.ArrayPattern;
this.elements = elements;
this:finish();
do return this; end
end),
["finishArrowFunctionExpression"] = (function(this,params,defaults,body,expression)
this.type = _local2.Syntax.ArrowFunctionExpression;
this.id = null;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = false;
this.expression = expression;
this:finish();
do return this; end
end),
["finishAssignmentExpression"] = (function(this,operator,left,right)
this.type = _local2.Syntax.AssignmentExpression;
this.operator = operator;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishAssignmentPattern"] = (function(this,left,right)
this.type = _local2.Syntax.AssignmentPattern;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishBinaryExpression"] = (function(this,operator,left,right)
this.type = (function() if ((function() local _lev=(operator == "||"); return _bool(_lev) and _lev or (operator == "&&") end)()) then return _local2.Syntax.LogicalExpression; else return _local2.Syntax.BinaryExpression; end end)();
this.operator = operator;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishBlockStatement"] = (function(this,body)
this.type = _local2.Syntax.BlockStatement;
this.body = body;
this:finish();
do return this; end
end),
["finishBreakStatement"] = (function(this,label)
this.type = _local2.Syntax.BreakStatement;
this.label = label;
this:finish();
do return this; end
end),
["finishCallExpression"] = (function(...)
local this,callee,args,arguments = ...;
local arguments = _args(...);
this.type = _local2.Syntax.CallExpression;
this.callee = callee;
this.arguments = args;
this:finish();
do return this; end
end),
["finishCatchClause"] = (function(this,param,body)
this.type = _local2.Syntax.CatchClause;
this.param = param;
this.body = body;
this:finish();
do return this; end
end),
["finishClassBody"] = (function(this,body)
this.type = _local2.Syntax.ClassBody;
this.body = body;
this:finish();
do return this; end
end),
["finishClassDeclaration"] = (function(this,id,superClass,body)
this.type = _local2.Syntax.ClassDeclaration;
this.id = id;
this.superClass = superClass;
this.body = body;
this:finish();
do return this; end
end),
["finishClassExpression"] = (function(this,id,superClass,body)
this.type = _local2.Syntax.ClassExpression;
this.id = id;
this.superClass = superClass;
this.body = body;
this:finish();
do return this; end
end),
["finishConditionalExpression"] = (function(this,test,consequent,alternate)
this.type = _local2.Syntax.ConditionalExpression;
this.test = test;
this.consequent = consequent;
this.alternate = alternate;
this:finish();
do return this; end
end),
["finishContinueStatement"] = (function(this,label)
this.type = _local2.Syntax.ContinueStatement;
this.label = label;
this:finish();
do return this; end
end),
["finishDebuggerStatement"] = (function(this)
this.type = _local2.Syntax.DebuggerStatement;
this:finish();
do return this; end
end),
["finishDoWhileStatement"] = (function(this,body,test)
this.type = _local2.Syntax.DoWhileStatement;
this.body = body;
this.test = test;
this:finish();
do return this; end
end),
["finishEmptyStatement"] = (function(this)
this.type = _local2.Syntax.EmptyStatement;
this:finish();
do return this; end
end),
["finishExpressionStatement"] = (function(this,expression)
this.type = _local2.Syntax.ExpressionStatement;
this.expression = expression;
this:finish();
do return this; end
end),
["finishForStatement"] = (function(this,init,test,update,body)
this.type = _local2.Syntax.ForStatement;
this.init = init;
this.test = test;
this.update = update;
this.body = body;
this:finish();
do return this; end
end),
["finishForOfStatement"] = (function(this,left,right,body)
this.type = _local2.Syntax.ForOfStatement;
this.left = left;
this.right = right;
this.body = body;
this:finish();
do return this; end
end),
["finishForInStatement"] = (function(this,left,right,body)
this.type = _local2.Syntax.ForInStatement;
this.left = left;
this.right = right;
this.body = body;
this.each = false;
this:finish();
do return this; end
end),
["finishFunctionDeclaration"] = (function(this,id,params,defaults,body,generator)
this.type = _local2.Syntax.FunctionDeclaration;
this.id = id;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = generator;
this.expression = false;
this:finish();
do return this; end
end),
["finishFunctionExpression"] = (function(this,id,params,defaults,body,generator)
this.type = _local2.Syntax.FunctionExpression;
this.id = id;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = generator;
this.expression = false;
this:finish();
do return this; end
end),
["finishIdentifier"] = (function(this,name)
this.type = _local2.Syntax.Identifier;
this.name = name;
this:finish();
do return this; end
end),
["finishIfStatement"] = (function(this,test,consequent,alternate)
this.type = _local2.Syntax.IfStatement;
this.test = test;
this.consequent = consequent;
this.alternate = alternate;
this:finish();
do return this; end
end),
["finishLabeledStatement"] = (function(this,label,body)
this.type = _local2.Syntax.LabeledStatement;
this.label = label;
this.body = body;
this:finish();
do return this; end
end),
["finishLiteral"] = (function(this,token)
this.type = _local2.Syntax.Literal;
this.value = token.value;
this.raw = _local2.source:slice(token.start,token["end"]);
if _bool(token.regex) then
this.regex = token.regex;
end

this:finish();
do return this; end
end),
["finishMemberExpression"] = (function(this,accessor,object,property)
this.type = _local2.Syntax.MemberExpression;
this.computed = (accessor == "[");
this.object = object;
this.property = property;
this:finish();
do return this; end
end),
["finishMetaProperty"] = (function(this,meta,property)
this.type = _local2.Syntax.MetaProperty;
this.meta = meta;
this.property = property;
this:finish();
do return this; end
end),
["finishNewExpression"] = (function(...)
local this,callee,args,arguments = ...;
local arguments = _args(...);
this.type = _local2.Syntax.NewExpression;
this.callee = callee;
this.arguments = args;
this:finish();
do return this; end
end),
["finishObjectExpression"] = (function(this,properties)
this.type = _local2.Syntax.ObjectExpression;
this.properties = properties;
this:finish();
do return this; end
end),
["finishObjectPattern"] = (function(this,properties)
this.type = _local2.Syntax.ObjectPattern;
this.properties = properties;
this:finish();
do return this; end
end),
["finishPostfixExpression"] = (function(this,operator,argument)
this.type = _local2.Syntax.UpdateExpression;
this.operator = operator;
this.argument = argument;
this.prefix = false;
this:finish();
do return this; end
end),
["finishProgram"] = (function(this,body,sourceType)
this.type = _local2.Syntax.Program;
this.body = body;
this.sourceType = sourceType;
this:finish();
do return this; end
end),
["finishProperty"] = (function(this,kind,key,computed,value,method,shorthand)
this.type = _local2.Syntax.Property;
this.key = key;
this.computed = computed;
this.value = value;
this.kind = kind;
this.method = method;
this.shorthand = shorthand;
this:finish();
do return this; end
end),
["finishRestElement"] = (function(this,argument)
this.type = _local2.Syntax.RestElement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishReturnStatement"] = (function(this,argument)
this.type = _local2.Syntax.ReturnStatement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishSequenceExpression"] = (function(this,expressions)
this.type = _local2.Syntax.SequenceExpression;
this.expressions = expressions;
this:finish();
do return this; end
end),
["finishSpreadElement"] = (function(this,argument)
this.type = _local2.Syntax.SpreadElement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishSwitchCase"] = (function(this,test,consequent)
this.type = _local2.Syntax.SwitchCase;
this.test = test;
this.consequent = consequent;
this:finish();
do return this; end
end),
["finishSuper"] = (function(this)
this.type = _local2.Syntax.Super;
this:finish();
do return this; end
end),
["finishSwitchStatement"] = (function(this,discriminant,cases)
this.type = _local2.Syntax.SwitchStatement;
this.discriminant = discriminant;
this.cases = cases;
this:finish();
do return this; end
end),
["finishTaggedTemplateExpression"] = (function(this,tag,quasi)
this.type = _local2.Syntax.TaggedTemplateExpression;
this.tag = tag;
this.quasi = quasi;
this:finish();
do return this; end
end),
["finishTemplateElement"] = (function(this,value,tail)
this.type = _local2.Syntax.TemplateElement;
this.value = value;
this.tail = tail;
this:finish();
do return this; end
end),
["finishTemplateLiteral"] = (function(this,quasis,expressions)
this.type = _local2.Syntax.TemplateLiteral;
this.quasis = quasis;
this.expressions = expressions;
this:finish();
do return this; end
end),
["finishThisExpression"] = (function(this)
this.type = _local2.Syntax.ThisExpression;
this:finish();
do return this; end
end),
["finishThrowStatement"] = (function(this,argument)
this.type = _local2.Syntax.ThrowStatement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishTryStatement"] = (function(this,block,handler,finalizer)
this.type = _local2.Syntax.TryStatement;
this.block = block;
this.guardedHandlers = _arr({},0);
this.handlers = (function() if _bool(handler) then return _arr({[0]=handler},1); else return _arr({},0); end end)();
this.handler = handler;
this.finalizer = finalizer;
this:finish();
do return this; end
end),
["finishUnaryExpression"] = (function(this,operator,argument)
this.type = (function() if ((function() local _lev=(operator == "++"); return _bool(_lev) and _lev or (operator == "--") end)()) then return _local2.Syntax.UpdateExpression; else return _local2.Syntax.UnaryExpression; end end)();
this.operator = operator;
this.argument = argument;
this.prefix = true;
this:finish();
do return this; end
end),
["finishVariableDeclaration"] = (function(this,declarations)
this.type = _local2.Syntax.VariableDeclaration;
this.declarations = declarations;
this.kind = "var";
this:finish();
do return this; end
end),
["finishLexicalDeclaration"] = (function(this,declarations,kind)
this.type = _local2.Syntax.VariableDeclaration;
this.declarations = declarations;
this.kind = kind;
this:finish();
do return this; end
end),
["finishVariableDeclarator"] = (function(this,id,init)
this.type = _local2.Syntax.VariableDeclarator;
this.id = id;
this.init = init;
this:finish();
do return this; end
end),
["finishWhileStatement"] = (function(this,test,body)
this.type = _local2.Syntax.WhileStatement;
this.test = test;
this.body = body;
this:finish();
do return this; end
end),
["finishWithStatement"] = (function(this,object,body)
this.type = _local2.Syntax.WithStatement;
this.object = object;
this.body = body;
this:finish();
do return this; end
end),
["finishExportSpecifier"] = (function(this,_g_local,exported)
this.type = _local2.Syntax.ExportSpecifier;
this.exported = (_bool(exported) and exported or _g_local);
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishImportDefaultSpecifier"] = (function(this,_g_local)
this.type = _local2.Syntax.ImportDefaultSpecifier;
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishImportNamespaceSpecifier"] = (function(this,_g_local)
this.type = _local2.Syntax.ImportNamespaceSpecifier;
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishExportNamedDeclaration"] = (function(this,declaration,specifiers,src)
this.type = _local2.Syntax.ExportNamedDeclaration;
this.declaration = declaration;
this.specifiers = specifiers;
this.source = src;
this:finish();
do return this; end
end),
["finishExportDefaultDeclaration"] = (function(this,declaration)
this.type = _local2.Syntax.ExportDefaultDeclaration;
this.declaration = declaration;
this:finish();
do return this; end
end),
["finishExportAllDeclaration"] = (function(this,src)
this.type = _local2.Syntax.ExportAllDeclaration;
this.source = src;
this:finish();
do return this; end
end),
["finishImportSpecifier"] = (function(this,_g_local,imported)
this.type = _local2.Syntax.ImportSpecifier;
this["local"] = (_bool(_g_local) and _g_local or imported);
this.imported = imported;
this:finish();
do return this; end
end),
["finishImportDeclaration"] = (function(this,specifiers,src)
this.type = _local2.Syntax.ImportDeclaration;
this.specifiers = specifiers;
this.source = src;
this:finish();
do return this; end
end),
["finishYieldExpression"] = (function(this,argument,delegate)
this.type = _local2.Syntax.YieldExpression;
this.argument = argument;
this.delegate = delegate;
this:finish();
do return this; end
end)
}); return Node.prototype end)();
exports.version = "2.7.2";
exports.tokenize = tokenize;
exports.parse = parse;
exports.Syntax = (function(this)
local _local3 = {};
_local3.types = _obj({});
if (_type(Object.create) == "function") then
_local3.types = Object:create(null);
end

local _p = _props(_local2.Syntax, true);
for _,name in _ipairs(_p) do
name = _tostr(name);
if _bool(_local2.Syntax:hasOwnProperty(_local3.name)) then
_local3.types[_local3.name] = _local2.Syntax[_local3.name];
end
::_continue::
end

if (_type(Object.freeze) == "function") then
Object:freeze(_local3.types);
end

do return _local3.types; end
end)(_ENV);
end));
return module.exports;
end, _ENV)();