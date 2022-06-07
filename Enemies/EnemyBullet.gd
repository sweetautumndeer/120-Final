extends Node2D


export var speed = 225

func _ready():
	set_as_toplevel(true)
	
#moves bullet forward at rate of speed at the rotation of the origin of the instance
func _process(delta):
	position += (Vector2.LEFT * speed).rotated(rotation) * delta
	
func _physics_process(delta):
	#yield(get_tree().create_timer(1.0), "timeout")
	set_physics_process(false)


#delete once leaves screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#deletes when entering a body
func _on_Area2D_body_entered(body):
	queue_free()


func _on_EnemyBullet_area_entered(area):
	queue_free()
