class_name PlayerController extends CharacterBody2D

# Enum used to determine if we should flip sprites or not
enum Facing {
	LEFT,
	RIGHT
}

var horizontal_input: float = 0.0 # Used for character movement
var dissolve_distance: Vector2 # Used for teleportation
var _facing: Facing = Facing.RIGHT # Setting default value that character is facing right
var attack_count: int = 0 # We use this variable to determine is attack combo needs to be chained
var _teleporting = false # If player is teleporting, can't do anything else
var _attacking = false

# Setting onready variables
@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var camera = $Camera2D
@onready var boxes = $Boxes
@onready var light_sword_hitbox = $Boxes/CustomHitBoxLight/CollisionShape2D
@onready var heavy_sword_hitbox = $Boxes/CustomHitBoxHard/CollisionShape2D

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
	# Player needs to hold "dissolve" and then determine the direction
	if event.is_action_pressed("dissolve") and Input.is_action_pressed("up") and not _teleporting:
			dissolve_distance = Vector2(0.0, -50.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("down") and not _teleporting:
			dissolve_distance = Vector2(0.0, 50.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("left") and not _teleporting:
			dissolve_distance = Vector2(-300.0, 0.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	elif event.is_action_pressed("dissolve") and Input.is_action_pressed("right") and not _teleporting:
			dissolve_distance = Vector2(300.0, 0.0)
			state_machine.transition(PlayerDissolvingState.state_name)
	
	# Count if we need a combo or not
	elif event.is_action_pressed("attack"):
		attack_count += 1
		# Only if player is not already attacking or teleporting, we switch to attacking state
		if not _teleporting and not _attacking:
			state_machine.transition(PlayerLightAttackingState.state_name)

func handle_facing() -> void:
	# If x vector is negative, flip the animation, set facing to left
	if horizontal_input < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
	# If x vector is positive, don't flip the animation, set facing to right
	elif horizontal_input > 0.0:
		_facing = Facing.RIGHT
		animation.flip_h = false
		
# Emits the signal upon finished animation
func _on_animated_sprite_2d_animation_finished() -> void:
	var current = state_machine.current_state.get_state_name()
	
	# Only if player dissolved, transition to condense
	if current == PlayerDissolvingState.state_name:
		state_machine.transition(PlayerCondensingState.state_name)
	# If attack combo is scheduled, then chain light and heavy attacks
	elif current == PlayerLightAttackingState.state_name and attack_count > 1:
		state_machine.transition(PlayerHeavyAttackingState.state_name)
	# In any other case, go back to idle state
	else:
		state_machine.transition(PlayerIdleState.state_name)
		
