extends Node2D

var is_paused = false

func _process(_delta):
	%LabelPoint.text = "Points: " + str(GameManager.TOTAL_POINTS)
	%PlayerProgressBar.value = GameManager.HIT_POINTS
	%LabelLevel.text = "Level: " + str(GameManager.CURRENT_LEVEL)
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
	GameManager.TOTAL_CURRENT_MONSTER += 1

func spawn_trees():
	pass

func _on_timer_timeout():
	if GameManager.TOTAL_CURRENT_MONSTER < GameManager.TOTAL_MINIMUM_MONSTER:
		spawn_mob()
	
	if GameManager.TOTAL_DEFEATED_MONSTER == GameManager.TOTAL_CURRENT_MONSTER:
		GameManager.CURRENT_LEVEL += 1
		GameManager.TOTAL_CURRENT_MONSTER = 0
		GameManager.TOTAL_DEFEATED_MONSTER = 0
		GameManager.TOTAL_MINIMUM_MONSTER += 2
		print("Masuk condition match sini")

func _on_player_health_depleted():
	%GameOverScreen.visible = true
	Engine.time_scale = 0

func _on_resume_button_pressed():
	%PausedScreen.visible = false
	Engine.time_scale = 1
	is_paused = !is_paused
