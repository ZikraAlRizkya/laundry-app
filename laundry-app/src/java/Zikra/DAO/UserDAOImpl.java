package Zikra.DAO;

import Zikra.Model.Edit;
import Zikra.Controller.DBConnection;
import java.sql.ResultSet;

public class UserDAOImpl implements UserDAO {
    @Override
    public Edit getUserById(String userId) {
        Edit user = new Edit();
        DBConnection db = new DBConnection();
        if (db.isConnected) {
            try {
                ResultSet rs = db.getData(
                    "SELECT * FROM users WHERE user_id = '" + userId + "'"
                );
                if (rs.next()) {
                    user.setId(rs.getInt("user_id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setCity(rs.getString("city"));
                    user.setBirthDate(rs.getDate("birth_date"));
                    user.setPhoneNumber(rs.getString("phone"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(rs.getString("password"));
                }
                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                db.disconnect();
            }
        }
        return user;
    }

    @Override
    public void updateUser(Edit user) {
        DBConnection db = new DBConnection();
        if (db.isConnected) {
            String sql = "UPDATE users SET "
                    + "first_name = '" + user.getFirstName() + "', "
                    + "last_name = '" + user.getLastName() + "', "
                    + "city = '" + user.getCity() + "', "
                    + "birth_date = '" + user.getBirthDate() + "', "
                    + "email = '" + user.getEmail() + "' "
                    + "WHERE user_id = '" + user.getId() + "'";
            db.runQuery(sql);
            db.disconnect();
        }
    }
}
