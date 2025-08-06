class_name PlayerHeavyAttackingState extends PlayerState

static var state_name = "PlayerHeavyAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	animation.play("attack_heavy")

	
	
	
