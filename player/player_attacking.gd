class_name PlayerAttackingState extends PlayerState

static var state_name = "PlayerAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	animation.play("attack")

	
	
	
