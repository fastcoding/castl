_nodejs = true;
local _ENV = require("castl.runtime");
local module = _obj({exports = _obj({})});
local exports = module.exports;
(function(this,root,factory)
if _bool(((function() local _lev=(_type(define) == "function"); if _bool(_lev) then return define.amd; else return _lev; end end)())) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif (exports ~= undefined) then
factory(_ENV,exports);
else
root.castl = _obj({});
factory(_ENV,root.castl);
end

end)(_ENV,this,(function(this,exports)
local _local2 = {};
setMeta =((function(this,node,meta)
if _bool(_local2.options.annotation) then
if _bool(((function() local _lev=_local2.annotations[(node.loc.start.line - 1)]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = _local2.annotations[(node.loc.start.line - 1)];
do return end
end

end

if _bool(_local2.options.heuristic) then
if _bool(((function() local _lev=_local2.deductions[node.loc.start.line]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = _local2.deductions[node.loc.start.line];
end

end

end));
CompileResult =((function(this,arr,sep)
this.array = (_bool(arr) and arr or _arr({},0));
this.sep = (_bool(sep) and sep or "");
do return this; end
end));
isNumOrString =((function(this,d)
do return (_ge(_arr({[0]="string","number"},2):indexOf(d),0)); end
end));
__mergeArray =((function(this,arr,src,sep)
local _local3 = {};
if not _bool(sep) then
sep = "";
end

src:forEach((function(this,v,idx)
local _local4 = {};
_local4.curTp = _type(v);
if _bool(isCompileResultLike(_ENV,v)) then
if _bool(((function() local _lev=v.array; if _bool(_lev) then return (_gt(v.array.length,0)); else return _lev; end end)())) then
arr:push(v);
end

else
if (v ~= "") then
if (idx == 0) then
arr:push(v);
else
if _bool(((function() local _lev=isNumOrString(_ENV,_local3.lastTp); if _bool(_lev) then return isNumOrString(_ENV,_local4.curTp); else return _lev; end end)())) then
do local _cp = (arr.length - 1); arr[_cp] = (_add(arr[_cp],(_add(sep,v)))) end;
else
arr:push(v);
end

end

end

end

_local3.lastTp = _local4.curTp;
end));
do return arr; end
end));
isCompileResultLike =((function(this,anyObj)
do return ((function() local _lev=((function() local _lev=anyObj.prototype; if _bool(_lev) then return (anyObj.prototype.constructor.name == "CompileResult"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(not _eq(anyObj.array,undefined)); if _bool(_lev) then return (not _eq(anyObj.sep,undefined)); else return _lev; end end)()) end)()); end
end));
ProtectedCallManager =((function(this)
this.protectedCallContext = _arr({},0);
this.mayReturnStack = _arr({},0);
this.mayBreakStack = _arr({},0);
this.mayContinueStack = _arr({},0);
this.iterationStatement = _arr({},0);
this.switchStatement = _arr({},0);
end));
LocalVarManager =((function(this)
this.pathNums = _arr({},0);
this.unresolved = _arr({},0);
this.locals = _arr({},0);
this.functions = _arr({},0);
this.args = _arr({},0);
end));
compileAST =((function(this,ast,opts,anno)
local _local3 = {};
_local2.options = (_bool(opts) and opts or _obj({}));
_local2.annotations = (_bool(anno) and anno or _obj({}));
if _bool(_local2.options.luaLocal) then
console:log("limited mode enabled - limited to 200 js vars each scope");
end

if (ast.type == "Program") then
_local3.compiledProgram = _new(CompileResult,_arr({},0),"\10");
_local2.localVarManager:reset();
_local2.localVarManager:createLocalContext();
_local3.topLevelStatements = compileListOfStatements(_ENV,ast.body);
_local3.context = _local2.localVarManager:popLocalContext();
_local3.useArguments = _local3.context[1];
if _bool(_local3.useArguments) then
_local3.compiledProgram:push("local arguments = _args(...);");
end

_local3.locals = _local3.context[0];
if (_gt(_local3.locals.length,0)) then
_local3.compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,_local3.locals);
_local3.compiledProgram:push(_local3.compiledLocalsDeclaration);
end

_local3.functions = _local3.context[2];
if (_gt(_local3.functions.length,0)) then
_local3.compiledFunctionsDeclaration = _new(CompileResult,_arr({},0));
_local3.i = 0;
while (_lt(_local3.i,_local3.functions.length)) do
_local3.compiledFunctionsDeclaration:push(_local3.functions[_local3.i]);
_local3.i = _inc(_local3.i);
end

_local3.compiledProgram:push(_local3.compiledFunctionsDeclaration:join("\10"));
end

_local3.compiledProgram:push(_local3.topLevelStatements);
do return _obj({
["success"] = true,
["compiled"] = _local3.compiledProgram:joinFinal("\10")
}); end
end

do return _obj({
["success"] = false,
["compiled"] = ""
}); end
end));
compileStatement =((function(this,statement)
local _local3 = {};
repeat
local _into = false;
local _cases = {["ExpressionStatement"] = true,["BlockStatement"] = true,["FunctionDeclaration"] = true,["VariableDeclaration"] = true,["IfStatement"] = true,["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true,["ReturnStatement"] = true,["BreakStatement"] = true,["TryStatement"] = true,["ThrowStatement"] = true,["SwitchStatement"] = true,["ContinueStatement"] = true,["LabeledStatement"] = true,["WithStatement"] = true,["EmptyStatement"] = true,["DebuggerStatement"] = true,["ForOfStatement"] = true,["ClassDeclaration"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ExpressionStatement") then
_local3.compiledStatement = compileExpressionStatement(_ENV,statement.expression);
break;
_into = true;
end
if _into or (_v == "BlockStatement") then
_local3.compiledStatement = compileListOfStatements(_ENV,statement.body);
break;
_into = true;
end
if _into or (_v == "FunctionDeclaration") then
_local3.compiledStatement = compileFunctionDeclaration(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "VariableDeclaration") then
_local3.compiledStatement = compileVariableDeclaration(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "IfStatement") then
_local3.compiledStatement = compileIfStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "ForStatement") then

_into = true;
end
if _into or (_v == "WhileStatement") then

_into = true;
end
if _into or (_v == "DoWhileStatement") then

_into = true;
end
if _into or (_v == "ForInStatement") then
_local3.compiledStatement = compileIterationStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "ReturnStatement") then
_local3.compiledStatement = compileReturnStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "BreakStatement") then
_local3.compiledStatement = compileBreakStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "TryStatement") then
_local3.compiledStatement = compileTryStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "ThrowStatement") then
_local3.compiledStatement = compileThrowStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "SwitchStatement") then
_local3.compiledStatement = compileSwitchStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "ContinueStatement") then
_local3.compiledStatement = compileContinueStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "LabeledStatement") then
_local3.compiledStatement = compileLabeledStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "WithStatement") then
_local3.compiledStatement = compileWithStatement(_ENV,statement);
break;
_into = true;
end
if _into or (_v == "EmptyStatement") then

_into = true;
end
if _into or (_v == "DebuggerStatement") then
do return ""; end
_into = true;
end
if _into or (_v == "ForOfStatement") then
_throw(_new(Error,"For...of statement (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "ClassDeclaration") then
_throw(_new(Error,"Class declaration (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown Statement type: ",statement.type))),0)
_into = true;
end
until true
if (_local3.compiledStatement ~= undefined) then
if _bool(_local2.options.debug) then
_local3.line = statement.loc.start.line;
do return _new(CompileResult,_arr({[0]=((_addStr1("--[[",_local3.line)) .. "--]] ")},1)):push(_local3.compiledStatement); end
end

do return _local3.compiledStatement; end
end

end));
compileListOfStatements =((function(this,statementList)
local _local3 = {};
_local3.compiledStatements = _new(CompileResult,_arr({},0),"\10");
_local3.i = 0;
while (_lt(_local3.i,statementList.length)) do
_local3.compiledStatement = compileStatement(_ENV,statementList[_local3.i]);
if ((function() local _lev=(_local3.compiledStatement ~= ""); if _bool(_lev) then return (_local3.compiledStatement ~= undefined); else return _lev; end end)()) then
_local3.compiledStatements:push(_local3.compiledStatement);
end

_local3.i = _inc(_local3.i);
end

do return _local3.compiledStatements; end
end));
compileBooleanExpression =((function(this,expression)
local _local3 = {};
_local3.compiledBooleanExpression = _new(CompileResult);
_local3.meta = _obj({});
_local3.compiledExpression = compileExpression(_ENV,expression,_local3.meta);
if (_local3.meta.type == "boolean") then
_local3.compiledBooleanExpression:push(_local3.compiledExpression);
else
_local3.compiledBooleanExpression:push("_bool(");
_local3.compiledBooleanExpression:push(_local3.compiledExpression);
_local3.compiledBooleanExpression:push(")");
end

do return _local3.compiledBooleanExpression; end
end));
compileIfStatement =((function(this,statement,elif)
local _local3 = {};
_local3.compiledIfStatement = _new(CompileResult);
if _bool(elif) then
_local3.compiledIfStatement:push("elseif ");
else
_local3.compiledIfStatement:push("if ");
end

_local3.compiledIfStatement:push(compileBooleanExpression(_ENV,statement.test));
_local3.compiledIfStatement:push(" then\10");
_local3.compiledIfStatement:push(compileStatement(_ENV,statement.consequent));
if (statement.alternate ~= null) then
_local3.compiledIfStatement:push("\10");
if (statement.alternate.type == "IfStatement") then
_local3.compiledIfStatement:push(compileIfStatement(_ENV,statement.alternate,true));
else
_local3.compiledIfStatement:push("else\10");
_local3.compiledIfStatement:push(compileStatement(_ENV,statement.alternate));
end

end

if not _bool(elif) then
_local3.compiledIfStatement:push("\10");
_local3.compiledIfStatement:push("end\10");
end

do return _local3.compiledIfStatement; end
end));
compileIterationStatement =((function(this,statement,compiledLabel)
local _local3 = {};
_local3.compiledIterationStatement = "";
_local2.continueNoLabelTracker:push(false);
_local2.protectedCallManager:openIterationStatement();
repeat
local _into = false;
local _cases = {["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ForStatement") then
_local3.compiledIterationStatement = compileForStatement(_ENV,statement,compiledLabel);
break;
_into = true;
end
if _into or (_v == "WhileStatement") then
_local3.compiledIterationStatement = compileWhileStatement(_ENV,statement,compiledLabel);
break;
_into = true;
end
if _into or (_v == "DoWhileStatement") then
_local3.compiledIterationStatement = compileDoWhileStatement(_ENV,statement,compiledLabel);
break;
_into = true;
end
if _into or (_v == "ForInStatement") then
_local3.compiledIterationStatement = compileForInStatement(_ENV,statement,compiledLabel);
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Not an IterationStatement ",statement.type))),0)
_into = true;
end
until true
_local2.protectedCallManager:closeIterationStatement();
_local2.continueNoLabelTracker:pop();
do return _local3.compiledIterationStatement; end
end));
compileForInit =((function(this,init)
local _local3 = {};
_local3.compiledForInit = _new(CompileResult);
if (init ~= null) then
if (init.type == "VariableDeclaration") then
_local3.compiledForInit:push(compileVariableDeclaration(_ENV,init));
else
_local3.compiledForInit:push(compileExpressionStatement(_ENV,init));
end

_local3.compiledForInit:push("\10");
end

do return _local3.compiledForInit; end
end));
compileForUpdate =((function(this,update)
local _local3 = {};
_local3.compiledForUpdate = _new(CompileResult);
if (update ~= null) then
_local3.compiledForUpdate:push(compileExpressionStatement(_ENV,update));
_local3.compiledForUpdate:push("\10");
end

do return _local3.compiledForUpdate; end
end));
compileForTest =((function(this,test)
if (test ~= null) then
do return compileBooleanExpression(_ENV,test); end
end

do return "true"; end
end));
isCompoundAssignment =((function(this,expression)
if (expression.type == "AssignmentExpression") then
do return (_gt(_arr({[0]="*=","/=","%=","+=","-=","<<=",">>=",">>>=","&=","^=","|="},11):indexOf(expression.operator),-1)); end
end

do return false; end
end));
isUpdateExpressionWith =((function(this,expression,variables)
if ((function() local _lev=(expression ~= null); if _bool(_lev) then return (expression.type == "UpdateExpression"); else return _lev; end end)()) then
if (expression.argument.type == "Identifier") then
do return (_gt(variables:indexOf(expression.argument.name),-1)); end
end

end

do return false; end
end));
isNumericCompoundAssignmentExpressionWith =((function(this,expression,variables)
local _local3 = {};
if _bool(((function() local _lev=(expression ~= null); if _bool(_lev) then return isCompoundAssignment(_ENV,expression); else return _lev; end end)())) then
if ((function() local _lev=(expression.left.type == "Identifier"); if _bool(_lev) then return (_gt(variables:indexOf(expression.left.name),-1)); else return _lev; end end)()) then
if (expression.operator == "+=") then
_local3.metaRight = _obj({});
compileExpression(_ENV,expression.right,_local3.metaRight);
do return (_local3.metaRight.type == "number"); end
end

do return true; end
end

end

do return false; end
end));
isComparisonExpressionWith =((function(this,expression,variables)
if (expression ~= null) then
if (expression.type == "BinaryExpression") then
if (_gt(_arr({[0]="<","<=",">",">="},4):indexOf(expression.operator),-1)) then
if (expression.left.type == "Identifier") then
if (_gt(variables:indexOf(expression.left.name),-1)) then
do return true; end
end

elseif (expression.right.type == "Identifier") then
if (_gt(variables:indexOf(expression.right.name),-1)) then
do return true; end
end

end

end

end

end

do return false; end
end));
mayBeNumericFor =((function(this,statement)
local _local3 = {};
_local3.possibleNumericForVariable = _arr({},0);
_local3.init = statement.init;
if (_local3.init == null) then
do return false; end
end

if (_local3.init.type == "VariableDeclaration") then
_local3.declarations = _local3.init.declarations;
_local3.i = 0;
while (_lt(_local3.i,_local3.declarations.length)) do
if (_local3.declarations[_local3.i].init ~= null) then
_local3.metaRight = _obj({});
compileExpression(_ENV,_local3.declarations[_local3.i].init,_local3.metaRight);
if (_local3.metaRight.type == "number") then
_local3.possibleNumericForVariable:push(_local3.declarations[_local3.i].id.name);
end

end

_local3.i = _inc(_local3.i);
end

elseif (_local3.init.type == "AssignmentExpression") then
if (_local3.init.left.type == "Identifier") then
_local3.metaRight = _obj({});
compileExpression(_ENV,_local3.init.right,_local3.metaRight);
if (_local3.metaRight.type == "number") then
_local3.possibleNumericForVariable:push(_local3.init.left.name);
end

end

end

if (_gt(_local3.possibleNumericForVariable.length,0)) then
if _bool(isComparisonExpressionWith(_ENV,statement.test,_local3.possibleNumericForVariable)) then
if _bool(isUpdateExpressionWith(_ENV,statement.update,_local3.possibleNumericForVariable)) then
do return true; end
end

if _bool(isNumericCompoundAssignmentExpressionWith(_ENV,statement.update,_local3.possibleNumericForVariable)) then
do return true; end
end

end

end

do return false; end
end));
compileForStatement =((function(this,statement,compiledLabel)
local _local3 = {};
_local3.compiledForStatement = _new(CompileResult);
if _bool(_local2.options.heuristic) then
if _bool(mayBeNumericFor(_ENV,statement)) then
_local2.deductions[statement.loc.start.line] = "number";
end

end

_local3.compiledForStatement:push(compileForInit(_ENV,statement.init));
_local3.compiledForStatement:push("while ");
_local3.compiledForStatement:push(compileForTest(_ENV,statement.test));
_local3.compiledForStatement:push(" do\10");
_local3.compiledForStatement:push(compileStatement(_ENV,statement.body));
_local3.compiledForStatement:push("\10");
if _bool(_local2.continueNoLabelTracker[(_local2.continueNoLabelTracker.length - 1)]) then
_local3.compiledForStatement:push("::_continue::\10");
end

if _bool(((function() if _bool(compiledLabel) then return _local2.labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
_local3.compiledForStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

_local3.compiledForStatement:push(compileForUpdate(_ENV,statement.update));
_local3.compiledForStatement:push("end\10");
do return _local3.compiledForStatement; end
end));
compileForInStatement =((function(this,statement,compiledLabel)
local _local3 = {};
_local3.compiledForInStatement = _new(CompileResult);
_local3.compiledForInStatement:push("local _p = _props(");
_local3.compiledForInStatement:push(compileExpression(_ENV,statement.right));
_local3.compiledForInStatement:push(", true);\10");
if (statement.left.type == "VariableDeclaration") then
_local3.compiledLeft = compilePattern(_ENV,statement.left.declarations[0].id);
else
_local3.compiledLeft = compileExpression(_ENV,statement.left);
end

_local3.compiledForInStatement:push("for _,");
_local3.compiledForInStatement:push(_local3.compiledLeft);
_local3.compiledForInStatement:push(" in _ipairs(_p) do\10");
_local3.compiledForInStatement:push(_local3.compiledLeft);
_local3.compiledForInStatement:push(" = _tostr(");
_local3.compiledForInStatement:push(_local3.compiledLeft);
_local3.compiledForInStatement:push(");\10");
_local3.compiledForInStatement:push(compileStatement(_ENV,statement.body));
_local3.compiledForInStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return _local2.labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
_local3.compiledForInStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

_local3.compiledForInStatement:push("end\10");
do return _local3.compiledForInStatement; end
end));
compileWhileStatement =((function(this,statement,compiledLabel)
local _local3 = {};
_local3.compiledWhileStatement = _new(CompileResult,_arr({[0]="while "},1));
_local3.compiledWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
_local3.compiledWhileStatement:push(" do\10");
_local3.compiledWhileStatement:push(compileStatement(_ENV,statement.body));
_local3.compiledWhileStatement:push("\10");
_local3.compiledWhileStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return _local2.labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
_local3.compiledWhileStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

_local3.compiledWhileStatement:push("end\10");
do return _local3.compiledWhileStatement; end
end));
compileDoWhileStatement =((function(this,statement,compiledLabel)
local _local3 = {};
_local3.compiledDoWhileStatement = _new(CompileResult,_arr({[0]="repeat\10"},1));
_local3.compiledDoWhileStatement:push(compileStatement(_ENV,statement.body));
_local3.compiledDoWhileStatement:push("\10");
_local3.compiledDoWhileStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return _local2.labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
_local3.compiledDoWhileStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

_local3.compiledDoWhileStatement:push("until not ");
_local3.compiledDoWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
_local3.compiledDoWhileStatement:push("\10");
do return _local3.compiledDoWhileStatement; end
end));
isIterationStatement =((function(this,statement)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(statement.type == "ForStatement"); return _bool(_lev) and _lev or (statement.type == "DoWhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "WhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "ForInStatement") end)()); end
end));
compileLabeledStatement =((function(this,statement)
local _local3 = {};
_local3.compiledLabeledStatement = _new(CompileResult);
_local3.label = statement.label;
_local3.compiledLabel = compileIdentifier(_ENV,_local3.label,"label");
_local2.labelTracker[_local3.compiledLabel] = _obj({
["mayBreak"] = false,
["mayContinue"] = false
});
if _bool(isIterationStatement(_ENV,statement.body)) then
_local3.compiledLabeledStatement:push(compileIterationStatement(_ENV,statement.body,_local3.compiledLabel));
else
_local3.compiledLabeledStatement:push(compileStatement(_ENV,statement.body));
end

if _bool(_local2.labelTracker[_local3.compiledLabel].mayBreak) then
_local3.compiledLabeledStatement:push(((_addStr1("::",_local3.compiledLabel)) .. "_b::\10"));
end

(function () local _r = false; local _g, _s = _local2.labelTracker["_g" .. _local3.compiledLabel], _local2.labelTracker["_s" .. _local3.compiledLabel]; _local2.labelTracker["_g" .. _local3.compiledLabel], _local2.labelTracker["_s" .. _local3.compiledLabel] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = _local2.labelTracker[_local3.compiledLabel]; _local2.labelTracker[_local3.compiledLabel] = nil; return _r or _v ~= nil; end)();
do return _local3.compiledLabeledStatement; end
end));
compileBreakStatement =((function(this,statement)
local _local3 = {};
if (statement.label == null) then
if _bool(_local2.protectedCallManager:breakOutside()) then
do return "do return _break; end"; end
end

if _bool(_local2.options.jit) then
do return "do break end;"; end
else
do return "break;"; end
end

end

_local3.compiledLabel = compileIdentifier(_ENV,statement.label,"label");
_local2.labelTracker[_local3.compiledLabel].mayBreak = true;
do return _new(CompileResult,_arr({[0]="goto ",_local3.compiledLabel,"_b;"},3),""); end
end));
compileContinueStatement =((function(this,statement)
local _local3 = {};
if (statement.label == null) then
_local2.continueNoLabelTracker[(_local2.continueNoLabelTracker.length - 1)] = true;
if _bool(_local2.protectedCallManager:continueOutside()) then
do return "do return _continue; end"; end
end

do return _new(CompileResult,_arr({[0]="goto _continue"},1),""); end
end

_local3.compiledLabel = compileIdentifier(_ENV,statement.label,"label");
_local2.labelTracker[_local3.compiledLabel].mayContinue = true;
do return _new(CompileResult,_arr({[0]="goto ",_local3.compiledLabel,"_c;"},3)); end
end));
compileSwitchStatement =((function(this,statement)
local _local3 = {};
_local2.protectedCallManager:openSwitchStatement();
_local3.cases = statement.cases;
if (_gt(_local3.cases.length,0)) then
_local3.compiledSwitchStatement = _new(CompileResult,_arr({[0]="repeat\10local _into = false;\10"},1));
_local3.casesTable = _new(CompileResult);
_local3.compiledTests = _arr({},0);
_local3.i = 0;
while (_lt(_local3.i,_local3.cases.length)) do
if (_local3.cases[_local3.i].test ~= null) then
_local3.compiledTests[_local3.i] = compileExpression(_ENV,_local3.cases[_local3.i].test);
_local3.caseTablementElement = _new(CompileResult);
_local3.caseTablementElement:push("[");
_local3.caseTablementElement:push(_local3.compiledTests[_local3.i]);
_local3.caseTablementElement:push("] = true");
_local3.casesTable:push(_local3.caseTablementElement);
end

_local3.i = _inc(_local3.i);
end

_local3.compiledSwitchStatement:push("local _cases = {");
_local3.compiledSwitchStatement:push(_local3.casesTable:join(","));
_local3.compiledSwitchStatement:push("};\10");
_local3.compiledSwitchStatement:push("local _v = ");
_local3.compiledSwitchStatement:push(compileExpression(_ENV,statement.discriminant));
_local3.compiledSwitchStatement:push(";\10");
_local3.compiledSwitchStatement:push("if not _cases[_v] then\10");
_local3.compiledSwitchStatement:push("_into = true;\10");
_local3.compiledSwitchStatement:push("goto _default\10");
_local3.compiledSwitchStatement:push("end\10");
_local3.hasDefault = false;
_local3.i = 0;
while (_lt(_local3.i,_local3.cases.length)) do
if (_local3.cases[_local3.i].test ~= null) then
_local3.compiledSwitchStatement:push("if _into or (_v == ");
_local3.compiledSwitchStatement:push(_local3.compiledTests[_local3.i]);
_local3.compiledSwitchStatement:push(") then\10");
else
_local3.hasDefault = true;
_local3.compiledSwitchStatement:push("::_default::\10");
_local3.compiledSwitchStatement:push("if _into then\10");
end

_local3.compiledSwitchStatement:push(compileListOfStatements(_ENV,_local3.cases[_local3.i].consequent));
_local3.compiledSwitchStatement:push("\10");
_local3.compiledSwitchStatement:push("_into = true;\10");
_local3.compiledSwitchStatement:push("end\10");
_local3.i = _inc(_local3.i);
end

if not _bool(_local3.hasDefault) then
_local3.compiledSwitchStatement:push("::_default::\10");
end

_local3.compiledSwitchStatement:push("until true");
_local2.protectedCallManager:closeSwitchStatement();
do return _local3.compiledSwitchStatement; end
end

_local2.protectedCallManager:closeSwitchStatement();
do return ""; end
end));
compileTryStatement =((function(this,statement)
if _bool(statement.handlers) then
do return compileTryStatementFlavored(_ENV,statement,true); end
end

do return compileTryStatementFlavored(_ENV,statement,false); end
end));
compileTryStatementFlavored =((function(this,statement,esprima)
local _local3 = {};
_local3.hasHandler = (function() if _bool(esprima) then return (_gt(statement.handlers.length,0)); else return (statement.handler ~= null); end end)();
_local3.hasFinalizer = (statement.finalizer ~= null);
_local2.protectedCallManager:openContext();
_local3.compiledTryStatement = _new(CompileResult,_arr({[0]="local _status, _return = _pcall(function()\10"},1));
_local3.compiledTryStatement:push(compileListOfStatements(_ENV,statement.block.body));
_local3.compiledTryStatement:push("\10");
_local3.compiledTryStatement:push("end);\10");
_local3.may = _local2.protectedCallManager:may();
_local2.protectedCallManager:closeContext();
if _bool(((function() local _lev=((function() local _lev=(_bool(_local3.hasFinalizer) and _local3.hasFinalizer or _local3.may.mayReturn); return _bool(_lev) and _lev or _local3.may.mayBreak end)()); return _bool(_lev) and _lev or _local3.may.mayContinue end)())) then
_local3.compiledTryStatement:push("if _status then\10");
if _bool(_local3.hasFinalizer) then
_local3.finallyStatements = compileListOfStatements(_ENV,statement.finalizer.body);
_local3.compiledTryStatement:push(_local3.finallyStatements);
_local3.compiledTryStatement:push("\10");
end

if _bool(((function() local _lev=_local3.may.mayBreak; if _bool(_lev) then return _local3.may.mayContinue; else return _lev; end end)())) then
_local3.compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\10");
elseif _bool(_local3.may.mayBreak) then
_local3.compiledTryStatement:push("if _return == _break then break; end\10");
elseif _bool(_local3.may.mayContinue) then
_local3.compiledTryStatement:push("if _return == _continue then goto _continue end\10");
end

if _bool(_local3.may.mayReturn) then
_local3.compiledTryStatement:push("if _return ~= nil then return _return; end\10");
end

_local3.compiledTryStatement:push("else\10");
else
_local3.compiledTryStatement:push("if not _status then\10");
end

if _bool(_local3.hasHandler) then
_local3.handler = (function() if _bool(esprima) then return statement.handlers[0]; else return statement.handler; end end)();
_local2.protectedCallManager:openContext();
_local3.compiledTryStatement:push("local _cstatus, _creturn = _pcall(function()\10");
_local3.compiledTryStatement:push("local ");
_local3.compiledTryStatement:push(compilePattern(_ENV,_local3.handler.param));
_local3.compiledTryStatement:push(" = _return;\10");
_local3.compiledTryStatement:push(compileListOfStatements(_ENV,_local3.handler.body.body));
_local3.compiledTryStatement:push("\10");
_local3.compiledTryStatement:push("end);\10");
_local3.may = _local2.protectedCallManager:may();
_local2.protectedCallManager:closeContext();
end

if _bool(_local3.hasFinalizer) then
_local3.compiledTryStatement:push(_local3.finallyStatements);
_local3.compiledTryStatement:push("\10");
end

if _bool(_local3.hasHandler) then
_local3.compiledTryStatement:push("if _cstatus then\10");
if _bool(((function() local _lev=_local3.may.mayBreak; if _bool(_lev) then return _local3.may.mayContinue; else return _lev; end end)())) then
_local3.compiledTryStatement:push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\10");
elseif _bool(_local3.may.mayBreak) then
_local3.compiledTryStatement:push("if _creturn == _break then break; end\10");
elseif _bool(_local3.may.mayContinue) then
_local3.compiledTryStatement:push("if _creturn == _continue then goto _continue end\10");
end

if _bool(_local3.may.mayReturn) then
_local3.compiledTryStatement:push("if _creturn ~= nil then return _creturn; end\10");
end

_local3.compiledTryStatement:push("else _throw(_creturn,0); end\10");
end

_local3.compiledTryStatement:push("end\10");
do return _local3.compiledTryStatement; end
end));
compileThrowStatement =((function(this,statement)
local _local3 = {};
_local3.compiledThrowStatement = _new(CompileResult,_arr({[0]="_throw("},1));
_local3.compiledThrowStatement:push(compileExpression(_ENV,statement.argument));
_local3.compiledThrowStatement:push(",0)");
do return _local3.compiledThrowStatement; end
end));
compileReturnStatement =((function(this,statement)
_local2.protectedCallManager:returnStatement();
if (statement.argument ~= null) then
do return _new(CompileResult,_arr({[0]="do return ",compileExpression(_ENV,statement.argument,_obj({})),"; end"},3)); end
end

do return "do return end"; end
end));
compileWithStatement =((function(this,statement)
local _local3 = {};
_local2.withTracker:push(true);
_local3.compiledWithStatement = _new(CompileResult,_arr({[0]="do\10"},1));
_local3.compiledWithStatement:push("local _oldENV = _ENV;\10");
_local3.compiledWithStatement:push("local _ENV = _with(");
_local3.compiledWithStatement:push(compileExpression(_ENV,statement.object));
_local3.compiledWithStatement:push(", _ENV);\10");
if _bool(_local2.options.jit) then
_local3.compiledWithStatement:push("_wenv(function(...)\10");
end

_local3.compiledWithStatement:push(compileStatement(_ENV,statement.body));
if _bool(_local2.options.jit) then
_local3.compiledWithStatement:push("\10end, _ENV)()");
end

_local3.compiledWithStatement:push("\10end");
_local2.withTracker:pop();
do return _local3.compiledWithStatement; end
end));
compileExpression =((function(this,expression,meta)
repeat
local _into = false;
local _cases = {["AssignmentExpression"] = true,["FunctionExpression"] = true,["Identifier"] = true,["Literal"] = true,["UnaryExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["MemberExpression"] = true,["CallExpression"] = true,["NewExpression"] = true,["ThisExpression"] = true,["ObjectExpression"] = true,["UpdateExpression"] = true,["ArrayExpression"] = true,["ConditionalExpression"] = true,["SequenceExpression"] = true,["ArrowFunctionExpression"] = true,["TemplateLiteral"] = true,["SpreadElement"] = true,["MetaProperty"] = true};
local _v = expression.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "AssignmentExpression") then
do return compileAssignmentExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "FunctionExpression") then
do return compileFunction(_ENV,expression,(_bool(meta) and meta or true)); end
_into = true;
end
if _into or (_v == "Identifier") then
do return compileIdentifier(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "Literal") then
do return compileLiteral(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "UnaryExpression") then
do return compileUnaryExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "BinaryExpression") then
do return compileBinaryExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "LogicalExpression") then
do return compileLogicalExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "MemberExpression") then
do return compileMemberExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "CallExpression") then
do return compileCallExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "NewExpression") then
do return compileNewExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ThisExpression") then
do return compileThisExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ObjectExpression") then
do return compileObjectExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "UpdateExpression") then
do return compileUpdateExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ArrayExpression") then
do return compileArrayExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ConditionalExpression") then
do return compileConditionalExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "SequenceExpression") then
do return compileSequenceExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ArrowFunctionExpression") then
_throw(_new(Error,"Arrow functions (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "TemplateLiteral") then
_throw(_new(Error,"String templating (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "SpreadElement") then
_throw(_new(Error,"Spread operator (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "MetaProperty") then
_throw(_new(Error,"Meta property (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown Expression type: ",expression.type))),0)
_into = true;
end
until true
end));
compileExpressionStatement =((function(this,expression,meta)
if _bool(_local2.options.evalMode) then
do return compileExpressionStatementEvalMode(_ENV,expression,meta); end
else
do return compileExpressionStatementNoEval(_ENV,expression,meta); end
end

end));
compileExpressionStatementEvalMode =((function(this,expression,meta)
local _local3 = {};
_local3.compiledExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
_local3.compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
_local3.compiledExpressionStatement:push(");");
do return _local3.compiledExpressionStatement; end
end));
compileExpressionStatementNoEval =((function(this,expression,meta)
local _local3 = {};
repeat
local _into = false;
local _cases = {["Literal"] = true,["Identifier"] = true,["ThisExpression"] = true,["UpdateExpression"] = true,["AssignmentExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["ConditionalExpression"] = true,["MemberExpression"] = true,["FunctionExpression"] = true,["UnaryExpression"] = true,["CallExpression"] = true,["NewExpression"] = true,["ArrayExpression"] = true,["ObjectExpression"] = true,["SequenceExpression"] = true,["YieldExpression"] = true};
local _v = expression.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "Literal") then

_into = true;
end
if _into or (_v == "Identifier") then

_into = true;
end
if _into or (_v == "ThisExpression") then
do return end
_into = true;
end
if _into or (_v == "UpdateExpression") then
do return compileUpdateExpressionNoEval(_ENV,expression,meta):push(";"); end
_into = true;
end
if _into or (_v == "AssignmentExpression") then
do return compileAssignmentExpressionNoEval(_ENV,expression,meta):push(";"); end
_into = true;
end
if _into or (_v == "BinaryExpression") then

_into = true;
end
if _into or (_v == "LogicalExpression") then

_into = true;
end
if _into or (_v == "ConditionalExpression") then

_into = true;
end
if _into or (_v == "MemberExpression") then

_into = true;
end
if _into or (_v == "FunctionExpression") then
_local3.compiledExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
_local3.compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
_local3.compiledExpressionStatement:push(");");
do return _local3.compiledExpressionStatement:join(""); end
_into = true;
end
if _into or (_v == "UnaryExpression") then
if (expression.operator == "!") then
_local3.compiledUnaryExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
_local3.compiledUnaryExpressionStatement:push(compileUnaryExpression(_ENV,expression,meta));
_local3.compiledUnaryExpressionStatement:push(");");
do return _local3.compiledUnaryExpressionStatement:join(""); end
end

do return compileUnaryExpression(_ENV,expression,meta):push(";"); end
_into = true;
end
if _into or (_v == "CallExpression") then

_into = true;
end
if _into or (_v == "NewExpression") then

_into = true;
end
if _into or (_v == "ArrayExpression") then

_into = true;
end
if _into or (_v == "ObjectExpression") then

_into = true;
end
if _into or (_v == "SequenceExpression") then
do return compileExpression(_ENV,expression,meta):push(";"); end
_into = true;
end
if _into or (_v == "YieldExpression") then
_throw(_new(Error,"Yield expression not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown expression type: ",expression.type))),0)
_into = true;
end
until true
end));
compileCompoundAssignmentBinaryExpression =((function(this,left,right,operator,metaLeft,metaRight,meta)
local _local3 = {};
_local3.compiledCompoundAssignmentBinaryExpression = _new(CompileResult,_arr({[0]="("},1));
repeat
local _into = false;
local _cases = {["<<="] = true,[">>="] = true,[">>>="] = true,["+="] = true,["-="] = true,["*="] = true,["/="] = true,["%="] = true,["|="] = true,["^="] = true,["&="] = true};
local _v = operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "<<=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_lshift(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == ">>=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_arshift(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == ">>>=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_rshift(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "+=") then
_local3.compiledCompoundAssignmentBinaryExpression:push(compileAdditionOperator(_ENV,left,right,metaLeft,metaRight,meta));
break;
_into = true;
end
if _into or (_v == "-=") then
pushSimpleBinaryExpression(_ENV,_local3.compiledCompoundAssignmentBinaryExpression," - ",left,right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "*=") then
pushSimpleBinaryExpression(_ENV,_local3.compiledCompoundAssignmentBinaryExpression," * ",left,right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "/=") then
pushSimpleBinaryExpression(_ENV,_local3.compiledCompoundAssignmentBinaryExpression," / ",left,right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "%=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_mod(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "|=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_bor(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "^=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_bxor(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "&=") then
_local3.compiledCompoundAssignmentBinaryExpression:push("_band(");
_local3.compiledCompoundAssignmentBinaryExpression:push(left);
_local3.compiledCompoundAssignmentBinaryExpression:push(",");
_local3.compiledCompoundAssignmentBinaryExpression:push(right);
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown BinaryOperator: ",operator))),0)
_into = true;
end
until true
_local3.compiledCompoundAssignmentBinaryExpression:push(")");
do return _local3.compiledCompoundAssignmentBinaryExpression; end
end));
storeComputedProperty =((function(this,expression)
local _local3 = {};
_local3.hasComputedProperty = ((function() local _lev=(expression.type == "MemberExpression"); if _bool(_lev) then return expression.computed; else return _lev; end end)());
if _bool(_local3.hasComputedProperty) then
if (expression.property.type == "Literal") then
do return false; end
end

else
do return false; end
end

do return true; end
end));
compileCompoundAssignmentNoEval =((function(this,expression)
local _local3 = {};
_local3.compiledAssignmentBinaryExpression = _new(CompileResult);
_local3.mustStore = storeComputedProperty(_ENV,expression.left);
_local3.metaLeft = _obj({});
_local3.metaRight = _obj({});
_local3.left = compileExpression(_ENV,expression.left,_local3.metaLeft);
_local3.right = compileExpression(_ENV,expression.right,_local3.metaRight);
if _bool(_local3.mustStore) then
_local3.split = getBaseMember(_ENV,_local3.left);
_local3.left = (_addStr2(_local3.split.base,"[_cp]"));
_local3.compiledAssignmentBinaryExpression:push("do local _cp = ");
_local3.compiledAssignmentBinaryExpression:push(_local3.split.member);
_local3.compiledAssignmentBinaryExpression:push("; ");
end

_local3.compiledAssignmentBinaryExpression:push(_local3.left);
_local3.compiledAssignmentBinaryExpression:push(" = ");
_local3.compiledAssignmentBinaryExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,_local3.left,_local3.right,expression.operator,_local3.metaLeft,_local3.metaRight));
if _bool(_local3.mustStore) then
_local3.compiledAssignmentBinaryExpression:push(" end");
end

do return _local3.compiledAssignmentBinaryExpression; end
end));
compileAssignmentExpressionNoEval =((function(this,expression)
local _local3 = {};
_local3.compiledAssignmentExpression = _new(CompileResult);
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
_local3.left = compileExpression(_ENV,expression.left);
_local3.right = compileExpression(_ENV,expression.right);
_local3.compiledAssignmentExpression:push(_local3.left);
_local3.compiledAssignmentExpression:push(" = ");
_local3.compiledAssignmentExpression:push(_local3.right);
break;
_into = true;
end
::_default::
if _into then
do return compileCompoundAssignmentNoEval(_ENV,expression); end
_into = true;
end
until true
do return _local3.compiledAssignmentExpression; end
end));
compileAssignmentExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledAssignmentExpression = _new(CompileResult,_arr({[0]="(function() "},1));
_local3.mustStore = storeComputedProperty(_ENV,expression.left);
_local3.metaLeft = _obj({});
_local3.metaRight = _obj({});
_local3.left = compileExpression(_ENV,expression.left,_local3.metaLeft);
_local3.right = compileExpression(_ENV,expression.right,_local3.metaRight);
if _bool(_local3.mustStore) then
_local3.split = getBaseMember(_ENV,_local3.left);
_local3.compiledAssignmentExpression:push("local _cp = ");
_local3.compiledAssignmentExpression:push(_local3.split.member);
_local3.compiledAssignmentExpression:push(";");
_local3.left = (_addStr2(_local3.split.base,"[_cp]"));
end

_local3.compiledAssignmentExpression:push(_local3.left);
_local3.compiledAssignmentExpression:push(" = ");
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
_local3.compiledAssignmentExpression:push(_local3.right);
if _bool(meta) then
meta.type = _local3.metaRight.type;
end

break;
_into = true;
end
::_default::
if _into then
_local3.compiledAssignmentExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,_local3.left,_local3.right,expression.operator,_local3.metaLeft,_local3.metaRight,meta));
_into = true;
end
until true
_local3.compiledAssignmentExpression:push("; return ");
_local3.compiledAssignmentExpression:push(_local3.left);
_local3.compiledAssignmentExpression:push(" end)()");
do return _local3.compiledAssignmentExpression; end
end));
compileUpdateExpressionNoEval =((function(this,expression)
local _local3 = {};
_local3.compiledUpdateExpression = _new(CompileResult);
_local3.mustStore = storeComputedProperty(_ENV,expression.argument);
_local3.metaArgument = _obj({});
_local3.compiledArgument = compileExpression(_ENV,expression.argument,_local3.metaArgument);
if _bool(_local3.mustStore) then
_local3.split = getBaseMember(_ENV,_local3.compiledArgument);
_local3.compiledArgument = (_addStr2(_local3.split.base,"[_cp]"));
_local3.compiledUpdateExpression:push("do local _cp = ");
_local3.compiledUpdateExpression:push(_local3.split.member);
_local3.compiledUpdateExpression:push("; ");
end

_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" + 1");
else
_local3.compiledUpdateExpression:push("_inc(");
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(")");
end

break;
_into = true;
end
if _into or (_v == "--") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" - 1");
else
_local3.compiledUpdateExpression:push("_dec(");
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(")");
end

