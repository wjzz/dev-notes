import java.util.*;

public class TwoDimArrays {
    public final static int MAX_BOUND = 100;
    
    public static void main(String[] args) {
	var rand = new Random();
	
	int size = Integer.parseInt(args[0]);

	int[][] arr = new int[size][];
	
	for (int i = 0; i < size; ++i) {
	    arr[i] = new int[size];
	}
	
	for (int i = 0; i < size; ++i) {
	    for (int j = 0; j < size; ++j) {
		arr[i][j] = rand.nextInt(MAX_BOUND);
	    }
	}
	
	for (int[] line : arr) {
	    System.out.println(Arrays.toString(line));
	}
    }
}
