class_name GhostController extends CharacterBody2D

enum Facing {
	LEFT,
	RIGHT
}

var _facing: Facing = Facing.RIGHT
var health = 3

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var hurt_box = $AnimatedSprite2D/CustomHurtBox/CollisionShape2D
#@onready var collision_shape = $CollisionShape2D

func _ready() -> void:
	var states: Array[State] = [GhostIdleState.new(self), GhostDeathState.new(self)]
	state_machine.start_machine(states)

func _process(delta: float) -> void:
	if state_machine.current_state.get_state_name() != GhostDeathState.state_name and health <= 0:
		state_machine.transition(GhostDeathState.state_name)
		#self.queue_free()

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
	health -= amount
	print(health)

func _on_animated_sprite_2d_animation_finished() -> void:
	var current = state_machine.current_state.get_state_name()
	# Only if player dissolved, transition to condense
	if current == GhostDeathState.state_name:
		queue_free()