break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
if _bool(_local3.mustStore) then
_local3.compiledUpdateExpression:push(";end");
end

do return _local3.compiledUpdateExpression; end
end));
compileUpdateExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledUpdateExpression = _new(CompileResult,_arr({[0]="(function () "},1));
_local3.mustStore = storeComputedProperty(_ENV,expression.argument);
_local3.metaArgument = _obj({});
_local3.compiledArgument = compileExpression(_ENV,expression.argument,_local3.metaArgument);
if _bool(_local3.mustStore) then
_local3.split = getBaseMember(_ENV,_local3.compiledArgument);
_local3.compiledUpdateExpression:push("local _cp = ");
_local3.compiledUpdateExpression:push(_local3.split.member);
_local3.compiledUpdateExpression:push(";");
_local3.compiledArgument = (_addStr2(_local3.split.base,"[_cp]"));
end

_local3.compiledUpdateExpression:push("local _tmp = ");
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" + 1; ");
else
_local3.compiledUpdateExpression:push("_inc(");
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push("); ");
end

break;
_into = true;
end
if _into or (_v == "--") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" - 1; ");
else
_local3.compiledUpdateExpression:push("_dec(");
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push("); ");
end

break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" = _tmp");
else
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push("; ");
_local3.compiledUpdateExpression:push(_local3.compiledArgument);
_local3.compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push("_tmp + 1");
else
_local3.compiledUpdateExpression:push("_inc(_tmp)");
end

