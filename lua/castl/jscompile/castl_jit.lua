_nodejs = true;
local _ENV = require("castl.runtime");
return setfenv(function(...)
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
local localVarManager,protectedCallManager,deductions,withTracker,continueNoLabelTracker,labelTracker,annotations,options,luaKeywords;
setMeta =((function(this,node,meta)
if _bool(options.annotation) then
if _bool(((function() local _lev=annotations[(node.loc.start.line - 1)]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = annotations[(node.loc.start.line - 1)];
do return end
end

end

if _bool(options.heuristic) then
if _bool(((function() local _lev=deductions[node.loc.start.line]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = deductions[node.loc.start.line];
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
local lastTp;
if not _bool(sep) then
sep = "";
end

src:forEach((function(this,v,idx)
local curTp;
curTp = _type(v);
if _bool(isCompileResultLike(_ENV,v)) then
if _bool(((function() local _lev=v.array; if _bool(_lev) then return (_gt(v.array.length,0)); else return _lev; end end)())) then
arr:push(v);
end

else
if (v ~= "") then
if (idx == 0) then
arr:push(v);
else
if _bool(((function() local _lev=isNumOrString(_ENV,lastTp); if _bool(_lev) then return isNumOrString(_ENV,curTp); else return _lev; end end)())) then
do local _cp = (arr.length - 1); arr[_cp] = (_add(arr[_cp],(_add(sep,v)))) end;
else
arr:push(v);
end

end

end

end

lastTp = curTp;
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
local i,compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,locals,useArguments,context,topLevelStatements,compiledProgram;
options = (_bool(opts) and opts or _obj({}));
annotations = (_bool(anno) and anno or _obj({}));
if _bool(options.luaLocal) then
console:log("limited mode enabled - limited to 200 js vars each scope");
end

if (ast.type == "Program") then
compiledProgram = _new(CompileResult,_arr({},0),"\10");
localVarManager:reset();
localVarManager:createLocalContext();
topLevelStatements = compileListOfStatements(_ENV,ast.body);
context = localVarManager:popLocalContext();
useArguments = context[1];
if _bool(useArguments) then
compiledProgram:push("local arguments = _args(...);");
end

locals = context[0];
if (_gt(locals.length,0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals);
compiledProgram:push(compiledLocalsDeclaration);
end

functions = context[2];
if (_gt(functions.length,0)) then
compiledFunctionsDeclaration = _new(CompileResult,_arr({},0));
i = 0;
while (_lt(i,functions.length)) do
compiledFunctionsDeclaration:push(functions[i]);
i = _inc(i);
end

compiledProgram:push(compiledFunctionsDeclaration:join("\10"));
end

compiledProgram:push(topLevelStatements);
do return _obj({
["success"] = true,
["compiled"] = compiledProgram:joinFinal("\10")
}); end
end

do return _obj({
["success"] = false,
["compiled"] = ""
}); end
end));
compileStatement =((function(this,statement)
local line,compiledStatement;
repeat
local _into = false;
local _cases = {["ExpressionStatement"] = true,["BlockStatement"] = true,["FunctionDeclaration"] = true,["VariableDeclaration"] = true,["IfStatement"] = true,["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true,["ReturnStatement"] = true,["BreakStatement"] = true,["TryStatement"] = true,["ThrowStatement"] = true,["SwitchStatement"] = true,["ContinueStatement"] = true,["LabeledStatement"] = true,["WithStatement"] = true,["EmptyStatement"] = true,["DebuggerStatement"] = true,["ForOfStatement"] = true,["ClassDeclaration"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ExpressionStatement") then
compiledStatement = compileExpressionStatement(_ENV,statement.expression);
do break end;
_into = true;
end
if _into or (_v == "BlockStatement") then
compiledStatement = compileListOfStatements(_ENV,statement.body);
do break end;
_into = true;
end
if _into or (_v == "FunctionDeclaration") then
compiledStatement = compileFunctionDeclaration(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "VariableDeclaration") then
compiledStatement = compileVariableDeclaration(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "IfStatement") then
compiledStatement = compileIfStatement(_ENV,statement);
do break end;
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
compiledStatement = compileIterationStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ReturnStatement") then
compiledStatement = compileReturnStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "BreakStatement") then
compiledStatement = compileBreakStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "TryStatement") then
compiledStatement = compileTryStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ThrowStatement") then
compiledStatement = compileThrowStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "SwitchStatement") then
compiledStatement = compileSwitchStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ContinueStatement") then
compiledStatement = compileContinueStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "LabeledStatement") then
compiledStatement = compileLabeledStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "WithStatement") then
compiledStatement = compileWithStatement(_ENV,statement);
do break end;
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
if (compiledStatement ~= undefined) then
if _bool(options.debug) then
line = statement.loc.start.line;
do return _new(CompileResult,_arr({[0]=((_addStr1("--[[",line)) .. "--]] ")},1)):push(compiledStatement); end
end

do return compiledStatement; end
end

end));
compileListOfStatements =((function(this,statementList)
local compiledStatement,i,compiledStatements;
compiledStatements = _new(CompileResult,_arr({},0),"\10");
i = 0;
while (_lt(i,statementList.length)) do
compiledStatement = compileStatement(_ENV,statementList[i]);
if ((function() local _lev=(compiledStatement ~= ""); if _bool(_lev) then return (compiledStatement ~= undefined); else return _lev; end end)()) then
compiledStatements:push(compiledStatement);
end

i = _inc(i);
end

do return compiledStatements; end
end));
compileBooleanExpression =((function(this,expression)
local compiledExpression,meta,compiledBooleanExpression;
compiledBooleanExpression = _new(CompileResult);
meta = _obj({});
compiledExpression = compileExpression(_ENV,expression,meta);
if (meta.type == "boolean") then
compiledBooleanExpression:push(compiledExpression);
else
compiledBooleanExpression:push("_bool(");
compiledBooleanExpression:push(compiledExpression);
compiledBooleanExpression:push(")");
end

do return compiledBooleanExpression; end
end));
compileIfStatement =((function(this,statement,elif)
local compiledIfStatement;
compiledIfStatement = _new(CompileResult);
if _bool(elif) then
compiledIfStatement:push("elseif ");
else
compiledIfStatement:push("if ");
end

compiledIfStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledIfStatement:push(" then\10");
compiledIfStatement:push(compileStatement(_ENV,statement.consequent));
if (statement.alternate ~= null) then
compiledIfStatement:push("\10");
if (statement.alternate.type == "IfStatement") then
compiledIfStatement:push(compileIfStatement(_ENV,statement.alternate,true));
else
compiledIfStatement:push("else\10");
compiledIfStatement:push(compileStatement(_ENV,statement.alternate));
end

end

if not _bool(elif) then
compiledIfStatement:push("\10");
compiledIfStatement:push("end\10");
end

do return compiledIfStatement; end
end));
compileIterationStatement =((function(this,statement,compiledLabel)
local compiledIterationStatement;
compiledIterationStatement = "";
continueNoLabelTracker:push(false);
protectedCallManager:openIterationStatement();
repeat
local _into = false;
local _cases = {["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ForStatement") then
compiledIterationStatement = compileForStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "WhileStatement") then
compiledIterationStatement = compileWhileStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "DoWhileStatement") then
compiledIterationStatement = compileDoWhileStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "ForInStatement") then
compiledIterationStatement = compileForInStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Not an IterationStatement ",statement.type))),0)
_into = true;
end
until true
protectedCallManager:closeIterationStatement();
continueNoLabelTracker:pop();
do return compiledIterationStatement; end
end));
compileForInit =((function(this,init)
local compiledForInit;
compiledForInit = _new(CompileResult);
if (init ~= null) then
if (init.type == "VariableDeclaration") then
compiledForInit:push(compileVariableDeclaration(_ENV,init));
else
compiledForInit:push(compileExpressionStatement(_ENV,init));
end

compiledForInit:push("\10");
end

do return compiledForInit; end
end));
compileForUpdate =((function(this,update)
local compiledForUpdate;
compiledForUpdate = _new(CompileResult);
if (update ~= null) then
compiledForUpdate:push(compileExpressionStatement(_ENV,update));
compiledForUpdate:push("\10");
end

do return compiledForUpdate; end
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
local metaRight;
if _bool(((function() local _lev=(expression ~= null); if _bool(_lev) then return isCompoundAssignment(_ENV,expression); else return _lev; end end)())) then
if ((function() local _lev=(expression.left.type == "Identifier"); if _bool(_lev) then return (_gt(variables:indexOf(expression.left.name),-1)); else return _lev; end end)()) then
if (expression.operator == "+=") then
metaRight = _obj({});
compileExpression(_ENV,expression.right,metaRight);
do return (metaRight.type == "number"); end
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
local i,declarations,metaRight,init,possibleNumericForVariable;
possibleNumericForVariable = _arr({},0);
init = statement.init;
if (init == null) then
do return false; end
end

if (init.type == "VariableDeclaration") then
declarations = init.declarations;
i = 0;
while (_lt(i,declarations.length)) do
if (declarations[i].init ~= null) then
metaRight = _obj({});
compileExpression(_ENV,declarations[i].init,metaRight);
if (metaRight.type == "number") then
possibleNumericForVariable:push(declarations[i].id.name);
end

end

i = _inc(i);
end

elseif (init.type == "AssignmentExpression") then
if (init.left.type == "Identifier") then
metaRight = _obj({});
compileExpression(_ENV,init.right,metaRight);
if (metaRight.type == "number") then
possibleNumericForVariable:push(init.left.name);
end

end

end

if (_gt(possibleNumericForVariable.length,0)) then
if _bool(isComparisonExpressionWith(_ENV,statement.test,possibleNumericForVariable)) then
if _bool(isUpdateExpressionWith(_ENV,statement.update,possibleNumericForVariable)) then
do return true; end
end

if _bool(isNumericCompoundAssignmentExpressionWith(_ENV,statement.update,possibleNumericForVariable)) then
do return true; end
end

end

end

do return false; end
end));
compileForStatement =((function(this,statement,compiledLabel)
local compiledForStatement;
compiledForStatement = _new(CompileResult);
if _bool(options.heuristic) then
if _bool(mayBeNumericFor(_ENV,statement)) then
deductions[statement.loc.start.line] = "number";
end

end

compiledForStatement:push(compileForInit(_ENV,statement.init));
compiledForStatement:push("while ");
compiledForStatement:push(compileForTest(_ENV,statement.test));
compiledForStatement:push(" do\10");
compiledForStatement:push(compileStatement(_ENV,statement.body));
compiledForStatement:push("\10");
if _bool(continueNoLabelTracker[(continueNoLabelTracker.length - 1)]) then
compiledForStatement:push("::_continue::\10");
end

if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledForStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

compiledForStatement:push(compileForUpdate(_ENV,statement.update));
compiledForStatement:push("end\10");
do return compiledForStatement; end
end));
compileForInStatement =((function(this,statement,compiledLabel)
local compiledLeft,compiledForInStatement;
compiledForInStatement = _new(CompileResult);
compiledForInStatement:push("local _p = _props(");
compiledForInStatement:push(compileExpression(_ENV,statement.right));
compiledForInStatement:push(", true);\10");
if (statement.left.type == "VariableDeclaration") then
compiledLeft = compilePattern(_ENV,statement.left.declarations[0].id);
else
compiledLeft = compileExpression(_ENV,statement.left);
end

compiledForInStatement:push("for _,");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" in _ipairs(_p) do\10");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" = _tostr(");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(");\10");
compiledForInStatement:push(compileStatement(_ENV,statement.body));
compiledForInStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledForInStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

compiledForInStatement:push("end\10");
do return compiledForInStatement; end
end));
compileWhileStatement =((function(this,statement,compiledLabel)
local compiledWhileStatement;
compiledWhileStatement = _new(CompileResult,_arr({[0]="while "},1));
compiledWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledWhileStatement:push(" do\10");
compiledWhileStatement:push(compileStatement(_ENV,statement.body));
compiledWhileStatement:push("\10");
compiledWhileStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledWhileStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

compiledWhileStatement:push("end\10");
do return compiledWhileStatement; end
end));
compileDoWhileStatement =((function(this,statement,compiledLabel)
local compiledDoWhileStatement;
compiledDoWhileStatement = _new(CompileResult,_arr({[0]="repeat\10"},1));
compiledDoWhileStatement:push(compileStatement(_ENV,statement.body));
compiledDoWhileStatement:push("\10");
compiledDoWhileStatement:push("::_continue::\10");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledDoWhileStatement:push(((_addStr1("::",compiledLabel)) .. "_c::\10"));
end

compiledDoWhileStatement:push("until not ");
compiledDoWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledDoWhileStatement:push("\10");
do return compiledDoWhileStatement; end
end));
isIterationStatement =((function(this,statement)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(statement.type == "ForStatement"); return _bool(_lev) and _lev or (statement.type == "DoWhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "WhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "ForInStatement") end)()); end
end));
compileLabeledStatement =((function(this,statement)
local compiledLabel,label,compiledLabeledStatement;
compiledLabeledStatement = _new(CompileResult);
label = statement.label;
compiledLabel = compileIdentifier(_ENV,label,"label");
labelTracker[compiledLabel] = _obj({
["mayBreak"] = false,
["mayContinue"] = false
});
if _bool(isIterationStatement(_ENV,statement.body)) then
compiledLabeledStatement:push(compileIterationStatement(_ENV,statement.body,compiledLabel));
else
compiledLabeledStatement:push(compileStatement(_ENV,statement.body));
end

if _bool(labelTracker[compiledLabel].mayBreak) then
compiledLabeledStatement:push(((_addStr1("::",compiledLabel)) .. "_b::\10"));
end

(function () local _r = false; local _g, _s = labelTracker["_g" .. compiledLabel], labelTracker["_s" .. compiledLabel]; labelTracker["_g" .. compiledLabel], labelTracker["_s" .. compiledLabel] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = labelTracker[compiledLabel]; labelTracker[compiledLabel] = nil; return _r or _v ~= nil; end)();
do return compiledLabeledStatement; end
end));
compileBreakStatement =((function(this,statement)
local compiledLabel;
if (statement.label == null) then
if _bool(protectedCallManager:breakOutside()) then
do return "do return _break; end"; end
end

if _bool(options.jit) then
do return "do break end;"; end
else
do return "break;"; end
end

end

compiledLabel = compileIdentifier(_ENV,statement.label,"label");
labelTracker[compiledLabel].mayBreak = true;
do return _new(CompileResult,_arr({[0]="goto ",compiledLabel,"_b;"},3),""); end
end));
compileContinueStatement =((function(this,statement)
local compiledLabel;
if (statement.label == null) then
continueNoLabelTracker[(continueNoLabelTracker.length - 1)] = true;
if _bool(protectedCallManager:continueOutside()) then
do return "do return _continue; end"; end
end

do return _new(CompileResult,_arr({[0]="goto _continue"},1),""); end
end

compiledLabel = compileIdentifier(_ENV,statement.label,"label");
labelTracker[compiledLabel].mayContinue = true;
do return _new(CompileResult,_arr({[0]="goto ",compiledLabel,"_c;"},3)); end
end));
compileSwitchStatement =((function(this,statement)
local hasDefault,compiledTests,caseTablementElement,casesTable,i,compiledSwitchStatement,cases;
protectedCallManager:openSwitchStatement();
cases = statement.cases;
if (_gt(cases.length,0)) then
compiledSwitchStatement = _new(CompileResult,_arr({[0]="repeat\10local _into = false;\10"},1));
casesTable = _new(CompileResult);
compiledTests = _arr({},0);
i = 0;
while (_lt(i,cases.length)) do
if (cases[i].test ~= null) then
compiledTests[i] = compileExpression(_ENV,cases[i].test);
caseTablementElement = _new(CompileResult);
caseTablementElement:push("[");
caseTablementElement:push(compiledTests[i]);
caseTablementElement:push("] = true");
casesTable:push(caseTablementElement);
end

i = _inc(i);
end

compiledSwitchStatement:push("local _cases = {");
compiledSwitchStatement:push(casesTable:join(","));
compiledSwitchStatement:push("};\10");
compiledSwitchStatement:push("local _v = ");
compiledSwitchStatement:push(compileExpression(_ENV,statement.discriminant));
compiledSwitchStatement:push(";\10");
compiledSwitchStatement:push("if not _cases[_v] then\10");
compiledSwitchStatement:push("_into = true;\10");
compiledSwitchStatement:push("goto _default\10");
compiledSwitchStatement:push("end\10");
hasDefault = false;
i = 0;
while (_lt(i,cases.length)) do
if (cases[i].test ~= null) then
compiledSwitchStatement:push("if _into or (_v == ");
compiledSwitchStatement:push(compiledTests[i]);
compiledSwitchStatement:push(") then\10");
else
hasDefault = true;
compiledSwitchStatement:push("::_default::\10");
compiledSwitchStatement:push("if _into then\10");
end

compiledSwitchStatement:push(compileListOfStatements(_ENV,cases[i].consequent));
compiledSwitchStatement:push("\10");
compiledSwitchStatement:push("_into = true;\10");
compiledSwitchStatement:push("end\10");
i = _inc(i);
end

if not _bool(hasDefault) then
compiledSwitchStatement:push("::_default::\10");
end

compiledSwitchStatement:push("until true");
protectedCallManager:closeSwitchStatement();
do return compiledSwitchStatement; end
end

protectedCallManager:closeSwitchStatement();
do return ""; end
end));
compileTryStatement =((function(this,statement)
if _bool(statement.handlers) then
do return compileTryStatementFlavored(_ENV,statement,true); end
end

do return compileTryStatementFlavored(_ENV,statement,false); end
end));
compileTryStatementFlavored =((function(this,statement,esprima)
local handler,compiledTryStatement,may,finallyStatements,hasFinalizer,hasHandler;
hasHandler = (function() if _bool(esprima) then return (_gt(statement.handlers.length,0)); else return (statement.handler ~= null); end end)();
hasFinalizer = (statement.finalizer ~= null);
protectedCallManager:openContext();
compiledTryStatement = _new(CompileResult,_arr({[0]="local _status, _return = _pcall(function()\10"},1));
compiledTryStatement:push(compileListOfStatements(_ENV,statement.block.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
may = protectedCallManager:may();
protectedCallManager:closeContext();
if _bool(((function() local _lev=((function() local _lev=(_bool(hasFinalizer) and hasFinalizer or may.mayReturn); return _bool(_lev) and _lev or may.mayBreak end)()); return _bool(_lev) and _lev or may.mayContinue end)())) then
compiledTryStatement:push("if _status then\10");
if _bool(hasFinalizer) then
finallyStatements = compileListOfStatements(_ENV,statement.finalizer.body);
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool(((function() local _lev=may.mayBreak; if _bool(_lev) then return may.mayContinue; else return _lev; end end)())) then
compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\10");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _return == _break then break; end\10");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _return == _continue then goto _continue end\10");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _return ~= nil then return _return; end\10");
end

compiledTryStatement:push("else\10");
else
compiledTryStatement:push("if not _status then\10");
end

if _bool(hasHandler) then
handler = (function() if _bool(esprima) then return statement.handlers[0]; else return statement.handler; end end)();
protectedCallManager:openContext();
compiledTryStatement:push("local _cstatus, _creturn = _pcall(function()\10");
compiledTryStatement:push("local ");
compiledTryStatement:push(compilePattern(_ENV,handler.param));
compiledTryStatement:push(" = _return;\10");
compiledTryStatement:push(compileListOfStatements(_ENV,handler.body.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
may = protectedCallManager:may();
protectedCallManager:closeContext();
end

if _bool(hasFinalizer) then
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool(hasHandler) then
compiledTryStatement:push("if _cstatus then\10");
if _bool(((function() local _lev=may.mayBreak; if _bool(_lev) then return may.mayContinue; else return _lev; end end)())) then
compiledTryStatement:push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\10");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _creturn == _break then break; end\10");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _creturn == _continue then goto _continue end\10");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _creturn ~= nil then return _creturn; end\10");
end

compiledTryStatement:push("else _throw(_creturn,0); end\10");
end

compiledTryStatement:push("end\10");
do return compiledTryStatement; end
end));
compileThrowStatement =((function(this,statement)
local compiledThrowStatement;
compiledThrowStatement = _new(CompileResult,_arr({[0]="_throw("},1));
compiledThrowStatement:push(compileExpression(_ENV,statement.argument));
compiledThrowStatement:push(",0)");
do return compiledThrowStatement; end
end));
compileReturnStatement =((function(this,statement)
protectedCallManager:returnStatement();
if (statement.argument ~= null) then
do return _new(CompileResult,_arr({[0]="do return ",compileExpression(_ENV,statement.argument,_obj({})),"; end"},3)); end
end

do return "do return end"; end
end));
compileWithStatement =((function(this,statement)
local compiledWithStatement;
withTracker:push(true);
compiledWithStatement = _new(CompileResult,_arr({[0]="do\10"},1));
compiledWithStatement:push("local _oldENV = _ENV;\10");
compiledWithStatement:push("local _ENV = _with(");
compiledWithStatement:push(compileExpression(_ENV,statement.object));
compiledWithStatement:push(", _ENV);\10");
if _bool(options.jit) then
compiledWithStatement:push("_wenv(function(...)\10");
end

compiledWithStatement:push(compileStatement(_ENV,statement.body));
if _bool(options.jit) then
compiledWithStatement:push("\10end, _ENV)()");
end

compiledWithStatement:push("\10end");
withTracker:pop();
do return compiledWithStatement; end
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
if _bool(options.evalMode) then
do return compileExpressionStatementEvalMode(_ENV,expression,meta); end
else
do return compileExpressionStatementNoEval(_ENV,expression,meta); end
end

end));
compileExpressionStatementEvalMode =((function(this,expression,meta)
local compiledExpressionStatement;
compiledExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
compiledExpressionStatement:push(");");
do return compiledExpressionStatement; end
end));
compileExpressionStatementNoEval =((function(this,expression,meta)
local compiledUnaryExpressionStatement,compiledExpressionStatement;
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
compiledExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
compiledExpressionStatement:push(");");
do return compiledExpressionStatement:join(""); end
_into = true;
end
if _into or (_v == "UnaryExpression") then
if (expression.operator == "!") then
compiledUnaryExpressionStatement = _new(CompileResult,_arr({[0]="_e("},1));
compiledUnaryExpressionStatement:push(compileUnaryExpression(_ENV,expression,meta));
compiledUnaryExpressionStatement:push(");");
do return compiledUnaryExpressionStatement:join(""); end
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
local compiledCompoundAssignmentBinaryExpression;
compiledCompoundAssignmentBinaryExpression = _new(CompileResult,_arr({[0]="("},1));
repeat
local _into = false;
local _cases = {["<<="] = true,[">>="] = true,[">>>="] = true,["+="] = true,["-="] = true,["*="] = true,["/="] = true,["%="] = true,["|="] = true,["^="] = true,["&="] = true};
local _v = operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "<<=") then
compiledCompoundAssignmentBinaryExpression:push("_lshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>=") then
compiledCompoundAssignmentBinaryExpression:push("_arshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>>=") then
compiledCompoundAssignmentBinaryExpression:push("_rshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+=") then
compiledCompoundAssignmentBinaryExpression:push(compileAdditionOperator(_ENV,left,right,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "-=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," - ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "*=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," * ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "/=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," / ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "%=") then
compiledCompoundAssignmentBinaryExpression:push("_mod(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "|=") then
compiledCompoundAssignmentBinaryExpression:push("_bor(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "^=") then
compiledCompoundAssignmentBinaryExpression:push("_bxor(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "&=") then
compiledCompoundAssignmentBinaryExpression:push("_band(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown BinaryOperator: ",operator))),0)
_into = true;
end
until true
compiledCompoundAssignmentBinaryExpression:push(")");
do return compiledCompoundAssignmentBinaryExpression; end
end));
storeComputedProperty =((function(this,expression)
local hasComputedProperty;
hasComputedProperty = ((function() local _lev=(expression.type == "MemberExpression"); if _bool(_lev) then return expression.computed; else return _lev; end end)());
if _bool(hasComputedProperty) then
if (expression.property.type == "Literal") then
do return false; end
end

else
do return false; end
end

do return true; end
end));
compileCompoundAssignmentNoEval =((function(this,expression)
local split,right,left,metaRight,metaLeft,mustStore,compiledAssignmentBinaryExpression;
compiledAssignmentBinaryExpression = _new(CompileResult);
mustStore = storeComputedProperty(_ENV,expression.left);
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
if _bool(mustStore) then
split = getBaseMember(_ENV,left);
left = (_addStr2(split.base,"[_cp]"));
compiledAssignmentBinaryExpression:push("do local _cp = ");
compiledAssignmentBinaryExpression:push(split.member);
compiledAssignmentBinaryExpression:push("; ");
end

compiledAssignmentBinaryExpression:push(left);
compiledAssignmentBinaryExpression:push(" = ");
compiledAssignmentBinaryExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,left,right,expression.operator,metaLeft,metaRight));
if _bool(mustStore) then
compiledAssignmentBinaryExpression:push(" end");
end

