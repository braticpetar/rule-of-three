extends Node

signal health_changed

var player: CharacterBody2D = null
var health = 10


func get_player_position() -> Vector2:
	if is_instance_valid(player):
		return player.global_position
	return Vector2.ZERO
