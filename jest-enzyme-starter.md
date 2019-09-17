# HOWTO get started with testing React apps with Jest and Enzyme (with TypeScript) on linux

Written on 01.08.2019

__Table of contents__:

1. [Preliminaries](https://github.com/wjzz/dev-notes/blob/master/jest-enzyme-starter.md#preliminaries)
2. [Install Jest - the test runner (using Create React App)](#initial-setup-with-create-react-app-this-will-install-and-configure-jest-automatically)
3. [Install Enzyme - the renderer for React components](#install-enzyme-for-react-16)
4. [Install React-test-renderer for snapshots](#enable-snapshot-testing)
5. [Install Jest-enzyme to get additional assertions](#install-additional-assertions-with-jest-enzyme)
6. [Enable CI with Travis-CI](#enable-continuos-integration-using-travis-ci)
7. [See the final repo](#final-repo)
8. [Further links](#further-links)

## Preliminaries:

```
$ node --version
v10.16.0
$ npm --version
6.9.0
$ create-react-app --version
3.0.1
```

## Initial setup with Create React App (this will install and configure Jest automatically)

1. Create a new React app using Create React App (CRA)

```
$ create-react-app testing-example                  # normal JavaScript
# or 
$ create-react-app testing-example --typescript     # TypeScript
```

2. Go to the main folder

```
$ cd testing-example
```

3. Run some tests.

CRA comes equipped with Jest and an example test, so we can start by

```
$ npm test     # enters an interactive watch mode
```

The watch mode is very useful for developing, because it will only run the test that need to be rerun after your latest changes. It's not very good for batch on the other hand.

If you want to run the test without interacting (for CI or to integrate with some tooling) you can use:
```
$ CI=true npm test
```

Example output:

```
> testing-example@0.1.0 test /wjzz/learning/testing-example
> react-scripts test

PASS src/App.test.tsx
  ✓ renders without crashing (25ms)

Test Suites: 1 passed, 1 total
Tests:       1 passed, 1 total
Snapshots:   0 total
Time:        1.815s, estimated 2s
Ran all test suites.
```

## Install Enzyme for React 16

Source: 
https://airbnb.io/enzyme/docs/installation/

1. Install Enzyme and the adapter for React 16

```
npm i --save-dev enzyme enzyme-adapter-react-16
```

For TypeScript include the types as well:

```
npm i --save-dev @types/enzyme  @types/enzyme-adapter-react-16
```

2. Create (or update) the `src/setupTests.ts` (or .js if you don't use TypeScript) with the following contents:

```
// setup file
import { configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });
```

3. Use Enzyme in tests.

Update the `src/App.test.tsx` file to become:

```
import React from "react";
import ReactDOM from "react-dom";
import App from "./App";

import { shallow, mount, render } from "enzyme";

it("renders without crashing", () => {
  const div = document.createElement("div");
  ReactDOM.render(<App />, div);
  ReactDOM.unmountComponentAtNode(div);
});

it("works fine with enzyme", () => {
  const wrapper = shallow(<App />);

  expect(wrapper.text()).toContain("Learn React");
});
```

## Enable snapshot testing

We can now go ahead and add some snapshot testing as well:
https://jestjs.io/docs/en/snapshot-testing

```
$ npm install --save-dev react-test-renderer @types/react-test-renderer
```

__Note:__ An alternative package is called [enzyme-to-json](https://github.com/adriantoine/enzyme-to-json), with it you don't need the `component.toJSON();` call.

Update the test file as follows:

```
// ...

import renderer from "react-test-renderer";

test("App is in sync with the snapshot", () => {
  const component = renderer.create(<App />);
  let tree = component.toJSON();
  expect(tree).toMatchSnapshot();
});

// ....

```

If you run the tests now, Jest will create a snapshot in the `src/__snapshot__` directory and during subsequent runs it will check if you haven't changed the snapshot. You will have to update the snapshot after you change the UI - Jest will ask you if it should update it once you run `npm test`. 

__Note:__ I think the snapshots should be put under version control, they document your expectations nicely and snapshot testing will work with CI as well.

```
$ npm test
```

Example output (first run):

```
 PASS  src/App.test.tsx
  ✓ renders without crashing (19ms)
  ✓ works fine with enzyme (5ms)
  ✓ App is in sync with the snapshot (9ms)

 › 1 snapshot written.
Snapshot Summary
 › 1 snapshot written from 1 test suite.

Test Suites: 1 passed, 1 total
Tests:       3 passed, 3 total
Snapshots:   1 written, 1 total
Time:        2.972s
Ran all test suites related to changed files.
```

Example output (second run, no changes to the code):
```
...
PASS src/App.test.tsx
  ✓ renders without crashing (17ms)
  ✓ works fine with enzyme (4ms)
  ✓ App is in sync with the snapshot (8ms)
  
Test Suites: 1 passed, 1 total
Tests:       3 passed, 3 total
Snapshots:   1 passed, 1 total
Time:        1.976s, estimated 2s
Ran all test suites.
```

## Install additional assertions with jest-enzyme

1. Install the package: (`@types/jest-enzyme` is not available but the type definitions seem to be included)

```
$ npm i --save-dev jest-enzyme
```

2. Update the `src/setupTests.ts` file to contain:

```
import "jest-enzyme";
```

3. Now you can use many new assertions:
https://www.npmjs.com/package/jest-enzyme#matchers

For example we can add the following test to `src/App.tests.ts`:

```
it("works fine with jest-enzyme", () => {
  const wrapper = shallow(<App />);

  expect(wrapper).toIncludeText("Learn React");
});
```

And we are done!

## Enable Continuos Integration using Travis CI

1. Create a `travis.yml` file in the root directory of the project:

```
language: node_js
node_js:
  - "10.16"
before_install:
  - npm install -g typescript@3.5
script:
  - npm test
```

2. Put the repo on github

3. Go to [Travis CI Homepage](https://travis-ci.org/), login with your Github credentials and enable CI (the default settings should be enough).

## Final repo

Repo:
https://github.com/wjzz/tutorial-react-jest-enzyme

Another example with some other example tests:
https://github.com/wjzz/cs-books-react

## Further links

To read on mock testing, testing redux applications etc:
https://circleci.com/blog/continuously-testing-react-applications-with-jest-and-enzyme/
