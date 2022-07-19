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

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>F-Cake Home</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card-header my-3">
			<ul class="nav nav-pills card-header-tabs">
				<li class="nav-item"><a class="nav-link active"
					href="adminHome.jsp"><b>All Products</b></a></li>
				<li class="nav-item"><a class="nav-link" href="create-product">Create Product</a>
				</li>

			</ul>
		</div>
		<div class="row">
			<%
				if (!products.isEmpty()) {
				for (Product p : products) {
			%>
			<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src="product-images/<%=p.getImage()%>.jpg"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">Price:<%=p.getPrice()%>VND</h6>
						<h6 class="category">Category:<%=p.getCategory()%></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a href="delete-product?id=<%= p.getId()%>" class="btn btn-outline-info">Delete</a>
						</div>

					</div>
				</div>
				</div><%}
			}			
			%>
			

		<%@include file="includes/footer.jsp"%>
</body>
</html>