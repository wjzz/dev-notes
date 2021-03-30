import java.util.Arrays;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class Collections {
    public static void sortCmdArgs(String[] args) {
        int[] args2 = new int[args.length];

        for (int i = 0; i < args.length; ++i) {
            args2[i] = Integer.parseInt(args[i]);
        }

        Arrays.sort(args2);

        for (int i = 0; i < args2.length; ++i) {
            System.out.println(args2[i]);
        }
    }

    public static void example() {
        int[] small_primes = { 2, 3, 5, 7, 11, 13, 17, 19, 23 };

        List<Integer> list_sp = Arrays.asList(small_primes);
    }

    public static void sets() {
        Set<Integer> visited = new Set<Integer>();
    }

    public static void main(String[] args) {
        sortCmdArgs(args);
    }
}
