class_name PlayerLightAttackingState extends PlayerState

static var state_name = "PlayerLightAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	animation.play("attack_light")
	player.light_sword_hitbox.set_deferred("disabled", false) # Turn on hitbox
	player._attacking = true # Send signal
	
	# Flip the boxes depending on player's facing
	if player._facing == 0:
		player.boxes.scale.x = abs(player.boxes.scale.x) * -1
	elif player._facing == 1:
		player.boxes.scale.x = abs(player.boxes.scale.x)
	
func _process() -> void:
	pass#player.handle_facing()
	
func exit() -> void:
	player.light_sword_hitbox.set_deferred("disabled", true) # Disable hitbox
	player._attacking = false # Send signal

	
	
	
