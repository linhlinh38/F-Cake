<%@ page import="java.util.*"%>
<%@ page import="connection.DbCon"%>
<%@ page import="dao.ProductDao"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth == null) {
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
<title>Create Product</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">
				<h4>
					<b>New product</b>
				</h4>
			</div>
			<div class="card-body">
				<form action="create-product" method="post">

					<div class="form-group">
						<label>Name</label> <input type="text" class="form-control"
							name="name" placeholder="Enter Product Name" required>
					</div>

					<div class="form-group">
						<label>Category</label> <input type="text" class="form-control"
							name="category" placeholder="Sweet Cake/Barguette" required>
					</div>

					<div class="form-group">
						<label>Price</label> <input type="text" class="form-control"
							name="price" placeholder="Product Price" required>
					</div>

					<div class="form-group">
						<label>Image</label> <input type="text" class="form-control"
							name="image" placeholder="Product Image" required>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="checkbox" value=""
							id="invalidCheck" required> <label
							class="form-check-label" for="invalidCheck"> Agree to
							terms and conditions </label>
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn-outline-info">Submit</button>
					</div>

				</form>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>