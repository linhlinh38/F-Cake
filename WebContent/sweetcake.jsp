<%@ page import="java.util.*"%>
<%@ page import="connection.DbCon"%>
<%@ page import="dao.ProductDao"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
} 

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}

%>
<!DOCTYPE html>
<html>
<head>
<title>F-Cake</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="card-header my-3">
			<ul class="nav nav-pills card-header-tabs">
				<li class="nav-item"><a class="nav-link" href="index.jsp"><b>All
							Products</b></a></li>
				<li class="nav-item"><a class="nav-link active"
					href="sweetcake.jsp">Sweet Cake</a></li>
		
				<li class="nav-item"><a class="nav-link" href="barguette.jsp">Barguette</a></li>
			</ul>
		</div>
		<div class="row">
			<%
			if(!products.isEmpty()) {
				for(Product p:products) {
					if((p.getCategory()).equals("Sweet Cake")) {%>
			<div class="col-md-3 my-3">
				<div class="card w-100" style="width: 18rem;">
					<img class="card-img-top" src="product-images/<%= p.getImage() %>.jpg"
						alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%= p.getName() %></h5>
						<h6 class="price">
							Price:
							<%= p.getPrice() %>VND
						</h6>
						<h6 class="category">
							Category:
							<%= p.getCategory() %></h6>
						<div class="mt-3 d-flex justify-content-between">
							<a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-outline-info">Add
								to Cart</a> <a href="order-now?quantity=1&id=<%= p.getId() %>"
								class="btn btn-info">Buy Now</a>
						</div>

					</div>
				</div>
			</div>
			<%}
					}
			}
		%>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>