package operation_implementor;

import operation.AdminOperation;
import model.AdminPojo;
import DBconfig.GetConnection;

import java.sql.*;
import java.util.*;

public class AdminOperationImpl implements AdminOperation {

    @Override
    public AdminPojo loginAdmin(String username, String password) {

        String sql = "SELECT * FROM Admin WHERE username=? AND password=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                AdminPojo admin = new AdminPojo();
                admin.setAdminID(rs.getInt("adminID"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setRole(rs.getString("role"));
                return admin;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean callNextToken(String queueID) {

        String sql = "{CALL CallNextToken(?)}";

        try (Connection con = GetConnection.getConnection();
             CallableStatement cs = con.prepareCall(sql)) {

            cs.setString(1, queueID);
            cs.execute();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<String> getAllQueues() {

        List<String> queues = new ArrayList<>();

        String sql = "SELECT queueID FROM Queue";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                queues.add(rs.getString("queueID"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return queues;
    }
}