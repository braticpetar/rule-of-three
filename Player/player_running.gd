class_name PlayerRunningState extends PlayerState

static var state_name = "PlayerRunningState"

const ACCELERATION: float = 20.0
const MAX_SPEED: float = 150.0

func get_state_name() -> String:
	return state_name
	
func physics_process(_delta: float) -> void:
	var input: float = player.horizontal_input * ACCELERATION
	
	player.velocity.x += input
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
