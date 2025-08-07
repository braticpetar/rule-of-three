class_name GrimDeathState extends GrimState

static var state_name = "GrimDeathState"

func enter() -> void:
	grim.velocity = Vector2(0, 0)
	animation.play("vanish")
	grim.hitbox.set_deferred("disabled", true)

func get_state_name() -> String:
	return state_name
	
func process(_delta: float) -> void:
	
	grim.handle_facing()
	
#func exit() -> void:
