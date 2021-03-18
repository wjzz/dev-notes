```
sdk i java # or similar for java 1.8
``` 
```
sdk i gradle
```
```
gradle init
```

**Running the project**
```
./gradlew run # downloades the specified version of gradle
gradle run   # uses the installed version of gradle
```
produces
```
$ gradle run

> Task :app:run
Hello World!

BUILD SUCCESSFUL in 41s
2 actionable tasks: 2 executed
```

**Running the tests**
```
$ gradle test
```
produces
```
BUILD SUCCESSFUL in 550ms
3 actionable tasks: 3 up-to-date
```
