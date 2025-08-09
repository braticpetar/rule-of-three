extends Node2D

func _ready() -> void:
	$AnimationPlayer.get_animation("default").loop = true
	$AnimationPlayer.play("default")

# Be consumed, functions the same as damage, just does negative damage
func _on_custom_hit_box_area_entered(area: Area2D) -> void:
	queue_free()
