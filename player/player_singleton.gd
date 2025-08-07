extends Node

var player: CharacterBody2D = null

func get_player_position() -> Vector2:
	if is_instance_valid(player):
		return player.global_position
	return Vector2.ZERO
