class_name GhostState extends State

var ghost: GhostController
var animation = AnimatedSprite2D
var state_machine: StateMachine

func _init(ghost_controller: GhostController) -> void:
	ghost = ghost_controller
	animation = ghost.animation
	state_machine = ghost.state_machine
