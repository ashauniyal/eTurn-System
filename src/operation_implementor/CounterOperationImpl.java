package operation_implementor;

import operation.CounterOperation;
import model.CounterPojo;
import model.QueuePojo;
import DBconfig.GetConnection;

import java.sql.*;
import java.util.*;

public class CounterOperationImpl implements CounterOperation {

    @Override
    public boolean addCounter(CounterPojo counter) {

        String sql = "INSERT INTO Counter (counterID, serviceType, status) VALUES (?,?,?)";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, counter.getCounterID());
            ps.setString(2, counter.getServiceType());
            ps.setString(3, counter.getStatus());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<CounterPojo> getAllCounters() {

        List<CounterPojo> list = new ArrayList<>();

        String sql = "SELECT * FROM Counter";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while(rs.next()){
                CounterPojo c = new CounterPojo();
                c.setCounterID(rs.getString("counterID"));
                c.setServiceType(rs.getString("serviceType"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public boolean updateStatus(String counterID, String status) {

        String sql = "UPDATE Counter SET status=? WHERE counterID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, counterID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteCounter(String counterID) {

        String sql = "DELETE FROM Counter WHERE counterID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, counterID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

	@Override
	public List<QueuePojo> getAllQueuesWithService() {
		List<QueuePojo> list = new ArrayList<>();

	    try {
	        Connection con = GetConnection.getConnection();

	        String sql = "SELECT q.queueID, c.serviceType " +
	                     "FROM Queue q " +
	                     "JOIN Counter c ON q.counterID = c.counterID";

	        PreparedStatement ps = con.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        while(rs.next()) {
	            QueuePojo q = new QueuePojo();
	            q.setQueueID(rs.getString("queueID"));
	            q.setServiceType(rs.getString("serviceType")); // add this field
	            list.add(q);
	        }

	    } catch(Exception e){
	        e.printStackTrace();
	    }

	    return list;

	}
}