break;
_into = true;
end
if _into or (_v == "--") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUpdateExpression:push("_tmp - 1");
else
_local3.compiledUpdateExpression:push("_dec(_tmp)");
end

break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
end

_local3.compiledUpdateExpression:push("; return _tmp; end)()");
if _bool(meta) then
meta.type = "number";
end

do return _local3.compiledUpdateExpression; end
end));
replaceAt =((function(this,str,index,char)
do return (_add((_add(str:substr(0,index),char)),str:substr((_addNum2(index,1))))); end
end));
lastTopLevelBracketedGroupStartIndex =((function(this,str)
local _local3 = {};
_local3.startIndex = 0;
_local3.count = 0;
_local3.i = 0;
while (_lt(_local3.i,str.length)) do
if (str[_local3.i] == "[") then
if (_local3.count == 0) then
_local3.startIndex = _local3.i;
end

_local3.count = _inc(_local3.count);
elseif (str[_local3.i] == "]") then
_local3.count = _dec(_local3.count);
end

_local3.i = _inc(_local3.i);
end

do return _local3.startIndex; end
end));
lastTopLevelBracketedGroupStartIndex__a =((function(this,str)
local _local3 = {};
_local3.startIndex = 0;
_local3.count = 0;
_local3.i = 0;
while (_lt(_local3.i,str.length)) do
_local3.s = str[_local3.i];
if (_type(_local3.s) ~= "string") then
goto _continue
end

if _bool(_local3.s:match(_regexp("^\\[",""))) then
if (_local3.count == 0) then
_local3.startIndex = _local3.i;
end

_local3.count = _inc(_local3.count);
elseif _bool(str[_local3.i]:match(_regexp("^\\]",""))) then
_local3.count = _dec(_local3.count);
end

::_continue::
_local3.i = _inc(_local3.i);
end

do return _local3.startIndex; end
end));
compileCallArguments =((function(this,args)
local _local3 = {};
_local3.compiledArguments = _new(CompileResult,_arr({},0),",");
_local3.i = 0;
while (_lt(_local3.i,args.length)) do
_local3.compiledArguments:push(compileExpression(_ENV,args[_local3.i]));
_local3.i = _inc(_local3.i);
end

do return _local3.compiledArguments; end
end));
compileCallExpression =((function(...)
local this,expression,meta,arguments = ...;
local arguments = _args(...);
local _local3 = {};
_local3.compiledCallExpression = _new(CompileResult);
_local3.compiledCallee = compileExpression(_ENV,expression.callee,_obj({}));
_local3.compiledArguments = compileCallArguments(_ENV,expression.arguments);
if (expression.callee.type == "MemberExpression") then
_local3.calleeStr = _local3.compiledCallee:toString();
if _bool(_local3.calleeStr:match(_regexp("\\]$",""))) then
if _bool(_local2.options.luaLocal) then
_local3.startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,_local3.calleeStr);
_local3.base = _local3.calleeStr:substr(0,_local3.startIndex);
_local3.member = _local3.calleeStr:substr((_addNum2(_local3.startIndex,1)));
else
_local3.compiledCallee.array:forEach((function(this,v,idx)
if _bool(((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return v:match(_regexp("^\\[","")); else return _lev; end end)())) then
_local3.startIndex = idx;
end

end));
_local3.base = _local3.compiledCallee:slice(0,_local3.startIndex);
_local3.member = _local3.compiledCallee:slice(_local3.startIndex);
end

_local3.compiledCallExpression:push("(function() local _this = ");
_local3.compiledCallExpression:push(_local3.base);
_local3.compiledCallExpression:push("; local _f = _this");
_local3.compiledCallExpression:push(_local3.member);
_local3.compiledCallExpression:push("; return _f(_this");
if (_gt(expression.arguments.length,0)) then
_local3.compiledCallExpression:push(",");
_local3.compiledCallExpression:push(_local3.compiledArguments);
end

_local3.compiledCallExpression:push("); end)()");
else
if _bool(_local2.options.luaLocal) then
_local3.lastPointIndex = _local3.calleeStr:lastIndexOf(".");
_local3.compiledCallee = replaceAt(_ENV,_local3.calleeStr,_local3.lastPointIndex,":");
_local3.compiledCallExpression:push(_local3.compiledCallee);
else
_local3.compiledCallee.array:findIndex((function(this,v,idx)
if ((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return (v == "."); else return _lev; end end)()) then
_local3.lastPointIndex = idx;
end

end));
_local3.compiledCallExpression:push(_local3.compiledCallee:slice(0,_local3.lastPointIndex));
_local3.compiledCallExpression:push(":");
_local3.compiledCallExpression:push(_local3.compiledCallee:slice((_addNum2(_local3.lastPointIndex,1))));
end

_local3.compiledCallExpression:push("(");
_local3.compiledCallExpression:push(_local3.compiledArguments);
_local3.compiledCallExpression:push(")");
end

else
_local3.compiledCallExpression:push(_local3.compiledCallee);
if (_local2.withTracker.length == 0) then
_local3.compiledCallExpression:push("(_ENV");
else
_local3.compiledCallExpression:push("(_oldENV");
end

if (_gt(expression.arguments.length,0)) then
_local3.compiledCallExpression:push(",");
_local3.compiledCallExpression:push(_local3.compiledArguments);
end

_local3.compiledCallExpression:push(")");
end

setMeta(_ENV,expression,meta);
do return _local3.compiledCallExpression; end
end));
compileLogicalExpression =((function(this,expression,meta)
local _local3 = {};
_local3.metaLeft = _obj({});
_local3.metaRight = _obj({});
_local3.compiledLeft = compileExpression(_ENV,expression.left,_local3.metaLeft);
_local3.compiledRight = compileExpression(_ENV,expression.right,_local3.metaRight);
if _bool(meta) then
if ((function() local _lev=(_local3.metaLeft.type == _local3.metaRight.type); if _bool(_lev) then return (_local3.metaLeft.type ~= undefined); else return _lev; end end)()) then
meta.type = _local3.metaLeft.type;
end

end

if ((function() local _lev=(expression.left.type == "Identifier"); return _bool(_lev) and _lev or (expression.left.type == "Literal") end)()) then
do return compileLogicalExpressionLeftIdentifierOrLiteral(_ENV,expression,_local3.compiledLeft,_local3.compiledRight); end
else
do return compileGenericLogicalExpression(_ENV,expression,_local3.compiledLeft,_local3.compiledRight); end
end

end));
compileLogicalExpressionLeftIdentifierOrLiteral =((function(this,expression,compiledLeft,compiledRight)
local _local3 = {};
_local3.compiledLogicalExpression = _new(CompileResult,_arr({[0]="("},1));
_local3.leftCondition = compileBooleanExpression(_ENV,expression.left);
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
_local3.compiledLogicalExpression:push("(function() if ");
_local3.compiledLogicalExpression:push(_local3.leftCondition);
_local3.compiledLogicalExpression:push(" then return ");
_local3.compiledLogicalExpression:push(compiledRight);
_local3.compiledLogicalExpression:push("; else return ");
_local3.compiledLogicalExpression:push(compiledLeft);
_local3.compiledLogicalExpression:push("; end end)()");
break;
_into = true;
end
if _into or (_v == "||") then
_local3.compiledLogicalExpression:push(_local3.leftCondition);
_local3.compiledLogicalExpression:push(" and ");
_local3.compiledLogicalExpression:push(compiledLeft);
_local3.compiledLogicalExpression:push(" or ");
_local3.compiledLogicalExpression:push(compiledRight);
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
_local3.compiledLogicalExpression:push(")");
do return _local3.compiledLogicalExpression; end
end));
compileGenericLogicalExpression =((function(this,expression,compiledLeft,compiledRight)
local _local3 = {};
_local3.compiledLogicalExpression = _new(CompileResult,_arr({[0]="("},1));
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
_local3.compiledLogicalExpression:push("(function() local _lev=");
_local3.compiledLogicalExpression:push(compiledLeft);
_local3.compiledLogicalExpression:push("; if _bool(_lev) then return ");
_local3.compiledLogicalExpression:push(compiledRight);
_local3.compiledLogicalExpression:push("; else return _lev; end end)()");
break;
_into = true;
end
if _into or (_v == "||") then
_local3.compiledLogicalExpression:push("(function() local _lev=");
_local3.compiledLogicalExpression:push(compiledLeft);
_local3.compiledLogicalExpression:push("; return _bool(_lev) and _lev or ");
_local3.compiledLogicalExpression:push(compiledRight);
_local3.compiledLogicalExpression:push(" end)()");
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
_local3.compiledLogicalExpression:push(")");
do return _local3.compiledLogicalExpression; end
end));
getBaseMember =((function(this,compiledExpression)
local _local3 = {};
_local3.startIndex = 0;
_local3.compiledExpressionStr = compiledExpression:toString();
if _bool(_local3.compiledExpressionStr:match(_regexp("\\]$",""))) then
if _bool(_local2.options.luaLocal) then
_local3.startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,_local3.compiledExpressionStr);
do return _obj({
["base"] = _local3.compiledExpressionStr:slice(0,_local3.startIndex),
["member"] = _local3.compiledExpressionStr:slice((_addNum2(_local3.startIndex,1)),-1)
}); end
end

_local3.startIndex = lastTopLevelBracketedGroupStartIndex__a(_ENV,compiledExpression.array);
do return _obj({
["base"] = compiledExpression:slice(0,_local3.startIndex),
["member"] = compiledExpression:slice((_addNum2(_local3.startIndex,1)),-1)
}); end
else
if _bool(_local2.options.luaLocal) then
_local3.startIndex = _local3.compiledExpressionStr:lastIndexOf(".");
do return _obj({
["base"] = _local3.compiledExpressionStr:slice(0,_local3.startIndex),
["member"] = ((_addStr1("\"",_local3.compiledExpressionStr:slice((_addNum2(_local3.startIndex,1))))) .. "\"")
}); end
end

compiledExpression.array:forEach((function(this,v,idx)
if ((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return (v == "."); else return _lev; end end)()) then
_local3.startIndex = idx;
end

end));
do return _obj({
["base"] = compiledExpression:slice(0,_local3.startIndex),
["member"] = compiledExpression:slice((_addNum2(_local3.startIndex,1))):quote("\"")
}); end
end

end));
getGetterSetterExpression =((function(this,compiledExpression)
local _local3 = {};
_local3.split = getBaseMember(_ENV,compiledExpression);
_local3.suffix = " .. ";
if _bool(_local2.options.luaLocal) then
do return _obj({
["getter"] = ((_addStr1((_addStr1((_addStr2(_local3.split.base,"[\"_g\"")),_local3.suffix)),_local3.split.member)) .. "]"),
["setter"] = ((_addStr1((_addStr1((_addStr2(_local3.split.base,"[\"_s\"")),_local3.suffix)),_local3.split.member)) .. "]")
}); end
end

do return _obj({
["getter"] = _new(CompileResult):push(_local3.split.base):push((_addStr1("[\"_g\"",_local3.suffix))):push(_local3.split.member):push("]"),
["setter"] = _new(CompileResult):push(_local3.split.base):push((_addStr1("[\"_s\"",_local3.suffix))):push(_local3.split.member):push("]")
}); end
end));
compileUnaryExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledUnaryExpression = _new(CompileResult);
_local3.metaArgument = _obj({});
_local3.compiledExpression = compileExpression(_ENV,expression.argument,_local3.metaArgument);
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["-"] = true,["+"] = true,["!"] = true,["~"] = true,["typeof"] = true,["delete"] = true,["void"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "-") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUnaryExpression:push("-");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
else
_local3.compiledUnaryExpression:push("-_tonum(");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
_local3.compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "+") then
if (_local3.metaArgument.type == "number") then
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
else
_local3.compiledUnaryExpression:push("_tonum(");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
_local3.compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "!") then
_local3.compiledUnaryExpression:push("not ");
_local3.compiledUnaryExpression:push(compileBooleanExpression(_ENV,expression.argument));
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "~") then
_local3.compiledUnaryExpression:push("_bnot(");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
_local3.compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "typeof") then
_local3.compiledUnaryExpression:push("_type(");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
_local3.compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "string";
end

