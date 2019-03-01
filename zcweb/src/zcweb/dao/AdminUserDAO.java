package zcweb.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import zcweb.bean.AdminUser;

import zcweb.util.DBUtil;

public class AdminUserDAO {
	public AdminUser get(String name, String password) {
		AdminUser bean = null;
		 
		String sql = "select * from admin where name = ? and password=?";
        try (Connection c = DBUtil.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
        	ps.setString(1, name);
        	ps.setString(2, password);
            ResultSet rs =ps.executeQuery();
 
            if (rs.next()) {
                bean = new AdminUser();
                int id = rs.getInt("id");
                bean.setName(name);
                bean.setPassword(password);
                bean.setId(id);
            }
 
        } catch (SQLException e) {
 
            e.printStackTrace();
        }
        return bean;
	}
}
