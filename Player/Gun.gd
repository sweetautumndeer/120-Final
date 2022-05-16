extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var can_fire = true;
var bullet = preload("res://Player/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)


func _physics_process(delta):
	#gun trails slightly behind player to create feeling of separate objects
	position.x = lerp(position.x + 5, get_parent().position.x, 0.5)
	position.y = lerp(position.y - 2, get_parent().position.y, 0.5)
	
	#gets mouse position and rotates gun based on it
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	#flips gun to face the mouse sprite direction
	if mouse_pos.x < position.x:
		get_node(".").set_flip_v(true)
	else:
		get_node(".").set_flip_v(false)
	
	#if fire is inputted using mouse click creates bullet instance at guns rotation
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		
		#flips bullet if gun is flipped
		if get_node(".").flip_v == true:
			bullet_instance.get_node("Sprite").set_flip_v(true)
		
		#creates instance at gun position
		bullet_instance.global_position = $Position2D.global_position
		get_parent().add_child(bullet_instance)
		
		#timer until gun can be fire again
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true;
