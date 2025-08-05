class_name State

# Called when state machine enters a certain state
func enter() -> void:
	pass
	
# We call this method when the state ends
func exit() -> void:
	pass
	
# Called upon registered input from user
func input(_event: InputEvent) -> void:
	pass

# Called in Godot's main update loop
func process(_delta: float) -> void:
	pass
	
# Called in Godot's main physics update loop
func physics_process(_delta: float) -> void:
	pass
	
func get_state_name() -> String:
	push_error("It is mandatory to define get_state_name() method")
	return ""
