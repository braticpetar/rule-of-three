class_name GhostAttackingState extends GhostState

static var state_name = "GhostAttackingState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	ghost.velocity = Vector2(0, 0)
	ghost.hitbox.set_deferred("disabled", false)
	ghost.attack_area.set_deferred("disabled", true)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("attack")
	ghost.handle_facing()
	 # Turn on hitbox
	
	
	# Flip the boxes depending on player's facing
	if ghost._facing == 0:
		ghost.hitbox.scale.x = abs(ghost.hitbox.scale.x) * -1
	elif ghost._facing == 1:
		ghost.hitbox.scale.x = abs(ghost.hitbox.scale.x)
		
	
func exit() -> void:
	pass#ghost.hitbox.set_deferred("disabled", true)
	
