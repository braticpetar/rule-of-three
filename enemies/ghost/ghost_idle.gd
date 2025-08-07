class_name GhostIdleState extends GhostState

static var state_name = "GhostIdleState"

const SPEED: float = 20

func enter() -> void:
	ghost.velocity = Vector2.ZERO
	
func exit() -> void:
	ghost.velocity = Vector2.ZERO

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("idle")
	ghost.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - ghost.global_position).normalized()
	ghost.velocity.x  = direction.x * SPEED
	ghost.move_and_slide()
	

		
		
