extends CharacterBody2D

signal slime_mob_depleted
@onready var player = $"../Player"
var health = 3
var knockbarPower: int = 800

func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200.0
	move_and_slide()

func knockback():
	var knockbackDirection = -velocity.normalized() * knockbarPower
	velocity = knockbackDirection
	move_and_slide()

func take_damage():
	
	health -= 1
	knockback()
	%SlimeProgressBar.value = health
	%Slime.play_hurt()
	
	if health == 0:
		slime_mob_depleted.emit()
		GameManager.TOTAL_POINTS += 1
		GameManager.TOTAL_DEFEATED_MONSTER += 1
		queue_free()
		
		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_EXPLOSION.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
