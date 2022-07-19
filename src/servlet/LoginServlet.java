package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.DbCon;
import dao.UserDao;
import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("login-email");
			String password = request.getParameter("login-password");
			if (!Pattern.matches("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>])(?=\\S+$).{8,20}$",
					password)) {
				out.print("<meta charset=\"ISO-8859-1\">\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css\" />\r\n"
						+ "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\">");
				out.print("<div class='container'>"
						+ "  <a class='navbar-brand' style='color:#F87474; font-variant: small-caps; font-size: 30px;'><b>F-Cake</b></a></div>");
				out.print("<h4 class='alert alert-danger' role='alert' style='text-align:center'>"
						+ "  Login User failed: <b>Wrong password format ! </b><a href='login.jsp' class='alert-link'>Login Again</a>"
						+ "</h4>");
				out.print(
						"<p style='text-align:center;'><img src='product-images/Chicken Floss.jpg' alt='F-Cake' margin-left: auto;'"
								+ "margin-right: auto; display: block; width='900' height='200'></p>");
			} else {
				try {
					UserDao udao = new UserDao(DbCon.getConnection());
					
					User user = udao.userLogin(email);
					if (user != null) {
						// out.print("User Login");
						
							out.print("<meta charset=\"ISO-8859-1\">\r\n"
									+ "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css\" />\r\n"
									+ "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\">");
							out.print("<div class='container'>"
									+ "  <a class='navbar-brand' style='color:#F87474; font-variant: small-caps; font-size: 30px;'><b>F-Cake</b></a></div>");

							out.print("<h4 class='alert alert-danger' role='alert' style='text-align:center'>"
									+ "  User Login Failed: <b>Wrong Your Password</b><a href='login.jsp' class='alert-link'>Login Again</a>"
									+ "</h4>");
							out.print(
									"<p style='text-align:center;'><img src='product-images/Chicken Floss.jpg' alt='F-Cake' margin-left: auto;'"
											+ "margin-right: auto; display: block; width='900' height='200'></p>");


						user.setPassword("");
						request.getSession().setAttribute("auth", user);
						
						if ((user.getEmail()).equals("admin123@gmail.com")) {
							response.sendRedirect("adminHome.jsp");
							// out.print("Admin Login");
						} else {
							response.sendRedirect("index.jsp");
							// out.print("User Login");
						}

					} else {
						out.print("<meta charset=\"ISO-8859-1\">\r\n"
								+ "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css\" />\r\n"
								+ "<link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css\">");
						out.print("<div class='container'>"
								+ "  <a class='navbar-brand' style='color:#F87474; font-variant: small-caps; font-size: 30px;'><b>F-Cake</b></a></div>");

						out.print("<h4 class='alert alert-danger' role='alert' style='text-align:center'>"
								+ "  User Login Failed: <b>Wrong Your Email</b><a href='login.jsp' class='alert-link'>Login Again</a>"
								+ "</h4>");
						out.print(
								"<p style='text-align:center;'><img src='product-images/Chicken Floss.jpg' alt='F-Cake' margin-left: auto;'"
										+ "margin-right: auto; display: block; width='900' height='200'></p>");
					}
				} catch (ClassNotFoundException | SQLException e) {
					e.printStackTrace();
				}
			}

		}
	}

}