break;
_into = true;
end
if _into or (_v == "delete") then
if (_local2.withTracker.length == 0) then
_local3.scope = "_ENV.";
else
_local3.scope = "_oldENV.";
end

_local3.compiledUnaryExpression:push("(function () local _r = false; ");
if (expression.argument.type == "MemberExpression") then
_local3.scope = "";
_local3.gs = getGetterSetterExpression(_ENV,_local3.compiledExpression);
_local3.compiledUnaryExpression:push("local _g, _s = ");
_local3.compiledUnaryExpression:push(_local3.gs.getter);
_local3.compiledUnaryExpression:push(", ");
_local3.compiledUnaryExpression:push(_local3.gs.setter);
_local3.compiledUnaryExpression:push("; ");
_local3.compiledUnaryExpression:push(_local3.gs.getter);
_local3.compiledUnaryExpression:push(", ");
_local3.compiledUnaryExpression:push(_local3.gs.setter);
_local3.compiledUnaryExpression:push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\10");
end

_local3.compiledUnaryExpression:push("local _v = ");
if _bool(isCompileResultLike(_ENV,_local3.compiledExpression)) then
_local3.ename = _local3.compiledExpression:toString();
elseif (_type(_local3.compiledExpression) == "string") then
_local3.ename = _local3.compiledExpression;
else
_local3.ename = _local3.compiledExpression.name;
end

