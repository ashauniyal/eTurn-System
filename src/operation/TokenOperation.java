package operation;

import model.TokenPojo;

public interface TokenOperation {

    boolean joinQueue(String queueID, int userID);

    boolean isUserTokenCalled(int userID);

    TokenPojo getUserActiveToken(int userID);
}