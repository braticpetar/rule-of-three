class_name GhostDeathState extends GhostState

static var state_name = "GhostDeathState"

func enter() -> void:
	ghost.velocity = Vector2(0, 0)
	animation.play("vanish")
	ghost.hitbox.set_deferred("disabled", true)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	
	ghost.handle_facing()
	
#func exit() -> void:
