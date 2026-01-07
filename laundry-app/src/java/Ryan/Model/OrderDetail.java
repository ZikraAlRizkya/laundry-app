package Ryan.Model;

/**
 *
 * @author Lenovo
 */

public class OrderDetail {

    private int orderId;
    private int serviceId;
    private double quantity;
    private double price;
    private double subtotal;

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }
}
