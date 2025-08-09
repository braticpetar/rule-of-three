class_name EnemyIdleState extends EnemyState

static var state_name = "EnemyIdleState"

const SPEED: float = 20

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	
func exit() -> void:
	enemy.velocity = Vector2.ZERO

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("idle")
	enemy.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - enemy.global_position).normalized()
	enemy.velocity.x  = direction.x * SPEED
	enemy.move_and_slide()
	

		
		
