package model;

public class QueuePojo {

    private String queueID;
    private String counterID;
    private int currentToken;
    private String serviceType;
    
    public String getQueueID() { return queueID; }
    public void setQueueID(String queueID) { this.queueID = queueID; }

    public String getCounterID() { return counterID; }
    public void setCounterID(String counterID) { this.counterID = counterID; }

    public int getCurrentToken() { return currentToken; }
    public void setCurrentToken(int currentToken) { this.currentToken = currentToken; }
    
    public String getServiceType() {return serviceType;}
    public void setServiceType(String serviceType) {this.serviceType = serviceType;}
}