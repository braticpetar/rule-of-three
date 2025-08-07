class_name GhostChasingState extends GhostState

static var state_name = "GhostChasingState"

const ACCELERATION: float = 10.0
const MAX_SPEED: float = 50.0

func enter() -> void:
	ghost.attack_area.set_deferred("disabled", false)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("move")
	ghost.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - ghost.global_position).normalized()
	ghost.velocity.x  = direction.x * MAX_SPEED
	ghost.move_and_slide()
