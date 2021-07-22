package pl.wjedynak.main;

public class Application {
    public static void main(String[] args) {
        System.out.println("Hello, World!");

        Person person = new Person();
        person.setName("Wojtek");
        person.setAge(33);
        System.out.println(person);
    }
}
