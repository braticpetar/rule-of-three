class_name PlayerIdleState extends PlayerState

static var state_name = "PlayerIdleState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	player.velocity = Vector2(0, 0)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("idle")
	player.handle_facing()
	
func physics_process(_delta: float) -> void:
	if player.horizontal_input != 0.0:
		state_machine.transition(PlayerRunningState.state_name)
