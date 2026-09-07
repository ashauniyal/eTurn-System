package operation_implementor;

import operation.UserOperation;
import model.UserPojo;
import DBconfig.GetConnection;

import java.sql.*;

public class UserOperationImpl implements UserOperation {

    @Override
    public boolean registerUser(UserPojo user) {

        String sql = "INSERT INTO Users (name,email,contactNumber,password) VALUES (?,?,?,?)";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getContactNumber());
            ps.setString(4, user.getPassword());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public UserPojo loginUser(String email, String password) {

        String sql = "SELECT * FROM Users WHERE email=? AND password=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserPojo user = new UserPojo();
                user.setUserID(rs.getInt("userID"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setContactNumber(rs.getString("contactNumber"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public UserPojo getUserByEmail(String email) {

        String sql = "SELECT * FROM Users WHERE email=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserPojo user = new UserPojo();
                user.setUserID(rs.getInt("userID"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setContactNumber(rs.getString("contactNumber"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateUser(int userID, UserPojo user) {

        String sql = "UPDATE Users SET name=?, email=?, contactNumber=? WHERE userID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getContactNumber());
            ps.setInt(4, userID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteUser(int userID) {

        String sql = "DELETE FROM Users WHERE userID=?";

        try (Connection con = GetConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}