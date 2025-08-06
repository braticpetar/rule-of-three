class_name PlayerIdleState extends PlayerState

static var state_name = "PlayerIdleState"

func get_state_name() -> String:
	return state_name

func enter() -> void:
	player.attack_count = 0
	
func process(_delta: float) -> void:
	animation.play("idle")
	player.handle_facing()
	
func physics_process(_delta: float) -> void:
	if player.horizontal_input != 0.0:
		state_machine.transition(PlayerRunningState.state_name)
