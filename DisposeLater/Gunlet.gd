extends Area2D


export var speed = 200

func _ready():
	set_as_toplevel(true)
	
#moves bullet forward at rate of speed at the rotation of the origin of the instance
func _process(delta):
	position += (Vector2.RIGHT * speed).rotated(rotation) * delta
	
func _physics_process(_delta):
	yield(get_tree().create_timer(0.01), "timeout")
	set_physics_process(false)


#delete once leaves screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#if hits area that is not player, will free itself
func _on_Area2D_body_entered(body):
	print(body)
	if(body.name == "Player"):
		pass
	else:
		
		queue_free()






func _on_Bullet_area_entered(area):
	queue_free()
