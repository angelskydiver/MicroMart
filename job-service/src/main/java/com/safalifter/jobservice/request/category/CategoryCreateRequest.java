package com.safalifter.jobservice.request.category;

import lombok.Data;

import jakarta.validation.constraints.NotBlank;

@Data
public class CategoryCreateRequest {
    @NotBlank(message = "Category name is required")
    private String name;
    private String description;
}
