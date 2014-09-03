var assert = require("assert");

var err, path = false,
    path2 = false,
    path3 = false;
try {
    throw "Error"
} catch (e) {
    err = e;
}
assert(err === "Error");

try {
    path = true;
} catch (e) {
    assert(false);
}
assert(path);

path = false;
try {
    var uselesss = 21;
} finally {
    path = true;
}
assert(path);

// Return statement in catch
function f() {
    try {
        throw "An error";
    } catch (e) {
        return false;
    } finally {
        return true;
    }
}

assert(f());

// Return statement in try
function f2() {
    try {
        return false
    } catch (e) {} finally {
        return true;
    }
}

assert(f2());

// Catch clause rethrow exception (or throw a new one)
path = false;

function f3() {
    try {
        throw "An error";
    } catch (e) {
        // Rethrow
        throw e;
    } finally {
        path = true;
    }
}

try {
    f3();
} catch (e) {}

assert(path);

// No catch clause for the thrown exception
path = false;

function f4() {
    try {
        throw "An error";
    } finally {
        path = true;
    }
}

try {
    f4();
} catch (e) {}

assert(path);

// Try catch inside a loop with break/continue

var i, finallyCount = 0;
for (i = 0; i < 3; ++i) {
    try {
        break;
        assert(false);
    } catch (e) {
        assert(false);
    } finally {
        finallyCount++;
    }
}

assert(finallyCount === 1);

finallyCount = 0;
for (i = 0; i < 3; ++i) {
    try {
        continue;
        assert(false);
    } catch (e) {
        assert(false);
    } finally {
        finallyCount++;
    }
}
assert(finallyCount === 3);

// Try in a try

path = false;
path2 = false;
try {
    try {
        throw "An error";
    } catch (e) {
        // Rethrow
        throw e;
    } finally {
        path = true;
    }
} catch (e) {
    path2 = true;
}
assert(path && path2);

// Try in try in try
path = false;
path2 = false;
path3 = false;

try {
    try {
        try {
            throw "An error";
        } catch (e) {
            // Rethrow
            throw e;
        } finally {
            path = true;
        }
    } catch (e) {
        throw e;
        path2 = true;
    }
} catch (e) {
    path3 = true;
}
assert(path && path3);
assert(!path2);
