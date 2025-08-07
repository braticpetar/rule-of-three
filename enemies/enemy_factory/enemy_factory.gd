class_name EnemyFactory
extends Node

func spawn_enemy(enemy_scene: PackedScene) -> Node:
	var enemy = enemy_scene.instantiate()
	return enemy 
