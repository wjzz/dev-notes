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

3. CRA comes equipped with an example test, so we can start by

```
$ npm test     # enters an interactive watch mode
```


