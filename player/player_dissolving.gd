class_name PlayerDissolvingState extends PlayerState

static var state_name = "PlayerDissolvingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	player.velocity = Vector2(0,0) # Stop moving
	animation.play("dissolve")
	player._teleporting = true # Send signal
	
	# Enable for smooth camera transition
	player.camera.position_smoothing_enabled = true
	player.camera.position_smoothing_speed = 10.0
	
func exit() -> void:
	# Play correct animation
	animation.play("dissolve")
		

	
	
	
	
