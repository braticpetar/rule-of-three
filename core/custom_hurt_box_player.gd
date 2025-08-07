class_name CustomHurtBoxPlayer

extends Area2D

var overlapping_hitbox: CustomHitBox = null
var damage_timer
	
func _ready() -> void:
	connect("area_entered", self._on_area_entered)
	connect("area_exited", self._on_area_exited)
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 1.0
	damage_timer.one_shot = false
	add_child(damage_timer)
	damage_timer.timeout.connect(_on_timer_timeout)
	
func _on_area_entered(hitbox: CustomHitBox) -> void:
	if hitbox == null:
		return
		
	overlapping_hitbox = hitbox
	owner.take_damage(overlapping_hitbox.damage)
	damage_timer.start()
		
func _on_area_exited(hitbox: CustomHitBox) -> void:
	if hitbox == overlapping_hitbox:
		damage_timer.stop()
		overlapping_hitbox = null
	
func _on_timer_timeout() -> void:
	if overlapping_hitbox and owner.has_method("take_damage"):
		owner.take_damage(overlapping_hitbox.damage)
	
	
