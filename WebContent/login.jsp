<%@ page import="java.util.*"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
    User auth = (User) request.getSession().getAttribute("auth");
    if(auth!=null) {
    	if((auth.getEmail()).equals("admin123@gmail.com")) {
    		response.sendRedirect("dashboard.jsp");
    	}
    	response.sendRedirect("index.jsp");
    }
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if(cart_list != null) {
    	request.setAttribute("cart_list", cart_list);
    }
    %>
<!DOCTYPE html>
<html>
<head>
<title>Login Page</title>
<%@include file="includes/header.jsp"%>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">
				<h4>
					<b>Login Your Account</b>
				</h4>
			</div>
			<div class="card-body">
				<form action="user-login" method="post">

					<div class="form-group">
						<label>Account</label> <input type="email"
							class="form-control" name="login-email"
							placeholder="Enter Your Email" required> 
					</div>

					<div class="form-group">
						<label>Password</label> <input type="password"
							class="form-control" name="login-password"
							placeholder="***************" maxlength="20"
							pattern="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#&()–[{}]:;',?/*~$^+=<>]).{8,20}$"
							required> 
					</div>

					<div class="text-center">
						<button type="submit" class="btn btn--outline-info">Login</button>
					</div>


				</form>
			</div>
		</div>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>