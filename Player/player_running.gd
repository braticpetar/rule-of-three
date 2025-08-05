class_name PlayerRunningState extends PlayerState

static var state_name = "PlayerRunningState"

const ACCELERATION: float = 20.0
const MAX_SPEED: float = 150.0

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("walk")
	player.handle_facing()
	
func physics_process(_delta: float) -> void:
	var input: float = player.horizontal_input * ACCELERATION
	
	# If there is no input, transition back to idle state
	if input == 0.0:
		state_machine.transition(PlayerIdleState.state_name)
		pass
	
	player.velocity.x += input
	player.velocity.x = clamp(player.velocity.x, -MAX_SPEED, MAX_SPEED)
