# Minimal java project packaged using gradle

## Steps

### 01 Check gradle version

```
$ gradle -v

------------------------------------------------------------
Gradle 7.0
------------------------------------------------------------

Build time:   2021-04-09 22:27:31 UTC
Revision:     d5661e3f0e07a8caff705f1badf79fb5df8022c4

Kotlin:       1.4.31
Groovy:       3.0.7
Ant:          Apache Ant(TM) version 1.10.9 compiled on September 27 2020
JVM:          16.0.1 (Eclipse OpenJ9 openj9-0.26.0)
OS:           Linux 4.15.0-140-generic amd64
```

### 02 Minimal config

`build.gradle`

```
plugins {
    id 'java'
}
```

### 03 Build the project

`$ gradle build`

Build artifacts:

```
$ tree -a build

build
├── classes
│   └── java
│       └── main
│           └── pl
│               └── wjedynak
│                   └── main
│                       └── Application.class
├── generated
│   └── sources
│       ├── annotationProcessor
│       │   └── java
│       │       └── main
│       └── headers
│           └── java
│               └── main
├── libs
│   └── ex_01.jar
└── tmp
    ├── compileJava
    │   └── source-classes-mapping.txt
    └── jar
        └── MANIFEST.MF

18 directories, 4 files
```

### 04 Actually run the application

Add the `application` plugin:

`build.gradle`

```
plugins {
    id 'java'
    id 'application'
}

application {
    mainClass = 'pl.wjedynak.main.Application'
}
```

and run the app using: `$ gradle run`
