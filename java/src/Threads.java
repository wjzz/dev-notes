import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;

public class Threads {
    public static void main(String[] args) {
	for (int i = 0; i < 3; ++i) {
	    Thread t1 = new Thread(new Phil());
	    t1.start();
	}
    }
}

class Phil implements Runnable {
    public static List<Long> history = new LinkedList<>();
    public static int counter = 0;

    public static Lock print_lock = new ReentrantLock();

    public final int id;

    public Phil() {
	id = Phil.counter++;
    }
    
    @Override
    public void run() {
	while(true) {
	    try {
		Thread.sleep(100 *(1+id));
	    } catch (Exception e) {
	    }
	    Phil.print_lock.lock();
	    try {
		System.out.println("Hello from " + id);
		var history = Phil.history;
		history.add((long)id);
		System.out.println(history.toString());
	    } finally {
		Phil.print_lock.unlock();
	    }
	}
    }
}
