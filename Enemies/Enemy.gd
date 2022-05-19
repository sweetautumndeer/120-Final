extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var motion = Vector2.ZERO
var GRAVITY = 250
export var enemy_health = 5
var bullet = preload("res://Player/bullet.tscn")
var fire_pause

#can only fall, does not move
func _physics_process(delta):
	motion.y += GRAVITY * delta
	motion.x = 0
	
	motion = move_and_slide(motion)
	
	


func _on_Area2D_body_entered(body):
	print(body)


#if area2D node enters enemy hurtbox, will damage health. once no more health, is deleted
func _on_Area2D_area_entered(area):
	print(area.name)
	enemy_health -= 1
	print(enemy_health)
	if enemy_health == 0:
		queue_free()
