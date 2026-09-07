package operation;

import model.CounterPojo;
import model.QueuePojo;

import java.util.List;

public interface CounterOperation {

    boolean addCounter(CounterPojo counter);

    List<CounterPojo> getAllCounters();

    List<QueuePojo> getAllQueuesWithService();
    
    boolean updateStatus(String counterID, String status);

    boolean deleteCounter(String counterID);
}