extends Area2D

func _physics_process(delta):
	#var enemies_in_range = get_overlapping_bodies()
	#if enemies_in_range.size() > 0:
		#var target_enemy = enemies_in_range.front()
		#look_at(target_enemy.global_position)
	
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	const BULLET = preload("res://game/bullet.tscn")
	const MUZZLE_FLASH = preload("res://pistol/muzzle_flash/muzzle_flash.tscn")
	
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	$SFXShoot.play()

#func _on_timer_timeout():
	#shoot()