do return compiledAssignmentBinaryExpression; end
end));
compileAssignmentExpressionNoEval =((function(this,expression)
local right,left,compiledAssignmentExpression;
compiledAssignmentExpression = _new(CompileResult);
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
left = compileExpression(_ENV,expression.left);
right = compileExpression(_ENV,expression.right);
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" = ");
compiledAssignmentExpression:push(right);
do break end;
_into = true;
end
::_default::
if _into then
do return compileCompoundAssignmentNoEval(_ENV,expression); end
_into = true;
end
until true
do return compiledAssignmentExpression; end
end));
compileAssignmentExpression =((function(this,expression,meta)
local split,right,left,metaRight,metaLeft,mustStore,compiledAssignmentExpression;
compiledAssignmentExpression = _new(CompileResult,_arr({[0]="(function() "},1));
mustStore = storeComputedProperty(_ENV,expression.left);
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
if _bool(mustStore) then
split = getBaseMember(_ENV,left);
compiledAssignmentExpression:push("local _cp = ");
compiledAssignmentExpression:push(split.member);
compiledAssignmentExpression:push(";");
left = (_addStr2(split.base,"[_cp]"));
end

compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" = ");
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
compiledAssignmentExpression:push(right);
if _bool(meta) then
meta.type = metaRight.type;
end

do break end;
_into = true;
end
::_default::
if _into then
compiledAssignmentExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,left,right,expression.operator,metaLeft,metaRight,meta));
_into = true;
end
until true
compiledAssignmentExpression:push("; return ");
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" end)()");
do return compiledAssignmentExpression; end
end));
compileUpdateExpressionNoEval =((function(this,expression)
local split,compiledArgument,metaArgument,mustStore,compiledUpdateExpression;
compiledUpdateExpression = _new(CompileResult);
mustStore = storeComputedProperty(_ENV,expression.argument);
metaArgument = _obj({});
compiledArgument = compileExpression(_ENV,expression.argument,metaArgument);
if _bool(mustStore) then
split = getBaseMember(_ENV,compiledArgument);
compiledArgument = (_addStr2(split.base,"[_cp]"));
compiledUpdateExpression:push("do local _cp = ");
compiledUpdateExpression:push(split.member);
compiledUpdateExpression:push("; ");
end

compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" + 1");
else
compiledUpdateExpression:push("_inc(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(")");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" - 1");
else
compiledUpdateExpression:push("_dec(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(")");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
if _bool(mustStore) then
compiledUpdateExpression:push(";end");
end

do return compiledUpdateExpression; end
end));
compileUpdateExpression =((function(this,expression,meta)
local split,compiledArgument,metaArgument,mustStore,compiledUpdateExpression;
compiledUpdateExpression = _new(CompileResult,_arr({[0]="(function () "},1));
mustStore = storeComputedProperty(_ENV,expression.argument);
metaArgument = _obj({});
compiledArgument = compileExpression(_ENV,expression.argument,metaArgument);
if _bool(mustStore) then
split = getBaseMember(_ENV,compiledArgument);
compiledUpdateExpression:push("local _cp = ");
compiledUpdateExpression:push(split.member);
compiledUpdateExpression:push(";");
compiledArgument = (_addStr2(split.base,"[_cp]"));
end

compiledUpdateExpression:push("local _tmp = ");
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
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" + 1; ");
else
compiledUpdateExpression:push("_inc(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("); ");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" - 1; ");
else
compiledUpdateExpression:push("_dec(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("); ");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = _tmp");
else
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("; ");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push("_tmp + 1");
else
compiledUpdateExpression:push("_inc(_tmp)");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push("_tmp - 1");
else
compiledUpdateExpression:push("_dec(_tmp)");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
end

