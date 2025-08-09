class_name EnemyState extends State

var enemy: EnemyController
var animation = AnimatedSprite2D
var state_machine: StateMachine

func _init(enemy_controller: EnemyController) -> void:
	enemy = enemy_controller
	animation = enemy.animation
	state_machine = enemy.state_machine
