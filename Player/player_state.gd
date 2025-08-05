class_name PlayerState extends State

var player: PlayerController
var animation = AnimatedSprite2D
var state_machine: StateMachine

func _init(player_controller: PlayerController) -> void:
	player = player_controller
	animation = player.animation
	state_machine = player.state_machine
