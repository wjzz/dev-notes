public class Singletons {
    private Singletons() {}

    private final static Singletons instance = new Singletons();

    // factory method
    public static Singletons getInstance() {
        return instance;
    }

    // singleton using enum
    public enum Singleton3 {
        INSTANCE;

        public void greet() {
            System.out.println("hello from singleton3");
        }
    }

    public static void main(String[] args) {
        Singleton3 singleton = Singleton3.INSTANCE;
        singleton.greet();
    }
}
