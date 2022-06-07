extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var can_fire = true;
var bullet = preload("res://Player/PlayerBullet.tscn")
var using_mouse = false
var shooting_speed = 0.4
onready var gunshotSFX = $Gunshot
var not_game_over = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	
func _input(event):
	if event is InputEventMouseMotion and event.relative:
		using_mouse = true

func fire():
	if can_fire and not_game_over:
		gunshotSFX.play()
		
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
		yield(get_tree().create_timer(shooting_speed), "timeout")
		can_fire = true;

func _physics_process(delta):
	#gun trails slightly behind player to create feeling of separate objects
	#position.x = lerp(position.x + 5, get_parent().position.x, 0.5)
	#position.y = lerp(position.y - 2, get_parent().position.y, 0.5)
	position.x = get_parent().position.x + 4
	position.y = get_parent().position.y - 2
	

		
	
	
	#gets mouse position and rotates gun based on it
	var mouse_pos = get_global_mouse_position()
	if using_mouse:
		look_at(mouse_pos)
		#flips gun to face the mouse sprite direction
		if mouse_pos.x < position.x:
			get_node(".").set_flip_v(true)
		else:
			get_node(".").set_flip_v(false)
	
	#can also shoot using arrow keys
	if Input.is_action_pressed("arrow_down") and Input.is_action_pressed("arrow_right"):
		using_mouse = false
		flip_v = false
		look_at(position + Vector2.DOWN + Vector2.RIGHT)
		fire()
		
	elif Input.is_action_pressed("arrow_down") and Input.is_action_pressed("arrow_left") :
		using_mouse = false
		flip_v = true
		look_at(position + Vector2.DOWN + Vector2.LEFT)
		fire()
		
	elif Input.is_action_pressed("arrow_up") and Input.is_action_pressed("arrow_right") :
		using_mouse = false
		flip_v = false
		look_at(position + Vector2.UP + Vector2.RIGHT)
		fire()
		
	elif Input.is_action_pressed("arrow_up") and Input.is_action_pressed("arrow_left"):
		using_mouse = false
		flip_v = true
		look_at(position + Vector2.UP + Vector2.LEFT)
		fire()
	
	elif Input.is_action_pressed("arrow_right") :
		using_mouse = false
		flip_v = false
		look_at(position + Vector2.RIGHT)
		fire()
		
	elif Input.is_action_pressed("arrow_left"):
		using_mouse = false
		flip_v = true
		look_at(position + Vector2.LEFT)
		fire()
		
		
	elif Input.is_action_pressed("arrow_up"):
		using_mouse = false
		flip_v = false
		look_at(position + Vector2.UP)
		fire()
		
	elif Input.is_action_pressed("arrow_down"):
		using_mouse = false
		flip_v = false
		look_at(position + Vector2.DOWN)
		fire()

	
	
	#if fire is inputted using mouse click creates bullet instance at guns rotation
	if Input.is_action_pressed("fire"):
		fire()
