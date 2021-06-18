import java.util.stream.Stream;
import java.math.BigInteger;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Streams {
    public static void print_squares() {
        Stream<Integer> stream = Stream.of(1,2,3,4,5);

        stream
            .map(n -> n * n)
            .forEach(System.out::println);
    }

    public static void sum_squares() {
        int sum = IntStream
            .of(1,2,3,4,5)
            .map(n -> n * n)
            .sum();
            // when using Integers
            // .collect(Collectors.reducing(0, Integer::sum));
        System.out.println("sum = " + sum);
    }

    public static void infinite_stream() {
        Stream
            .generate(Math::random)
            .map(d -> Math.round(100 * d))
            .limit(10)
            .sorted()
            .takeWhile(n -> n < 25)
            .forEach(System.out::println);
    }

    public static void main(String[] args) {
        // print_squares();
        // sum_squares();
        infinite_stream();
    }
}
