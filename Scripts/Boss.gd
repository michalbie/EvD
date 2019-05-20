extends KinematicBody2D

signal died

export(float) var move_speed

var velocity : Vector2
var max_hp
var hp

func _ready():
	go_forward()
	
func set_max_hp(new_max_hp):
	max_hp = new_max_hp
	hp = max_hp
	$HPBar/HP.max_value = max_hp
	$HPBar/HP.value = hp
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		on_collision_hit(collision)
	
	$HPBar/HPLabel.text = str(hp)
	
func on_collision_hit(collision):
	# Because of collision layer and mask, dwarf definitly
	# collided with arrow so we can remove it
	var arrow = collision.collider
	arrow.queue_free()
	
	hp -= arrow.force
	if hp <= 0:
		emit_signal("died")
		queue_free()
	else:
		$HPBar/HP.value = hp
		
func _on_DwarfSpace_area_entered(area):
	velocity = Vector2.ZERO

func go_forward():
	velocity = Vector2(-move_speed, 0)
	