package operation_implementor;

import operation.TokenOperation;
import model.TokenPojo;
import DBconfig.GetConnection;

import java.sql.*;

public class TokenOperationImpl implements TokenOperation {

    Connection con = null;

    @Override
    public boolean joinQueue(String queueID, int userID) {

        con = GetConnection.getConnection();

        try {
            String sql = "CALL GenerateToken(?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, queueID);
            ps.setInt(2, userID);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isUserTokenCalled(int userID) {

        con = GetConnection.getConnection();

        try {
            String sql = "SELECT * FROM Token WHERE userID=? AND status='Called'";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public TokenPojo getUserActiveToken(int userID) {

        con = GetConnection.getConnection();

        try {
            String sql = "SELECT * FROM Token WHERE userID=? AND status IN ('Waiting','Called') LIMIT 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                TokenPojo token = new TokenPojo();
                token.setTokenID(rs.getInt("tokenID"));
                token.setQueueID(rs.getString("queueID"));
                token.setTokenNumber(rs.getInt("tokenNumber"));
                token.setStatus(rs.getString("status"));
                return token;
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return null;
    }
}