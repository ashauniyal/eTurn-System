package operation_implementor;

import operation.NotificationOperation;
import model.NotificationPojo;
import DBconfig.GetConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationOperationImpl implements NotificationOperation {

    @Override
    public List<NotificationPojo> getNotificationsByUser(int userID) {

        List<NotificationPojo> list = new ArrayList<>();

        try {
            Connection con = GetConnection.getConnection();

            String sql = "SELECT n.* FROM Notification n " +
                         "JOIN Token t ON n.tokenID = t.tokenID " +
                         "WHERE t.userID=? ORDER BY n.createdAt DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                NotificationPojo n = new NotificationPojo();
                n.setNotificationID(rs.getInt("notificationID"));
                n.setTokenID(rs.getInt("tokenID"));
                n.setMessage(rs.getString("message"));
                n.setStatus(rs.getString("status"));
                n.setCreatedAt(rs.getString("createdAt"));

                list.add(n);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}