public class InterfaceMethods {
    interface Monoid<T> {
        T zero();
        T add(T a, T b);

        default T sum(Iterable<T> iterable) {
            T result = zero();
            for (T a : iterable) {
                result = add(result, a);
            }

            return result;
        }
    }
}
