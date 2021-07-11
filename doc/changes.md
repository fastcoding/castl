Bugfixes and limits
==========
-  Created local variable for function name in expression
```js
var outer=(function inner_name(){
    //now can reference inner_name from inside the body
 }) 

```
-  Work around the lua's limit on maximum number of locals (200) and upvalues (60).  
   All var/const are moved into a single _local<stacknumber> table. However, this fix brings an issue to eval function. The original test script test/eval.js will fail.

- Only tested with luajit-2.1-beta3


