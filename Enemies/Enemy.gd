extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var motion = Vector2.ZERO
var GRAVITY = 250
export var enemy_health = 5


func _physics_process(delta):
	motion.y += GRAVITY * delta
	
	motion = move_and_slide(motion)


func _on_Area2D_body_entered(body):
	print(body)


func _on_Area2D_area_entered(area):
	enemy_health -= 1
	print(enemy_health)
	if enemy_health == 0:
		queue_free()
