extends Area2D

var TRAVELLED_DISTANCE = 0

func _physics_process(delta):
	const RANGE = 0
	const SPEED = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	#TRAVELLED_DISTANCE += SPEED * delta
	#if TRAVELLED_DISTANCE > RANGE:
		#queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
