/*
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
*/
(function (root, factory) {
    "use strict";
    // Universal Module Definition (UMD) to support AMD, CommonJS/Node.js,
    // Rhino, and plain browser loading.

    if (typeof define === 'function' && define.amd) {
        define(['exports'], factory);
    } else if (exports !== undefined) {
        factory(exports);
    } else {
        root.castl = {};
        factory(root.castl);
    }
}(this, function (exports) {
    "use strict";

    var luaKeywords = ['and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while'];

    var options, annotations;
    var labelTracker = [];
    var continueNoLabelTracker = [];
    var withTracker = [];
    var deductions = []; // Heuristic deductions

    function setMeta(node, meta) {
        // Annotations have priority over heuristic
        if (options.annotation) {
            // if there is an annotation the line before
            if (annotations[node.loc.start.line - 1] && meta) {
                meta.type = annotations[node.loc.start.line - 1];
                return;
            }
        }
        if (options.heuristic) {
            // if there is some heuristic deduction for this line
            if (deductions[node.loc.start.line] && meta) {
                meta.type = deductions[node.loc.start.line];
            }
        }
        
    }

    function CompileResult(arr,sep) {
        this.array=arr || [];        
        this.sep=sep || '';
        return this;
    }
    function isNumOrString(d){
        return ['string','number'].indexOf(d)>=0;
    }
    function _mergeArray(arr,src,sep){
        var lastTp;
        if (!sep){
            sep='';
        }        
        //console.log('before merge:['+sep+']',JSON.stringify(arr),JSON.stringify(src));
        src.forEach(function(v,idx){
            var curTp=typeof(v)
            if (isCompileResultLike(v)){
                if (v.array && v.array.length>0){
                    arr.push(v); 
                }           
            }else{
                if (v!==''){
                    if (idx===0){
                        arr.push(v);
                    }else{                        
                        if (isNumOrString(lastTp) && isNumOrString(curTp)){
                            arr[arr.length-1]+=sep+v;
                        }else{                             
                            arr.push(v);
                        }
                    }
                }                
            }            
            lastTp=curTp;
        });
        //console.log('after merge:',JSON.stringify(arr));
        return arr;
    }
    function isCompileResultLike(anyObj){
        return (anyObj.prototype && anyObj.prototype.constructor.name==='CompileResult')||(anyObj.array!=undefined && anyObj.sep!=undefined);
    }
    CompileResult.prototype={
        push:function(anyObj){
            var tp=typeof(anyObj)
            if (tp==='string' || tp==='number'){
                this.array.push(anyObj);                
            }else if (tp==='object'){ 
               if (isCompileResultLike(anyObj)){                  
                   this.pushOther(anyObj);                
               }else if(anyObj.name){
                   this.array.push(anyObj);
               }else{
                    console.error("invalid object:",anyObj.prototype ,JSON.stringify(anyObj,null,2));
               }
            }else{
                console.error("invalid type:",JSON.stringify(anyObj,null,2));
            }
            return this
        },
        pop:function(){
            return this.array.pop();
        },
        toString:function(){
            return this.array.map(function(v){
                return isNumOrString(typeof(v))?v:(isCompileResultLike(v)?v.toString():(v.value||v.name))
            }).join(this.sep);
        },

        quote:function(q){
            if (!q) q='"'
            this.array.unshift(q);
            this.array.push(q);
            return this;
        },
        
        slice:function(s,e){
            return new CompileResult(this.array.slice(s,e),this.sep);
        },
        mergeSelf:function(sep){
            if (!sep){
                sep=this.sep;
            }
            this.array=_mergeArray([],this.array,sep);
            return this;
        },
        indexOf:function(s){
            return this.array.findIndex(function(v){
                if(isNumOrString(typeof(v))) return v==s;
                if (typeof(v)==='object') return v.name===s;
                return false;
            });
        }, 
        prepend:function(s){
            this.array.unshift(s);
            return this;
        },
        pushOther:function(cr,sep){
            if (sep===undefined){
                sep=cr.sep;
            }
            if (this.sep===sep){
                _mergeArray(this.array,cr.array,sep);
            }else{
                this.array.push(cr)
            }            
        },
        joinFinal:function(sep){
            if (sep===undefined) sep=this.sep;           
            return this.array.filter(function(v){return v!==''}).map(function(v){
                if (isNumOrString(typeof(v))) return v;
                if (isCompileResultLike(v)){
                    return v.joinFinal(v.sep);
                }    
                if (typeof(v.name)!=='string'){
                    console.error('name unexpected:',v)
                }
                if (v.value){
                    return v.value;
                }
                //console.log('unresolved identifier:',v)
                return v.name;
            }).join(sep)
        },
        join:function(sep){
            if (sep===undefined){
                sep=this.sep;
            }
            return this.mergeSelf(sep);
        }        
    }


    /********************************
     *
     * ProtectedCallManager definition
     *
     * ******************************/

    function ProtectedCallManager() {
        this.protectedCallContext = []; // array of bool
        this.mayReturnStack = []; // array of bool
        this.mayBreakStack = []; // array of bool
        this.mayContinueStack = []; // array of bool
        this.iterationStatement = []; // array of arrays
        this.switchStatement = []; // array of arrays
    }

    ProtectedCallManager.prototype = {
        isInProtectedCallContext: function () {
            // @number
            if (this.protectedCallContext.length > 0) {
                return true;
            }
            return false;
        },
        noInsideIteration: function () {
            return this.iterationStatement[this.iterationStatement.length - 1].length === 0;
        },
        noInsideSwitch: function () {
            return this.switchStatement[this.switchStatement.length - 1].length === 0;
        },
        may: function () {
            return {
                mayReturn: this.mayReturnStack[this.mayReturnStack.length - 1],
                mayBreak: this.mayBreakStack[this.mayBreakStack.length - 1],
                mayContinue: this.mayContinueStack[this.mayContinueStack.length - 1]
            };
        },
        openContext: function () {
            this.protectedCallContext.push(true);
            this.iterationStatement.push([]);
            this.switchStatement.push([]);
            this.mayBreakStack.push(false);
            this.mayContinueStack.push(false);
            this.mayReturnStack.push(false);
        },
        closeContext: function () {
            this.protectedCallContext.pop();
            this.iterationStatement.pop();
            this.switchStatement.pop();
            this.mayBreakStack.pop();
            this.mayContinueStack.pop();
            this.mayReturnStack.pop();
        },
        openIterationStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.iterationStatement[this.iterationStatement.length - 1].push(true);
            }
        },
        closeIterationStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.iterationStatement[this.iterationStatement.length - 1].pop();
            }
        },
        openSwitchStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.switchStatement[this.iterationStatement.length - 1].push(true);
            }
        },
        closeSwitchStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.switchStatement[this.iterationStatement.length - 1].pop();
            }
        },
        returnStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.mayReturnStack[this.mayReturnStack.length - 1] = true;
            }
        },
        breakOutside: function () {
            if (this.isInProtectedCallContext() && this.noInsideIteration() && this.noInsideSwitch()) {
                this.mayBreakStack[this.mayBreakStack.length - 1] = true;
                return true;
            }
            return false;
        },
        continueOutside: function () {
            if (this.isInProtectedCallContext() && this.noInsideIteration()) {
                this.mayContinueStack[this.mayContinueStack.length - 1] = true;
                return true;
            }
            return false;
        }
    };

    // instance
    var protectedCallManager = new ProtectedCallManager();

    /********************************
     *
     * LocalVarManager definition
     *
     * ******************************/

    function LocalVarManager() {
        this.pathNums=[];        
        this.unresolved=[];
        this.locals = []; // Array of arrays
        this.functions = []; // Array of arrays
        this.args = []; // Array of booleans
    }    

    LocalVarManager.prototype = {
        reset:function(){
            this.pathNums=[];  
            this.unresolved=[]; 
            this.params=[];
            this.locals = []; // Array of arrays
            this.functions = []; // Array of arrays
            this.args = []; // Array of booleans
        },
        popLocalContext: function () {
            // @number
            if (this.locals.length > 0) {
                return [this.locals.pop(), this.args.pop(), this.functions.pop(),this.params.pop()];
            }
            throw new Error("LocalVarManager error: no current local context");
        },

        createLocalContext: function () {            
            this.locals.push([]);
            this.functions.push([]);
            this.params.push([]);
            this.args.push(false);
            while (this.pathNums.length<this.functions.length){
                this.pathNums.push(0);
            }
            this.pathNums[this.functions.length-1]++;
            //console.log('enter path: '+this.getVarPath());
        },

        printUnresolved:function(){
            this.unresolved.forEach(function(v,i){
                if(v.name==='isArray'){
                    //console.log(v);
                }
            })
        },
        
        addUnresolvedVar:function(name,resolved_level){  
            var path=this.getVarPath(); 
            var resolved_path,resolved_value
            if (resolved_level!==undefined){
                resolved_path=this.pathNums.slice(0,resolved_level+1).join('.');
                resolved_value='_local'+(resolved_level+1)+'.'+name;
            }             
            var va={name:name,path:path,value:resolved_value,resolvedPath:resolved_path};
            var idx=this.unresolved.findIndex(function(v){
                return v.name===name && v.path===path;
            });
            if (idx<0){
                this.unresolved.push(va);
                //console.log('register name:',va);
            }else if (resolved_level){
                var v=this.unresolved[idx];
                if (!v.resolvedPath || resolved_path.length>v.resolvedPath.length){                    
                    v.resolvedPath=resolved_path;
                    v.value=resolved_value;      
                    //console.log('resolve var:'+name + ' to '+curpath) ;
                }
                va=v;
            }else{
               va=this.unresolved[idx];
            }
            return va;
        },
        resolveVar:function(name){  
            var curpath=this.getVarPath();
            var changed=0;
            name=name.replace(/^[^\.]*\./g,'');
            
            this.unresolved.forEach((function(v){
                if (name==v.name && v.path.slice(0,curpath.length)==curpath){                    
                    if (!v.resolvedPath || curpath.length>v.resolvedPath.length){
                        v.value=this.loVarName(name);
                        v.resolvedPath=curpath       
                        //console.log('resolve var:'+name + ' to '+curpath) ;
                    }else{
                        //console.log('skip path: ' + curpath+':'+name);
                    }
                    changed++;
                }
            }).bind(this));
           // console.log('try resolve name:'+name+'@'+curpath+' result:',changed)
            return changed>0;
        },
        getVarPath:function(){
           return this.pathNums.slice(0,this.functions.length).join('.');
        },
        loVarsName: function(){
            return '_local'+(this.functions.length+1)
        },
        loVarName: function(id){
            return '_local'+this.functions.length+'.'+id
        },
        findLoVar: function(id){
            //console.log('looking for ',id,this.locals[this.locals.length-1],this.params[this.locals.length-1]);
            for(var i=this.locals.length-1;i>=0;i--){
                //var i=this.locals.length-1;
                var idx=this.locals[i].indexOf(id);
                if (idx>=0){                    
                    if (i<this.locals.length-1){                                               
                      return this.addUnresolvedVar(id,i);                       
                    }
                    return '_local'+(i+1)+'.'+id; //already nearest var
                }
                else {
                    //check params
                    if (this.params[i].indexOf(id)>=0){
                        return id; //resolved as function param, maybe uppervalue
                    }
                }
            }                        
            return null;
        },
        pushLocal: function (varName) {
            // @number
            if (this.locals.length > 0) {
                varName=varName.replace(/^[^\.]*\./g,'');                
                //console.log('add local '+varName)
                this.locals[this.locals.length - 1].push(varName);
                this.resolveVar(varName);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        pushFunction: function (functionDeclaration) {
            // @number
            if (this.functions.length > 0) {
                this.functions[this.functions.length - 1].push(functionDeclaration);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        pushParam:function(pn){
            if (this.params.length > 0) {
                this.params[this.params.length - 1].push(pn);
            }
        },

        useArguments: function () {
            // @number
            if (this.args.length > 0) {
                this.args[this.args.length - 1] = true;
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        }
    };

    // instance
    var localVarManager = new LocalVarManager();

    /*****************
     *
     * Compile
     *
     * ***************/

    function compileAST(ast, opts, anno) {
        options = opts || {};
        annotations = anno || {};
        if (options.luaLocal){
            console.log('limited mode enabled - limited to 200 js vars each scope')
        }
        // Compile top level
        if (ast.type === 'Program') {            
            var compiledProgram = new CompileResult([],'\n');
            localVarManager.reset();
            localVarManager.createLocalContext();
            var topLevelStatements = compileListOfStatements(ast.body);

            // Get local variables, function declarations and arguments
            var context = localVarManager.popLocalContext();
            var useArguments = context[1];

            if (useArguments) {
                compiledProgram.push("local arguments = _args(...);");
            }

            // Locals
            var locals = context[0];
            // @number
            if (locals.length > 0) {                
                //console.log('program locals:',locals)             
                var compiledLocalsDeclaration = buildLocalsDeclarationString(locals);  
                //console.log('compiled locals:',compiledLocalsDeclaration)                    
                compiledProgram.push(compiledLocalsDeclaration);
            }

            // Function declarations
            var functions = context[2];            
            // @number
            if (functions.length > 0) {
                var compiledFunctionsDeclaration = new CompileResult([]);
                var i;
                // @number
                for (i = 0; i < functions.length; ++i) {                    
                    compiledFunctionsDeclaration.push(functions[i]);
                }

                compiledProgram.push(compiledFunctionsDeclaration.join("\n"));
            }

            // Body of the program
            compiledProgram.push(topLevelStatements);
           // console.log('program:',JSON.stringify(compiledProgram,null,2));
            //localVarManager.printUnresolved();
            return ({
                success: true,
                compiled: compiledProgram.joinFinal("\n")
            });
        }

        return ({
            success: false,
            compiled: ""
        });
    }

    /*****************
     *
     * Statements
     *
     * ***************/

    function compileStatement(statement) {

        var compiledStatement;

        switch (statement.type) {
        case "ExpressionStatement":
            compiledStatement = compileExpressionStatement(statement.expression);
            break;
        case "BlockStatement":
            compiledStatement = compileListOfStatements(statement.body);
            break;
        case "FunctionDeclaration":
            compiledStatement = compileFunctionDeclaration(statement);
            break;
        case "VariableDeclaration":
            compiledStatement = compileVariableDeclaration(statement);
            break;
        case "IfStatement":
            compiledStatement = compileIfStatement(statement);
            break;
        case "ForStatement":
        case "WhileStatement":
        case "DoWhileStatement":
        case "ForInStatement":
            compiledStatement = compileIterationStatement(statement);
            break;
        case "ReturnStatement":
            compiledStatement = compileReturnStatement(statement);
            break;
        case "BreakStatement":
            compiledStatement = compileBreakStatement(statement);
            break;
        case "TryStatement":
            compiledStatement = compileTryStatement(statement);
            break;
        case "ThrowStatement":
            compiledStatement = compileThrowStatement(statement);
            break;
        case "SwitchStatement":
            compiledStatement = compileSwitchStatement(statement);
            break;
        case "ContinueStatement":
            compiledStatement = compileContinueStatement(statement);
            break;
        case "LabeledStatement":
            compiledStatement = compileLabeledStatement(statement);
            break;
        case "WithStatement":
            compiledStatement = compileWithStatement(statement);
            break;
        case "EmptyStatement":
        case "DebuggerStatement":
            return "";
        case "ForOfStatement":
            throw new Error("For...of statement (ES6) not supported yet.");
        case "ClassDeclaration":
            throw new Error("Class declaration (ES6) not supported yet.");
        default:
            // @string
            throw new Error("Unknown Statement type: " + statement.type);
        }

        if (compiledStatement !== undefined) {
            if (options.debug) {
                var line = statement.loc.start.line;
                //console.log('compiled statment: type:',statement.type,compiledStatement)
                // @string
                return new CompileResult(["--[[" + line + "--]] "]).push( compiledStatement);
            }
            return compiledStatement;
        }
    }

    function compileListOfStatements(statementList) {
        var compiledStatements =  new CompileResult([],'\n');

        var i, compiledStatement;
        // @number
        for (i = 0; i < statementList.length; ++i) {
            compiledStatement = compileStatement(statementList[i]);

            // After compilation some statements may become empty strings
            // or 'undefined' such as VariableDeclaration and FunctionDeclaration
            if (compiledStatement !== "" && compiledStatement !== undefined) {
                compiledStatements.push(compiledStatement);
            }
        }

        return compiledStatements;
    }

    function compileBooleanExpression(expression) {
        var compiledBooleanExpression =  new CompileResult();
        var meta = {};
        var compiledExpression = compileExpression(expression, meta);

        if (meta.type === "boolean") {
            compiledBooleanExpression.push(compiledExpression);
        } else {
            compiledBooleanExpression.push("_bool(");
            compiledBooleanExpression.push(compiledExpression);
            compiledBooleanExpression.push(")");
        }

        return compiledBooleanExpression;
    }

    function compileIfStatement(statement, elif) {
        var compiledIfStatement =  new CompileResult();

        if (elif) {
            compiledIfStatement.push("elseif ");
        } else {
            compiledIfStatement.push("if ");
        }

        compiledIfStatement.push(compileBooleanExpression(statement.test));
        compiledIfStatement.push(" then\n");

        compiledIfStatement.push(compileStatement(statement.consequent));

        if (statement.alternate !== null) {
            compiledIfStatement.push("\n");

            // Alternate is a If statement
            if (statement.alternate.type === "IfStatement") {
                compiledIfStatement.push(compileIfStatement(statement.alternate, true));
            } else {
                compiledIfStatement.push("else\n");
                compiledIfStatement.push(compileStatement(statement.alternate));
            }
        }

        if (!elif) {
            compiledIfStatement.push("\n");
            compiledIfStatement.push("end\n");
        }

        return compiledIfStatement;
    }

    function compileIterationStatement(statement, compiledLabel) {
        var compiledIterationStatement = "";
        continueNoLabelTracker.push(false);
        protectedCallManager.openIterationStatement();

        switch (statement.type) {
        case "ForStatement":
            compiledIterationStatement = compileForStatement(statement, compiledLabel);
            break;
        case "WhileStatement":
            compiledIterationStatement = compileWhileStatement(statement, compiledLabel);
            break;
        case "DoWhileStatement":
            compiledIterationStatement = compileDoWhileStatement(statement, compiledLabel);
            break;
        case "ForInStatement":
            compiledIterationStatement = compileForInStatement(statement, compiledLabel);
            break;
        default:
            // @string
            throw new Error("Not an IterationStatement " + statement.type);
        }
        protectedCallManager.closeIterationStatement();
        continueNoLabelTracker.pop();

        return compiledIterationStatement;
    }

    function compileForInit(init) {
        var compiledForInit =  new CompileResult();
        if (init !== null) {
            if (init.type === "VariableDeclaration") {
                compiledForInit.push(compileVariableDeclaration(init));
            } else {
                compiledForInit.push(compileExpressionStatement(init));
            }
            compiledForInit.push("\n");
        }

        return compiledForInit;
    }

    function compileForUpdate(update) {
        var compiledForUpdate =  new CompileResult();
        if (update !== null) {
            compiledForUpdate.push(compileExpressionStatement(update));
            compiledForUpdate.push("\n");
        }

        return compiledForUpdate;
    }

    function compileForTest(test) {
        if (test !== null) {
            return compileBooleanExpression(test);
        }
        return "true";
    }

    function isCompoundAssignment(expression) {
        if (expression.type === "AssignmentExpression") {
            return ["*=", "/=", "%=", "+=", "-=", "<<=", ">>=", ">>>=", "&=", "^=", "|="].indexOf(expression.operator) > -1;
        }
        return false;
    }

    function isUpdateExpressionWith(expression, variables) {
        if (expression !== null && expression.type === "UpdateExpression") {
            if (expression.argument.type === "Identifier") {
                // @number
                return variables.indexOf(expression.argument.name) > -1;
            }
        }

        return false;
    }

    function isNumericCompoundAssignmentExpressionWith(expression, variables) {
        if (expression !== null && isCompoundAssignment(expression)) {
            // Left operand is the numeric for variable
            // @number
            if (expression.left.type === "Identifier" && variables.indexOf(expression.left.name) > -1) {
                // If operator is += we have to check that right operand is a number (for other operators result is necessary a number)
                if (expression.operator === "+=") {
                    var metaRight = {};
                    // compile expression to get type of right
                    compileExpression(expression.right, metaRight);
                    return metaRight.type === "number";
                }
                return true;
            }
        }

        return false;
    }

    function isComparisonExpressionWith(expression, variables) {
        if (expression !== null) {
            if (expression.type === "BinaryExpression") {
                // @number
                if (["<", "<=", ">", ">="].indexOf(expression.operator) > -1) {
                    // left
                    if (expression.left.type === "Identifier") {
                        // @number
                        if (variables.indexOf(expression.left.name) > -1) {
                            return true;
                        }
                        // right
                    } else if (expression.right.type === "Identifier") {
                        // @number
                        if (variables.indexOf(expression.right.name) > -1) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    function mayBeNumericFor(statement) {
        var possibleNumericForVariable =  [];

        var init = statement.init;
        if (init === null) {
            return false;
        }
        var metaRight;
        if (init.type === "VariableDeclaration") {
            var declarations = init.declarations;
            var i;
            // @number
            for (i = 0; i < declarations.length; ++i) {
                // Variable is initialized with a number
                if (declarations[i].init !== null) {
                    metaRight = {};
                    // compile expression to get type of right
                    compileExpression(declarations[i].init, metaRight);
                    if (metaRight.type === "number") {
                        possibleNumericForVariable.push(declarations[i].id.name);
                    }
                }
            }
        } else if (init.type === "AssignmentExpression") {
            // Variable is initialized with a number
            if (init.left.type === "Identifier") {
                metaRight = {};
                // compile expression to get type of right
                compileExpression(init.right, metaRight);
                if (metaRight.type === "number") {
                    possibleNumericForVariable.push(init.left.name);
                }
            }
        }

        // @number
        if (possibleNumericForVariable.length > 0) {
            // Test is a comparison involving the numeric for variable
            if (isComparisonExpressionWith(statement.test, possibleNumericForVariable)) {
                // Update is an UpdateExpression of the numeric for variable
                if (isUpdateExpressionWith(statement.update, possibleNumericForVariable)) {
                    return true;
                }
                if (isNumericCompoundAssignmentExpressionWith(statement.update, possibleNumericForVariable)) {
                    return true;
                }
            }
        }

        return false;
    }

    function compileForStatement(statement, compiledLabel) {
        var compiledForStatement = new CompileResult();

        if (options.heuristic) {
            if (mayBeNumericFor(statement)) {
                deductions[statement.loc.start.line] = "number";
            }
        }

        // Init
        compiledForStatement.push(compileForInit(statement.init));

        // Test
        compiledForStatement.push("while ");
        compiledForStatement.push(compileForTest(statement.test));

        compiledForStatement.push(" do\n");

        // Body
        compiledForStatement.push(compileStatement(statement.body));
        compiledForStatement.push("\n");

        // Label for continue
        if (continueNoLabelTracker[continueNoLabelTracker.length - 1]) {
            compiledForStatement.push("::_continue::\n");
        }
        
        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
            compiledForStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Update
        compiledForStatement.push(compileForUpdate(statement.update));

        compiledForStatement.push("end\n");

        return compiledForStatement;
    }

    function compileForInStatement(statement, compiledLabel) {
        var compiledForInStatement = new CompileResult();
        var compiledLeft;

        compiledForInStatement.push("local _p = _props(");
        compiledForInStatement.push(compileExpression(statement.right));
        compiledForInStatement.push(", true);\n");

        if (statement.left.type === "VariableDeclaration") {
            compiledLeft = compilePattern(statement.left.declarations[0].id,'for_in');
            // Add to current local context, but var in for is already lexically local
            //localVarManager.pushLocal(compiledLeft);
        } else {
            compiledLeft = compileExpression(statement.left,'for_in');
        }       
        compiledForInStatement.push("for _,");
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(" in _ipairs(_p) do\n");

        // Cast to string
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(" = _tostr(");
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(");\n");

        // Body
        compiledForInStatement.push(compileStatement(statement.body));

        // Label for continue
        compiledForInStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
            compiledForInStatement.push("::" + compiledLabel + "_c::\n");
        }

        compiledForInStatement.push("end\n");

        return compiledForInStatement;
    }

    function compileWhileStatement(statement, compiledLabel) {
        var compiledWhileStatement = new CompileResult(["while "]);

        // Test
        compiledWhileStatement.push(compileBooleanExpression(statement.test));
        compiledWhileStatement.push(" do\n");

        // Body
        compiledWhileStatement.push(compileStatement(statement.body));
        compiledWhileStatement.push("\n");

        // Label for continue
        compiledWhileStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
            compiledWhileStatement.push("::" + compiledLabel + "_c::\n");
        }

        compiledWhileStatement.push("end\n");

        return compiledWhileStatement;
    }

    function compileDoWhileStatement(statement, compiledLabel) {
        var compiledDoWhileStatement = new CompileResult(["repeat\n"]);

        // Body
        compiledDoWhileStatement.push(compileStatement(statement.body));
        compiledDoWhileStatement.push("\n");

        // Label for continue
        compiledDoWhileStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
            compiledDoWhileStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Test
        compiledDoWhileStatement.push("until not ");
        compiledDoWhileStatement.push(compileBooleanExpression(statement.test));
        compiledDoWhileStatement.push("\n");

        return compiledDoWhileStatement;
    }

    function isIterationStatement(statement) {
        return statement.type === "ForStatement" ||
            statement.type === "DoWhileStatement" ||
            statement.type === "WhileStatement" ||
            statement.type === "ForInStatement";
    }

    function compileLabeledStatement(statement) {
        var compiledLabeledStatement = new CompileResult();

        var label = statement.label;
        var compiledLabel = compileIdentifier(label,'label');

        // create tracker for this label
        labelTracker[compiledLabel] = {
            mayBreak: false,
            mayContinue: false
        };

        if (isIterationStatement(statement.body)) {
            compiledLabeledStatement.push(compileIterationStatement(statement.body, compiledLabel));
        } else {
            compiledLabeledStatement.push(compileStatement(statement.body));
        }

        if (labelTracker[compiledLabel].mayBreak) {
            // @string
            compiledLabeledStatement.push("::" + compiledLabel + "_b::\n");
        }

        // delete tracker for this label
        delete labelTracker[compiledLabel];

        return compiledLabeledStatement;
    }

    function compileBreakStatement(statement) {
        if (statement.label === null) {
            // Inside a try catch
            if (protectedCallManager.breakOutside()) {
                return "do return _break; end";
            }
            if (options.jit) {
                return "do break end;";
            } else {
                return "break;";
            }
        }

        var compiledLabel = compileIdentifier(statement.label,'label');
        labelTracker[compiledLabel].mayBreak = true;
        // @string
        return new CompileResult(["goto " , compiledLabel , "_b;"],'');
    }

    // http://lua-users.org/wiki/ContinueProposal
    function compileContinueStatement(statement) {
        if (statement.label === null) {
            continueNoLabelTracker[continueNoLabelTracker.length - 1] = true;

            // Inside a try catch
            if (protectedCallManager.continueOutside()) {
                return "do return _continue; end";
            }

            return new CompileResult(["goto _continue"],'');
        }

        var compiledLabel = compileIdentifier(statement.label,'label');
        labelTracker[compiledLabel].mayContinue = true;
        // @string
        return new CompileResult(["goto " , compiledLabel , "_c;"]);
    }

    function compileSwitchStatement(statement) {
        protectedCallManager.openSwitchStatement();

        var cases = statement.cases;

        // @number
        if (cases.length > 0) {
            // Use a useless repeat loop to be able to use break
            var compiledSwitchStatement = new CompileResult(["repeat\nlocal _into = false;\n"]);

            // Construct lookup table
            var i;
            var casesTable = new CompileResult();
            var caseTablementElement;
            var compiledTests = [];
            // @number
            for (i = 0; i < cases.length; ++i) {
                if (cases[i].test !== null) {
                    compiledTests[i] = compileExpression(cases[i].test);

                    caseTablementElement = new CompileResult();
                    caseTablementElement.push("[");
                    caseTablementElement.push(compiledTests[i]);
                    caseTablementElement.push("] = true");

                    casesTable.push(caseTablementElement);
                }
            }

            compiledSwitchStatement.push("local _cases = {");
            compiledSwitchStatement.push(casesTable.join(","));
            compiledSwitchStatement.push("};\n");
            // Save discriminant
            compiledSwitchStatement.push("local _v = ");
            compiledSwitchStatement.push(compileExpression(statement.discriminant));
            compiledSwitchStatement.push(";\n");

            // Default jump
            compiledSwitchStatement.push("if not _cases[_v] then\n");
            compiledSwitchStatement.push("_into = true;\n");
            compiledSwitchStatement.push("goto _default\n");
            compiledSwitchStatement.push("end\n");

            // Cases
            var hasDefault = false;
            // @number
            for (i = 0; i < cases.length; ++i) {
                if (cases[i].test !== null) {
                    compiledSwitchStatement.push("if _into or (_v == ");
                    compiledSwitchStatement.push(compiledTests[i]);
                    compiledSwitchStatement.push(") then\n");
                } else {
                    // Default case
                    hasDefault = true;
                    compiledSwitchStatement.push("::_default::\n");
                    compiledSwitchStatement.push("if _into then\n");
                }

                compiledSwitchStatement.push(compileListOfStatements(cases[i].consequent));
                compiledSwitchStatement.push("\n");
                compiledSwitchStatement.push("_into = true;\n");
                compiledSwitchStatement.push("end\n");
            }

            if (!hasDefault) {
                compiledSwitchStatement.push("::_default::\n");
            }

            compiledSwitchStatement.push("until true");

            protectedCallManager.closeSwitchStatement();
            return compiledSwitchStatement;
        }

        protectedCallManager.closeSwitchStatement();
        return "";
    }

    function compileTryStatement(statement) {
        // Esprima TryStatement is slightly different from SpiderMonkey specification
        if (statement.handlers) {
            return compileTryStatementFlavored(statement, true);
        }

        return compileTryStatementFlavored(statement, false);

    }

    // Finally cases: http://stackoverflow.com/a/9688068
    // esprima = true: use statement.handlers array
    // esprima = false: use statement.handler
    function compileTryStatementFlavored(statement, esprima) {
        // @number
        var hasHandler = esprima ? (statement.handlers.length > 0) : statement.handler !== null;
        var hasFinalizer = (statement.finalizer !== null);
        var finallyStatements;
        var may;

        // Protected call
        protectedCallManager.openContext();
        var compiledTryStatement = new CompileResult(["local _status, _return = _pcall(function()\n"]);
        compiledTryStatement.push(compileListOfStatements(statement.block.body));
        compiledTryStatement.push("\n");
        compiledTryStatement.push("end);\n");
        // Collect result of analysis before closing
        may = protectedCallManager.may();
        protectedCallManager.closeContext();

        // No exception raised and something to do after execution of try block
        // either a finally to execute or a return,break or continue to handle
        if (hasFinalizer || may.mayReturn || may.mayBreak || may.mayContinue) {
            compiledTryStatement.push("if _status then\n");

            if (hasFinalizer) {
                finallyStatements = compileListOfStatements(statement.finalizer.body);
                compiledTryStatement.push(finallyStatements);
                compiledTryStatement.push("\n");
            }

            if (may.mayBreak && may.mayContinue) {
                compiledTryStatement.push("if _return == _break then break; elseif _return == _continue then goto _continue end\n");
            } else if (may.mayBreak) {
                compiledTryStatement.push("if _return == _break then break; end\n");
            } else if (may.mayContinue) {
                compiledTryStatement.push("if _return == _continue then goto _continue end\n");
            }

            if (may.mayReturn) {
                compiledTryStatement.push("if _return ~= nil then return _return; end\n");
            }

            // Exception has been raised
            compiledTryStatement.push("else\n");
        } else {
            compiledTryStatement.push("if not _status then\n");
        }

        if (hasHandler) {
            var handler = esprima ? statement.handlers[0] : statement.handler;

            // Protected call
            protectedCallManager.openContext();
            compiledTryStatement.push("local _cstatus, _creturn = _pcall(function()\n");
            compiledTryStatement.push("local ");
            compiledTryStatement.push(compilePattern(handler.param));
            compiledTryStatement.push(" = _return;\n");
            compiledTryStatement.push(compileListOfStatements(handler.body.body));
            compiledTryStatement.push("\n");
            compiledTryStatement.push("end);\n");
            // Collect result of analysis before closing
            may = protectedCallManager.may();
            protectedCallManager.closeContext();
        }

        if (hasFinalizer) {
            compiledTryStatement.push(finallyStatements);
            compiledTryStatement.push("\n");
        }

        if (hasHandler) {
            compiledTryStatement.push("if _cstatus then\n");

            if (may.mayBreak && may.mayContinue) {
                compiledTryStatement.push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\n");
            } else if (may.mayBreak) {
                compiledTryStatement.push("if _creturn == _break then break; end\n");
            } else if (may.mayContinue) {
                compiledTryStatement.push("if _creturn == _continue then goto _continue end\n");
            }

            if (may.mayReturn) {
                compiledTryStatement.push("if _creturn ~= nil then return _creturn; end\n");
            }

            compiledTryStatement.push("else _throw(_creturn,0); end\n");
        }

        compiledTryStatement.push("end\n");

        return compiledTryStatement;
    }

    function compileThrowStatement(statement) {
        var compiledThrowStatement = new CompileResult(["_throw("]);
        compiledThrowStatement.push(compileExpression(statement.argument));
        compiledThrowStatement.push(",0)");

        return compiledThrowStatement;
    }

    function compileReturnStatement(statement) {
        protectedCallManager.returnStatement();

        if (statement.argument !== null) {
            // @string
            return new CompileResult(["do return " , compileExpression(statement.argument,{}) , "; end"]);
        }

        return "do return end";
    }

    function compileWithStatement(statement) {
        withTracker.push(true);
        var compiledWithStatement = new CompileResult(["do\n"]);

        // with
        compiledWithStatement.push("local _oldENV = _ENV;\n");
        compiledWithStatement.push("local _ENV = _with(");
        compiledWithStatement.push(compileExpression(statement.object));
        compiledWithStatement.push(", _ENV);\n");

        if (options.jit) {
            compiledWithStatement.push("_wenv(function(...)\n");
        }

        // body
        compiledWithStatement.push(compileStatement(statement.body));

        if (options.jit) {
            compiledWithStatement.push("\nend, _ENV)()");
        }

        compiledWithStatement.push("\nend");

        withTracker.pop();
        return compiledWithStatement;
    }

    /*******************
     *
     * Expressions
     *
     * ******************/

    function compileExpression(expression, meta) {
        switch (expression.type) {
        case "AssignmentExpression":
            return compileAssignmentExpression(expression, meta);
        case "FunctionExpression":
            return compileFunction(expression, meta||true);
        case "Identifier":
            return compileIdentifier(expression, meta);
        case "Literal":
            return compileLiteral(expression, meta);
        case "UnaryExpression":
            return compileUnaryExpression(expression, meta);
        case "BinaryExpression":
            return compileBinaryExpression(expression, meta);
        case "LogicalExpression":
            return compileLogicalExpression(expression, meta);
        case "MemberExpression":
            return compileMemberExpression(expression, meta);
        case "CallExpression":
            return compileCallExpression(expression, meta);
        case "NewExpression":
            return compileNewExpression(expression, meta);
        case "ThisExpression":
            return compileThisExpression(expression, meta);
        case "ObjectExpression":
            return compileObjectExpression(expression, meta);
        case "UpdateExpression":
            return compileUpdateExpression(expression, meta);
        case "ArrayExpression":
            return compileArrayExpression(expression, meta);
        case "ConditionalExpression":
            return compileConditionalExpression(expression, meta);
        case "SequenceExpression":
            return compileSequenceExpression(expression, meta);
        case "ArrowFunctionExpression":
            throw new Error("Arrow functions (ES6) not supported yet.");
        case "TemplateLiteral":
            throw new Error("String templating (ES6) not supported yet.");
        case "SpreadElement":
            throw new Error("Spread operator (ES6) not supported yet.");
        case "MetaProperty":
            throw new Error("Meta property (ES6) not supported yet.");
        default:
            // @string
            throw new Error("Unknown Expression type: " + expression.type);
        }
    }

    function compileExpressionStatement(expression, meta) {
        if (options.evalMode) {
            return compileExpressionStatementEvalMode(expression, meta);
        } else {
            return compileExpressionStatementNoEval(expression, meta);
        }
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementEvalMode(expression, meta) {
        // Enclose the statement in a _e to be evaluated
        var compiledExpressionStatement = new CompileResult(["_e("]);
        compiledExpressionStatement.push(compileExpression(expression, meta));
        compiledExpressionStatement.push(");");
        return compiledExpressionStatement;
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementNoEval(expression, meta) {
        switch (expression.type) {
        case "Literal":
        case "Identifier":
        case "ThisExpression":
            return;
        case "UpdateExpression":
            // @string
            return compileUpdateExpressionNoEval(expression, meta).push(";");
        case "AssignmentExpression":
            // @string
            return compileAssignmentExpressionNoEval(expression, meta).push(";");
        case "BinaryExpression":
        case "LogicalExpression":
        case "ConditionalExpression":
        case "MemberExpression":
        case "FunctionExpression":
            // Enclose the statement in a _e to be evaluated
            var compiledExpressionStatement = new CompileResult(["_e("]);
            compiledExpressionStatement.push(compileExpression(expression, meta));
            compiledExpressionStatement.push(");");
            return compiledExpressionStatement.join("");
        case "UnaryExpression":
            // ! operator conversion is not enclosed in a function
            // so we enclose it in _e
            if (expression.operator === "!") {
                var compiledUnaryExpressionStatement = new CompileResult(["_e("]);
                compiledUnaryExpressionStatement.push(compileUnaryExpression(expression, meta));
                compiledUnaryExpressionStatement.push(");");
                return compiledUnaryExpressionStatement.join("");
            }
            // @string
            return compileUnaryExpression(expression, meta).push(";");
        case "CallExpression":
        case "NewExpression":
        case "ArrayExpression":
        case "ObjectExpression":
        case "SequenceExpression":
            // @string
            return compileExpression(expression, meta).push(";");
        case "YieldExpression":
            throw new Error("Yield expression not supported yet.");
        default:
            // @string
            throw new Error("Unknown expression type: " + expression.type);
        }
    }

    function compileCompoundAssignmentBinaryExpression(left, right, operator, metaLeft, metaRight, meta) {
        var compiledCompoundAssignmentBinaryExpression = new CompileResult(["("]);

        switch (operator) {
            // Bits shift
        case "<<=":
            compiledCompoundAssignmentBinaryExpression.push("_lshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>=":
            compiledCompoundAssignmentBinaryExpression.push("_arshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>>=":
            compiledCompoundAssignmentBinaryExpression.push("_rshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Arithmetic
        case "+=":
            compiledCompoundAssignmentBinaryExpression.push(compileAdditionOperator(left, right, metaLeft, metaRight, meta));
            break;
        case "-=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " - ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "*=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " * ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "/=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " / ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "%=":
            compiledCompoundAssignmentBinaryExpression.push("_mod(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Bitwise operators
        case "|=":
            compiledCompoundAssignmentBinaryExpression.push("_bor(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "^=":
            compiledCompoundAssignmentBinaryExpression.push("_bxor(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "&=":
            compiledCompoundAssignmentBinaryExpression.push("_band(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        default:
            // @string
            throw new Error("Unknown BinaryOperator: " + operator);
        }

        compiledCompoundAssignmentBinaryExpression.push(")");

        return compiledCompoundAssignmentBinaryExpression;
    }

    function storeComputedProperty(expression) {
        var hasComputedProperty = expression.type === "MemberExpression" && expression.computed;

        if (hasComputedProperty) {
            if (expression.property.type === "Literal") {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    function compileCompoundAssignmentNoEval(expression) {
        var compiledAssignmentBinaryExpression = new CompileResult();
        var mustStore = storeComputedProperty(expression.left);
        var metaLeft = {},
            metaRight = {};

        var left = compileExpression(expression.left, metaLeft);
        var right = compileExpression(expression.right, metaRight);

        if (mustStore) {
            var split = getBaseMember(left);
            // @string
            left = split.base + "[_cp]";

            // store computed property to evalute it only once
            compiledAssignmentBinaryExpression.push("do local _cp = ");
            compiledAssignmentBinaryExpression.push(split.member);
            compiledAssignmentBinaryExpression.push("; ");
        }

        compiledAssignmentBinaryExpression.push(left);
        compiledAssignmentBinaryExpression.push(" = ");
        compiledAssignmentBinaryExpression.push(compileCompoundAssignmentBinaryExpression(left, right, expression.operator, metaLeft, metaRight));

        if (mustStore) {
            compiledAssignmentBinaryExpression.push(" end");
        }

        return compiledAssignmentBinaryExpression;
    }

    function compileAssignmentExpressionNoEval(expression) {
        var compiledAssignmentExpression = new CompileResult();

        switch (expression.operator) {
            // Regular assignement
        case "=":
            var left = compileExpression(expression.left);
            var right = compileExpression(expression.right);
            compiledAssignmentExpression.push(left);
            compiledAssignmentExpression.push(" = ");
            compiledAssignmentExpression.push(right);
            break;
        default:
            // Compound assignments
            return compileCompoundAssignmentNoEval(expression);
        }

        return compiledAssignmentExpression;
    }

    function compileAssignmentExpression(expression, meta) {
        var compiledAssignmentExpression = new CompileResult(["(function() "]);
        var mustStore = storeComputedProperty(expression.left);
        var metaLeft = {},
            metaRight = {};
        var left = compileExpression(expression.left, metaLeft);
        var right = compileExpression(expression.right, metaRight);

        if (mustStore) {
            var split = getBaseMember(left);
            // store computed property to evalute it only once
            compiledAssignmentExpression.push("local _cp = ");
            compiledAssignmentExpression.push(split.member);
            compiledAssignmentExpression.push(";");

            // @string
            left = split.base + "[_cp]";
        }

        compiledAssignmentExpression.push(left);
        compiledAssignmentExpression.push(" = ");

        switch (expression.operator) {
            // regular assignment
        case "=":
            compiledAssignmentExpression.push(right);
            if (meta) {
                meta.type = metaRight.type;
            }
            break;
        default:
            // Compound assignments
            compiledAssignmentExpression.push(compileCompoundAssignmentBinaryExpression(left, right, expression.operator, metaLeft, metaRight, meta));
        }

        compiledAssignmentExpression.push("; return ");
        compiledAssignmentExpression.push(left);
        compiledAssignmentExpression.push(" end)()");

        return compiledAssignmentExpression;
    }

    function compileUpdateExpressionNoEval(expression) {
        var compiledUpdateExpression = new CompileResult();
        var mustStore = storeComputedProperty(expression.argument);
        var metaArgument = {};
        var compiledArgument = compileExpression(expression.argument, metaArgument);

        if (mustStore) {
            var split = getBaseMember(compiledArgument);
            // @string
            compiledArgument = split.base + "[_cp]";

            // store computed property to evalute it only once
            compiledUpdateExpression.push("do local _cp = ");
            compiledUpdateExpression.push(split.member);
            compiledUpdateExpression.push("; ");
        }

        compiledUpdateExpression.push(compiledArgument);
        compiledUpdateExpression.push(" = ");

        switch (expression.operator) {
        case "++":
            if (metaArgument.type === "number") {
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(" + 1");
            } else {
                compiledUpdateExpression.push("_inc(");
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(")");
            }
            break;
        case "--":
            if (metaArgument.type === "number") {
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(" - 1");
            } else {
                compiledUpdateExpression.push("_dec(");
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(")");
            }
            break;
        default:
            // @string
            throw new Error("Unknown UpdateOperator: " + expression.operator);
        }

        if (mustStore) {
            compiledUpdateExpression.push(";end");
        }

        return compiledUpdateExpression;
    }

    function compileUpdateExpression(expression, meta) {
        var compiledUpdateExpression = new CompileResult(["(function () "]);
        var mustStore = storeComputedProperty(expression.argument);
        var metaArgument = {};
        var compiledArgument = compileExpression(expression.argument, metaArgument);

        if (mustStore) {
            var split = getBaseMember(compiledArgument);
            // store computed property to evalute it only once
            compiledUpdateExpression.push("local _cp = ");
            compiledUpdateExpression.push(split.member);
            compiledUpdateExpression.push(";");

            // @string
            compiledArgument = split.base + "[_cp]";
        }

        compiledUpdateExpression.push("local _tmp = ");
        if (expression.prefix) {
            // Prefix
            switch (expression.operator) {
            case "++":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push(" + 1; ");
                } else {
                    compiledUpdateExpression.push("_inc(");
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push("); ");
                }
                break;
            case "--":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push(" - 1; ");
                } else {
                    compiledUpdateExpression.push("_dec(");
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push("); ");
                }
                break;
            default:
                // @string
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }

            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = _tmp");
        } else {
            // Postfix
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push("; ");
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = ");

            switch (expression.operator) {
            case "++":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push("_tmp + 1");
                } else {
                    compiledUpdateExpression.push("_inc(_tmp)");
                }
                break;
            case "--":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push("_tmp - 1");
                } else {
                    compiledUpdateExpression.push("_dec(_tmp)");
                }
                break;
            default:
                // @string
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }
        }

        compiledUpdateExpression.push("; return _tmp; end)()");

        // UpdateExpression always returns a number
        if (meta) {
            meta.type = "number";
        }

        return compiledUpdateExpression;
    }

    // Replace the character in str at the given index by char
    function replaceAt(str, index, char) {
        // @string
        return str.substr(0, index) + char + str.substr(
            // @number
            index + 1);
    }

    function lastTopLevelBracketedGroupStartIndex(str) {
        var startIndex = 0,
            count = 0,
            i;
        // @number
        for (i = 0; i < str.length; ++i) {
            if (str[i] === '[') {
                if (count === 0) {
                    startIndex = i;
                }
                // @number
                count++;
            } else if (str[i] === ']') {
                // @number
                count--;
            }
        }

        return startIndex;
    }

    function lastTopLevelBracketedGroupStartIndex_a(str) {
        var startIndex = 0,
            count = 0,
            i;
        // @number
        for (i = 0; i < str.length; ++i) {
            var s=str[i];
            if (typeof(s)!=='string') continue;
            if (s.match(/^\[/)) {
                if (count === 0) {
                    startIndex = i;
                }
                // @number
                count++;
            } else if (str[i].match(/^\]/)){
                // @number
                count--;
            }
        }

        return startIndex;
    }

    function compileCallArguments(args) {
        var compiledArguments = new CompileResult([],',');

        var i;
        // @number
        for (i = 0; i < args.length; ++i) {
            compiledArguments.push(compileExpression(args[i]));
        }

        return compiledArguments;
    }

    function compileCallExpression(expression, meta) {
        var compiledCallExpression = new CompileResult();
        var compiledCallee = compileExpression(expression.callee);
        var compiledArguments = compileCallArguments(expression.arguments);

        // If callee is method of an object
        if (expression.callee.type === "MemberExpression") {
            // If end by a bracket
            var calleeStr=compiledCallee.toString();
            
            //console.log('calleestr contains isArray from ',JSON.stringify(compiledCallee,null,2));            
           
            if (calleeStr.match(/\]$/)) {
                //
                var startIndex,base,member
                if (options.luaLocal){
                    startIndex = lastTopLevelBracketedGroupStartIndex(calleeStr);
                    base =calleeStr.substr(0, startIndex);
                    member = calleeStr.substr(startIndex + 1);
                }else{
                    compiledCallee.array.forEach(function(v,idx){
                        if(typeof(v)==='string' && v.match(/^\[/)){
                            startIndex=idx;
                        }
                    });
                    base =compiledCallee.slice(0,startIndex) ; 
                    // @number
                    member = compiledCallee.slice(startIndex); 
                }                
                compiledCallExpression.push("(function() local _this = ");
                compiledCallExpression.push(base);
                compiledCallExpression.push("; local _f = _this");
                compiledCallExpression.push(member);
                compiledCallExpression.push("; return _f(_this");

                if (expression.arguments.length >0 ) {
                    compiledCallExpression.push(",");
                    compiledCallExpression.push(compiledArguments);
                }
                compiledCallExpression.push("); end)()");
            } else {                
                if (options.luaLocal){
                    // Replace last occurence of '.' by ':'
                    var lastPointIndex = calleeStr.lastIndexOf('.');
                    compiledCallee = replaceAt(calleeStr, lastPointIndex, ':');
                    compiledCallExpression.push(compiledCallee);
                }else{
                    var lastPointIndex;
                    compiledCallee.array.findIndex(function(v,idx){
                        if(typeof(v)==='string' && v==='.'){
                            lastPointIndex=idx;
                        }
                    });
                    compiledCallExpression.push(compiledCallee.slice(0,lastPointIndex));
                    compiledCallExpression.push(':');
                    compiledCallExpression.push(compiledCallee.slice(lastPointIndex+1));
                }               
                compiledCallExpression.push("(");
                //console.log('call compiled:',compiledCallee, JSON.stringify(compiledArguments));
                compiledCallExpression.push(compiledArguments);
                compiledCallExpression.push(")");
            }
        } else {
            compiledCallExpression.push(compiledCallee);
            if (withTracker.length === 0) {
                compiledCallExpression.push("(_ENV");
            } else {
                compiledCallExpression.push("(_oldENV");
            }

            if (expression.arguments.length>0) {
                compiledCallExpression.push(",");                
                compiledCallExpression.push(compiledArguments);
            }
            compiledCallExpression.push(")");
        }

        setMeta(expression, meta);

        return compiledCallExpression;
    }

    function compileLogicalExpression(expression, meta) {

        var metaLeft = {},
            metaRight = {};
        var compiledLeft = compileExpression(expression.left, metaLeft),
            compiledRight = compileExpression(expression.right, metaRight);

        if (meta) {
            // if left and right are same type then return type is known
            if (metaLeft.type === metaRight.type && metaLeft.type !== undefined) {
                meta.type = metaLeft.type;
            }
        }

        if (expression.left.type === "Identifier" || expression.left.type === "Literal") {
            return compileLogicalExpressionLeftIdentifierOrLiteral(expression, compiledLeft, compiledRight);
        } else {
            return compileGenericLogicalExpression(expression, compiledLeft, compiledRight);
        }
    }

    function compileLogicalExpressionLeftIdentifierOrLiteral(expression, compiledLeft, compiledRight) {
        var compiledLogicalExpression = new CompileResult(["("]);

        var leftCondition = compileBooleanExpression(expression.left);

        switch (expression.operator) {
        case "&&":
            // (function() if boolean(a) then return b else return a end end)()
            compiledLogicalExpression.push("(function() if ");
            compiledLogicalExpression.push(leftCondition);
            compiledLogicalExpression.push(" then return ");
            compiledLogicalExpression.push(compiledRight);
            compiledLogicalExpression.push("; else return ");
            compiledLogicalExpression.push(compiledLeft);
            compiledLogicalExpression.push("; end end)()");
            break;
        case "||":
            // boolean(a) and a or b
            compiledLogicalExpression.push(leftCondition);
            compiledLogicalExpression.push(" and ");
            compiledLogicalExpression.push(compiledLeft);
            compiledLogicalExpression.push(" or ");
            compiledLogicalExpression.push(compiledRight);

            break;
        default:
            // @string
            throw new Error("Unknown LogicalOperator: " + expression.operator);
        }

        compiledLogicalExpression.push(")");

        return compiledLogicalExpression;
    }

    function compileGenericLogicalExpression(expression, compiledLeft, compiledRight) {
        var compiledLogicalExpression = new CompileResult(["("]);

        switch (expression.operator) {
        case "&&":
            // (function() local _left_eval=a; if boolean(_left_eval) then return b else return _left_eval end end)()
            compiledLogicalExpression.push("(function() local _lev=");
            compiledLogicalExpression.push(compiledLeft);
            compiledLogicalExpression.push("; if _bool(_lev) then return ");
            compiledLogicalExpression.push(compiledRight);
            compiledLogicalExpression.push("; else return _lev; end end)()");
            break;
        case "||":
            // (function() local _left_eval=a; boolean(_left_eval) and _left_eval or b
            compiledLogicalExpression.push("(function() local _lev=");
            compiledLogicalExpression.push(compiledLeft);
            compiledLogicalExpression.push("; return _bool(_lev) and _lev or ");
            compiledLogicalExpression.push(compiledRight);
            compiledLogicalExpression.push(" end)()");

            break;
        default:
            // @string
            throw new Error("Unknown LogicalOperator: " + expression.operator);
        }

        compiledLogicalExpression.push(")");

        return compiledLogicalExpression;
    }

    function getBaseMember(compiledExpression) {
        var startIndex = 0;
        var compiledExpressionStr=compiledExpression.toString()
        if (compiledExpressionStr.match(/\]$/)) {
            if (options.luaLocal){
                startIndex = lastTopLevelBracketedGroupStartIndex(compiledExpressionStr);
                return {
                    base: compiledExpressionStr.slice(0, startIndex),
                    // @number
                    member: compiledExpressionStr.slice(startIndex + 1, -1)
                };
            }
            startIndex=lastTopLevelBracketedGroupStartIndex_a(compiledExpression.array);
            return {
                base: compiledExpression.slice(0,startIndex),
                // @number
                member: compiledExpression.slice(startIndex + 1, -1)
            };
        } else {
            if (options.luaLocal){
                startIndex = compiledExpressionStr.lastIndexOf('.');
                return {
                    base: compiledExpressionStr.slice(0, startIndex),
                    // @string
                    member: '"' + compiledExpressionStr.slice(
                        // @number
                        startIndex + 1
                    ) + '"'
                };
            }            
            compiledExpression.array.forEach(function(v,idx){
                if(typeof(v)==='string' && v==='.'){
                    startIndex=idx;
                }
            });
            return {
                base: compiledExpression.slice(0, startIndex),
                // @string
                member: compiledExpression.slice(
                    // @number
                    startIndex + 1
                ).quote('"')
            };
        }
    }

    function getGetterSetterExpression(compiledExpression) {
        var split = getBaseMember(compiledExpression);
        //console.log('split:', JSON.stringify(split,null,2));
        var suffix=' .. '
        if (options.luaLocal){
            return {
                // @string
                getter: split.base+'["_g"'+suffix+split.member+']',
                // @string
                setter: split.base+'["_s"'+suffix+split.member+']'
            };
        }
        return {
            // @string
            getter: new CompileResult().push(split.base).push('["_g"'+suffix).push(split.member).push(']'),
            // @string
            setter: new CompileResult().push(split.base).push('["_s"'+suffix).push(split.member).push(']')
        };
    }

    function compileUnaryExpression(expression, meta) {
        var compiledUnaryExpression = new CompileResult();
        var metaArgument = {};
        var compiledExpression = compileExpression(expression.argument, metaArgument);

        if (expression.prefix) {
            // "-" | "+" | "!" | "~" | "typeof" | "void" | "delete"

            switch (expression.operator) {
                // convert to number and negate it
            case "-":
                if (metaArgument.type === "number") {
                    compiledUnaryExpression.push("-");
                    compiledUnaryExpression.push(compiledExpression);
                } else {
                    compiledUnaryExpression.push("-_tonum(");
                    compiledUnaryExpression.push(compiledExpression);
                    compiledUnaryExpression.push(")");
                }
                if (meta) {
                    meta.type = "number";
                }
                break;
                // convert to number
            case "+":
                if (metaArgument.type === "number") {
                    compiledUnaryExpression.push(compiledExpression);
                } else {
                    compiledUnaryExpression.push("_tonum(");
                    compiledUnaryExpression.push(compiledExpression);
                    compiledUnaryExpression.push(")");
                }
                if (meta) {
                    meta.type = "number";
                }
                break;
                // Negate
            case "!":
                compiledUnaryExpression.push("not ");
                compiledUnaryExpression.push(compileBooleanExpression(expression.argument));
                if (meta) {
                    meta.type = "boolean";
                }
                break;
                // Bit not
            case "~":
                compiledUnaryExpression.push("_bnot(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "number";
                }
                break;
            case "typeof":
                compiledUnaryExpression.push("_type(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "string";
                }
                break;
            case "delete":
                var scope;
                if (withTracker.length === 0) {
                    scope = "_ENV.";
                } else {
                    scope = "_oldENV.";
                }
                compiledUnaryExpression.push("(function () local _r = false; ");

                // Delete getter/setter
                if (expression.argument.type === "MemberExpression") {
                    scope = "";
                    var gs = getGetterSetterExpression(compiledExpression);                    
                    compiledUnaryExpression.push("local _g, _s = ");
                    compiledUnaryExpression.push(gs.getter);
                    compiledUnaryExpression.push(", ");
                    compiledUnaryExpression.push(gs.setter);
                    compiledUnaryExpression.push("; ");
                    compiledUnaryExpression.push(gs.getter);
                    compiledUnaryExpression.push(", ");
                    compiledUnaryExpression.push(gs.setter);
                    compiledUnaryExpression.push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\n");
                }

                // Delete value
                compiledUnaryExpression.push("local _v = ");
                // @string
                //always delete global var in ENV
                //console.log('delete compiledExpression:',compiledExpression);
                var ename;
                if (isCompileResultLike(compiledExpression)){
                    ename=compiledExpression.toString();                             
                }else if (typeof(compiledExpression)==='string'){
                    ename=compiledExpression;
                }else {
                    ename=compiledExpression.name;
                }
                if (!ename){
                    console.error('delete name = null')
                }else{
                    if (scope.length>0){
                        ename=ename.replace(/^_local\d+\./,'');
                    }                    
                }
                
                compiledUnaryExpression.push(scope).push(ename);
                compiledUnaryExpression.push("; ");
                // @string
                compiledUnaryExpression.push(scope).push(ename);
                compiledUnaryExpression.push(" = nil; return _r or _v ~= nil; end)()");

                if (meta) {
                    meta.type = "boolean";
                }
                break;
            case "void":
                compiledUnaryExpression.push("_void(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "undefined";
                }
                break;
            default:
                // @string
                throw new Error("Unknown UnaryOperator: " + expression.operator);
            }
        } else {
            throw new Error("UnaryExpression: postfix ?!");
        }

        return compiledUnaryExpression;
    }

    function compileAdditionOperator(left, right, metaLeft, metaRight, meta) {
        var compiledAdditionOperator = new CompileResult();
        if (metaLeft.type === "number" && metaRight.type === "number") {
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(" + ");
            compiledAdditionOperator.push(right);
            if (meta) {
                meta.type = "number";
            }
        } else if (metaLeft.type === "string") {
            if (metaRight.type === "number" || metaRight.type === "string") {
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(" .. ");
                compiledAdditionOperator.push(right);
            } else {
                compiledAdditionOperator.push("_addStr1(");
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(",");
                compiledAdditionOperator.push(right);
                compiledAdditionOperator.push(")");
            }
            if (meta) {
                meta.type = "string";
            }
        } else if (metaRight.type === "string") {
            if (metaLeft.type === "number" || metaLeft.type === "string") {
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(" .. ");
                compiledAdditionOperator.push(right);
            } else {
                compiledAdditionOperator.push("_addStr2(");
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(",");
                compiledAdditionOperator.push(right);
                compiledAdditionOperator.push(")");
            }
            if (meta) {
                meta.type = "string";
            }
        } else if (metaLeft.type === "number") {
            compiledAdditionOperator.push("_addNum1(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        } else if (metaRight.type === "number") {
            compiledAdditionOperator.push("_addNum2(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        } else {
            // Default case
            compiledAdditionOperator.push("_add(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        }

        return compiledAdditionOperator;
    }

    function compileComparisonOperator(left, right, operator, metaLeft, metaRight, meta) {
        var compiledComparisonOperator = new CompileResult();

        // Raw comparison
        if ((metaLeft.type === "string" && metaRight.type === "string") || (metaLeft.type === "number" && metaRight.type === "number")) {
            compiledComparisonOperator.push(left);
            compiledComparisonOperator.push(operator);
            compiledComparisonOperator.push(right);
        } else {
            switch (operator) {
            case "<":
                compiledComparisonOperator.push("_lt(");
                break;
            case "<=":
                compiledComparisonOperator.push("_le(");
                break;
            case ">":
                compiledComparisonOperator.push("_gt(");
                break;
            case ">=":
                compiledComparisonOperator.push("_ge(");
                break;
            }
            compiledComparisonOperator.push(left);
            compiledComparisonOperator.push(",");
            compiledComparisonOperator.push(right);
            compiledComparisonOperator.push(")");
        }

        // Result of comparison is always a boolean
        if (meta) {
            meta.type = "boolean";
        }

        return compiledComparisonOperator;
    }

    function compileBinaryExpression(expression, meta) {
        var compiledBinaryExpression = new CompileResult(["("]);
        var metaLeft = {},
            metaRight = {};
        var left = compileExpression(expression.left, metaLeft),
            right = compileExpression(expression.right, metaRight);

        switch (expression.operator) {
            // Equality
        case "==":
            compiledBinaryExpression.push("_eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "!=":
            compiledBinaryExpression.push("not _eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "===":
            pushSimpleBinaryExpression(compiledBinaryExpression, " == ", left, right);
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "!==":
            pushSimpleBinaryExpression(compiledBinaryExpression, " ~= ", left, right);
            if (meta) {
                meta.type = "boolean";
            }
            break;
            // Comparison
        case "<":
        case "<=":
        case ">":
        case ">=":
            compiledBinaryExpression.push(compileComparisonOperator(left, right, expression.operator, metaLeft, metaRight, meta));
            break;
            // Bits shift
        case "<<":
            compiledBinaryExpression.push("_lshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>":
            compiledBinaryExpression.push("_arshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>>":
            compiledBinaryExpression.push("_rshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Arithmetic
        case "+":
            compiledBinaryExpression.push(compileAdditionOperator(left, right, metaLeft, metaRight, meta));
            break;
        case "-":
            pushSimpleBinaryExpression(compiledBinaryExpression, " - ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "*":
            pushSimpleBinaryExpression(compiledBinaryExpression, " * ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "/":
            pushSimpleBinaryExpression(compiledBinaryExpression, " / ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "%":
            compiledBinaryExpression.push("_mod(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Bitwise operators
        case "|":
            compiledBinaryExpression.push("_bor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "^":
            compiledBinaryExpression.push("_bxor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "&":
            compiledBinaryExpression.push("_band(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Other
        case "in":
            compiledBinaryExpression.push("_in(");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "instanceof":
            compiledBinaryExpression.push("_instanceof(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "..":
            // E4X operator
            // doesn't worth to be implemented for now
            break;
        default:
            // @string
            throw new Error("Unknown BinaryOperator: " + expression.operator);
        }

        compiledBinaryExpression.push(")");

        return compiledBinaryExpression;
    }

    function pushSimpleBinaryExpression(compiledBinaryExpression, operator, left, right) {
        compiledBinaryExpression.push(left);
        compiledBinaryExpression.push(operator);
        compiledBinaryExpression.push(right);
    }

    // TernaryOperator: boxing/unboxing solution
    // http://lua-users.org/wiki/TernaryOperator
    function compileConditionalExpression(expression, meta) {
        var compiledConditionalExpression = new CompileResult(["(function() if "]);
        var metaConsequent = {},
            metaAlternate = {};
        // (function() if boolean(a) then return b else return c end end)()
        compiledConditionalExpression.push(compileBooleanExpression(expression.test));
        compiledConditionalExpression.push(" then return ");
        compiledConditionalExpression.push(compileExpression(expression.consequent, metaConsequent));
        compiledConditionalExpression.push("; else return ");
        compiledConditionalExpression.push(compileExpression(expression.alternate, metaAlternate));
        compiledConditionalExpression.push("; end end)()");

        if (meta) {
            if (metaConsequent.type === metaAlternate.type && metaConsequent.type !== undefined) {
                meta.type = metaConsequent.type;
            }
        }

        return compiledConditionalExpression;
    }

    function compileSequenceExpression(expression, meta) {
        var compiledSequenceExpression = new CompileResult(["_seq({"]);

        var i, expressions = expression.expressions;
        var sequence = new CompileResult([],',');
        var metaLast = {};
        // @number
        for (i = 0; i < expressions.length; ++i) {
            sequence.push(compileExpression(expressions[i], metaLast));
        }

        compiledSequenceExpression.push(sequence);
        compiledSequenceExpression.push("})");

        // Type returned by sequence is the same as the type of the last expression in the sequence
        if (meta) {
            meta.type = metaLast.type;
        }

        return compiledSequenceExpression;
    }

    function compileObjectExpression(expression, meta) {
        var compiledObjectExpression = new CompileResult(["_obj({"]);

        var i, length = expression.properties.length;
        var property;
        var compiledProperty,
            compiledProperties = new CompileResult([],",\n");
        var compiledKey = "";

        // @number
        for (i = 0; i < length; ++i) {
            compiledProperty =  new CompileResult(["["]);
            property = expression.properties[i];

            if (property.key.type === "Literal") {
                compiledKey = compileLiteral(property.key);
            } else if (property.key.type === "Identifier") {
                compiledKey = '"';
                // compile the identifier as a string literal
                // @string
                compiledKey += sanitizeLiteralString(property.key.name);
                // @string
                compiledKey += '"';
            } else {
                // @string
                throw new Error("Unexpected property key type: " + property.key.type);
            }           
            if (property.kind === "get") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    // @string
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_g');
            } else if (property.kind === "set") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    // @string
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_s');
            }
            
            compiledProperty.push(compiledKey);
            compiledProperty.push("] = ");
            compiledProperty.push(compileExpression(property.value));            
            compiledProperties.push(compiledProperty);
        }
        
        // @number
        if (length > 0) {
            compiledObjectExpression.push("\n");
            compiledObjectExpression.push(compiledProperties);            
            compiledObjectExpression.push("\n");
        }
        compiledObjectExpression.push("})");

        if (meta) {
            meta.type = "object";
        }

        return compiledObjectExpression;
    }

    function compileMemberExpression(expression, meta) {
        var compiledMemberExpression = new CompileResult([]);
        var compiledObject = compileExpression(expression.object,{});

        if (expression.object.type === "Literal") {
            // @string
            compiledObject = "(" + compiledObject + ")";
        }

        compiledMemberExpression.push(compiledObject);

        if (expression.computed) {
            compiledMemberExpression.push("[");
            compiledMemberExpression.push(compileExpression(expression.property));
            compiledMemberExpression.push("]");
        } else {
            //var compiledProperty = compileIdentifier(expression.property);

            if (sanitizeIdentifier(expression.property.name) !== expression.property.name) {
                compiledMemberExpression.push("[\"");
                compiledMemberExpression.push(sanitizeLiteralString(expression.property.name));
                compiledMemberExpression.push("\"]");
            } else {
                compiledMemberExpression.push(".");
                compiledMemberExpression.push(expression.property.name);
            }
        }

        setMeta(expression, meta);

        return compiledMemberExpression;
    }

    function compileNewExpression(expression) {
        var compiledNewExpression = new CompileResult(["_new("]);

        var newArguments =new CompileResult([compileExpression(expression.callee)],',') ;
        var i, length = expression.arguments.length;
        // @number
        for (i = 0; i < length; ++i) {
            newArguments.push(compileExpression(expression.arguments[i]));
        }

        compiledNewExpression.push(newArguments);
        compiledNewExpression.push(")");

        return compiledNewExpression;
    }

    function compileThisExpression() {
        return "this";
    }

    function compileArrayExpression(expression, meta) {
        var compiledArrayExpression = new CompileResult(["_arr({"]);

        var compiledElements = new CompileResult([],',');
        var i, length = expression.elements.length;

        // @number
        if (length > 0) {
            compiledArrayExpression.push("[0]=");
        }

        // @number
        for (i = 0; i < length; ++i) {
            if (expression.elements[i] !== null) {
                compiledElements.push(compileExpression(expression.elements[i]));
            } else {
                compiledElements.push("nil");
            }
        }
        compiledArrayExpression.push(compiledElements);
        compiledArrayExpression.push("},");
        compiledArrayExpression.push(length);
        compiledArrayExpression.push(")");

        if (meta) {
            meta.type = "object";
        }

        return compiledArrayExpression;
    }

    /*******************
     *
     * Declarations
     *
     * ******************/

    function compileFunctionDeclaration(declaration) {
        var compiledFunctionDeclaration = new CompileResult();
        var compiledId = compileIdentifier(declaration.id);
        //console.log('function decelare:',compiledId)
        localVarManager.pushLocal(compiledId.name);
        compiledFunctionDeclaration.push(compiledId); //lovar: replace compiledId with stack_var.id
        compiledFunctionDeclaration.push(" =(");
        compiledFunctionDeclaration.push(compileFunction(declaration));
        compiledFunctionDeclaration.push(");");
        localVarManager.pushFunction(compiledFunctionDeclaration);
    }

    function compileVariableDeclaration(variableDeclaration) {
        var compiledDeclarations = new CompileResult([],'\n');

        switch (variableDeclaration.kind) {
            // TODO:
            // for now we simply ignore constness
        case "const":
        case "var":

            var declarations = variableDeclaration.declarations;
            var i, declarator, pattern, expression, compiledDeclarationInit;

            // @number
            for (i = 0; i < declarations.length; ++i) {
                declarator = declarations[i];
                //lovar:
                pattern = compilePattern(declarator.id,"var");

                // Add to current local context
                //if (!declarator.init){
                localVarManager.pushLocal(pattern);                
                //}
                if (declarator.init !== null) {
                    expression = compileExpression(declarator.init);
                    compiledDeclarationInit = new CompileResult();
                    compiledDeclarationInit.push(pattern);
                    compiledDeclarationInit.push(" = ");
                    compiledDeclarationInit.push(expression);
                    compiledDeclarationInit.push(";");

                    compiledDeclarations.push(compiledDeclarationInit.join(''));
                }
            }
            break;
        case "let":
            // TODO
            throw new Error("let instruction is not supported yet");
        }

        return compiledDeclarations;
    }

    /********************
     *
     * Patterns
     *
     * ******************/

    function compilePattern(pattern, meta) {
        switch (pattern.type) {
        case "Identifier":
            return compileIdentifier(pattern, meta);
        case "RestElement":
            throw new Error("Rest parameters (ES6) not supported yet.");
        default:
            // @string
            throw new Error("Unknwown Pattern type: " + pattern.type);
        }
    }

    /********************
     *
     * Functions
     *
     * ******************/

    function compileFunction(fun,meta) {
	    var hasName=meta && fun.id && fun.id.name.length>0 
        var compiledFunction =new CompileResult([hasName?'(function() local '+fun.id.name+';'+fun.id.name+'=(function(':"(function("]);
        var compiledBody = "";

        // New context
        localVarManager.createLocalContext();
        var i;
        var params = fun.params;
        var compiledParams = new CompileResult(["this"],',');
        // @number
        for (i = 0; i < params.length; ++i) {
            var pa=compilePattern(params[i],'param');
            localVarManager.pushParam(pa);
            compiledParams.push(pa);
        }

        // Compile body of the function
        if (fun.body.type === "BlockStatement") {
            compiledBody = compileStatement(fun.body);
        } else if (fun.body.type === "Expression") {
            compiledBody = compileExpression(fun.body);
        }

        // Params
        // TODO: fun.defaults are ignored for now
        if (fun.defaults && fun.defaults.length > 0) {
            console.log('Warning: default parameters of functions are ignored');
        }
        

        // Get context information
        var context = localVarManager.popLocalContext();
        var locals = context[0];
        // Do not create Argument object if one of the parameters is called 'arguments'
        var useArguments = context[1] && (compiledParams.indexOf("arguments") === -1);

        if (useArguments) {
            compiledFunction.push("...)\n");
            // @string
            compiledFunction.push("local ").push(compiledParams).push(" = ...;\n");
            compiledFunction.push("local arguments = _args(...);\n");

            compiledParams.push("arguments");
        } else {            
            compiledFunction.push(compiledParams);
            compiledFunction.push(")\n");
        }

        // Locals
        // @number
        if (locals.length > 0) {
            // local that has the same identifier as one of the arguments will not be redefined            
            var compiledLocalsDeclaration = buildLocalsDeclarationString(locals, compiledParams);
            compiledFunction.push(compiledLocalsDeclaration);
        }

        // Function declarations
        var functions = context[2];
        // @number
        if (functions.length > 0) {
            var compiledFunctionsDeclaration = new CompileResult([],'\n');

            // @number
            for (i = 0; i < functions.length; ++i) {
                compiledFunctionsDeclaration.push(functions[i]);
            }
            compiledFunction.push(compiledFunctionsDeclaration);
        }

        // Append body and close function
        compiledFunction.push(compiledBody);
        compiledFunction.push("\n");
        compiledFunction.push("end)");
        if (hasName){            
            compiledFunction.push(' return '+fun.id.name+';end)()');
        }
       // console.log('function ',JSON.stringify(compiledFunction,null,2));
        return compiledFunction;
    }

    function buildLocalsDeclarationString(locals, ignore) {
        ignore = ignore || [];
        var namesSequence = new CompileResult([],',');

        var i, local,localname, length = locals.length;
        
        for (i = 0; i < length; ++i) {
            local = locals.pop();            
            if (typeof(local)==='string'){
                localname=local
            }else{
                localname=local.name 
            }
            if (!options.luaLocal || (ignore.indexOf(localname) === -1 && namesSequence.indexOf(localname) === -1)) {
                namesSequence.push(local);
                //console.log('push local:',local,ignore.indexOf(localname))
            }
        }

        // @number
        if (namesSequence.array.length > 0) { //if length>200, it results in lua runtime error
            if (options.luaLocal){
                var compiledLocalsDeclaration = new CompileResult(["local " ]);//+localVarManager.loVarsName()+" = {} "]; 
                compiledLocalsDeclaration.push(namesSequence);
                compiledLocalsDeclaration.push(";\n");
                return compiledLocalsDeclaration;
            }          
            return "local "+localVarManager.loVarsName()+" = {};\n";                       
        }
        
        return "";
    }

    /*************************
     *
     * Identifier and Literal
     *
     * ***********************/

    function sanitizeIdentifier(id) {
        // Reserved lua keywords are guarded
        // @number
        if (luaKeywords.indexOf(id) > -1) {
            // @string
            return '_g_' + id;
        }

        return id
            .replace(/_/g, '__') // (one consequence: CASTL can internally safely use identifiers begining by exactly one underscore)
            .replace(/\$/g, 'S') // variable name can contain a $ in JS, not in Lua
            .replace(/[\u0080-\uFFFF]/g, function (c) { // Latin-1 Supplement is allowed in JS var names, not yet in Lua
                // @string
                return '_' + c.charCodeAt(0);
            });
    }

    function compileIdentifier(identifier, meta) {
        var iname=identifier.name
        if (identifier.name === "arguments") {
            localVarManager.useArguments();
        }

        setMeta(identifier, meta);
        //console.log('identifier:',identifier.name,meta)
        
        var siname=sanitizeIdentifier(iname);
        /*if (iname.match(/^(?:global|Object|RegExp|Array)/)){

        }*/

        if (options.luaLocal){
            return siname;
        }
                
        if (identifier.name === "arguments") {
            return siname;
        }
        
        if (meta==='param' || meta==='label'||meta==='global'||meta==='for_in'){
            return siname;
        }

        if (meta==="var"){
            //lhs            
            return localVarManager.loVarName(siname);
        }
                       
        var ret=localVarManager.findLoVar(siname);
        
        if (ret) {
            //console.log(siname+' - resolved as ',ret)
            return ret;        
        }
        //console.log('unable to find '+siname+' - register unresolved')
        return localVarManager.addUnresolvedVar(siname) //to be resolve!
    }

    // http://en.wikipedia.org/wiki/UTF-8#Description
    // http://stackoverflow.com/a/18729931/1120148
    function toUTF8Array(str) {
        var utf8 = [];
        var i, charcode;
        // @number
        for (i = 0; i < str.length; ++i) {
            charcode = str.charCodeAt(i);
            // @number
            if (charcode < 0x80) {
                utf8.push(charcode);
                // @number
            } else if (charcode < 0x800) {
                utf8.push(0xc0 | (charcode >> 6),
                    0x80 | (charcode & 0x3f));
                // @number
            } else if (charcode < 0xd800 || charcode >= 0xe000) {
                utf8.push(0xe0 | (charcode >> 12),
                    0x80 | ((charcode >> 6) & 0x3f),
                    0x80 | (charcode & 0x3f));
            } else { // surrogate pair
                // @number
                i++;
                // UTF-16 encodes 0x10000-0x10FFFF by
                // subtracting 0x10000 and splitting the
                // 20 bits of 0x0-0xFFFFF into two halves
                // @number
                charcode = 0x10000 + (((charcode & 0x3ff) << 10) | (str.charCodeAt(i) & 0x3ff));
                utf8.push(0xf0 | (charcode >> 18),
                    0x80 | ((charcode >> 12) & 0x3f),
                    0x80 | ((charcode >> 6) & 0x3f),
                    0x80 | (charcode & 0x3f));
            }
        }
        return utf8;
    }

    function sanitizeLiteralString(str) {
        return str.replace(/\\/g, '\\\\') // escape backslash
            .replace(/"/g, '\\"') // escape double quotes
	    .replace(/[\x7f-\xff\x00-\x1f]/g,function(c){ return '\\'+c.charCodeAt(0) ;})
            /*.replace(/\u00A0/g, " ") // no-break space replaced by regular space
            .replace(/[\0-\u001f\u007F-\uD7FF\uDC00-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]|[\uD800-\uDBFF]/g, // unicode handling
                function (str) {
                    var ut8bytes = toUTF8Array(str);
                    ut8bytes = ut8bytes.map(function (e) {
                        // @string
                        return "\\" + ("00" + e).slice(-3);
                    });
                    return ut8bytes.join("");
                });*/
    }

    function sanitizeRegExpSource(str) {
        return str.replace(/\\/g, '\\\\') // escape backslash
            .replace(/"/g, '\\"') // escape double quotes
            .replace(/\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])/g, // convert "\uXXXX" string to character, then handle it
                function (str, hexaCode) {
                    var chars = String.fromCharCode(parseInt(hexaCode, 16));
                    // @string
                    return "\\" + toUTF8Array(chars).join("\\");
                });
    }

    function compileLiteral(literal, meta) {
        var ret = literal.raw;

        if (literal.value instanceof RegExp) {
            var regexp = literal.value;
            var compiledRegExp = new CompileResult(["_regexp(\""]);

            var source = sanitizeRegExpSource(regexp.source);
            compiledRegExp.push(source);
            compiledRegExp.push("\",\"");

            var flags = "";
            // @string
            flags += regexp.global ? "g" : "";
            // @string
            flags += regexp.ignoreCase ? "i" : "";
            // @string
            flags += regexp.multiline ? "m" : "";
            compiledRegExp.push(flags);
            compiledRegExp.push("\")");

            ret = compiledRegExp.join("");

            if (meta) {
                meta.type = "object";
            }

            return ret;
        }

        switch (typeof (literal.value)) {
        case "string":
            // @string
            ret = '"' + sanitizeLiteralString(literal.value) + '"';
            if (meta) {
                meta.type = "string";
            }
            break;
        case "number":
            // JSON.stringify write numbers in base 10
            // (Lua doesn't handle octal notation)
            ret = JSON.stringify(literal.value);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "boolean":
            if (meta) {
                meta.type = "boolean";
            }
            break;
        }

        return ret;
    }

    /********************
     *
     * Exports
     *
     * ******************/

    exports.compileAST = compileAST;

}));
