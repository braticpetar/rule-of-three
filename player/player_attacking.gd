class_name PlayerAttackingState extends PlayerState

static var state_name = "PlayerAttackingState"

var _is_attacking: bool = false

func get_state_name() -> String:
	return state_name
	
	
func process(_delta: float) -> void:
	animation.play("attack")
	
	
