class_name GrimIdleState extends GrimState

static var state_name = "GrimIdleState"

const SPEED: float = 20

func enter() -> void:
	grim.velocity = Vector2.ZERO
	
func exit() -> void:
	grim.velocity = Vector2.ZERO

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("idle")
	grim.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - grim.global_position).normalized()
	grim.velocity.x  = direction.x * SPEED
	grim.move_and_slide()
	

		
		
