package operation;

import model.NotificationPojo;
import java.util.List;

public interface NotificationOperation {

    List<NotificationPojo> getNotificationsByUser(int userID);

}