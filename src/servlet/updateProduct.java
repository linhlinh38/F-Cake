package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.DbCon;
import dao.ProductDao;
import model.Cart;
import model.Product;

/**
 * Servlet implementation class ChangeStatusOrderServlet
 */
@WebServlet("/update-product")
public class updateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
			response.sendRedirect("update-product.jsp");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try (PrintWriter out = response.getWriter()) {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));
			String name = request.getParameter("name");
			String category = request.getParameter("category");
			String priceStr = request.getParameter("price");
			int price =0;
			try {
				price = Integer.parseInt(priceStr);
			} catch (Exception e) {
			}
			boolean result = false;
			if (id >= 1 && name != null || id >= 1 && category != null || id >= 1 && priceStr != null) {
				ProductDao productDao = new ProductDao(DbCon.getConnection());
				result = productDao.updateProduct(id, name, category, price);
			}
			if (result) {
				response.sendRedirect("adminHome.jsp");
			} else {
				out.print("<meta charset=\"ISO-8859-1\">\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css\" />\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\">");
				out.print("<div class='container'>"
						+ "  <a class='navbar-brand' style='color:#8B4513; font-variant: small-caps; font-size: 30px;'><b>F-Cake</b></a></div>");
				out.print("<h4 class='alert alert-danger' role='alert' style='text-align:center'>"
						+ "  Update product Failed. <a href='adminHome.jsp' class='alert-link'>Go to Admin Home</a>"
						+ "</h4>");
				out.print(
						"<p style='text-align:center;'><img src='product-images/Chicken Floss.jpg' alt='F-Cake' margin-left: auto;'"
								+ "margin-right: auto; display: block; width='1400' height='550'></p>");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

}


