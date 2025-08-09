class_name GrimAttackingState extends GrimState

static var state_name = "GrimAttackingState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	grim.velocity = Vector2(0, 0)
	grim.hitbox_shape.set_deferred("disabled", false)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("attack")
	grim.handle_facing()
		
	
