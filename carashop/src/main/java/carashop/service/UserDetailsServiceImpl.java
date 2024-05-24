package carashop.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import carashop.model.User;

@Service
public class UserDetailsServiceImpl extends BaseService<User> implements UserDetailsService {
	
	@Override
	public Class<User> clazz() {
		return User.class;
	}
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		// Lấy user trong tbl_user theo username (username từ form login)
		String sql = "SELECT * FROM tbl_user u WHERE u.username='"
				+ username + "' and u.status= 'ACTIVE'";
		
		User user = this.getEntityByNativeSQL(sql);
		if (user != null) {
//			System.out.println("usename: " + user.getUsername() );
//			System.out.println("password: " + user.getPassword());
			return user;
		}
		else {
			return new User(); // userDetail không được null
		}
	}
}
