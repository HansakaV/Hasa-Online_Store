package lk.ijse.hasaonlinestore.model;

import java.util.Arrays;

public class OrderRequest {
    private String fullName;
    private String address;
    private String phone;
    private OrderItem[] items;

    public OrderRequest() {
    }

    public OrderRequest(String fullName, String address, String phone, OrderItem[] items) {
        this.fullName = fullName;
        this.address = address;
        this.phone = phone;
        this.items = items;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public OrderItem[] getItems() {
        return items;
    }

    public void setItems(OrderItem[] items) {
        this.items = items;
    }

    @Override
    public String toString() {
        return "OrderRequest{" +
                "fullName='" + fullName + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", items=" + Arrays.toString(items) +
                '}';
    }
}
