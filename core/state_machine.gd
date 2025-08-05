class_name StateMachine extends Node

var current_state: State
# We keep a list of all states in a dictionary
var states: Dictionary = {}

# Initializes all states and sets current state to the first one in the dict
func start_machine(init_states: Array[State]) -> void:
	for state in init_states:
		states[state.get_state_name()] = state
		
	current_state = init_states[0]
	current_state.enter()

func _process(delta:float) -> void:
	current_state.process(delta)
	
func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	
# Function for transitioning between states
func transition(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name)
	var current_state_name = current_state.get_state_name()
	
	if new_state == null:
		# New state cannot be null
		push_error("Can't transition to the state: STATE DOES NOT EXIST (%s)" % new_state_name)
	elif new_state == current_state:
		# We don't do anything if new and old states are the same
		push_warning("Ignoring the request. new_state and current_state are the same!")
		pass
	else:
		# Exit the old state, set current variable to desired state, enter the new state
		current_state.exit()
		current_state = states[new_state.get_state_name()]
		current_state.enter()
