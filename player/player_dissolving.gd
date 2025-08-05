class_name PlayerDissolvingState extends PlayerState

static var state_name = "PlayerDissolvingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	player.velocity = Vector2(0,0)
	animation.play("dissolve")

	
	
	
	
