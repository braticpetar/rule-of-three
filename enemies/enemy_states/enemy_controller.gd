class_name EnemyController extends CharacterBody2D

signal health_changed

enum Facing {
	LEFT,
	RIGHT
}

@export var _facing: Facing = Facing.RIGHT
@export var health = 5
@export var speed = 10
var previous_color

@onready var animation = $AnimatedSprite2D
@onready var state_machine = $StateMachine
@onready var hurt_box = $AnimatedSprite2D/CustomHurtBox/CollisionShape2D
@onready var hitbox = $CustomHitBox
@onready var hitbox_shape = $CustomHitBox/CollisionShape2D
@onready var attack_area = $AttackingArea
@onready var health_bar = $ProgressBar
@onready var collision_shape = $CollisionShape2D
@onready var take_damage_sfx: AudioStreamPlayer2D = $sounds/take_damage
@onready var death_sfx: AudioStreamPlayer2D = $sounds/death


func _ready() -> void:
	previous_color = animation.get_modulate()
	var states: Array[State] = [EnemyIdleState.new(self), EnemyDeathState.new(self), EnemyAttackingState.new(self), EnemyChasingState.new(self)]
	state_machine.start_machine(states)

func _process(delta: float) -> void:
	if state_machine.current_state.get_state_name() != EnemyDeathState.state_name and health <= 0:
		death_sfx.play()
		state_machine.transition(EnemyDeathState.state_name)

func _physics_process(delta: float) -> void:
	move_and_slide()

func handle_facing() -> void:	
	if velocity.x < 0.0:
		animation.flip_h = true
		_facing = Facing.LEFT
		hitbox.scale.x = abs(hitbox.scale.x) * -1
		attack_area.scale.x = abs(attack_area.scale.x) * -1
	elif velocity.x > 0.0:
		animation.flip_h = false
		_facing = Facing.RIGHT
		hitbox.scale.x = abs(hitbox.scale.x)
		attack_area.scale.x = abs(attack_area.scale.x)


func take_damage(amount: int) -> void:
	flash_white()
	take_damage_sfx.play()
	health -= amount
	health_changed.emit()
	print(health)

func _on_animated_sprite_2d_animation_finished() -> void:
	var current = state_machine.current_state.get_state_name()
	# Only if player dissolved, transition to condense
	if current == EnemyDeathState.state_name:
		queue_free()
		
func flash_white(duration := 0.3) -> void:
	animation.modulate = Color(123, 219, 71)
	await get_tree().create_timer(duration).timeout
	animation.modulate = previous_color


func _on_chasing_area_body_entered(_body) -> void:
	state_machine.transition(EnemyChasingState.state_name)

func _on_chasing_area_body_exited(_body: Node2D) -> void:
	state_machine.transition(EnemyIdleState.state_name)


func _on_attacking_area_body_entered(_body: Node2D) -> void:
	state_machine.transition(EnemyAttackingState.state_name)


func _on_attacking_area_body_exited(_body: Node2D) -> void:
	state_machine.transition(EnemyChasingState.state_name)
