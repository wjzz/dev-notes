import java.util.Arrays;

public class Enums {
    public enum MembershipType {
        // non-logged in user
        NONE,

        // free account
        FREE,

        // paid account
        PREMIUM,
    }

    public static void allTypes() {
        MembershipType[] all_types = {
            MembershipType.NONE,
            MembershipType.FREE,
            MembershipType.PREMIUM
        };

        // classic foreach loop
        for (MembershipType type : all_types) {
            System.out.println(type);
        }

        // java 8-style forEach
        // not available for arrays!!
        // all_types.stream().forEach(type -> {
        //     System.out.println(type);
        // });

        Arrays.asList(all_types).forEach(type ->
            System.out.println(type.ordinal())
        );
    }

    public static void main(String[] args) {
        allTypes();
    }
}
