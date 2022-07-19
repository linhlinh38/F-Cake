<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container" style="background-color:#F87474">
		<a class="navbar-brand" href="index.jsp">F-Cake</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<%
			if ((auth == null) || (auth != null && !(auth.getEmail()).equals("admin123@gmail.com"))) {
			%>
			
			<%
			}
			%>

			<ul class="navbar-nav ms-auto" style="align-items:center">
				<%
				if (auth == null) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home </a></li>
				<li class="nav-item"><a class="nav-link" href="cart.jsp">Cart<span
						class="badge badge-danger">${ cart_list.size() }</span></a></li>
				<li class="nav-item"><a class="nav-link" href="login.jsp">Login</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="register.jsp">Register</a>
				</li>

				<%
				} else if (auth != null && auth.getEmail().equals("admin123@gmail.com")) {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="adminHome.jsp">Product</a></li>
				<li class="nav-item active"><a class="nav-link"
					href="dashboard.jsp">Orders</a></li>
				<li class="nav-item"><a class="nav-link"
					href="admin-all-products.jsp">Solds</a></li>
				<li class="nav-item"><a class="nav-link"
					href="admin-all-customers.jsp">Customers</a></li>
				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a>
				</li>
				<%
				} else {
				%>
				<li class="nav-item active"><a class="nav-link"
					href="index.jsp">Home </a></li>
				<li class="nav-item"><a class="nav-link" href="cart.jsp">Cart<span
						class="badge badge-danger">${ cart_list.size() }</span></a></li>
				<li class="nav-item"><a class="nav-link" href="orders.jsp">Orders</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="profile.jsp">Profile</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="log-out">Logout</a>
				</li>

				<%
				}
				%>
				<form class="form-inline my-4 my-lg-2" action="search-products"  style=" width: 33vw; margin-left : 19vw;"
				method="post">
				<input class="form-control mr-sm-2" type="search" name="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-info my-2 my-sm-0" type="submit">Search</button>
			</form>



			</ul>
		</div>
	</div>
</nav>