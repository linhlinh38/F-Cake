package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.DbCon;
import dao.ProductDao;
import model.Product;
@WebServlet ("/create-product")
public class CreateProduct extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect("create-product.jsp");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("utf-8");
		try (PrintWriter out = resp.getWriter()) {
			String name = req.getParameter("name");
			String category = req.getParameter("category");
			String priceStr = req.getParameter("price");
			String image = req.getParameter("image");
			int price=0;
			try {
				price = Integer.parseInt(priceStr);
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			Product productModel= new Product();
			productModel.setName(name);
			productModel.setCategory(category);
			productModel.setPrice(price);
			productModel.setImage(image);
			
			try {
				ProductDao pd = new ProductDao(DbCon.getConnection());
				boolean result= pd.insertProduct(productModel);
				if(result) {
				resp.sendRedirect("adminHome.jsp");
			}else {
				out.print("<meta charset=\"ISO-8859-1\">\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css\" />\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\">");
				out.print("<div class='container'>"
						+ "  <a class='navbar-brand' style='color:#F87474; font-variant: small-caps; font-size: 30px;'><b>F-Cake</b></a></div>");
				
				out.print(
						"<p style='text-align:center;'><img src='product-images/Chicken Floss.jpg' alt='F-Cake' margin-left: auto;'"
								+ "margin-right: auto; display: block; width='900' height='200'></p>");
			}
			} catch (Exception e) {
				// TODO: handle exception
			}
			
			
			
		
		}

	}
}
