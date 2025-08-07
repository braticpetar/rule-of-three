class_name GrimAttackingState extends GrimState

static var state_name = "GrimAttackingState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	grim.velocity = Vector2(0, 0)
	grim.hitbox.set_deferred("disabled", false)
	#ghost.attack_area.set_deferred("disabled", true)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("attack")
	grim.handle_facing()
	 # Turn on hitbox
	
	# Flip the boxes depending on player's facing
	if grim._facing == 0:
		grim.hitbox.scale.x = abs(grim.hitbox.scale.x) * -1
	elif grim._facing == 1:
		grim.hitbox.scale.x = abs(grim.hitbox.scale.x)
		
	
