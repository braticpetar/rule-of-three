class_name EnemyAttackingState extends EnemyState

static var state_name = "EnemyAttackingState"

const STOP_FORCE: float = 15.0

func enter() -> void:
	enemy.velocity = Vector2(0, 0)
	enemy.hitbox_shape.set_deferred("disabled", false)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	animation.play("attack")
	enemy.handle_facing()
	
func exit() -> void:
	enemy.hitbox_shape.set_deferred("disabled", true)
		
	
