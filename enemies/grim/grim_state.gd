class_name GrimState extends State

var grim: GrimController
var animation = AnimatedSprite2D
var state_machine: StateMachine

func _init(grim_controller: GrimController) -> void:
	grim = grim_controller
	animation = grim.animation
	state_machine = grim.state_machine
