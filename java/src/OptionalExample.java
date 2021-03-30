import java.util.Optional;

public class OptionalExample {
    public static void main(String[] args) {
        Optional<String> empty = Optional.empty();

        // raises exception
        // empty.get();

        assert empty.isEmpty();
        assert !empty.isPresent();
        assert empty.orElse("123") == "123";
        assert empty.or(() -> Optional.of("444"))
          .equals(Optional.of("444"));

        // raises an exception
        // Optional<String> nullish_ = Optional.of(null);

        Optional<String> nullish = Optional.ofNullable(null);
        assert nullish.isEmpty();

        Optional.of(123).ifPresent(System.out::println);
    }
}
