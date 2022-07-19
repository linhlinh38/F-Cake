<%@ page import="java.util.*"%>
<%@ page import="connection.DbCon"%>
<%@ page import="dao.OrderDao"%>
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
List<Order> allOrderList = new OrderDao(DbCon.getConnection()).allOrders();
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
			<h4>
				<b>Orders</b>
			</h4>
		</div>
		<table class="table table-light">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Date</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">CustomerPhone</th>
					<th scope="col">Status</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
			if(allOrderList != null ) {
				for(Order o:allOrderList) {%>
				<tr>
					<td><%= o.getDate() %></td>
					<td><%= o.getName() %></td>
					<td><%= o.getCategory() %></td>
					<td><%= o.getQuantity() %></td>
					<td><%= o.getPrice() %>VND</td>
					<td><%= o.getUserPhone() %></td>
					<td>
						<%
					if((o.getStatus()).equals("CHECKING")) {%> <a
						class="btn btn-outline-info"
						href="change-status-order?id=<%= o.getOrderId() %>&&status=<%= o.getStatus()%>"><%= o.getStatus()%></a>
						<%} else if((o.getStatus()).equals("DELIVERING")) {%> <a
						class="btn btn-info"
						href="change-status-order?id=<%= o.getOrderId() %>&&status=<%= o.getStatus()%>"><%= o.getStatus()%></a>
						<%} else {%> <a class="btn btn-outline-info"><%= o.getStatus()%></a> <%}%>
					</td>
					<td>
						<% if((o.getStatus()).equals("CHECKING")) { %> <a
						class="btn btn-sm btn-outline-dark"
						href="cancel-order?id=<%= o.getOrderId() %>">Cancel</a> <%} %>
					</td>
				</tr>
				<%}
			}
			%>
			</tbody>
		</table>
	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>