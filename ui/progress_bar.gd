extends ProgressBar

func _ready():
	PlayerSingleton.health_changed.connect(update)
	update()
	

func update():
	value = PlayerSingleton.health
	print("HEALTH: ", value)
	
