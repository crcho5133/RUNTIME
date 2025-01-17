package org.example.back.record.controller;

import lombok.RequiredArgsConstructor;
import org.example.back.record.dto.RecordListResponseDto;
import org.example.back.record.dto.RecordResponseDto;
import org.example.back.record.dto.StatisticResponseDto;
import org.example.back.record.service.RecordService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/records")
public class RecordController {
    private final RecordService recordService;


    // 기록 조회
    @GetMapping("")
    public ResponseEntity<RecordListResponseDto> getAllRecords(
            @RequestParam(value = "lastId",required = false) Long lastId,
            @RequestParam("pageSize") Integer pageSize,
            @RequestParam(value = "gameMode", required = false) String gameModeStr
    ) {
        RecordListResponseDto recordListResponseDto = recordService.getAllRecords(lastId, pageSize, gameModeStr);
        return ResponseEntity.ok(recordListResponseDto);
    }

    // 기록 상세 조회
    @GetMapping("/{recordId}")
    public ResponseEntity<RecordResponseDto> getRecord(@PathVariable Long recordId) {
        RecordResponseDto recordResponseDto = recordService.getRecord(recordId);
        return ResponseEntity.ok(recordResponseDto);
    }

    // 통계 조회
    @GetMapping("/statistics")
    public ResponseEntity<StatisticResponseDto> getStatistic(
            @RequestParam(value = "type") String type,
            @RequestParam(value = "selectedDate", required = false) LocalDate selectedDate
    ) {
        StatisticResponseDto statisticResponseDto = recordService.getStatistic(type, selectedDate);
        return ResponseEntity.ok(statisticResponseDto);
    }

}
