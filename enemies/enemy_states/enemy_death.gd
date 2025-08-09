class_name EnemyDeathState extends EnemyState

static var state_name = "EnemyDeathState"

func enter() -> void:
	enemy.velocity = Vector2(0, 0)
	animation.play("vanish")
	enemy.hitbox.set_deferred("disabled", true)
	enemy.collision_shape.set_deferred("disabled", true)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	
	enemy.handle_facing()
	
#func exit() -> void:
