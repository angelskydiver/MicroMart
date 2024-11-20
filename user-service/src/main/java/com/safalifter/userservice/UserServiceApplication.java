package com.safalifter.userservice;

import com.safalifter.userservice.enums.Role;
import com.safalifter.userservice.model.User;
import com.safalifter.userservice.repository.UserRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.util.StringUtils;

@SpringBootApplication
@EnableFeignClients
public class UserServiceApplication implements CommandLineRunner {
    private final UserRepository userRepository;
    @Value("${application.admin.bootstrap.enabled:false}")
    private boolean bootstrapAdminEnabled;
    @Value("${application.admin.username:admin}")
    private String adminUsername;
    @Value("${application.admin.email:admin@example.com}")
    private String adminEmail;
    @Value("${application.admin.password-hash:}")
    private String adminPasswordHash;

    public UserServiceApplication(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public static void main(String[] args) {
        SpringApplication.run(UserServiceApplication.class, args);
    }

    @Override
    public void run(String... args) {
        if (!bootstrapAdminEnabled) {
            return;
        }
        if (!StringUtils.hasText(adminPasswordHash)) {
            throw new IllegalStateException("application.admin.password-hash must be configured when admin bootstrap is enabled");
        }
        var admin = User.builder()
                .username(adminUsername)
                .email(adminEmail)
                .password(adminPasswordHash)
                .role(Role.ADMIN).build();
        if (userRepository.findByUsername(adminUsername).isEmpty()) userRepository.save(admin);
    }
}
