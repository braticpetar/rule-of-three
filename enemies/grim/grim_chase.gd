class_name GrimChasingState extends GrimState

static var state_name = "GrimChasingState"

const ACCELERATION: float = 10.0
const MAX_SPEED: float = 50.0

func enter() -> void:
	grim.attack_area.set_deferred("disabled", false)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("move")
	grim.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - grim.global_position).normalized()
	grim.velocity.x  = direction.x * MAX_SPEED
	grim.move_and_slide()
