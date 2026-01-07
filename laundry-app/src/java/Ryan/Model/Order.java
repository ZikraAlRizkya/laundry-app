package Ryan.Model;
import java.sql.Timestamp;
/**
 *
 * @author Lenovo
 */
public class Order {

    private int orderId;
    private Timestamp orderDate;
    private String status;
    private double totalPrice;

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}
