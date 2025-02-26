package com.wzx.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class TransferBossDTO {
    private Long loginUserId;
    private String teamName;
    private Long transferUserId;
}
