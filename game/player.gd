extends CharacterBody2D

signal health_depleted
var health = 100.0
var dash_speed = 3000

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	
	if(Input.is_action_just_pressed("dash")):
		velocity = direction * dash_speed
		ghosting()
	
	move_and_slide()
	
	if velocity.length() > 0.00:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()
	
	const DAMAGE_RATE = 10.0	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
func ghosting():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate", Color(1,1,1,1), 0.75)
	await tween_fade.finished
