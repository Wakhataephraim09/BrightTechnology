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

