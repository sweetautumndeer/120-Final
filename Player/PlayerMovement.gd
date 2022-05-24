extends KinematicBody2D


const ACCELERATION = 512
const MAX_SPEED = 150
const FRICTION = 0.25
const GRAVITY = 350
const JUMP_FORCE = 190

export var health = 3
var motion = Vector2.ZERO
var format_string = "Health = %d"

onready var hitflash = $HitflashAnimation

func _ready():
	get_node("CollisionShape2D")
	hitflash.play("Stop")
	$Health.text = format_string % health


# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	#moves player based on input strength
	var x_in = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_in == -1:
		get_node("Sprite").set_flip_h(true)
	elif x_in == 1:
		get_node("Sprite").set_flip_h(false)
	
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
	health -= 1
	$Health.text = format_string % health
	if health > 0:
		set_global_position(spawn)
	else:
		print("game over")
		queue_free()


func _on_Area2D_area_entered(area):
	health -= 1
	hitflash.play("Start")
	$Health.text = format_string % health
	if health == 0:
		print("game over")
		queue_free()
