/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import DAO.UserDAO;
import Model.Supplier;
import Model.Vendor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Joel
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    UserDAO userDAO = new UserDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try  {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
            
            //retrieves input from user from Login Page
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            //create a new session
            HttpSession session = request.getSession();
            
            //destination
            String url = "Login.jsp";
            
            String supplier_id = attemptLoginSupplier(email, password);
            String vendor_id = attemptLoginVendor(email, password);
            
            if(vendor_id == null && supplier_id == null){
                //redirect to login page
                request.setAttribute("errorMsg", "Invalid e-mail or password entered");
            }else if(vendor_id != null && supplier_id == null){
                //redirect to vendor home
                url = "";
                session.setAttribute("currentVendor", vendor_id);
                request.setAttribute("errMsg", null);
                
            }else if(vendor_id == null && supplier_id != null){
                //redirect to supplier home
                url = "";
                session.setAttribute("currentSupplier", supplier_id);
                request.setAttribute("errMsg", null);
            }else{
                request.setAttribute("errMsg", "Invalid email or password entered.");
            }
            //redirect to respective pages
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);
            
            
        }finally{
            out.flush();
            out.close();
        }
    }
    
    private String attemptLoginVendor(String email, String password){
        Vendor vendor = userDAO.loginVendor(email, password);
        String actualEmail = vendor.getEmail();
        return actualEmail;
    } 
    
    private String attemptLoginSupplier(String email, String password){
        Supplier supplier = userDAO.loginSupplier(email, password);
        String actualEmail = supplier.getEmail();
        return actualEmail;
    } 
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
