# Go to backend main Java folder
Set-Location "C:\Users\wakha\Documents\NetBeansProjects\BrightTechnology\bright-backend\src\main\java\com\brighttech\backend"

# Create Java package folders if not exist
New-Item -ItemType Directory -Force -Path ".\model"
New-Item -ItemType Directory -Force -Path ".\repository"
New-Item -ItemType Directory -Force -Path ".\dto"
New-Item -ItemType Directory -Force -Path ".\controller"

# Create Product.java
@"
package com.brighttech.backend.model;

import jakarta.persistence.*;

@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Double price;

    // Getters and Setters
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }
}
"@ | Out-File -Encoding UTF8 ".\model\Product.java"

# Create ProductRepository.java
@"
package com.brighttech.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.brighttech.backend.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {}
"@ | Out-File -Encoding UTF8 ".\repository\ProductRepository.java"

# Create OrderRequest.java
@"
package com.brighttech.backend.dto;

public class OrderRequest {
    private Long productId;
    private Integer quantity;

    // Getters and Setters
    public Long getProductId() {
        return productId;
    }
    public void setProductId(Long productId) {
        this.productId = productId;
    }
    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
}
"@ | Out-File -Encoding UTF8 ".\dto\OrderRequest.java"

# Create ProductController.java
@"
package com.brighttech.backend.controller;

import com.brighttech.backend.model.Product;
import com.brighttech.backend.repository.ProductRepository;
import com.brighttech.backend.dto.OrderRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpServletRequest;

import java.util.*;
import java.util.stream.*;

@RestController
@RequestMapping("/api")
public class ProductController {

    @Autowired
    private ProductRepository productRepo;

    @GetMapping("/products")
    public List<Product> listAll() {
        return productRepo.findAll();
    }

    @PostMapping("/orders")
    public ResponseEntity<?> createOrder(@RequestBody OrderRequest req) {
        // TODO: implement saving logic later
        return ResponseEntity.ok(Collections.singletonMap("orderId", 12345));
    }

    @GetMapping("/slider")
    public List<String> sliderImages(HttpServletRequest req) {
        String base = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort();
        return IntStream.rangeClosed(1, 7)
                .mapToObj(i -> base + "/images/slider/slide" + i + ".png")
                .collect(Collectors.toList());
    }
}
"@ | Out-File -Encoding UTF8 ".\controller\ProductController.java"

# Now create application.properties under resources
$resourcesPath = "C:\Users\wakha\Documents\NetBeansProjects\BrightTechnology\bright-backend\src\main\resources"
New-Item -ItemType Directory -Force -Path $resourcesPath | Out-Null

@"
# Server port
server.port=8080

# Database connection
spring.datasource.url=jdbc:mysql://localhost:3306/brighttech
spring.datasource.username=bright_user
spring.datasource.password=BrightPass123!

# Hibernate settings
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
"@ | Out-File -Encoding UTF8 "$resourcesPath\application.properties"

Write-Output "✅ Backend Java classes and application.properties created successfully!"
