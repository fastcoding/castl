var assert = require("assert");
function outer1()
{
  return outer();
}
function outer()
{
    return function inner(x) {
         if(x == 10)
              return x;
         return inner.call(x, x+1);
    }(0);
}
assert(outer1()===10);
