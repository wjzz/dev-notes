# Spring MVC

Docs: https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/mvc.html

Supported controller method argument types: https://docs.spring.io/spring-framework/docs/3.2.x/spring-framework-reference/html/mvc.html#mvc-ann-arguments

## Classical servlet style

We can still use the old Servlet style by declaring the `HttpServletRequest` and `HttpServletResponse` parameters in the controller. Spring will automatically inject the proper values here.

```java
@GetMapping("/old")
public void testOldPatternsPage(HttpServletRequest request, HttpServletResponse response) throws IOException {
    final Optional<String> value = Arrays
            .stream(request.getCookies())
            .filter(cookie -> cookie.getName().equals("JSESSIONID"))
            .map(cookie -> cookie.getValue())
            .findFirst();
    String cookieValue = value.orElse("cookie was not found");

    PrintWriter out = response.getWriter();
    out.println("This is an example response.");
    out.println("The value of the JESSIONID cookie is: " + cookieValue);
    out.flush();
}
```

While we can continue using this old style, the annotation provided to us by Spring MVC allow us to write much shorter and cleaner code.

## Cookies

Docs: https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/bind/annotation/CookieValue.html


```java
public String controller(@CookieValue("JSESSIONID") String sessionID) { ... }
```

This will get the cookie and if the cookie is not found, it will throw an Exception.

To mark the cookie optional, we pass an additional argument to the annotation:

```java
public String controller(@CookieValue("JSESSIONID") String sessionID, required=false) { ... }
```

Now if the cookie is not present, a `null` value will be passed. We can additionally add a default value:
```java
@CookieValue(value="JSESSIONID", required=false, defaultValue = "defaultValue") String sessionID) {
```

Finally, we can use the `Optional<String>` type:
```java
@CookieValue("JSESSIONID") Optional<String> sessionID) {
```

## Request params (query parameters)

To get the value of a query parameter (eg. the value of `id` from `/debug?id=123` would be '123') we use the `@RequestParam` annotation:

```java
public String controller(@RequestParam("id") String id) { ... }
```
As with cookies, this makes the parameter required and will throw an exception when the parameter is missing. We can relax this restriction by using:

```java
@RequestParam(value="id", required=false, defaultValue = "defaultValue") String id) {
```

## Path variables

To get the value of a path variable we use the @PathVariable annotation (https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/bind/annotation/PathVariable.html):

```java
@GetMapping("/hello/{id}")
public String controller(@PathVariable("id") String id) { ... }
```

This makes the path variable required. To handle a case where the path variable is optional, we use a get mapping with multiple URLs:

```java
@GetMapping({"/hello/{id}", "/hello"})
public String controller(@PathVariable(value="id", required=false) String id) { ... }
```

`id` will be `null` when `GET /hello` is performed. We can change the String type to `Optional<String>` as well (the `required=false` is not necessary):

```java
@GetMapping({"/hello/{id}", "/hello"})
public String testPage(@PathVariable("id") Optional<String> id) { ... }    
```

The second way is a bit shorter and perphaps more type safe.

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
