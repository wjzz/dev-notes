interface Logger {
    void log(String msg);
}

class A implements Logger {
    public void log(String msg) {
        System.out.println(msg);
    }
}

class B implements Logger {
    public void log(String msg) {
        System.out.println(msg);
    }
}

public class Interfaces {
    public static void log_twice(Logger logger, String msg) {
        logger.log(msg);
        logger.log(msg);
    }

    public static void main(String[] args) {

    }
}