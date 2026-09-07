package model;

public class TokenPojo {

    private int tokenID;
    private String queueID;
    private int tokenNumber;
    private String status;

    public int getTokenID() { return tokenID; }
    public void setTokenID(int tokenID) { this.tokenID = tokenID; }

    public String getQueueID() { return queueID; }
    public void setQueueID(String queueID) { this.queueID = queueID; }

    public int getTokenNumber() { return tokenNumber; }
    public void setTokenNumber(int tokenNumber) { this.tokenNumber = tokenNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}