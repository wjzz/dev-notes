// method references

import java.util.function.BinaryOperator;
import java.util.function.Predicate;
import java.util.Arrays;
import java.util.List;

public class Lambda {
    public static void filterList(List<Integer> list, Predicate<Integer> predicate) {
        for (var n : list) {
            if (predicate.test(n)) {
                System.out.println(n);
            }
        }
    }

    public static void pairwise (
        Integer[] arr,
        BinaryOperator<Integer> bin_op
    ) {
        for (int i = 0; i < arr.length-1; ++i) {
            System.out.println(bin_op.apply(arr[i], arr[i+1]));
        }
    }

    public static void main(String[] args) {
        Integer[] arr = new Integer[]{ 1,4,15,3,9,13,22 };
        List<Integer> list = Arrays.asList(arr);

        // version 1: anonymous class
        filterList(list, new Predicate<Integer>(){
           public boolean test(Integer n) {
               return n % 2 == 1;
           }
        });

        System.out.println();

        // version 2: lambda
        filterList(list, n -> n % 2 == 1);

        System.out.println();
        pairwise(arr, (l, r) -> l + r);

        System.out.println();
        pairwise(arr, Integer::compare);

        System.out.println();
        pairwise(arr, Integer::sum);
    }
}
