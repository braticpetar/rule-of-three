class_name GhostIdleState extends GhostState

static var state_name = "GhostIdleState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	pass#ghost.velocity = Vector2(0, 0)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("idle")
	ghost.handle_facing()
	
#func physics_process(_delta: float) -> void:
	#if ghost.horizontal_input != 0.0:
		#state_machine.transition(PlayerRunningState.state_name)
