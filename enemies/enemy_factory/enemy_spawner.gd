class_name EnemySpawner
extends Node2D

# For progress bar
signal health_changed

@export var enemy_factory: EnemyFactory
@export var enemy_scenes: Array[PackedScene] = []
@export var spawn_interval: float = 5.0
@export var spawn_timer: Timer
@export var health: int = 200
@export var min_spawn_interval: float = 1.0
@export var max_spawn_interval: float = 5.0
@export var drop_item: PackedScene

@onready var sprite = $AnimatedSprite2D

func _ready():
	# We create a new timer and set it's paramaters
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	#Play default portal animation
	sprite.play("default")

func _on_spawn_timer_timeout():
	# Catch the error of possible empty array of enemy scenes
	if enemy_scenes.is_empty():
		return
	
	# Pick a random scene from the array and spawn that enemy
	var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
	var enemy = enemy_factory.spawn_enemy(enemy_scene)

	# Set newly spawned enemy parameters
	if enemy:
		enemy.global_position.x = global_position.x
		enemy.global_position.y = PlayerSingleton.get_player_position().y
		get_tree().current_scene.add_child(enemy)
		
	# Randomize next spawn interval	
	spawn_timer.wait_time - randf_range(min_spawn_interval, max_spawn_interval)

# Hitbox uses this method
func take_damage(amount: int) -> void:
	health -= amount
	
	if health <= 0:
		if drop_item:
			call_deferred("_spawn_drop_item")
		queue_free() # Safely remove node from the tree
	else:
		health_changed.emit() # Emit the signal to update progress bar
		flash_white() 

func _spawn_drop_item():
	var item_instance = drop_item.instantiate()
	item_instance.global_position.x = global_position.x
	item_instance.global_position.y = PlayerSingleton.get_player_position().y
	get_tree().current_scene.add_child(item_instance)


# Flash white then return to normal
func flash_white(duration := 0.3) -> void:
	sprite.modulate = Color(123, 219, 71)
	await get_tree().create_timer(duration).timeout
	sprite.modulate = Color(1, 1, 1, 1)
