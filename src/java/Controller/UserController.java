package Controller;

import DAO.UserDAO;
import Model.Supplier;
import Model.Vendor;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import javamail.EmailController;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

    @WebServlet("/userservlet/*")
public class UserController extends HttpServlet {

    @Override
    //doGet will be given to FavouriteSuppliers.jsp
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Will receive vendor id and supplier id interested
        String vendor_idStr = request.getParameter("vendor_id");
        String action = request.getParameter("action");
        String supplier_idStr = request.getParameter("supplier_id");
        if (!UtilityController.checkNullStringArray(new String[]{vendor_idStr,supplier_idStr})) {
            int vendor_id =UtilityController.convertStringtoInt(vendor_idStr);
            int supplier_id = UtilityController.convertStringtoInt(supplier_idStr);
            if(action.equals("delete")){
                deleteFavouriteSupplier(vendor_id,supplier_id);
            } else{ //create
                saveAsFavouriteSupplier(vendor_id,supplier_id);
            }
            response.sendRedirect("FavouriteSuppliers.jsp");
        }


        response.setContentType("text/plain");  // Set content type of the response so that AJAX knows what it can expect.
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("");       // Write response body.
    }

    public static ArrayList<Supplier> retrieveSupplierList() {
        return UserDAO.retrieveSupplierList();
    }

    public static Supplier loginSupplier(String supplier_name, String password) {
        return UserDAO.loginSupplier(supplier_name, password);
    }

    public static void signUpSupplier(Supplier supplier) {
        UserDAO.signUpSupplier(supplier);
    }
    public static Supplier retrieveSupplierByID(int supplierID){
        return UserDAO.getSupplierById(supplierID);
    }

    public static Vendor retrieveVendorByID(int vendorID){
        return UserDAO.getVendorByID(vendorID);
    }
    public static ArrayList<Vendor> retrieveVendorList() {
        return UserDAO.retrieveVendorList();
    }

    public static Vendor loginVendor(String vendor_name, String password) {
        return UserDAO.loginVendor(vendor_name, password);
    }

    public static void signUpVendor(Vendor vendor) {
        UserDAO.signUpVendor(vendor);
    }

    public static ArrayList<Supplier> retrieveSupplierListByVendor(int vendor_id) {
        return UserDAO.retrieveFavouriteSupplierListByVendor(vendor_id);
    }

    public static void saveAsFavouriteSupplier(int vendor_id, int supplier_id) {
        UserDAO.saveAsFavouriteSupplier(vendor_id, supplier_id);
    }

    public static void deleteFavouriteSupplier(int vendor_id, int supplier_id) {
        UserDAO.deleteFavouriteSupplier(vendor_id, supplier_id);
    }
}
