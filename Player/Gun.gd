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
	position.x = lerp(position.x + 5, get_parent().position.x, 0.5)
	position.y = lerp(position.y - 2, get_parent().position.y, 0.5)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_just_pressed("fire"):
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $Position2D.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true;
