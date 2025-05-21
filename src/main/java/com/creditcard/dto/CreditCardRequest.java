package com.creditcard.dto;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Min;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreditCardRequest {
    @Size(min = 2, message = "Name must be at least 2 characters long")
    @Pattern(regexp = "^[a-zA-Z ]+$", message = "Name must contain only letters and spaces")
    private String name;
    
    private String cardNumber;
    
    @Min(value = 0, message = "Credit limit must be a positive number")
    private double creditLimit;
} 