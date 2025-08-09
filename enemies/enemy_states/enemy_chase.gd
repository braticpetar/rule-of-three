class_name EnemyChasingState extends EnemyState

static var state_name = "EnemyChasingState"

const ACCELERATION: float = 10.0
const MAX_SPEED: float = 50.0

func enter() -> void:
	enemy.attack_area.set_deferred("disabled", false)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("move")
	enemy.handle_facing()
	
func physics_process(_delta: float) -> void:
	var direction = (PlayerSingleton.player.get_global_position() - enemy.global_position).normalized()
	enemy.velocity.x  = direction.x * MAX_SPEED
	enemy.move_and_slide()