compiledUpdateExpression:push("; return _tmp; end)()");
if _bool(meta) then
meta.type = "number";
end

do return compiledUpdateExpression; end
end));
replaceAt =((function(this,str,index,char)
do return (_add((_add(str:substr(0,index),char)),str:substr((_addNum2(index,1))))); end
end));
lastTopLevelBracketedGroupStartIndex =((function(this,str)
local i,count,startIndex;
startIndex = 0;
count = 0;
i = 0;
while (_lt(i,str.length)) do
if (str[i] == "[") then
if (count == 0) then
startIndex = i;
end

count = _inc(count);
elseif (str[i] == "]") then
count = _dec(count);
end

i = _inc(i);
end

do return startIndex; end
end));
lastTopLevelBracketedGroupStartIndex__a =((function(this,str)
local s,i,count,startIndex;
startIndex = 0;
count = 0;
i = 0;
while (_lt(i,str.length)) do
s = str[i];
if (_type(s) ~= "string") then
goto _continue
end

if _bool(s:match(_regexp("^\\[",""))) then
if (count == 0) then
startIndex = i;
end

count = _inc(count);
elseif _bool(str[i]:match(_regexp("^\\]",""))) then
count = _dec(count);
end

::_continue::
i = _inc(i);
end

do return startIndex; end
end));
compileCallArguments =((function(this,args)
local i,compiledArguments;
compiledArguments = _new(CompileResult,_arr({},0),",");
i = 0;
while (_lt(i,args.length)) do
compiledArguments:push(compileExpression(_ENV,args[i]));
i = _inc(i);
end

do return compiledArguments; end
end));
compileCallExpression =((function(...)
local this,expression,meta,arguments = ...;
local arguments = _args(...);
local lastPointIndex,member,base,startIndex,calleeStr,compiledArguments,compiledCallee,compiledCallExpression;
compiledCallExpression = _new(CompileResult);
compiledCallee = compileExpression(_ENV,expression.callee,_obj({}));
compiledArguments = compileCallArguments(_ENV,expression.arguments);
if (expression.callee.type == "MemberExpression") then
calleeStr = compiledCallee:toString();
if _bool(calleeStr:match(_regexp("\\]$",""))) then
if _bool(options.luaLocal) then
startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,calleeStr);
base = calleeStr:substr(0,startIndex);
member = calleeStr:substr((_addNum2(startIndex,1)));
else
compiledCallee.array:forEach((function(this,v,idx)
if _bool(((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return v:match(_regexp("^\\[","")); else return _lev; end end)())) then
startIndex = idx;
end

end));
base = compiledCallee:slice(0,startIndex);
member = compiledCallee:slice(startIndex);
end

compiledCallExpression:push("(function() local _this = ");
compiledCallExpression:push(base);
compiledCallExpression:push("; local _f = _this");
compiledCallExpression:push(member);
compiledCallExpression:push("; return _f(_this");
if (_gt(expression.arguments.length,0)) then
compiledCallExpression:push(",");
compiledCallExpression:push(compiledArguments);
end

compiledCallExpression:push("); end)()");
else
if _bool(options.luaLocal) then
lastPointIndex = calleeStr:lastIndexOf(".");
compiledCallee = replaceAt(_ENV,calleeStr,lastPointIndex,":");
compiledCallExpression:push(compiledCallee);
else
compiledCallee.array:findIndex((function(this,v,idx)
if ((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return (v == "."); else return _lev; end end)()) then
lastPointIndex = idx;
end

end));
compiledCallExpression:push(compiledCallee:slice(0,lastPointIndex));
compiledCallExpression:push(":");
compiledCallExpression:push(compiledCallee:slice((_addNum2(lastPointIndex,1))));
end

compiledCallExpression:push("(");
compiledCallExpression:push(compiledArguments);
compiledCallExpression:push(")");
end

else
compiledCallExpression:push(compiledCallee);
if (withTracker.length == 0) then
compiledCallExpression:push("(_ENV");
else
compiledCallExpression:push("(_oldENV");
end

if (_gt(expression.arguments.length,0)) then
compiledCallExpression:push(",");
compiledCallExpression:push(compiledArguments);
end

compiledCallExpression:push(")");
end

setMeta(_ENV,expression,meta);
do return compiledCallExpression; end
end));
compileLogicalExpression =((function(this,expression,meta)
local compiledRight,compiledLeft,metaRight,metaLeft;
metaLeft = _obj({});
metaRight = _obj({});
compiledLeft = compileExpression(_ENV,expression.left,metaLeft);
compiledRight = compileExpression(_ENV,expression.right,metaRight);
if _bool(meta) then
if ((function() local _lev=(metaLeft.type == metaRight.type); if _bool(_lev) then return (metaLeft.type ~= undefined); else return _lev; end end)()) then
meta.type = metaLeft.type;
end

end

if ((function() local _lev=(expression.left.type == "Identifier"); return _bool(_lev) and _lev or (expression.left.type == "Literal") end)()) then
do return compileLogicalExpressionLeftIdentifierOrLiteral(_ENV,expression,compiledLeft,compiledRight); end
else
do return compileGenericLogicalExpression(_ENV,expression,compiledLeft,compiledRight); end
end

end));
compileLogicalExpressionLeftIdentifierOrLiteral =((function(this,expression,compiledLeft,compiledRight)
local leftCondition,compiledLogicalExpression;
compiledLogicalExpression = _new(CompileResult,_arr({[0]="("},1));
leftCondition = compileBooleanExpression(_ENV,expression.left);
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
compiledLogicalExpression:push("(function() if ");
compiledLogicalExpression:push(leftCondition);
compiledLogicalExpression:push(" then return ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push("; else return ");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; end end)()");
do break end;
_into = true;
end
if _into or (_v == "||") then
compiledLogicalExpression:push(leftCondition);
compiledLogicalExpression:push(" and ");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push(" or ");
compiledLogicalExpression:push(compiledRight);
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledLogicalExpression:push(")");
do return compiledLogicalExpression; end
end));
compileGenericLogicalExpression =((function(this,expression,compiledLeft,compiledRight)
local compiledLogicalExpression;
compiledLogicalExpression = _new(CompileResult,_arr({[0]="("},1));
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
compiledLogicalExpression:push("(function() local _lev=");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; if _bool(_lev) then return ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push("; else return _lev; end end)()");
do break end;
_into = true;
end
if _into or (_v == "||") then
compiledLogicalExpression:push("(function() local _lev=");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; return _bool(_lev) and _lev or ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push(" end)()");
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledLogicalExpression:push(")");
do return compiledLogicalExpression; end
end));
getBaseMember =((function(this,compiledExpression)
local compiledExpressionStr,startIndex;
startIndex = 0;
compiledExpressionStr = compiledExpression:toString();
if _bool(compiledExpressionStr:match(_regexp("\\]$",""))) then
if _bool(options.luaLocal) then
startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,compiledExpressionStr);
do return _obj({
["base"] = compiledExpressionStr:slice(0,startIndex),
["member"] = compiledExpressionStr:slice((_addNum2(startIndex,1)),-1)
}); end
end

startIndex = lastTopLevelBracketedGroupStartIndex__a(_ENV,compiledExpression.array);
do return _obj({
["base"] = compiledExpression:slice(0,startIndex),
["member"] = compiledExpression:slice((_addNum2(startIndex,1)),-1)
}); end
else
if _bool(options.luaLocal) then
startIndex = compiledExpressionStr:lastIndexOf(".");
do return _obj({
["base"] = compiledExpressionStr:slice(0,startIndex),
["member"] = ((_addStr1("\"",compiledExpressionStr:slice((_addNum2(startIndex,1))))) .. "\"")
}); end
end

compiledExpression.array:forEach((function(this,v,idx)
if ((function() local _lev=(_type(v) == "string"); if _bool(_lev) then return (v == "."); else return _lev; end end)()) then
startIndex = idx;
end

end));
do return _obj({
["base"] = compiledExpression:slice(0,startIndex),
["member"] = compiledExpression:slice((_addNum2(startIndex,1))):quote("\"")
}); end
end

end));
getGetterSetterExpression =((function(this,compiledExpression)
local suffix,split;
split = getBaseMember(_ENV,compiledExpression);
suffix = " .. ";
if _bool(options.luaLocal) then
do return _obj({
["getter"] = ((_addStr1((_addStr1((_addStr2(split.base,"[\"_g\"")),suffix)),split.member)) .. "]"),
["setter"] = ((_addStr1((_addStr1((_addStr2(split.base,"[\"_s\"")),suffix)),split.member)) .. "]")
}); end
end

do return _obj({
["getter"] = _new(CompileResult):push(split.base):push((_addStr1("[\"_g\"",suffix))):push(split.member):push("]"),
["setter"] = _new(CompileResult):push(split.base):push((_addStr1("[\"_s\"",suffix))):push(split.member):push("]")
}); end
end));
compileUnaryExpression =((function(this,expression,meta)
local ename,gs,scope,compiledExpression,metaArgument,compiledUnaryExpression;
compiledUnaryExpression = _new(CompileResult);
metaArgument = _obj({});
compiledExpression = compileExpression(_ENV,expression.argument,metaArgument);
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
if (metaArgument.type == "number") then
compiledUnaryExpression:push("-");
compiledUnaryExpression:push(compiledExpression);
else
compiledUnaryExpression:push("-_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+") then
if (metaArgument.type == "number") then
compiledUnaryExpression:push(compiledExpression);
else
compiledUnaryExpression:push("_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "!") then
compiledUnaryExpression:push("not ");
compiledUnaryExpression:push(compileBooleanExpression(_ENV,expression.argument));
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "~") then
compiledUnaryExpression:push("_bnot(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "typeof") then
compiledUnaryExpression:push("_type(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "string";
end

do break end;
_into = true;
end
if _into or (_v == "delete") then
if (withTracker.length == 0) then
scope = "_ENV.";
else
scope = "_oldENV.";
end

compiledUnaryExpression:push("(function () local _r = false; ");
if (expression.argument.type == "MemberExpression") then
scope = "";
gs = getGetterSetterExpression(_ENV,compiledExpression);
compiledUnaryExpression:push("local _g, _s = ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\10");
end

compiledUnaryExpression:push("local _v = ");
if _bool(isCompileResultLike(_ENV,compiledExpression)) then
ename = compiledExpression:toString();
elseif (_type(compiledExpression) == "string") then
ename = compiledExpression;
else
ename = compiledExpression.name;
end

if not _bool(ename) then
console:error("delete name = null");
else
if (_gt(scope.length,0)) then
ename = ename:replace(_regexp("^_local\\d+\\.",""),"");
end

end

compiledUnaryExpression:push(scope):push(ename);
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push(scope):push(ename);
compiledUnaryExpression:push(" = nil; return _r or _v ~= nil; end)()");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "void") then
compiledUnaryExpression:push("_void(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "undefined";
end

do break end;
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

do return compiledUnaryExpression; end
end));
compileAdditionOperator =((function(this,left,right,metaLeft,metaRight,meta)
local compiledAdditionOperator;
compiledAdditionOperator = _new(CompileResult);
if ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" + ");
compiledAdditionOperator:push(right);
if _bool(meta) then
meta.type = "number";
end

elseif (metaLeft.type == "string") then
if ((function() local _lev=(metaRight.type == "number"); return _bool(_lev) and _lev or (metaRight.type == "string") end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" .. ");
compiledAdditionOperator:push(right);
else
compiledAdditionOperator:push("_addStr1(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaRight.type == "string") then
if ((function() local _lev=(metaLeft.type == "number"); return _bool(_lev) and _lev or (metaLeft.type == "string") end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" .. ");
compiledAdditionOperator:push(right);
else
compiledAdditionOperator:push("_addStr2(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaLeft.type == "number") then
compiledAdditionOperator:push("_addNum1(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
elseif (metaRight.type == "number") then
compiledAdditionOperator:push("_addNum2(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
else
compiledAdditionOperator:push("_add(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

do return compiledAdditionOperator; end
end));
compileComparisonOperator =((function(this,left,right,operator,metaLeft,metaRight,meta)
local compiledComparisonOperator;
compiledComparisonOperator = _new(CompileResult);
if ((function() local _lev=((function() local _lev=(metaLeft.type == "string"); if _bool(_lev) then return (metaRight.type == "string"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) end)()) then
compiledComparisonOperator:push(left);
compiledComparisonOperator:push(operator);
compiledComparisonOperator:push(right);
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
compiledComparisonOperator:push("_lt(");
do break end;
_into = true;
end
if _into or (_v == "<=") then
compiledComparisonOperator:push("_le(");
do break end;
_into = true;
end
if _into or (_v == ">") then
compiledComparisonOperator:push("_gt(");
do break end;
_into = true;
end
if _into or (_v == ">=") then
compiledComparisonOperator:push("_ge(");
do break end;
_into = true;
end
::_default::
until true
compiledComparisonOperator:push(left);
compiledComparisonOperator:push(",");
compiledComparisonOperator:push(right);
compiledComparisonOperator:push(")");
end

if _bool(meta) then
meta.type = "boolean";
end

do return compiledComparisonOperator; end
end));
compileBinaryExpression =((function(this,expression,meta)
local right,left,metaRight,metaLeft,compiledBinaryExpression;
compiledBinaryExpression = _new(CompileResult,_arr({[0]="("},1));
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
repeat
local _into = false;
local _cases = {["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,["<="] = true,[">"] = true,[">="] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true,["|"] = true,["^"] = true,["&"] = true,["in"] = true,["instanceof"] = true,[".."] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "==") then
compiledBinaryExpression:push("_eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "!=") then
compiledBinaryExpression:push("not _eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "===") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," == ",left,right);
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "!==") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," ~= ",left,right);
if _bool(meta) then
meta.type = "boolean";
end

do break end;
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
compiledBinaryExpression:push(compileComparisonOperator(_ENV,left,right,expression.operator,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "<<") then
compiledBinaryExpression:push("_lshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>") then
compiledBinaryExpression:push("_arshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>>") then
compiledBinaryExpression:push("_rshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+") then
compiledBinaryExpression:push(compileAdditionOperator(_ENV,left,right,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "-") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," - ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "*") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," * ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "/") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," / ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "%") then
compiledBinaryExpression:push("_mod(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "|") then
compiledBinaryExpression:push("_bor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "^") then
compiledBinaryExpression:push("_bxor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "&") then
compiledBinaryExpression:push("_band(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "in") then
compiledBinaryExpression:push("_in(");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "instanceof") then
compiledBinaryExpression:push("_instanceof(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "..") then
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_addStr1("Unknown BinaryOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledBinaryExpression:push(")");
do return compiledBinaryExpression; end
end));
pushSimpleBinaryExpression =((function(this,compiledBinaryExpression,operator,left,right)
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(operator);
compiledBinaryExpression:push(right);
end));
compileConditionalExpression =((function(this,expression,meta)
local metaAlternate,metaConsequent,compiledConditionalExpression;
compiledConditionalExpression = _new(CompileResult,_arr({[0]="(function() if "},1));
metaConsequent = _obj({});
metaAlternate = _obj({});
compiledConditionalExpression:push(compileBooleanExpression(_ENV,expression.test));
compiledConditionalExpression:push(" then return ");
compiledConditionalExpression:push(compileExpression(_ENV,expression.consequent,metaConsequent));
compiledConditionalExpression:push("; else return ");
compiledConditionalExpression:push(compileExpression(_ENV,expression.alternate,metaAlternate));
compiledConditionalExpression:push("; end end)()");
if _bool(meta) then
if ((function() local _lev=(metaConsequent.type == metaAlternate.type); if _bool(_lev) then return (metaConsequent.type ~= undefined); else return _lev; end end)()) then
meta.type = metaConsequent.type;
end

end

do return compiledConditionalExpression; end
end));
compileSequenceExpression =((function(this,expression,meta)
local metaLast,sequence,expressions,i,compiledSequenceExpression;
compiledSequenceExpression = _new(CompileResult,_arr({[0]="_seq({"},1));
expressions = expression.expressions;
sequence = _new(CompileResult,_arr({},0),",");
metaLast = _obj({});
i = 0;
while (_lt(i,expressions.length)) do
sequence:push(compileExpression(_ENV,expressions[i],metaLast));
i = _inc(i);
end

compiledSequenceExpression:push(sequence);
compiledSequenceExpression:push("})");
if _bool(meta) then
meta.type = metaLast.type;
end

do return compiledSequenceExpression; end
end));
compileObjectExpression =((function(this,expression,meta)
local compiledKey,compiledProperties,compiledProperty,property,length,i,compiledObjectExpression;
compiledObjectExpression = _new(CompileResult,_arr({[0]="_obj({"},1));
length = expression.properties.length;
compiledProperties = _new(CompileResult,_arr({},0),",\10");
compiledKey = "";
i = 0;
while (_lt(i,length)) do
compiledProperty = _new(CompileResult,_arr({[0]="["},1));
property = expression.properties[i];
if (property.key.type == "Literal") then
compiledKey = compileLiteral(_ENV,property.key);
elseif (property.key.type == "Identifier") then
compiledKey = "\"";
compiledKey = (_add(compiledKey,sanitizeLiteralString(_ENV,property.key.name)));
compiledKey = (_addStr2(compiledKey,"\""));
else
_throw(_new(Error,(_addStr1("Unexpected property key type: ",property.key.type))),0)
end

if (property.kind == "get") then
if (_type(property.key.value) == "number") then
compiledKey = ((_addStr1("\"",compiledKey)) .. "\"");
end

compiledKey = compiledKey:replace(_regexp("^\"",""),"\"_g");
elseif (property.kind == "set") then
if (_type(property.key.value) == "number") then
compiledKey = ((_addStr1("\"",compiledKey)) .. "\"");
end

compiledKey = compiledKey:replace(_regexp("^\"",""),"\"_s");
end

compiledProperty:push(compiledKey);
compiledProperty:push("] = ");
compiledProperty:push(compileExpression(_ENV,property.value));
compiledProperties:push(compiledProperty);
i = _inc(i);
end

if (_gt(length,0)) then
compiledObjectExpression:push("\10");
compiledObjectExpression:push(compiledProperties);
compiledObjectExpression:push("\10");
end

compiledObjectExpression:push("})");
if _bool(meta) then
meta.type = "object";
end

do return compiledObjectExpression; end
end));
compileMemberExpression =((function(this,expression,meta)
local compiledProperty,compiledObject,compiledMemberExpression;
compiledMemberExpression = _new(CompileResult,_arr({},0));
compiledObject = compileExpression(_ENV,expression.object,_obj({}));
if (expression.object.type == "Literal") then
compiledObject = ((_addStr1("(",compiledObject)) .. ")");
end

compiledMemberExpression:push(compiledObject);
if _bool(expression.computed) then
compiledMemberExpression:push("[");
compiledMemberExpression:push(compileExpression(_ENV,expression.property));
compiledMemberExpression:push("]");
else
compiledProperty = compileIdentifier(_ENV,expression.property);
if (sanitizeIdentifier(_ENV,expression.property.name) ~= expression.property.name) then
compiledMemberExpression:push("[\"");
compiledMemberExpression:push(sanitizeLiteralString(_ENV,expression.property.name));
compiledMemberExpression:push("\"]");
else
compiledMemberExpression:push(".");
compiledMemberExpression:push(expression.property.name);
end

end

setMeta(_ENV,expression,meta);
do return compiledMemberExpression; end
end));
compileNewExpression =((function(...)
local this,expression,arguments = ...;
local arguments = _args(...);
local length,i,newArguments,compiledNewExpression;
compiledNewExpression = _new(CompileResult,_arr({[0]="_new("},1));
newArguments = _new(CompileResult,_arr({[0]=compileExpression(_ENV,expression.callee)},1),",");
length = expression.arguments.length;
i = 0;
while (_lt(i,length)) do
newArguments:push(compileExpression(_ENV,expression.arguments[i]));
i = _inc(i);
end

compiledNewExpression:push(newArguments);
compiledNewExpression:push(")");
do return compiledNewExpression; end
end));
compileThisExpression =((function(this)
do return "this"; end
end));
compileArrayExpression =((function(this,expression,meta)
local length,i,compiledElements,compiledArrayExpression;
compiledArrayExpression = _new(CompileResult,_arr({[0]="_arr({"},1));
compiledElements = _new(CompileResult,_arr({},0),",");
length = expression.elements.length;
if (_gt(length,0)) then
compiledArrayExpression:push("[0]=");
end

i = 0;
while (_lt(i,length)) do
if (expression.elements[i] ~= null) then
compiledElements:push(compileExpression(_ENV,expression.elements[i]));
else
compiledElements:push("nil");
end

i = _inc(i);
end

compiledArrayExpression:push(compiledElements);
compiledArrayExpression:push("},");
compiledArrayExpression:push(length);
compiledArrayExpression:push(")");
if _bool(meta) then
meta.type = "object";
end

do return compiledArrayExpression; end
end));
compileFunctionDeclaration =((function(this,declaration)
local compiledId,compiledFunctionDeclaration;
compiledFunctionDeclaration = _new(CompileResult);
compiledId = compileIdentifier(_ENV,declaration.id,"global");
compiledFunctionDeclaration:push(compiledId);
compiledFunctionDeclaration:push(" =(");
compiledFunctionDeclaration:push(compileFunction(_ENV,declaration));
compiledFunctionDeclaration:push(");");
localVarManager:pushFunction(compiledFunctionDeclaration);
end));
compileVariableDeclaration =((function(this,variableDeclaration)
local compiledDeclarationInit,expression,pattern,declarator,i,declarations,compiledDeclarations;
compiledDeclarations = _new(CompileResult,_arr({},0),"\10");
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
declarations = variableDeclaration.declarations;
i = 0;
while (_lt(i,declarations.length)) do
declarator = declarations[i];
pattern = compilePattern(_ENV,declarator.id,true);
localVarManager:pushLocal(pattern);
if (declarator.init ~= null) then
expression = compileExpression(_ENV,declarator.init);
compiledDeclarationInit = _new(CompileResult);
compiledDeclarationInit:push(pattern);
compiledDeclarationInit:push(" = ");
compiledDeclarationInit:push(expression);
compiledDeclarationInit:push(";");
compiledDeclarations:push(compiledDeclarationInit:join(""));
end

i = _inc(i);
end

do break end;
_into = true;
end
if _into or (_v == "let") then
_throw(_new(Error,"let instruction is not supported yet"),0)
_into = true;
end
::_default::
until true
do return compiledDeclarations; end
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
local compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,useArguments,locals,context,pa,compiledParams,params,i,compiledBody,compiledFunction,hasName;
hasName = ((function() local _lev=((function() if _bool(meta) then return fun.id; else return meta; end end)()); if _bool(_lev) then return (_gt(fun.id.name.length,0)); else return _lev; end end)());
compiledFunction = _new(CompileResult,_arr({[0]=(function() if _bool(hasName) then return ((_addStr1(((_addStr1("(function() local ",fun.id.name)) .. ";"),fun.id.name)) .. "=(function("); else return "(function("; end end)()},1));
compiledBody = "";
localVarManager:createLocalContext();
params = fun.params;
compiledParams = _new(CompileResult,_arr({[0]="this"},1),",");
i = 0;
while (_lt(i,params.length)) do
pa = compilePattern(_ENV,params[i],"param");
localVarManager:pushParam(pa);
compiledParams:push(pa);
i = _inc(i);
end

if (fun.body.type == "BlockStatement") then
compiledBody = compileStatement(_ENV,fun.body);
elseif (fun.body.type == "Expression") then
compiledBody = compileExpression(_ENV,fun.body);
end

if _bool(((function() local _lev=fun.defaults; if _bool(_lev) then return (_gt(fun.defaults.length,0)); else return _lev; end end)())) then
console:log("Warning: default parameters of functions are ignored");
end

context = localVarManager:popLocalContext();
locals = context[0];
useArguments = ((function() local _lev=context[1]; if _bool(_lev) then return (compiledParams:indexOf("arguments") == -1); else return _lev; end end)());
if _bool(useArguments) then
compiledFunction:push("...)\10");
compiledFunction:push("local "):push(compiledParams):push(" = ...;\10");
compiledFunction:push("local arguments = _args(...);\10");
compiledParams:push("arguments");
else
compiledFunction:push(compiledParams);
compiledFunction:push(")\10");
end

if (_gt(locals.length,0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals,compiledParams);
compiledFunction:push(compiledLocalsDeclaration);
end

functions = context[2];
if (_gt(functions.length,0)) then
compiledFunctionsDeclaration = _new(CompileResult,_arr({},0),"\10");
i = 0;
while (_lt(i,functions.length)) do
compiledFunctionsDeclaration:push(functions[i]);
i = _inc(i);
end

compiledFunction:push(compiledFunctionsDeclaration);
end

compiledFunction:push(compiledBody);
compiledFunction:push("\10");
compiledFunction:push("end)");
if _bool(hasName) then
compiledFunction:push(((_addStr1(" return ",fun.id.name)) .. ";end)()"));
end

do return compiledFunction; end
end));
buildLocalsDeclarationString =((function(this,locals,ignore)
local compiledLocalsDeclaration,length,localname,_g_local,i,namesSequence;
ignore = (_bool(ignore) and ignore or _arr({},0));
namesSequence = _new(CompileResult,_arr({},0),",");
length = locals.length;
i = 0;
while (_lt(i,length)) do
_g_local = locals:pop();
if (_type(_g_local) == "string") then
localname = _g_local;
else
localname = _g_local.name;
end

if ((function() local _lev=not _bool(options.luaLocal); return _bool(_lev) and _lev or ((function() local _lev=(ignore:indexOf(localname) == -1); if _bool(_lev) then return (namesSequence:indexOf(localname) == -1); else return _lev; end end)()) end)()) then
namesSequence:push(_g_local);
end

i = _inc(i);
end

if (_gt(namesSequence.array.length,0)) then
if _bool(options.luaLocal) then
compiledLocalsDeclaration = _new(CompileResult,_arr({[0]="local "},1));
compiledLocalsDeclaration:push(namesSequence);
compiledLocalsDeclaration:push(";\10");
do return compiledLocalsDeclaration; end
end

do return ((_addStr1("local ",localVarManager:loVarsName())) .. " = {};\10"); end
end

do return ""; end
end));
sanitizeIdentifier =((function(this,id)
if (_gt(luaKeywords:indexOf(id),-1)) then
do return (_addStr1("_g_",id)); end
end

do return id:replace(_regexp("_","g"),"__"):replace(_regexp("\\$","g"),"S"):replace(_regexp("[\194\128-\239\191\191]","g"),(function(this,c)
do return (_addStr1("_",c:charCodeAt(0))); end
end)); end
end));
compileIdentifier =((function(this,identifier,meta)
local ret,siname,iname;
iname = identifier.name;
if (identifier.name == "arguments") then
localVarManager:useArguments();
end

setMeta(_ENV,identifier,meta);
siname = sanitizeIdentifier(_ENV,iname);
if _bool(options.luaLocal) then
do return siname; end
end

if (identifier.name == "arguments") then
do return siname; end
end

if ((function() local _lev=((function() local _lev=(meta == "param"); return _bool(_lev) and _lev or (meta == "label") end)()); return _bool(_lev) and _lev or (meta == "global") end)()) then
do return siname; end
end

if (meta == true) then
do return localVarManager:loVarName(siname); end
end

ret = localVarManager:findLoVar(siname);
if _bool(ret) then
do return ret; end
end

do return localVarManager:registerUnresolvedVar(siname); end
end));
toUTF8Array =((function(this,str)
local charcode,i,utf8;
utf8 = _arr({},0);
i = 0;
while (_lt(i,str.length)) do
charcode = str:charCodeAt(i);
if (_lt(charcode,128)) then
utf8:push(charcode);
elseif (_lt(charcode,2048)) then
utf8:push((_bor(192,(_arshift(charcode,6)))),(_bor(128,(_band(charcode,63)))));
elseif ((function() local _lev=(_lt(charcode,55296)); return _bool(_lev) and _lev or (_ge(charcode,57344)) end)()) then
utf8:push((_bor(224,(_arshift(charcode,12)))),(_bor(128,(_band((_arshift(charcode,6)),63)))),(_bor(128,(_band(charcode,63)))));
else
i = _inc(i);
charcode = (65536 + (_bor((_lshift((_band(charcode,1023)),10)),(_band(str:charCodeAt(i),1023)))));
utf8:push((_bor(240,(_arshift(charcode,18)))),(_bor(128,(_band((_arshift(charcode,12)),63)))),(_bor(128,(_band((_arshift(charcode,6)),63)))),(_bor(128,(_band(charcode,63)))));
end

i = _inc(i);
end

do return utf8; end
end));
sanitizeLiteralString =((function(this,str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("[\\x7f-\\xff\\x00-\\x1f]","g"),(function(this,c)
do return (_addStr1("\\",c:charCodeAt(0))); end
end)); end
end));
sanitizeRegExpSource =((function(this,str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\\\\\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])","g"),(function(this,str,hexaCode)
local chars;
chars = String:fromCharCode(parseInt(_ENV,hexaCode,16));
do return (_addStr1("\\",toUTF8Array(_ENV,chars):join("\\"))); end
end)); end
end));
compileLiteral =((function(this,literal,meta)
local flags,source,compiledRegExp,regexp,ret;
ret = literal.raw;
if (_instanceof(literal.value,RegExp)) then
regexp = literal.value;
compiledRegExp = _new(CompileResult,_arr({[0]="_regexp(\""},1));
source = sanitizeRegExpSource(_ENV,regexp.source);
compiledRegExp:push(source);
compiledRegExp:push("\",\"");
flags = "";
flags = (_addStr2(flags,(function() if _bool(regexp.global) then return "g"; else return ""; end end)()));
flags = (_addStr2(flags,(function() if _bool(regexp.ignoreCase) then return "i"; else return ""; end end)()));
flags = (_addStr2(flags,(function() if _bool(regexp.multiline) then return "m"; else return ""; end end)()));
compiledRegExp:push(flags);
compiledRegExp:push("\")");
ret = compiledRegExp:join("");
if _bool(meta) then
meta.type = "object";
end

do return ret; end
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
ret = ((_addStr1("\"",sanitizeLiteralString(_ENV,literal.value))) .. "\"");
if _bool(meta) then
meta.type = "string";
end

do break end;
_into = true;
end
if _into or (_v == "number") then
ret = JSON:stringify(literal.value);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "boolean") then
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
::_default::
until true
do return ret; end
end));luaKeywords = _arr({[0]="and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"},22);
labelTracker = _arr({},0);
continueNoLabelTracker = _arr({},0);
withTracker = _arr({},0);
deductions = _arr({},0);
CompileResult.prototype = _obj({
["push"] = (function(this,anyObj)
local tp;
tp = _type(anyObj);
if ((function() local _lev=(tp == "string"); return _bool(_lev) and _lev or (tp == "number") end)()) then
this.array:push(anyObj);
elseif (tp == "object") then
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
protectedCallManager = _new(ProtectedCallManager);
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
local va,resolved__value,resolved__path,path;
path = this:getVarPath();
if (resolved__level ~= undefined) then
resolved__path = this.pathNums:slice(0,(_addNum2(resolved__level,1))):join(".");
resolved__value = (_addStr1(((_addStr1("_local",(_addNum2(resolved__level,1)))) .. "."),name));
end

va = _obj({
["name"] = name,
["path"] = path,
["value"] = resolved__value,
["resolvedPath"] = resolved__path
});
if (_lt(this.unresolved:findIndex((function(this,v)
do return ((function() local _lev=(_eq(v.name,name)); if _bool(_lev) then return (_eq(v.path,path)); else return _lev; end end)()); end
end)),0)) then
this.unresolved:push(va);
end

do return va; end
end),
["resolveVar"] = (function(this,name)
local changed,curpath;
curpath = this:getVarPath();
changed = 0;
name = name:replace(_regexp("^[^\\.]*\\.","g"),"");
this.unresolved:forEach((function(this,v)
if ((function() local _lev=(_eq(name,v.name)); if _bool(_lev) then return (_eq(v.path:slice(0,curpath.length),curpath)); else return _lev; end end)()) then
if ((function() local _lev=not _bool(v.resolvedPath); return _bool(_lev) and _lev or (_gt(curpath.length,v.resolvedPath.length)) end)()) then
v.value = this:loVarName(name);
v.resolvedPath = curpath;
else

end

changed = _inc(changed);
end

end):bind(this));
do return (_gt(changed,0)); end
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
local idx,i;
i = (this.locals.length - 1);
while (_ge(i,0)) do
idx = this.locals[i]:indexOf(id);
if (_ge(idx,0)) then
if (_lt(i,(this.locals.length - 1))) then
do return this:registerUnresolvedVar(id,i); end
end

do return (_addStr1(((_addStr1("_local",(_addNum2(i,1)))) .. "."),id)); end
else
if (_ge(this.params[i]:indexOf(id),0)) then
do return id; end
end

end

i = _dec(i);
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
localVarManager = _new(LocalVarManager);
exports.compileAST = compileAST;
end));
return module.exports;
end, _ENV)();