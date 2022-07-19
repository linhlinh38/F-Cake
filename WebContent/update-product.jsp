<%@ page import="java.util.*"%>
<%@ page import="connection.DbCon"%>
<%@ page import="dao.ProductDao"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth == null ) {
	response.sendRedirect("login.jsp");
}
if ((auth.getEmail()).equals("admin123@gmail.com")) {
	request.setAttribute("auth", auth);
} else {
	response.sendRedirect("index.jsp");
}

String id = (String)request.getSession().getAttribute("id");
ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
request.getSession().removeAttribute("id");

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Update Product</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">
			<h4>
				<b>Your Product</b>
			</h4>
		</div>
		<div class="container">
			<div class="card w-50 mx-auto my-5">
				<div class="card-header text-center">
					<h3>product Information</h3>
				</div>
				<div class="card-body">
					<form action="update-product" method="post">
					<%
			if(products!=null) {
				for(Product p:products) { 
				%>

						<div class="form-group">
							<label>Name:</label>
							<input type="name"
							class="form-control" name="name"
							placeholder=<%= p.getName() %> > 
						</div>

						<div class="form-group">
							<label>Category:</label>
							<input type="name"
							class="form-control" name="name"
							placeholder=<%= p.getCategory() %>>
						</div>

						<div class="form-group">
							<label>price:</label>
							<input type="name"
							class="form-control" name="name"
							placeholder=<%= p.getPrice() %>>
						</div>
						
						<div class="text-center">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>

				<%}
				}
		%>
					</form>
					
				</div>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>