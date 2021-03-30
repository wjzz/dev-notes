public class Singleton1 {
    private Singleton1() {}

    private static Singleton1 instance = null;

    // factory method
    public static Singleton1 getInstance() {
        if (instance == null) {
            instance = new Singleton1();
        }
        return instance;
    }
}
