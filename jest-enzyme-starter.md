# HOWTO get started with testing React apps with Jest and Enzyme (with TypeScript) on linux

Written on 01.08.2019

0. Preliminaries:

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

2. Create (or update) the `src/setupTests.ts` (or .js if you don't use TypeScript) with the following contents:

```
// setup file
import { configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });
```

