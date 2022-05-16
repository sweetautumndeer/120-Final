extends KinematicBody2D


const ACCELERATION = 512
const MAX_SPEED = 80
const FRICTION = 0.25
const GRAVITY = 250
const JUMP_FORCE = 150

var motion = Vector2.ZERO

func _ready():
	get_node("CollisionShape2D")


# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	#moves player based on input strength
	var x_in = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_in == -1:
		get_node("Sprite").set_flip_h(false)
	elif x_in == 1:
		get_node("Sprite").set_flip_h(true)
	
	#moves at rate of acceleration times delta and maxes out at max speed
	if x_in != 0:
		motion.x += x_in * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	#falls at gravity * delta speed
	motion.y += GRAVITY * delta
	
	#jumps if player is on floor
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	
	#performs movement of player
	motion = move_and_slide(motion, Vector2.UP);
	


#respawns player if off screen
func _on_VisibilityNotifier2D_screen_exited():
	var spawn = Vector2(50.0, 100.0)
	set_global_position(spawn)
