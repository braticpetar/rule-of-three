class_name PlayerController extends CharacterBody2D

enum Facing {
	LEFT,
	RIGHT
}

var horizontal_input: float = 0.0
var dissolve_distance: Vector2
var _facing: Facing = Facing.RIGHT
var _teleporting: bool = false

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine

func _ready() -> void:
	var states: Array[State] = [PlayerIdleState.new(self), PlayerRunningState.new(self), PlayerAttackingState.new(self), PlayerDissolvingState.new(self), PlayerCondensingState.new(self)]
	state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		state_machine.transition(PlayerAttackingState.state_name)
		
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
	if horizontal_input < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
	elif horizontal_input > 0.0:
		animation.flip_h = false
		_facing = Facing.RIGHT

# Emits the signal upon finished animation
func _on_animated_sprite_2d_animation_finished() -> void:
	if state_machine.current_state.get_state_name() == PlayerDissolvingState.state_name:
		state_machine.transition(PlayerCondensingState.state_name)
	else:
		state_machine.transition(PlayerIdleState.state_name)
		
