# Spring MVC

Docs: https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/mvc.html

## Cookie

```java
public String controller(@CookieValue("JSESSIONID") String sessionID) { ... }
```

This will get the cookie and if the cookie is not found, it will throw an Exception.

To mark the cookie optional, we pass an additional argument to the annotation:

```java
public String controller(@CookieValue("JSESSIONID") String sessionID, required=false) { ... }
```

Now if the cookie is not present, a `null` value will be passed. We can also change the `String` type to `Optional<String>`.

Another option is to add a default value:
```java
@CookieValue(value="JSESSIONID123", required=false, defaultValue = "defaultValue") String sessionID) {
```

## Model

```java
public String controller(Model model) { ... }

model.asMap() // get all attributes
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