if not _bool(_local3.ename) then
console:error("delete name = null");
else
if (_gt(_local3.scope.length,0)) then
_local3.ename = _local3.ename:replace(_regexp("^_local\\d+\\.",""),"");
end

end

_local3.compiledUnaryExpression:push(_local3.scope):push(_local3.ename);
_local3.compiledUnaryExpression:push("; ");
_local3.compiledUnaryExpression:push(_local3.scope):push(_local3.ename);
_local3.compiledUnaryExpression:push(" = nil; return _r or _v ~= nil; end)()");
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "void") then
_local3.compiledUnaryExpression:push("_void(");
_local3.compiledUnaryExpression:push(_local3.compiledExpression);
_local3.compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "undefined";
end

break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UnaryOperator: ",expression.operator))),0)
_into = true;
end
until true
else
_throw(_new(Error,"UnaryExpression: postfix ?!"),0)
end

do return _local3.compiledUnaryExpression; end
end));
compileAdditionOperator =((function(this,left,right,metaLeft,metaRight,meta)
local _local3 = {};
_local3.compiledAdditionOperator = _new(CompileResult);
if ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) then
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(" + ");
_local3.compiledAdditionOperator:push(right);
if _bool(meta) then
meta.type = "number";
end

elseif (metaLeft.type == "string") then
if ((function() local _lev=(metaRight.type == "number"); return _bool(_lev) and _lev or (metaRight.type == "string") end)()) then
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(" .. ");
_local3.compiledAdditionOperator:push(right);
else
_local3.compiledAdditionOperator:push("_addStr1(");
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(",");
_local3.compiledAdditionOperator:push(right);
_local3.compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaRight.type == "string") then
if ((function() local _lev=(metaLeft.type == "number"); return _bool(_lev) and _lev or (metaLeft.type == "string") end)()) then
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(" .. ");
_local3.compiledAdditionOperator:push(right);
else
_local3.compiledAdditionOperator:push("_addStr2(");
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(",");
_local3.compiledAdditionOperator:push(right);
_local3.compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaLeft.type == "number") then
_local3.compiledAdditionOperator:push("_addNum1(");
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(",");
_local3.compiledAdditionOperator:push(right);
_local3.compiledAdditionOperator:push(")");
elseif (metaRight.type == "number") then
_local3.compiledAdditionOperator:push("_addNum2(");
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(",");
_local3.compiledAdditionOperator:push(right);
_local3.compiledAdditionOperator:push(")");
else
_local3.compiledAdditionOperator:push("_add(");
_local3.compiledAdditionOperator:push(left);
_local3.compiledAdditionOperator:push(",");
_local3.compiledAdditionOperator:push(right);
_local3.compiledAdditionOperator:push(")");
end

