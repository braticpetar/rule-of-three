class_name GhostAttackingState extends GhostState

static var state_name = "GhostAttackingState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	ghost.velocity = Vector2(0, 0)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("attack")
	ghost.handle_facing()
	ghost.hitbox.set_deferred("disabled", false) # Turn on hitbox
	
	# Flip the boxes depending on player's facing
	if ghost._facing == 0:
		ghost.hitbox.scale.x = abs(ghost.hitbox.scale.x) * -1
	elif ghost._facing == 1:
		ghost.hitbox.scale.x = abs(ghost.hitbox.scale.x)
	
func exit() -> void:
	ghost.hitbox.set_deferred("disabled", true)
