class_name PlayerHeavyAttackingState extends PlayerState

static var state_name = "PlayerHeavyAttackingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	animation.play("attack_heavy")
	player.heavy_sword_hitbox.set_deferred("disabled", false) # Turn on hitbox
	player._attacking = true # Send signal
	
	# Flip boxes depending on the side player is facing
	if player._facing == 0:
		player.boxes.scale.x = abs(player.boxes.scale.x) * -1
	elif player._facing == 1:
		player.boxes.scale.x = abs(player.boxes.scale.x)
	
func _process(delta: float) -> void:
	pass#player.handle_facing()
	
func exit() -> void:
	player.heavy_sword_hitbox.set_deferred("disabled", true) # Disable hitbox
	player._attacking = false # Send signal

	
	
	
