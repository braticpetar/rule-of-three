class_name PlayerController extends CharacterBody2D

var horizontal_input: float = 0.0

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine

func _ready() -> void:
	var states: Array[State] = [PlayerIdleState.new(self), PlayerRunningState.new(self)]
	state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	move_and_slide()