do return _local3.compiledAdditionOperator; end
end));
compileComparisonOperator =((function(this,left,right,operator,metaLeft,metaRight,meta)
local _local3 = {};
_local3.compiledComparisonOperator = _new(CompileResult);
if ((function() local _lev=((function() local _lev=(metaLeft.type == "string"); if _bool(_lev) then return (metaRight.type == "string"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) end)()) then
_local3.compiledComparisonOperator:push(left);
_local3.compiledComparisonOperator:push(operator);
_local3.compiledComparisonOperator:push(right);
else
repeat
local _into = false;
local _cases = {["<"] = true,["<="] = true,[">"] = true,[">="] = true};
local _v = operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "<") then
_local3.compiledComparisonOperator:push("_lt(");
break;
_into = true;
end
if _into or (_v == "<=") then
_local3.compiledComparisonOperator:push("_le(");
break;
_into = true;
end
if _into or (_v == ">") then
_local3.compiledComparisonOperator:push("_gt(");
break;
_into = true;
end
if _into or (_v == ">=") then
_local3.compiledComparisonOperator:push("_ge(");
break;
_into = true;
end
::_default::
until true
_local3.compiledComparisonOperator:push(left);
_local3.compiledComparisonOperator:push(",");
_local3.compiledComparisonOperator:push(right);
_local3.compiledComparisonOperator:push(")");
end

if _bool(meta) then
meta.type = "boolean";
end

do return _local3.compiledComparisonOperator; end
end));
compileBinaryExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledBinaryExpression = _new(CompileResult,_arr({[0]="("},1));
_local3.metaLeft = _obj({});
_local3.metaRight = _obj({});
_local3.left = compileExpression(_ENV,expression.left,_local3.metaLeft);
_local3.right = compileExpression(_ENV,expression.right,_local3.metaRight);
repeat
local _into = false;
local _cases = {["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,["<="] = true,[">"] = true,[">="] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true,["|"] = true,["^"] = true,["&"] = true,["in"] = true,["instanceof"] = true,[".."] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "==") then
_local3.compiledBinaryExpression:push("_eq(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "!=") then
_local3.compiledBinaryExpression:push("not _eq(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "===") then
pushSimpleBinaryExpression(_ENV,_local3.compiledBinaryExpression," == ",_local3.left,_local3.right);
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "!==") then
pushSimpleBinaryExpression(_ENV,_local3.compiledBinaryExpression," ~= ",_local3.left,_local3.right);
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "<") then

_into = true;
end
if _into or (_v == "<=") then

_into = true;
end
if _into or (_v == ">") then

_into = true;
end
if _into or (_v == ">=") then
_local3.compiledBinaryExpression:push(compileComparisonOperator(_ENV,_local3.left,_local3.right,expression.operator,_local3.metaLeft,_local3.metaRight,meta));
break;
_into = true;
end
if _into or (_v == "<<") then
_local3.compiledBinaryExpression:push("_lshift(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == ">>") then
_local3.compiledBinaryExpression:push("_arshift(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == ">>>") then
_local3.compiledBinaryExpression:push("_rshift(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "+") then
_local3.compiledBinaryExpression:push(compileAdditionOperator(_ENV,_local3.left,_local3.right,_local3.metaLeft,_local3.metaRight,meta));
break;
_into = true;
end
if _into or (_v == "-") then
pushSimpleBinaryExpression(_ENV,_local3.compiledBinaryExpression," - ",_local3.left,_local3.right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "*") then
pushSimpleBinaryExpression(_ENV,_local3.compiledBinaryExpression," * ",_local3.left,_local3.right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "/") then
pushSimpleBinaryExpression(_ENV,_local3.compiledBinaryExpression," / ",_local3.left,_local3.right);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "%") then
_local3.compiledBinaryExpression:push("_mod(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "|") then
_local3.compiledBinaryExpression:push("_bor(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "^") then
_local3.compiledBinaryExpression:push("_bxor(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "&") then
_local3.compiledBinaryExpression:push("_band(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "in") then
_local3.compiledBinaryExpression:push("_in(");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "instanceof") then
_local3.compiledBinaryExpression:push("_instanceof(");
_local3.compiledBinaryExpression:push(_local3.left);
_local3.compiledBinaryExpression:push(",");
_local3.compiledBinaryExpression:push(_local3.right);
_local3.compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
if _into or (_v == "..") then
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown BinaryOperator: ",expression.operator))),0)
_into = true;
end
until true
_local3.compiledBinaryExpression:push(")");
do return _local3.compiledBinaryExpression; end
end));
pushSimpleBinaryExpression =((function(this,compiledBinaryExpression,operator,left,right)
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(operator);
compiledBinaryExpression:push(right);
end));
compileConditionalExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledConditionalExpression = _new(CompileResult,_arr({[0]="(function() if "},1));
_local3.metaConsequent = _obj({});
_local3.metaAlternate = _obj({});
_local3.compiledConditionalExpression:push(compileBooleanExpression(_ENV,expression.test));
_local3.compiledConditionalExpression:push(" then return ");
_local3.compiledConditionalExpression:push(compileExpression(_ENV,expression.consequent,_local3.metaConsequent));
_local3.compiledConditionalExpression:push("; else return ");
_local3.compiledConditionalExpression:push(compileExpression(_ENV,expression.alternate,_local3.metaAlternate));
_local3.compiledConditionalExpression:push("; end end)()");
if _bool(meta) then
if ((function() local _lev=(_local3.metaConsequent.type == _local3.metaAlternate.type); if _bool(_lev) then return (_local3.metaConsequent.type ~= undefined); else return _lev; end end)()) then
meta.type = _local3.metaConsequent.type;
end

end

do return _local3.compiledConditionalExpression; end
end));
compileSequenceExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledSequenceExpression = _new(CompileResult,_arr({[0]="_seq({"},1));
_local3.expressions = expression.expressions;
_local3.sequence = _new(CompileResult,_arr({},0),",");
_local3.metaLast = _obj({});
_local3.i = 0;
while (_lt(_local3.i,_local3.expressions.length)) do
_local3.sequence:push(compileExpression(_ENV,_local3.expressions[_local3.i],_local3.metaLast));
_local3.i = _inc(_local3.i);
end

_local3.compiledSequenceExpression:push(_local3.sequence);
_local3.compiledSequenceExpression:push("})");
if _bool(meta) then
meta.type = _local3.metaLast.type;
end

do return _local3.compiledSequenceExpression; end
end));
compileObjectExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledObjectExpression = _new(CompileResult,_arr({[0]="_obj({"},1));
_local3.length = expression.properties.length;
_local3.compiledProperties = _new(CompileResult,_arr({},0),",\10");
_local3.compiledKey = "";
_local3.i = 0;
while (_lt(_local3.i,_local3.length)) do
_local3.compiledProperty = _new(CompileResult,_arr({[0]="["},1));
_local3.property = expression.properties[_local3.i];
if (_local3.property.key.type == "Literal") then
_local3.compiledKey = compileLiteral(_ENV,_local3.property.key);
elseif (_local3.property.key.type == "Identifier") then
_local3.compiledKey = "\"";
_local3.compiledKey = (_add(_local3.compiledKey,sanitizeLiteralString(_ENV,_local3.property.key.name)));
_local3.compiledKey = (_addStr2(_local3.compiledKey,"\""));
else
_throw(_new(Error,(_addStr1("Unexpected property key type: ",_local3.property.key.type))),0)
end

if (_local3.property.kind == "get") then
if (_type(_local3.property.key.value) == "number") then
_local3.compiledKey = ((_addStr1("\"",_local3.compiledKey)) .. "\"");
end

_local3.compiledKey = _local3.compiledKey:replace(_regexp("^\"",""),"\"_g");
elseif (_local3.property.kind == "set") then
if (_type(_local3.property.key.value) == "number") then
_local3.compiledKey = ((_addStr1("\"",_local3.compiledKey)) .. "\"");
end

_local3.compiledKey = _local3.compiledKey:replace(_regexp("^\"",""),"\"_s");
end

_local3.compiledProperty:push(_local3.compiledKey);
_local3.compiledProperty:push("] = ");
_local3.compiledProperty:push(compileExpression(_ENV,_local3.property.value));
_local3.compiledProperties:push(_local3.compiledProperty);
_local3.i = _inc(_local3.i);
end

if (_gt(_local3.length,0)) then
_local3.compiledObjectExpression:push("\10");
_local3.compiledObjectExpression:push(_local3.compiledProperties);
_local3.compiledObjectExpression:push("\10");
end

_local3.compiledObjectExpression:push("})");
if _bool(meta) then
meta.type = "object";
end

do return _local3.compiledObjectExpression; end
end));
compileMemberExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledMemberExpression = _new(CompileResult,_arr({},0));
_local3.compiledObject = compileExpression(_ENV,expression.object,_obj({}));
if (expression.object.type == "Literal") then
_local3.compiledObject = ((_addStr1("(",_local3.compiledObject)) .. ")");
end

_local3.compiledMemberExpression:push(_local3.compiledObject);
if _bool(expression.computed) then
_local3.compiledMemberExpression:push("[");
_local3.compiledMemberExpression:push(compileExpression(_ENV,expression.property));
_local3.compiledMemberExpression:push("]");
else
_local3.compiledProperty = compileIdentifier(_ENV,expression.property);
if (sanitizeIdentifier(_ENV,expression.property.name) ~= expression.property.name) then
_local3.compiledMemberExpression:push("[\"");
_local3.compiledMemberExpression:push(sanitizeLiteralString(_ENV,expression.property.name));
_local3.compiledMemberExpression:push("\"]");
else
_local3.compiledMemberExpression:push(".");
_local3.compiledMemberExpression:push(expression.property.name);
end

end

