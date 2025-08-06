class_name PlayerLightAttackingState extends PlayerState

static var state_name = "PlayerLightAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	animation.play("attack_light")

	
	
	
