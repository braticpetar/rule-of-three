class_name GhostDeathState extends GhostState

static var state_name = "GhostDeathState"

func enter() -> void:
	animation.play("vanish")

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	
	ghost.handle_facing()
	
#func exit() -> void:
