class_name PlayerLightAttackingState extends PlayerState

static var state_name = "PlayerLightAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	player.light_sword_collision.set_deferred("disabled", false)
	animation.play("attack_light")
	
func exit() -> void:
	player.light_sword_collision.set_deferred("disabled", true)

	
	
	
