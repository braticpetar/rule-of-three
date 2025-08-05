class_name PlayerCondensingState extends PlayerState

static var state_name = "PlayerCondensingState"
var _teleporting: bool = true

func get_state_name() -> String:
	return state_name
	
func enter() -> void:
	player.velocity = Vector2(0,0)
	player.position += player.dissolve_distance
	animation.play_backwards("dissolve")	

		
	
	
	
	
	
