package org.example.back.db.entity;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.*;
import lombok.*;
import org.example.back.common.BaseEntity;

import org.example.back.db.enums.GameMode;
import org.example.back.record.dto.RecordDto;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "record")
public class Record extends BaseEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false)
	private Long id;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "member_id", nullable = false)
	private Member member;

	@Lob
	@Enumerated(EnumType.STRING)
	@Column(name = "game_mode")
	private GameMode gameMode;

	@Column(name = "ranking")
	private Integer ranking;

	@Column(name = "distance")
	private Float distance;

	@Column(name = "run_start_time")
	private LocalDateTime runStartTime;

	@Column(name = "run_end_time")
	private LocalDateTime runEndTime;

	@Column(name = "pace")
	private Integer pace;

	@Column(name = "calorie")
	private Integer calorie;

	@Column(name="duration")
	private Long duration;

	@OneToMany(mappedBy = "record")
	private List<RealtimeRecord> realtimeRecords;

	@Column(name="course_img_url")
	private String courseImgUrl;

	public void updateDuration() {
		duration = (runStartTime != null && runEndTime != null) ?
			Duration.between(runStartTime, runEndTime).toMillis() :
			null;
	}
	public RecordDto toRecordDto() {
		return RecordDto.builder()
				.id(getId())
				.duration(getDuration())
				.runStartTime(getRunStartTime())
				.gameMode(getGameMode())
				.ranking(getRanking())
				.distance(getDistance())
				.build();
	}

}