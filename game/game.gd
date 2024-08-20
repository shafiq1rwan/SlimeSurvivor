extends Node2D

var is_paused = false

func _process(_delta):
	%LabelPoint.text = "Points: " + str(GameManager.HIT_POINTS)
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if is_paused:
		%PausedScreen.visible = true
		Engine.time_scale = 0
	else:
		%PausedScreen.visible = false
		Engine.time_scale = 1
		
	is_paused = !is_paused

func spawn_mob():
	var SLIME_MOB = preload("res://game/slime_mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	SLIME_MOB.global_position = %PathFollow2D.global_position
	add_child(SLIME_MOB)

func spawn_trees():
	pass

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%GameOverScreen.visible = true
	Engine.time_scale = 0

func _on_resume_button_pressed():
	%PausedScreen.visible = false
	Engine.time_scale = 1
	is_paused = !is_paused
