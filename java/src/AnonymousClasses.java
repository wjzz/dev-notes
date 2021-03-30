public class AnonymousClasses {
    interface Greeter {
        public void greet();
    }


    public static void main(String[] args) {
        final class PolishGreeter implements Greeter {
            @Override
            public void greet() {
                System.out.println("Cześć!");
            }
        }

        Greeter polish = new PolishGreeter();
        polish.greet();

        // anonymous class
        Greeter english = new Greeter() {
            @Override
            public void greet() {
                System.out.println("Hello!");
            }
        };
        english.greet();
    }
}
