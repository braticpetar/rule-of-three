extends ProgressBar

@export var enemy: Node

func _ready():
	enemy.health_changed.connect(update)
	update()
	

func update():
	value = enemy.health
	print("HEALTH: ", value)
	
