class_name PlayerCondensingState extends PlayerState

static var state_name = "PlayerCondensingState"

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	player.position += player.dissolve_distance # Teleport player
	animation.play_backwards("dissolve") # Play correct animation
	
func exit() -> void:
	player.camera.position_smoothing_enabled = false # Disable smooth camera so it doesn't get choppy
	player._teleporting = false # Send signal
