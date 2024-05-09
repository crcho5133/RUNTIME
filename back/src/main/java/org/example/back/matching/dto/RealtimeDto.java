package org.example.back.matching.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class RealtimeDto {
    private Long memberId;
    private double lon; // 경도
    private double lat; // 위도
    private double distance; // 총 이동거리
    private int index;
    private LocalDateTime currentTime; // 현재 시간
}