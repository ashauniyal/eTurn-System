package operation_implementor;

import operation.QueueOperation;
import model.QueuePojo;
import DBconfig.GetConnection;

import java.sql.*;
import java.util.*;

public class QueueOperationImpl implements QueueOperation {

    @Override
    public boolean createQueue(QueuePojo queue) {

        String sql = "INSERT INTO Queue (queueID, counterID, currentToken) VALUES (?,?,0)";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, queue.getQueueID());
            ps.setString(2, queue.getCounterID());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<QueuePojo> getAllQueues() {

        List<QueuePojo> list = new ArrayList<>();

        String sql = "SELECT * FROM Queue";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while(rs.next()){

                QueuePojo q = new QueuePojo();
                q.setQueueID(rs.getString("queueID"));
                q.setCounterID(rs.getString("counterID"));
                q.setCurrentToken(rs.getInt("currentToken"));

                list.add(q);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public QueuePojo getQueueByID(String queueID) {

        String sql = "SELECT * FROM Queue WHERE queueID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, queueID);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){

                QueuePojo q = new QueuePojo();
                q.setQueueID(rs.getString("queueID"));
                q.setCounterID(rs.getString("counterID"));
                q.setCurrentToken(rs.getInt("currentToken"));

                return q;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean deleteQueue(String queueID) {

        String sql = "DELETE FROM Queue WHERE queueID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, queueID);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}