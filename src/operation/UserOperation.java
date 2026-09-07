package operation;

import model.UserPojo;

public interface UserOperation {

    boolean registerUser(UserPojo user);

    UserPojo loginUser(String email, String password);

    UserPojo getUserByEmail(String email);

    boolean updateUser(int userID, UserPojo user);

    boolean deleteUser(int userID);
}