class AA {
    public String greet() {
        return "A";
    }
}

class BB extends AA {
    // methods are virtual by default
    public String greet() {
        return "B";
    }
}

public class Inheritance {
    public static void main(String[] args) {
        AA a1 = new AA();
        System.out.println(a1.greet());

        AA a2 = new BB();
        System.out.println(a2.greet());
    }
}
