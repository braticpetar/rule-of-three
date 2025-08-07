class_name GhostController extends CharacterBody2D

signal health_changed

enum Facing {
	LEFT,
	RIGHT
}

var _facing: Facing = Facing.LEFT
var health = 3

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var hurt_box = $AnimatedSprite2D/CustomHurtBox/CollisionShape2D
@onready var hitbox = $CustomHitBox/CollisionShape2D
@onready var attack_area = $AttackingArea/CollisionShape2D
@onready var health_bar = $ProgressBar

func _ready() -> void:
	var states: Array[State] = [GhostIdleState.new(self), GhostDeathState.new(self), GhostAttackingState.new(self), GhostChasingState.new(self)]
	state_machine.start_machine(states)

func _process(delta: float) -> void:
	if state_machine.current_state.get_state_name() != GhostDeathState.state_name and health <= 0:
		state_machine.transition(GhostDeathState.state_name)
		#self.queue_free()

func _physics_process(delta: float) -> void:
	move_and_slide()

func handle_facing() -> void:	
	if velocity.x < 0.0:
		animation.flip_h = false
		_facing = Facing.LEFT
	elif velocity.x > 0.0:
		animation.flip_h = true
		_facing = Facing.RIGHT

func take_damage(amount: int) -> void:
	health -= amount
	health_changed.emit()
	flash_white()
	print(health)

func _on_animated_sprite_2d_animation_finished() -> void:
	var current = state_machine.current_state.get_state_name()
	# Only if player dissolved, transition to condense
	if current == GhostDeathState.state_name:
		queue_free()
		
func flash_white(duration := 0.3) -> void:
	animation.modulate = Color(123, 219, 71)
	await get_tree().create_timer(duration).timeout
	animation.modulate = Color(1, 1, 1, 1)


func _on_chasing_area_body_entered(body) -> void:
	state_machine.transition(GhostChasingState.state_name)
	print("entered")

func _on_chasing_area_body_exited(body: Node2D) -> void:
	state_machine.transition(GhostIdleState.state_name)
	print("exited")


func _on_attacking_area_body_entered(body: Node2D) -> void:
	state_machine.transition(GhostAttackingState.state_name)


func _on_attacking_area_body_exited(body: Node2D) -> void:
	state_machine.transition(GhostChasingState.state_name)
