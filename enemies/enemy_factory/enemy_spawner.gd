class_name EnemySpawner
extends Node2D

@export var enemy_factory: EnemyFactory
@export var enemy_scene: PackedScene
@export var spawn_interval: float = 5.0

var spawn_timer: Timer

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
