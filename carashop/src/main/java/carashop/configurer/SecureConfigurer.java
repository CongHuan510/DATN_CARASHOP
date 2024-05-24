package carashop.configurer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import carashop.service.UserDetailsServiceImpl;

// Cấu hình 

@Configuration
@EnableWebSecurity // Bật tính năng security
public class SecureConfigurer extends WebSecurityConfigurerAdapter {
	
	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		
		// Bắt đầu cấu hình
		
		// BẮT đầu request tu browser
		http.csrf().disable().authorizeRequests() 
		
		// Cho phép truy cập vào các request, static khong bị ràng buộc login
		.antMatchers("/frontend/**" ,"/backend/**","/FileUploads/**" ,
				"/login","/logout").permitAll()
		
		// Các requests kiểu "/admin/**" phải login (xác thực)
		//.antMatchers("/admin/**").authenticated() // step 1+2
		// Các request kiểu "/admin/**" phải có role là ADMIN // step 3
		//.antMatchers("/admin/**").hasAuthority("SUPERADMIN")
		.antMatchers("/admin/**").hasAnyAuthority("SUPERADMIN", "ADMIN")
		
		.and()
		
		// Nếu chưa login (xác thực) thì redirect đến trang login
		// Với "/login" là 1 request trong (LoginController)
		.formLogin().loginPage("/login").loginProcessingUrl("/login_processing_url")
		
		// Login thành công thì vào trang home
		//.defaultSuccessUrl("/admin/index", true)
		
		//(backend) step 1+2
		// Login thành công: chuyến đến request phù hợp với role step 3
		.successHandler(new UrlAuthenticationSuccessHandler())
		
		// Login không thành công
		.failureUrl("/login?login_error=true")
		
		.and()
		
		// Cấu hình logout
		.logout().logoutUrl("/logout").logoutSuccessUrl("/index")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		
		.and()
		
		.rememberMe().key("uniqueAndSecret").tokenValiditySeconds(86400);
		
	}
	
	@Autowired
	private UserDetailsServiceImpl userDetailsService;
	
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder(4));
	}
	
	
//	public static void main(String[] args) {
//		System.out.println(new BCryptPasswordEncoder(4).encode("123"));
//	}
}
