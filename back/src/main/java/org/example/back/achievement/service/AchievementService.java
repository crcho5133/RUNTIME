package org.example.back.achievement.service;

import java.util.List;
import java.util.Objects;

import org.example.back.achievement.dto.AchievementResDto;
import org.example.back.achievement.dto.CheckAchievementResDto;
import org.example.back.achievement.dto.RecordSummaryResDto;
import org.example.back.db.entity.Achievement;
import org.example.back.db.entity.AchievementType;
import org.example.back.db.entity.Character;
import org.example.back.db.entity.CurrentAchievement;
import org.example.back.db.entity.CurrentAchievementId;
import org.example.back.db.entity.UnlockedCharacter;
import org.example.back.db.entity.UnlockedCharacterId;
import org.example.back.db.repository.AchievementRepository;
import org.example.back.db.repository.AchievementTypeRepository;
import org.example.back.db.repository.CharacterRepository;
import org.example.back.db.repository.CurrentAchievementRepository;
import org.example.back.db.repository.MemberRepository;
import org.example.back.db.repository.RecordRepository;
import org.example.back.db.repository.UnlockedCharacterRepository;
import org.example.back.exception.AchievementAlreadyReceivedException;
import org.example.back.exception.AchievementNotCompletedException;
import org.example.back.exception.AchievementNotFoundException;
import org.example.back.util.SecurityUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.persistence.EntityManager;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AchievementService {

	private final AchievementRepository achievementRepository;
	private final AchievementTypeRepository achievementTypeRepository;
	private final RecordRepository recordRepository;
	private final CurrentAchievementRepository currentAchievementRepository;
	private final MemberRepository memberRepository;
	private final CharacterRepository characterRepository;
	private final UnlockedCharacterRepository unlockedCharacterRepository;
	private final EntityManager entityManager;

	public List<AchievementResDto> findOwn() {
		//로그인한 사용자 id
		Long memberId = SecurityUtil.getCurrentMemberId();

		// 해당 사용자가 진행중인 도전과제 리스트.
		List<AchievementResDto> list = achievementRepository.findOwnAchievement(memberId);
		list.removeIf(achievementResDto -> achievementResDto.getIsHidden() && !achievementResDto.getIsComplete());

		return list;
	}

	@Transactional
	public CheckAchievementResDto updateAchievement() {
		Long memberId = SecurityUtil.getCurrentMemberId();

		// 현재 진행중인 모든 도전과제 리스트
		List<AchievementResDto> achievementlist = achievementRepository.findOwnAchievement(memberId);
		// 현재 로그인한 사용자의 달리기 통계
		RecordSummaryResDto recordSummary = recordRepository.getSummary(memberId);
		// 친구 정보
		int countFriends = memberRepository.countFriends(memberId);

		// 히든 과제: Duration 마지막 자리 77
		boolean isDoubleSevenDuration = recordRepository.existsDoubleSevenDuration(memberId);

		// 수령하지 않은 도전과제가 있는가를 반환하는 dto
		CheckAchievementResDto resDto = new CheckAchievementResDto(false);

		// 현재 진행중인 도전과제들에 대해 loop
		achievementlist.forEach(achievement -> {
			// 업데이트할 진행중 도전과제 객체
			CurrentAchievement currentAchievement = CurrentAchievement.builder()
				.id(new CurrentAchievementId(memberId, achievement.getType()))
				.progress(achievement.getProgress())
				.isReceived(achievement.getIsReceive())
				.currentGrade(achievement.getGrade())
				.build();
			// 현재 진행중인 도전과제의 기준항목에 따라
			float progress = 0.0f;
			switch (achievement.getCriteria()) {
				case DISTANCE -> {
					progress = recordSummary.getTotalDistance();
				}
				case DURATION -> {
					progress = recordSummary.getTotalDuration();
				}
				case COUNT_WINS -> {
					progress = recordSummary.getCountWins();
				}
				case COUNT_FRIENDS -> {
					progress = countFriends;
				}
				case DOUBLE_SEVEN_DURATION -> {
					progress = isDoubleSevenDuration?1:0;
				}
			}
			currentAchievement.updateProgress(progress);
			if (currentAchievement.getProgress() >= achievement.getGoal()) {
				if (!currentAchievement.getIsReceived()) {
					resDto.setHasReward(true);
				}
			}
			currentAchievementRepository.save(currentAchievement);
		});
		return resDto;
	}

	@Transactional
	public AchievementResDto receiveReward(Long achievementTypeId) {

		/*
		* 도전과제 완료 메소드
		* 완료를 원하는 도전과제의 타입과 단계를 확인 후 목표를 달성했는 지 확인
		* 달성했다면 다음 단계의 도전과제 리턴, 마지막 단계라면 받았다고 체크하고 기존 단계 그대로 리턴
		* 히든과제의 경우 무조건 마지막 단계이므로 갱신 필요 없음
		* */

		Long memberId = SecurityUtil.getCurrentMemberId();

		// 현재 로그인한 사용자의 달리기 통계
		RecordSummaryResDto recordSummary = recordRepository.getSummary(memberId);
		// 친구 정보
		int countFriends = memberRepository.countFriends(memberId);

		// 	해당하는 도전과제 불러오기
		CurrentAchievementId id = CurrentAchievementId.builder()
			.memberId(memberId)
			.achievementTypeId(achievementTypeId)
			.build();
		CurrentAchievement currentAchievement = currentAchievementRepository.findById(id).orElseThrow(
			AchievementNotFoundException::new);

		Achievement achievement = achievementRepository.findByAchievementTypeIdAndGrade(achievementTypeId,
				currentAchievement.getCurrentGrade())
			.orElseThrow(AchievementNotFoundException::new);

		// 	해당 도전과제를 완료했는지 확인
		if (currentAchievement.getProgress() < achievement.getGoal()) {
			// 완료되지 않은 도전과제라는 에러 출력
			throw new AchievementNotCompletedException();
		}else if(currentAchievement.getIsReceived()){
			throw new AchievementAlreadyReceivedException();
		}
		// 	보유 캐릭터 업데이트하기.
		Character character = characterRepository.findByAchievementTypeAndGrade(currentAchievement.getAchievementType().getId(), currentAchievement.getCurrentGrade());
		UnlockedCharacterId unlockedCharacterId = UnlockedCharacterId.builder()
			.characterId(character.getId())
			.memberId(memberId)
			.build();
		UnlockedCharacter unlockedCharacter = UnlockedCharacter.builder()
			.id(unlockedCharacterId)
			.isCheck(false)
			.build();
		unlockedCharacterRepository.save(unlockedCharacter);



		// 	도전과제 갱신하기.
		AchievementType achievementType = achievementTypeRepository.findById(currentAchievement.getId()
			.getAchievementTypeId()).orElseThrow(AchievementNotFoundException::new);

		Achievement nextAchievement = null;
		Character nextCharacter = null;

		// 마지막 단계인 경우 grade를 올리지 않고 수령했다고 표시함.
		int grade = currentAchievement.getCurrentGrade();
		if (Objects.equals(achievementType.getFinalGrade(), currentAchievement.getCurrentGrade())) {
			currentAchievement.markReceived();
			nextAchievement = achievementRepository.findByAchievementTypeIdAndGrade(achievementTypeId,
					currentAchievement.getCurrentGrade())
				.orElseThrow(AchievementNotFoundException::new);
			nextCharacter = character;
		} else {
			currentAchievement.toNextGrade();
			// 다음 도전과제 상세 내용 불러오기
			nextAchievement = achievementRepository.findByAchievementTypeIdAndGrade(achievementTypeId,
					currentAchievement.getCurrentGrade())
				.orElseThrow(AchievementNotFoundException::new);

			// 다음 캐릭터 불러오기
			nextCharacter = characterRepository.findByAchievementTypeAndGrade(
				nextAchievement.getAchievementType().getId(),nextAchievement.getGrade()
			);
			float progress = 0.0f;
			switch (achievementType.getCriteria()) {
				case DISTANCE -> {
					progress = recordSummary.getTotalDistance();
				}
				case DURATION -> {
					progress = recordSummary.getTotalDuration();
				}
				case COUNT_WINS -> {
					progress = recordSummary.getCountWins();
				}
				case COUNT_FRIENDS -> {
					progress = countFriends;
				}
			}
			currentAchievement.updateProgress(progress);
		}
		currentAchievementRepository.save(currentAchievement);

		// 	다음 도전과제 리턴
		return AchievementResDto.builder()
			.achievementType(achievementType)
			.achievement(nextAchievement)
			.currentAchievement(currentAchievement)
			.character(nextCharacter)
			.prevGoal(achievement.getGoal())
			.build();

	}
}
