package lk.ijse.hasaonlinestore.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class OrderDTO {
    private String userID;
    private int itemCode;
    private int qty;
    private double unitPrice;
    private double subtotal;

}
