package Zikra.DAO;
import Zikra.Model.Edit;

public interface UserDAO {
    Edit getUserById(String userId);
    void updateUser(Edit user);
}