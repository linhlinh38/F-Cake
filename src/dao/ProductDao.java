package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import model.*;

public class ProductDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public ProductDao(Connection con) {
		this.con = con;
	}

	public List<Product> getAllProducts() {
		List<Product> products = new ArrayList<Product>();

		try {
			query = "SELECT * FROM product";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getInt("price"));
				row.setImage(rs.getString("image"));
				products.add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}

	public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
		List<Cart> products = new ArrayList<Cart>();
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "SELECT * FROM product WHERE id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while (rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));
						row.setPrice(rs.getInt("price") * item.getQuantity());
						row.setQuantity(item.getQuantity());
						products.add(row);
					}

				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());

		}
		return products;
	}

	public Product getSingleProduct(int id) {
		Product row = null;

		try {
			query = "SELECT * FROM product WHERE id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();

			while (rs.next()) {
				row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getInt("price"));
				row.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return row;
	}

	public int getTotalCartPrice(ArrayList<Cart> cartList) {
		int sum = 0;
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "SELECT price FROM product WHERE id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();

					while (rs.next()) {
						sum += rs.getInt("price") * item.getQuantity();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	
	public boolean insertProduct(Product product) {
		boolean result= false;
		try {
			query= "insert into product(name, category, price, image) values (?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setString(1, product.getName());
			pst.setString(2, product.getCategory());
			pst.setInt(3, product.getPrice());
			pst.setString(4, product.getImage());
			pst.executeUpdate();
			result = true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean updateProduct (int id, String name, String category, int price) {
		boolean result = false;
		try {
			query = "UPDATE product SET name=?, category=?, price=? WHERE id=?;";
			pst = this.con.prepareStatement(query);
			pst.setString(1, name);
			pst.setString(2, category);
			pst.setInt(3, price);
			pst.setInt(4, id);
			pst.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void deleteProduct(int id) {
		try {
			query = "DELETE FROM product WHERE id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
