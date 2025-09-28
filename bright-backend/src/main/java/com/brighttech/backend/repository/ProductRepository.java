package com.brighttech.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.brighttech.backend.model.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {}

