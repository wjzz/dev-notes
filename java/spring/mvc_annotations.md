# Spring MVC

Docs: https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/mvc.html

## Model

```java
public String controller(Model model) { ... }
```

## ModelAttribute

```java
public String controller(@ModelAttribute("pet") Pet pet) { ... }
```
Fetches the given attribute from the model

## Template

```java
public String controller() { ... }
```