setMeta(_ENV,expression,meta);
do return _local3.compiledMemberExpression; end
end));
compileNewExpression =((function(...)
local this,expression,arguments = ...;
local arguments = _args(...);
local _local3 = {};
_local3.compiledNewExpression = _new(CompileResult,_arr({[0]="_new("},1));
_local3.newArguments = _new(CompileResult,_arr({[0]=compileExpression(_ENV,expression.callee)},1),",");
_local3.length = expression.arguments.length;
_local3.i = 0;
while (_lt(_local3.i,_local3.length)) do
_local3.newArguments:push(compileExpression(_ENV,expression.arguments[_local3.i]));
_local3.i = _inc(_local3.i);
end

_local3.compiledNewExpression:push(_local3.newArguments);
_local3.compiledNewExpression:push(")");
do return _local3.compiledNewExpression; end
end));
compileThisExpression =((function(this)
do return "this"; end
end));
compileArrayExpression =((function(this,expression,meta)
local _local3 = {};
_local3.compiledArrayExpression = _new(CompileResult,_arr({[0]="_arr({"},1));
_local3.compiledElements = _new(CompileResult,_arr({},0),",");
_local3.length = expression.elements.length;
if (_gt(_local3.length,0)) then
_local3.compiledArrayExpression:push("[0]=");
end

_local3.i = 0;
while (_lt(_local3.i,_local3.length)) do
if (expression.elements[_local3.i] ~= null) then
_local3.compiledElements:push(compileExpression(_ENV,expression.elements[_local3.i]));
else
_local3.compiledElements:push("nil");
end

_local3.i = _inc(_local3.i);
end

_local3.compiledArrayExpression:push(_local3.compiledElements);
_local3.compiledArrayExpression:push("},");
_local3.compiledArrayExpression:push(_local3.length);
_local3.compiledArrayExpression:push(")");
if _bool(meta) then
meta.type = "object";
end

do return _local3.compiledArrayExpression; end
end));
compileFunctionDeclaration =((function(this,declaration)
local _local3 = {};
_local3.compiledFunctionDeclaration = _new(CompileResult);
_local3.compiledId = compileIdentifier(_ENV,declaration.id,"global");
_local3.compiledFunctionDeclaration:push(_local3.compiledId);
_local3.compiledFunctionDeclaration:push(" =(");
_local3.compiledFunctionDeclaration:push(compileFunction(_ENV,declaration));
_local3.compiledFunctionDeclaration:push(");");
_local2.localVarManager:pushFunction(_local3.compiledFunctionDeclaration);
end));
compileVariableDeclaration =((function(this,variableDeclaration)
local _local3 = {};
_local3.compiledDeclarations = _new(CompileResult,_arr({},0),"\10");
repeat
local _into = false;
local _cases = {["const"] = true,["var"] = true,["let"] = true};
local _v = variableDeclaration.kind;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "const") then

_into = true;
end
if _into or (_v == "var") then
_local3.declarations = variableDeclaration.declarations;
_local3.i = 0;
while (_lt(_local3.i,_local3.declarations.length)) do
_local3.declarator = _local3.declarations[_local3.i];
_local3.pattern = compilePattern(_ENV,_local3.declarator.id,true);
_local2.localVarManager:pushLocal(_local3.pattern);
if (_local3.declarator.init ~= null) then
_local3.expression = compileExpression(_ENV,_local3.declarator.init);
_local3.compiledDeclarationInit = _new(CompileResult);
_local3.compiledDeclarationInit:push(_local3.pattern);
_local3.compiledDeclarationInit:push(" = ");
_local3.compiledDeclarationInit:push(_local3.expression);
_local3.compiledDeclarationInit:push(";");
_local3.compiledDeclarations:push(_local3.compiledDeclarationInit:join(""));
end

_local3.i = _inc(_local3.i);
end

break;
_into = true;
end
if _into or (_v == "let") then
_throw(_new(Error,"let instruction is not supported yet"),0)
_into = true;
end
::_default::
until true
do return _local3.compiledDeclarations; end
end));
compilePattern =((function(this,pattern,meta)
repeat
local _into = false;
local _cases = {["Identifier"] = true,["RestElement"] = true};
local _v = pattern.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "Identifier") then
do return compileIdentifier(_ENV,pattern,meta); end
_into = true;
end
if _into or (_v == "RestElement") then
_throw(_new(Error,"Rest parameters (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknwown Pattern type: ",pattern.type))),0)
_into = true;
end
until true
end));
compileFunction =((function(this,fun,meta)
local _local3 = {};
_local3.hasName = ((function() local _lev=((function() if _bool(meta) then return fun.id; else return meta; end end)()); if _bool(_lev) then return (_gt(fun.id.name.length,0)); else return _lev; end end)());
_local3.compiledFunction = _new(CompileResult,_arr({[0]=(function() if _bool(_local3.hasName) then return ((_addStr1(((_addStr1("(function() local ",fun.id.name)) .. ";"),fun.id.name)) .. "=(function("); else return "(function("; end end)()},1));
_local3.compiledBody = "";
_local2.localVarManager:createLocalContext();
_local3.params = fun.params;
_local3.compiledParams = _new(CompileResult,_arr({[0]="this"},1),",");
_local3.i = 0;
while (_lt(_local3.i,_local3.params.length)) do
_local3.pa = compilePattern(_ENV,_local3.params[_local3.i],"param");
_local2.localVarManager:pushParam(_local3.pa);
_local3.compiledParams:push(_local3.pa);
_local3.i = _inc(_local3.i);
end

if (fun.body.type == "BlockStatement") then
_local3.compiledBody = compileStatement(_ENV,fun.body);
elseif (fun.body.type == "Expression") then
_local3.compiledBody = compileExpression(_ENV,fun.body);
end

if _bool(((function() local _lev=fun.defaults; if _bool(_lev) then return (_gt(fun.defaults.length,0)); else return _lev; end end)())) then
console:log("Warning: default parameters of functions are ignored");
end

_local3.context = _local2.localVarManager:popLocalContext();
_local3.locals = _local3.context[0];
_local3.useArguments = ((function() local _lev=_local3.context[1]; if _bool(_lev) then return (_local3.compiledParams:indexOf("arguments") == -1); else return _lev; end end)());
if _bool(_local3.useArguments) then
_local3.compiledFunction:push("...)\10");
_local3.compiledFunction:push("local "):push(_local3.compiledParams):push(" = ...;\10");
_local3.compiledFunction:push("local arguments = _args(...);\10");
_local3.compiledParams:push("arguments");
else
_local3.compiledFunction:push(_local3.compiledParams);
_local3.compiledFunction:push(")\10");
end

if (_gt(_local3.locals.length,0)) then
_local3.compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,_local3.locals,_local3.compiledParams);
_local3.compiledFunction:push(_local3.compiledLocalsDeclaration);
end

_local3.functions = _local3.context[2];
if (_gt(_local3.functions.length,0)) then
_local3.compiledFunctionsDeclaration = _new(CompileResult,_arr({},0),"\10");
_local3.i = 0;
while (_lt(_local3.i,_local3.functions.length)) do
_local3.compiledFunctionsDeclaration:push(_local3.functions[_local3.i]);
_local3.i = _inc(_local3.i);
end

_local3.compiledFunction:push(_local3.compiledFunctionsDeclaration);
end

_local3.compiledFunction:push(_local3.compiledBody);
_local3.compiledFunction:push("\10");
_local3.compiledFunction:push("end)");
if _bool(_local3.hasName) then
_local3.compiledFunction:push(((_addStr1(" return ",fun.id.name)) .. ";end)()"));
end

do return _local3.compiledFunction; end
end));
buildLocalsDeclarationString =((function(this,locals,ignore)
local _local3 = {};
ignore = (_bool(ignore) and ignore or _arr({},0));
_local3.namesSequence = _new(CompileResult,_arr({},0),",");
_local3.length = locals.length;
_local3.i = 0;
while (_lt(_local3.i,_local3.length)) do
_local3._g_local = locals:pop();
if (_type(_local3._g_local) == "string") then
_local3.localname = _local3._g_local;
else
_local3.localname = _local3._g_local.name;
end

if ((function() local _lev=not _bool(_local2.options.luaLocal); return _bool(_lev) and _lev or ((function() local _lev=(ignore:indexOf(_local3.localname) == -1); if _bool(_lev) then return (_local3.namesSequence:indexOf(_local3.localname) == -1); else return _lev; end end)()) end)()) then
_local3.namesSequence:push(_local3._g_local);
end

_local3.i = _inc(_local3.i);
end

if (_gt(_local3.namesSequence.array.length,0)) then
if _bool(_local2.options.luaLocal) then
_local3.compiledLocalsDeclaration = _new(CompileResult,_arr({[0]="local "},1));
_local3.compiledLocalsDeclaration:push(_local3.namesSequence);
_local3.compiledLocalsDeclaration:push(";\10");
do return _local3.compiledLocalsDeclaration; end
end

do return ((_addStr1("local ",_local2.localVarManager:loVarsName())) .. " = {};\10"); end
end

do return ""; end
end));
sanitizeIdentifier =((function(this,id)
if (_gt(_local2.luaKeywords:indexOf(id),-1)) then
do return (_addStr1("_g_",id)); end
end

do return id:replace(_regexp("_","g"),"__"):replace(_regexp("\\$","g"),"S"):replace(_regexp("[\194\128-\239\191\191]","g"),(function(this,c)
do return (_addStr1("_",c:charCodeAt(0))); end
end)); end
end));
compileIdentifier =((function(this,identifier,meta)
local _local3 = {};
_local3.iname = identifier.name;
if (identifier.name == "arguments") then
_local2.localVarManager:useArguments();
end

setMeta(_ENV,identifier,meta);
_local3.siname = sanitizeIdentifier(_ENV,_local3.iname);
if _bool(_local2.options.luaLocal) then
do return _local3.siname; end
end

if (identifier.name == "arguments") then
do return _local3.siname; end
end

if ((function() local _lev=((function() local _lev=(meta == "param"); return _bool(_lev) and _lev or (meta == "label") end)()); return _bool(_lev) and _lev or (meta == "global") end)()) then
do return _local3.siname; end
end

if (meta == true) then
do return _local2.localVarManager:loVarName(_local3.siname); end
end

_local3.ret = _local2.localVarManager:findLoVar(_local3.siname);
if _bool(_local3.ret) then
do return _local3.ret; end
end

do return _local2.localVarManager:registerUnresolvedVar(_local3.siname); end
end));
toUTF8Array =((function(this,str)
local _local3 = {};
_local3.utf8 = _arr({},0);
_local3.i = 0;
while (_lt(_local3.i,str.length)) do
_local3.charcode = str:charCodeAt(_local3.i);
if (_lt(_local3.charcode,128)) then
_local3.utf8:push(_local3.charcode);
elseif (_lt(_local3.charcode,2048)) then
_local3.utf8:push((_bor(192,(_arshift(_local3.charcode,6)))),(_bor(128,(_band(_local3.charcode,63)))));
elseif ((function() local _lev=(_lt(_local3.charcode,55296)); return _bool(_lev) and _lev or (_ge(_local3.charcode,57344)) end)()) then
_local3.utf8:push((_bor(224,(_arshift(_local3.charcode,12)))),(_bor(128,(_band((_arshift(_local3.charcode,6)),63)))),(_bor(128,(_band(_local3.charcode,63)))));
else
_local3.i = _inc(_local3.i);
_local3.charcode = (65536 + (_bor((_lshift((_band(_local3.charcode,1023)),10)),(_band(str:charCodeAt(_local3.i),1023)))));
_local3.utf8:push((_bor(240,(_arshift(_local3.charcode,18)))),(_bor(128,(_band((_arshift(_local3.charcode,12)),63)))),(_bor(128,(_band((_arshift(_local3.charcode,6)),63)))),(_bor(128,(_band(_local3.charcode,63)))));
end

_local3.i = _inc(_local3.i);
end

do return _local3.utf8; end
end));
sanitizeLiteralString =((function(this,str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("[\\x7f-\\xff\\x00-\\x1f]","g"),(function(this,c)
do return (_addStr1("\\",c:charCodeAt(0))); end
end)); end
end));
sanitizeRegExpSource =((function(this,str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\\\\\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])","g"),(function(this,str,hexaCode)
local _local4 = {};
_local4.chars = String:fromCharCode(parseInt(_ENV,hexaCode,16));
do return (_addStr1("\\",toUTF8Array(_ENV,_local4.chars):join("\\"))); end
end)); end
end));
compileLiteral =((function(this,literal,meta)
local _local3 = {};
_local3.ret = literal.raw;
if (_instanceof(literal.value,RegExp)) then
_local3.regexp = literal.value;
_local3.compiledRegExp = _new(CompileResult,_arr({[0]="_regexp(\""},1));
_local3.source = sanitizeRegExpSource(_ENV,_local3.regexp.source);
_local3.compiledRegExp:push(_local3.source);
_local3.compiledRegExp:push("\",\"");
_local3.flags = "";
_local3.flags = (_addStr2(_local3.flags,(function() if _bool(_local3.regexp.global) then return "g"; else return ""; end end)()));
_local3.flags = (_addStr2(_local3.flags,(function() if _bool(_local3.regexp.ignoreCase) then return "i"; else return ""; end end)()));
_local3.flags = (_addStr2(_local3.flags,(function() if _bool(_local3.regexp.multiline) then return "m"; else return ""; end end)()));
_local3.compiledRegExp:push(_local3.flags);
_local3.compiledRegExp:push("\")");
_local3.ret = _local3.compiledRegExp:join("");
if _bool(meta) then
meta.type = "object";
end

do return _local3.ret; end
end

repeat
local _into = false;
local _cases = {["string"] = true,["number"] = true,["boolean"] = true};
local _v = _type(literal.value);
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "string") then
_local3.ret = ((_addStr1("\"",sanitizeLiteralString(_ENV,literal.value))) .. "\"");
if _bool(meta) then
meta.type = "string";
end

break;
_into = true;
end
if _into or (_v == "number") then
_local3.ret = JSON:stringify(literal.value);
if _bool(meta) then
meta.type = "number";
end

break;
_into = true;
end
if _into or (_v == "boolean") then
if _bool(meta) then
meta.type = "boolean";
end

break;
_into = true;
end
::_default::
until true
do return _local3.ret; end
end));_local2.luaKeywords = _arr({[0]="and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"},22);
_local2.labelTracker = _arr({},0);
_local2.continueNoLabelTracker = _arr({},0);
_local2.withTracker = _arr({},0);
_local2.deductions = _arr({},0);
CompileResult.prototype = _obj({
["push"] = (function(this,anyObj)
local _local3 = {};
_local3.tp = _type(anyObj);
if ((function() local _lev=(_local3.tp == "string"); return _bool(_lev) and _lev or (_local3.tp == "number") end)()) then
this.array:push(anyObj);
elseif (_local3.tp == "object") then
if _bool(isCompileResultLike(_ENV,anyObj)) then
this:pushOther(anyObj);
elseif _bool(anyObj.name) then
this.array:push(anyObj);
else
console:error("invalid object:",anyObj.prototype,JSON:stringify(anyObj,null,2));
end

else
console:error("invalid type:",JSON:stringify(anyObj,null,2));
end

do return this; end
end),
["pop"] = (function(this)
do return this.array:pop(); end
end),
["toString"] = (function(this)
do return this.array:map((function(this,v)
do return (function() if _bool(isNumOrString(_ENV,_type(v))) then return v; else return (function() if _bool(isCompileResultLike(_ENV,v)) then return v:toString(); else return ((function() local _lev=v.value; return _bool(_lev) and _lev or v.name end)()); end end)(); end end)(); end
end)):join(this.sep); end
end),
["quote"] = (function(this,q)
if not _bool(q) then
q = "\"";
end

this.array:unshift(q);
this.array:push(q);
do return this; end
end),
["slice"] = (function(this,s,e)
do return _new(CompileResult,this.array:slice(s,e),this.sep); end
end),
["mergeSelf"] = (function(this,sep)
if not _bool(sep) then
sep = this.sep;
end

this.array = __mergeArray(_ENV,_arr({},0),this.array,sep);
do return this; end
end),
["indexOf"] = (function(this,s)
do return this.array:findIndex((function(this,v)
if _bool(isNumOrString(_ENV,_type(v))) then
do return (_eq(v,s)); end
end

if (_type(v) == "object") then
do return (v.name == s); end
end

do return false; end
end)); end
end),
["prepend"] = (function(this,s)
this.array:unshift(s);
do return this; end
end),
["pushOther"] = (function(this,cr,sep)
if (sep == undefined) then
sep = cr.sep;
end

if (this.sep == sep) then
__mergeArray(_ENV,this.array,cr.array,sep);
else
this.array:push(cr);
end

end),
["joinFinal"] = (function(this,sep)
if (sep == undefined) then
sep = this.sep;
end

do return this.array:filter((function(this,v)
do return (v ~= ""); end
end)):map((function(this,v)
if _bool(isNumOrString(_ENV,_type(v))) then
do return v; end
end

if _bool(isCompileResultLike(_ENV,v)) then
do return v:joinFinal(v.sep); end
end

if (_type(v.name) ~= "string") then
console:error("name unexpected:",v);
end

if _bool(v.value) then
do return v.value; end
end

do return v.name; end
end)):join(sep); end
end),
["join"] = (function(this,sep)
if (sep == undefined) then
sep = this.sep;
end

do return this:mergeSelf(sep); end
end)
});
ProtectedCallManager.prototype = _obj({
["isInProtectedCallContext"] = (function(this)
if (_gt(this.protectedCallContext.length,0)) then
do return true; end
end

do return false; end
end),
["noInsideIteration"] = (function(this)
do return (this.iterationStatement[(this.iterationStatement.length - 1)].length == 0); end
end),
["noInsideSwitch"] = (function(this)
do return (this.switchStatement[(this.switchStatement.length - 1)].length == 0); end
end),
["may"] = (function(this)
do return _obj({
["mayReturn"] = this.mayReturnStack[(this.mayReturnStack.length - 1)],
["mayBreak"] = this.mayBreakStack[(this.mayBreakStack.length - 1)],
["mayContinue"] = this.mayContinueStack[(this.mayContinueStack.length - 1)]
}); end
end),
["openContext"] = (function(this)
this.protectedCallContext:push(true);
this.iterationStatement:push(_arr({},0));
this.switchStatement:push(_arr({},0));
this.mayBreakStack:push(false);
this.mayContinueStack:push(false);
this.mayReturnStack:push(false);
end),
["closeContext"] = (function(this)
this.protectedCallContext:pop();
this.iterationStatement:pop();
this.switchStatement:pop();
this.mayBreakStack:pop();
this.mayContinueStack:pop();
this.mayReturnStack:pop();
end),
["openIterationStatement"] = (function(this)
if _bool(this:isInProtectedCallContext()) then
this.iterationStatement[(this.iterationStatement.length - 1)]:push(true);
end

end),
["closeIterationStatement"] = (function(this)
if _bool(this:isInProtectedCallContext()) then
this.iterationStatement[(this.iterationStatement.length - 1)]:pop();
end

end),
["openSwitchStatement"] = (function(this)
if _bool(this:isInProtectedCallContext()) then
this.switchStatement[(this.iterationStatement.length - 1)]:push(true);
end

end),
["closeSwitchStatement"] = (function(this)
if _bool(this:isInProtectedCallContext()) then
this.switchStatement[(this.iterationStatement.length - 1)]:pop();
end

end),
["returnStatement"] = (function(this)
if _bool(this:isInProtectedCallContext()) then
this.mayReturnStack[(this.mayReturnStack.length - 1)] = true;
end

end),
["breakOutside"] = (function(this)
if _bool(((function() local _lev=((function() local _lev=this:isInProtectedCallContext(); if _bool(_lev) then return this:noInsideIteration(); else return _lev; end end)()); if _bool(_lev) then return this:noInsideSwitch(); else return _lev; end end)())) then
this.mayBreakStack[(this.mayBreakStack.length - 1)] = true;
do return true; end
end

do return false; end
end),
["continueOutside"] = (function(this)
if _bool(((function() local _lev=this:isInProtectedCallContext(); if _bool(_lev) then return this:noInsideIteration(); else return _lev; end end)())) then
this.mayContinueStack[(this.mayContinueStack.length - 1)] = true;
do return true; end
end

do return false; end
end)
});
_local2.protectedCallManager = _new(ProtectedCallManager);
LocalVarManager.prototype = _obj({
["reset"] = (function(this)
this.pathNums = _arr({},0);
this.unresolved = _arr({},0);
this.params = _arr({},0);
this.locals = _arr({},0);
this.functions = _arr({},0);
this.args = _arr({},0);
end),
["popLocalContext"] = (function(this)
if (_gt(this.locals.length,0)) then
do return _arr({[0]=this.locals:pop(),this.args:pop(),this.functions:pop(),this.params:pop()},4); end
end

_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end),
["createLocalContext"] = (function(this)
this.locals:push(_arr({},0));
this.functions:push(_arr({},0));
this.params:push(_arr({},0));
this.args:push(false);
while (_lt(this.pathNums.length,this.functions.length)) do
this.pathNums:push(0);
::_continue::
end

do local _cp = (this.functions.length - 1); this.pathNums[_cp] = _inc(this.pathNums[_cp]);end;
end),
["registerUnresolvedVar"] = (function(this,name,resolved__level)
local _local3 = {};
_local3.path = this:getVarPath();
if (resolved__level ~= undefined) then
_local3.resolved__path = this.pathNums:slice(0,(_addNum2(resolved__level,1))):join(".");
_local3.resolved__value = (_addStr1(((_addStr1("_local",(_addNum2(resolved__level,1)))) .. "."),name));
end

_local3.va = _obj({
["name"] = name,
["path"] = _local3.path,
["value"] = _local3.resolved__value,
["resolvedPath"] = _local3.resolved__path
});
if (_lt(this.unresolved:findIndex((function(this,v)
do return ((function() local _lev=(_eq(v.name,name)); if _bool(_lev) then return (_eq(v.path,_local3.path)); else return _lev; end end)()); end
end)),0)) then
this.unresolved:push(_local3.va);
end

do return _local3.va; end
end),
["resolveVar"] = (function(this,name)
local _local3 = {};
_local3.curpath = this:getVarPath();
_local3.changed = 0;
name = name:replace(_regexp("^[^\\.]*\\.","g"),"");
this.unresolved:forEach((function(this,v)
if ((function() local _lev=(_eq(name,v.name)); if _bool(_lev) then return (_eq(v.path:slice(0,_local3.curpath.length),_local3.curpath)); else return _lev; end end)()) then
if ((function() local _lev=not _bool(v.resolvedPath); return _bool(_lev) and _lev or (_gt(_local3.curpath.length,v.resolvedPath.length)) end)()) then
v.value = this:loVarName(name);
v.resolvedPath = _local3.curpath;
else

end

_local3.changed = _inc(_local3.changed);
end

end):bind(this));
do return (_gt(_local3.changed,0)); end
end),
["getVarPath"] = (function(this)
do return this.pathNums:slice(0,this.functions.length):join("."); end
end),
["loVarsName"] = (function(this)
do return (_addStr1("_local",(_addNum2(this.functions.length,1)))); end
end),
["loVarName"] = (function(this,id)
do return (_addStr1(((_addStr1("_local",this.functions.length)) .. "."),id)); end
end),
["findLoVar"] = (function(this,id)
local _local3 = {};
_local3.i = (this.locals.length - 1);
while (_ge(_local3.i,0)) do
_local3.idx = this.locals[_local3.i]:indexOf(id);
if (_ge(_local3.idx,0)) then
if (_lt(_local3.i,(this.locals.length - 1))) then
do return this:registerUnresolvedVar(id,_local3.i); end
end

do return (_addStr1(((_addStr1("_local",(_addNum2(_local3.i,1)))) .. "."),id)); end
else
if (_ge(this.params[_local3.i]:indexOf(id),0)) then
do return id; end
end

end

_local3.i = _dec(_local3.i);
end

do return null; end
end),
["pushLocal"] = (function(this,varName)
if (_gt(this.locals.length,0)) then
varName = varName:replace(_regexp("^[^\\.]*\\.","g"),"");
this.locals[(this.locals.length - 1)]:push(varName);
this:resolveVar(varName);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["pushFunction"] = (function(this,functionDeclaration)
if (_gt(this.functions.length,0)) then
this.functions[(this.functions.length - 1)]:push(functionDeclaration);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["pushParam"] = (function(this,pn)
if (_gt(this.params.length,0)) then
this.params[(this.params.length - 1)]:push(pn);
end

end),
["useArguments"] = (function(this)
if (_gt(this.args.length,0)) then
this.args[(this.args.length - 1)] = true;
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end)
});
_local2.localVarManager = _new(LocalVarManager);
exports.compileAST = compileAST;
end));
return module.exports;