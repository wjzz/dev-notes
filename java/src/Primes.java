import java.util.BitSet;
import java.util.Optional;

public class Primes {
    public static boolean isPrime(long n) {
        if (n <= 1) return false;

        if (n == 2) return true;
        if (n % 2 == 0) return false;

        long root = Math.round(Math.sqrt((double)n));
        for (long d = 3; d <= root; d += 2) {
            if (n % d == 0)
                return false;
        }
        return true;
    }

    public static long primeCount(long upperBound) {
        long count = 0;
        for (long i = 2; i <= upperBound; i++) {
            if (isPrime(i)) {
                count++;
            }
        }
        return count;
    }

    public static long sieveCount(long upperBound) {
        if (upperBound < 10) {
            return primeCount(upperBound);
        }

        boolean composite[] = new boolean[(int)upperBound + 1];
        composite[1] = composite[0] = true;

        for (int n = 4; n <= upperBound; n += 2) {
            composite[n] = true;
        }

        for (int n = 3; n <= upperBound; n += 2) {
            if (!composite[n]) {
                for (int m = n + n; m <= upperBound; m += n) {
                    composite[m] = true;
                }
            }
        }

        long count = 0;
        for (boolean isComposite : composite) {
            if (!isComposite) {
                count++;
            }
        }

        return count;
    }

    public static long sieveCountBitSet(long upperBound) {
        if (upperBound < 10) {
            return primeCount(upperBound);
        }
        BitSet composite = new BitSet((int)upperBound + 1);
        composite.set(0);
        composite.set(1);

        for (int n = 4; n <= upperBound; n += 2) {
            composite.set(n);
        }

        for (int n = 3; n <= upperBound; n += 2) {
            if (!composite.get(n)) {
                for (int m = n + n; m <= upperBound; m += n) {
                    composite.set(m);
                }
            }
        }

        long count = upperBound+1 - composite.cardinality();
        return count;
    }


    static class PrimesTest {
        public static void test_isPrime() {
            assert !isPrime(-1);
            assert !isPrime(0);
            assert !isPrime(1);

            assert isPrime(2);
            assert isPrime(3);

            assert !isPrime(4);
            assert !isPrime(9);

            assert isPrime(11);
        }

        interface PrimeCounter {
            long count(long upperBound);
        }

        public static void test_primeCount(PrimeCounter counter) {
            assert counter.count(0) == 0;
            assert counter.count(10) == 4;
            assert counter.count(100) == 25;
            assert counter.count(1000 * 1000) == 78498;
        }

        public static void main() {
            System.out.println("Testing...");
            test_isPrime();
            test_primeCount(Primes::primeCount);
            test_primeCount(Primes::sieveCount);
            test_primeCount(Primes::sieveCountBitSet);
        }
    }

    public static void main(String[] args) {
        Optional<Long> upperBound = Optional.empty();
        String method = "slow";

        if (args.length > 0) {
            method = args[0];
            if (args.length > 1) {
                upperBound = Optional.of((long)Integer.parseInt(args[1]));
            } else {
                upperBound = Optional.of(100L);
            }
        }

        if (upperBound.isPresent()) {
            long count;
            if (method.equals("slow")) {
                count = primeCount(upperBound.get());
            } else if (method.equals("bit")) {
                count = sieveCountBitSet(upperBound.get());
            } {
                count = sieveCount(upperBound.get());
            }
            System.out.println(count);
        } else {
            PrimesTest.main();
        }
    }
}
