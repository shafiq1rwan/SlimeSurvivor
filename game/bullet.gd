extends Area2D

var TRAVELLED_DISTANCE = 0

func _physics_process(delta):
	const RANGE = 1200
	const SPEED = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	TRAVELLED_DISTANCE += SPEED * delta
	if TRAVELLED_DISTANCE > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	
	const IMPACT = preload("res://pistol/impact/impact.tscn")
	var impact = IMPACT.instantiate()
	get_parent().add_child(impact)
	impact.global_position = global_position
	
	if body.has_method("take_damage"):
		body.take_damage()
