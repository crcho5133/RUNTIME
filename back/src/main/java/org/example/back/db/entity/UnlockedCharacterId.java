package org.example.back.db.entity;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Embeddable
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class UnlockedCharacterId implements Serializable {
	@Column(name = "character_id", nullable = false)
	private Long characterId;

	@Column(name = "mmeber_id", nullable = false)
	private Long memberId;
}
