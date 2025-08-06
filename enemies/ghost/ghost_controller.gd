class_name GhostController extends CharacterBody2D

enum Facing {
	LEFT,
	RIGHT
}

var _facing: Facing = Facing.RIGHT
var health = 10

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var area = $AnimatedSprite2D/CustomHurtBox/CollisionShape2D
#@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	var states: Array[State] = [GhostIdleState.new(self)]
	state_machine.start_machine(states)
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func handle_facing() -> void:	
	if velocity.x < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
	elif velocity.x > 0.0:
		animation.flip_h = false
		_facing = Facing.RIGHT

func take_damage(amount: int) -> void:
	print(health)
