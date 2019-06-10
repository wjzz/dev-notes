# HOWTO intergrate mocha and chai to a node.js project

1. Initialize a new project

```
$ npm init
```

2. Install mocha and chai

```
$ npm install --save-dev mocha chai
```

3. Create a command to run the tests

In `package.json` update the `test` command like this:

```
  "scripts": {
    "test": "mocha --watch || true"
  },
```

4. Create some example files:

* Create a file *app.js* with the following content:

```
module.exports = {
    myFun: () => "hello"
}
```

* Create a `test` directory with a *appTest.js* file inside with the following content:
```
const myFun = require("../app").myFun;
const expect = require('chai').expect;

describe('App', () => {
    it('myFun should return hello', () => {
        const result = myFun();
        expect(result).to.equal("hello");
    })
});
```


5. To run the tests, run:

```
$ npm test
```

*Note*: The `--watch` flag helps a lot with live-coding.
*Note*: The ` || true` part silences the npm (it will print an stack trace when a test fails).

# HOWTO Generate nice HTML reports

1. Install [`mochawesome`](https://www.npmjs.com/package/mochawesome)

```
$ npm install --save-dev mochawesome
```

2. Update the `package.json` like this:

```
  "scripts": {
    "test": "mocha --watch --reporter mochawesome --reporter-options json=false,quiet=true || true"
  },
```

For details, see the [mochawesome documentation](https://www.npmjs.com/package/mochawesome), it's very simple and nice.

3. The html documentation will be automatically generated every time you run

```
$ npm test
```

(in watch mode it will be regenerated automatically after each change. To enable autorefresh in the browser you can use e.g. the Live-server package in Visual Studio Code).
