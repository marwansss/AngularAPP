function greet(name) {
    return `hello, ${name}!`;  // use backticks for interpolation
}

module.exports = greet;  // export the function

// Only runs if this file is executed directly: `node app.js`
if (require.main === module) {
    console.log(greet("world"));
}
