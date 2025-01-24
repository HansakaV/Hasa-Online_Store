package lk.ijse.hasaonlinestore.Controller;

import jakarta.annotation.Resource;
import lk.ijse.hasaonlinestore.dto.ItemDTO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ItemController", value = "/ItemController")
public class ItemController extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads";
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 5;      // 5MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 10;  // 10MB

    @Resource(name = "jdbc/Pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!ServletFileUpload.isMultipartContent(request)) {
            sendError(response, "Request must be multipart/form-data");
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists() && !uploadDir.mkdirs()) {
            sendError(response, "Failed to create upload directory");
            return;
        }

        try {
            ItemDTO itemDTO = new ItemDTO();
            String action = "";

            List<FileItem> formItems = upload.parseRequest(request);

            // First pass: Process form fields
            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    processFormField(item, itemDTO);
                    if (item.getFieldName().equals("action")) {
                        action = item.getString("UTF-8");
                    }
                }
            }

            // Second pass: Process files
            for (FileItem item : formItems) {
                if (!item.isFormField() && !item.getName().isEmpty()) {
                    processFileItem(item, uploadPath, itemDTO);
                }
            }

            boolean operationResult = performDatabaseOperation(action, itemDTO);

            if (operationResult) {
                response.sendRedirect("itemManagement.jsp?success=true");
            } else {
                response.sendRedirect("itemManagement.jsp?error=" + URLEncoder.encode("Operation failed", "UTF-8"));
            }

        } catch (FileUploadException e) {
            handleUploadError(response, "File upload error: " + e.getMessage());
        } catch (Exception e) {
            handleUploadError(response, "Server error: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void processFormField(FileItem item, ItemDTO itemDTO) throws Exception {
        String fieldName = item.getFieldName();
        String value = item.getString("UTF-8");

        switch (fieldName) {
            case "itemName":
                itemDTO.setItemName(value);
                break;
            case "itemCategory":
                itemDTO.setCategory(value);
                break;
            case "itemBrand":
                itemDTO.setBrand(value);
                break;
            case "itemDescription":
                itemDTO.setDescription(value);
                break;
            case "itemPrice":
                itemDTO.setUnitPrice(Double.parseDouble(value));
                break;
            case "itemQty":
                itemDTO.setQtyOnHand(Integer.parseInt(value));
                break;
        }
    }

    private void processFileItem(FileItem item, String uploadPath, ItemDTO itemDTO) throws Exception {
        String fileName = System.currentTimeMillis() + "_" + new File(item.getName()).getName();
        File storeFile = new File(uploadPath + File.separator + fileName);

        // Ensure parent directories exist
        if (!storeFile.getParentFile().exists()) {
            storeFile.getParentFile().mkdirs();
        }

        item.write(storeFile);
        itemDTO.setImagePath(UPLOAD_DIRECTORY + "/" + fileName);
    }

    private boolean performDatabaseOperation(String action, ItemDTO itemDTO) throws SQLException {
        switch (action.toLowerCase()) {
            case "save":
                return saveItem(itemDTO);
            case "update":
                return updateItem(itemDTO);
            case "delete":
                return deleteItem(itemDTO);
            default:
                return false;
        }
    }

    private boolean saveItem(ItemDTO item) throws SQLException {
        String sql = "INSERT INTO item " +
                "(item_name, category, description, unit_price, qty_on_hand, brand, image_path) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, item.getItemName());
            pstm.setString(2, item.getCategory());
            pstm.setString(3, item.getDescription());
            pstm.setDouble(4, item.getUnitPrice());
            pstm.setInt(5, item.getQtyOnHand());
            pstm.setString(6, item.getBrand());
            pstm.setString(7, item.getImagePath());

            return pstm.executeUpdate() > 0;
        }
    }

    private boolean updateItem(ItemDTO item) throws SQLException {
        String sql = "UPDATE item SET " +
                "category = ?, description = ?, unit_price = ?, " +
                "qty_on_hand = ?, brand = ?, image_path = ? " +
                "WHERE item_name = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, item.getCategory());
            pstm.setString(2, item.getDescription());
            pstm.setDouble(3, item.getUnitPrice());
            pstm.setInt(4, item.getQtyOnHand());
            pstm.setString(5, item.getBrand());
            pstm.setString(6, item.getImagePath());
            pstm.setString(7, item.getItemName());

            return pstm.executeUpdate() > 0;
        }
    }

    private boolean deleteItem(ItemDTO item) throws SQLException {
        String sql = "DELETE FROM item WHERE item_name = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql)) {

            pstm.setString(1, item.getItemName());
            return pstm.executeUpdate() > 0;
        }
    }

    private void sendError(HttpServletResponse response, String message) throws IOException {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, message);
    }

    private void handleUploadError(HttpServletResponse response, String message) throws IOException {
        response.sendRedirect("itemManagement.jsp?error=" + URLEncoder.encode(message, "UTF-8"));
    }
}