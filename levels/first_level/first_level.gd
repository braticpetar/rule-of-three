extends Node2D
@onready var music: AudioStreamPlayer2D = $Music

var playlist: Array[AudioStream] = [
	preload("res://sounds/bass-guitar-death-metal.mp3"),
	preload("res://sounds/dnb-liquid.mp3"),
	preload("res://sounds/glass-buildings-liquid-jungle-breakbeat-drum-and-bass.mp3"),
	preload("res://sounds/no-remorse-instrumental.mp3"),
]

var current_index: int = 1

func _ready() -> void:
	music.stream = playlist[current_index]

func _on_music_finished():
	current_index = (current_index + 1) % playlist.size()
	music.stream = playlist[current_index]
	music.play()

func _on_tension_finished() -> void:
	print("BWEEEE")
	music.play()
