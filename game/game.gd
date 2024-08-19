extends Node2D

func _physics_process(delta):
	%LabelPoint.text = "Points: " + str(GameManager.HIT_POINTS)

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
	get_tree().paused = true

func _on_reload_button_pressed():
	get_tree().change_scene_to_file("res://game/game.tscn")
