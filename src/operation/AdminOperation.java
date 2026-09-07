package operation;

import model.AdminPojo;
import java.util.List;

public interface AdminOperation {

    AdminPojo loginAdmin(String username, String password);

    boolean callNextToken(String queueID);

    List<String> getAllQueues();
}