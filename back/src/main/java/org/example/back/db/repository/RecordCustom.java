package org.example.back.db.repository;

import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.Member;
import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;
import org.example.back.record.dto.StatisticsDto;
import org.example.back.record.dto.StatisticsResponseDto;
import org.hibernate.stat.Statistics;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Slice;

import java.time.LocalDate;
import java.util.Map;

public interface RecordCustom {
    Slice<RecordDto> findAll(Long lastId, int pageSize, Member member, GameMode gameMode);

    RecordSummaryResDto getSummary(Long memberId);

    StatisticsDto getStatisticsByMonth(Member member, LocalDate selectedDate);
    StatisticsDto getStatisticsByYear(Member member, LocalDate selectedDate);
    StatisticsDto getStatisticsByAll(Member member);

    Long getBestRecordFromLastTenRecords(Long myMemberId); // 나의 최근 10개의 기록 중 페이스가 가장 좋은 것을 가져온다.
}
