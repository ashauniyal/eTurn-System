package operation;

import model.QueuePojo;
import java.util.List;

public interface QueueOperation {

    boolean createQueue(QueuePojo queue);

    List<QueuePojo> getAllQueues();

    QueuePojo getQueueByID(String queueID);

    boolean deleteQueue(String queueID);
}