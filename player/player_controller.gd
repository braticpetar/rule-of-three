class_name PlayerController extends CharacterBody2D

# Enum used to determine if we should flip sprites or not
enum Facing {
	LEFT,
	RIGHT
}

var horizontal_input: float = 0.0 # Used for character movement
var dissolve_distance: Vector2 # Used for teleportation
var _facing: Facing = Facing.RIGHT # Setting default value that character is facing right
var attack_count: int = 0

# Setting onready variables
@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var camera = $Camera2D
@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	# We initialize the array with all states and start the machine
	var states: Array[State] = [PlayerIdleState.new(self), PlayerRunningState.new(self), PlayerLightAttackingState.new(self), PlayerDissolvingState.new(self), PlayerCondensingState.new(self), PlayerHeavyAttackingState.new(self)]
	state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	# We get horizontal input to determine x value of position vector, as well as direction player is facing
	horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	move_and_slide() # Mandatory function for movement in physics process

# Handilng user input
func _input(event: InputEvent) -> void:
	# Switch to attack state if player pressed attack button
	if event.is_action_pressed("attack"):
		attack_count += 1
		state_machine.transition(PlayerLightAttackingState.state_name)
		
	# Player needs to hold "dissolve" and then determine the direction
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("up"):
			dissolve_distance = Vector2(0.0, -50.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("down"):
			dissolve_distance = Vector2(0.0, 50.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("left"):
			dissolve_distance = Vector2(-300.0, 0.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("right"):
			dissolve_distance = Vector2(300.0, 0.0)
			state_machine.transition(PlayerDissolvingState.state_name)

func handle_facing() -> void:
	# If x vector is negative, flip the animation, set facing to left
	if horizontal_input < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
	# If x vector is positive, don't flip the animation, set facing to right
	elif horizontal_input > 0.0:
		animation.flip_h = false
		_facing = Facing.RIGHT

# Emits the signal upon finished animation
func _on_animated_sprite_2d_animation_finished() -> void:
	# Only if player dissolved, transition to condense
	if state_machine.current_state.get_state_name() == PlayerDissolvingState.state_name:
		state_machine.transition(PlayerCondensingState.state_name)
	# If attack combo is scheduled, then chain light and heavy attacks
	if state_machine.current_state.get_state_name() == PlayerLightAttackingState.state_name and attack_count > 1:
		state_machine.transition(PlayerHeavyAttackingState.state_name)
	# In any other case, go back to idle state
	else:
		state_machine.transition(PlayerIdleState.state_name)
		
