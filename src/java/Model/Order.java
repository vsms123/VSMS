package Model;

import java.util.ArrayList;
import java.util.Date;

public class Order {

    private int order_id;
    private int vendor_id;
    private double total_final_price;
    private Date dt_order;
    private ArrayList<Orderline> orderlines;
    private String status; //status will have 3 values "Approved","Rejected","Pending" in proper case

    public Order(int order_id, int vendor_id, double total_final_price, Date dt_order, String status,ArrayList<Orderline> orderlines) {
        this.order_id = order_id;
        this.vendor_id = vendor_id;
        this.total_final_price = total_final_price;
        this.dt_order = dt_order;
        this.status = status;
        this.orderlines = orderlines;
    }

    public Order(int order_id, int vendor_id, double total_final_price, Date dt_order, String status) {
        this.order_id = order_id;
        this.vendor_id = vendor_id;
        this.total_final_price = total_final_price;
        this.orderlines = orderlines;
        this.status = status;
    }
    public void addOrderlines (Orderline orderline){
        this.orderlines.add(orderline);
    }

    public int getOrder_id() {
        return order_id;
    }

    public int getVendor_id() {
        return vendor_id;
    }

    public double getTotal_final_price() {
        return total_final_price;
    }

    public ArrayList<Orderline> getOrderlines() {
        return orderlines;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public void setVendor_id(int vendor_id) {
        this.vendor_id = vendor_id;
    }

    public void setTotal_final_price(double total_final_price) {
        this.total_final_price = total_final_price;
    }

    public void setOrderlines(ArrayList<Orderline> orderlines) {
        this.orderlines = orderlines;
    }

    public Date getDtOrder() {
        return dt_order;
    }

    public void setDtOrder(Date dt_order) {
        this.dt_order = dt_order;
    }
    public String getStatus(){
        return status;
    }
    public void setStatus(String status){
        this.status = status;
    }

    public String toString() {
        return "Order_id: " + order_id + "Vendor_id: " + vendor_id + "Total final price: " + total_final_price+"The status is "+status+" the OrderTime is "+dt_order.toString();
    }
    @Override
    public int hashCode() {
        return order_id;
    }

    @Override
    public boolean equals(Object o) {
        return ((Order) o).order_id == this.order_id;
    }
}
