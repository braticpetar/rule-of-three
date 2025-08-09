extends Node2D

# Be consumed, functions the same as damage, just does negative damage
func _on_custom_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
