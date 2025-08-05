class_name PlayerController extends CharacterBody2D

enum Facing {
	LEFT,
	RIGHT
}

var horizontal_input: float = 0.0
var _facing: Facing = Facing.RIGHT

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine

func _ready() -> void:
	var states: Array[State] = [PlayerIdleState.new(self), PlayerRunningState.new(self), PlayerAttackingState.new(self)]
	state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_just_released("attack"):
		state_machine.transition(PlayerAttackingState.state_name)
	
	move_and_slide()
	
func handle_facing() -> void:	
	if horizontal_input < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
	elif horizontal_input > 0.0:
		animation.flip_h = false
		_facing = Facing.RIGHT


func _on_animated_sprite_2d_animation_looped() -> void:
	state_machine.transition(PlayerIdleState.state_name)
