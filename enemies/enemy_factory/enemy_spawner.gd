class_name EnemySpawner
extends Node2D

signal health_changed

@export var enemy_factory: EnemyFactory
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 5.0

@onready var sprite = $Sprite2D

var spawn_timer: Timer
var health = 20

func _ready():
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

func _on_spawn_timer_timeout():
	var enemy = enemy_factory.spawn_enemy(enemy_scene)

	if enemy:
		enemy.global_position = global_position
		get_tree().current_scene.add_child(enemy)
		
func take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		queue_free()
	else:
		health_changed.emit()
		flash_white()
		print(health)
	
func flash_white(duration := 0.3) -> void:
	sprite.modulate = Color(123, 219, 71)
	await get_tree().create_timer(duration).timeout
	sprite.modulate = Color(1, 1, 1, 1)
