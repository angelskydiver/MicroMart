package com.safalifter.jobservice.request.offer;

import lombok.Data;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Data
public class MakeAnOfferRequest {
    @NotBlank(message = "User id is required")
    private String userId;
    @NotBlank(message = "Advert id is required")
    private String advertId;
    @NotNull(message = "Offered price is required")
    private int offeredPrice;
}
