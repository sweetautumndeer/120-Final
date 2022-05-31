extends KinematicBody2D


const ACCELERATION = 300
const MAX_SPEED = 200
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
		get_node("AnimatedSprite").set_flip_h(true)
		get_node("AnimatedSprite").play("run")
	elif x_in == 1:
		get_node("AnimatedSprite").set_flip_h(false)
		get_node("AnimatedSprite").play("run")
	else:
		get_node("AnimatedSprite").play("idle")
	
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
			
	if Input.is_action_just_pressed("fire"):
		print($Gun.rotation_degrees + 180)
		motion = Vector2(-1, 0).rotated($Gun.rotation) * MAX_SPEED
	
	#performs movement of player
	motion = move_and_slide(motion, Vector2.UP);
	
	
	


#respawns player if off screen
func _on_VisibilityNotifier2D_screen_exited():
	var spawn = Vector2(50.0, 100.0)
	
	$Health.text = format_string % health
	if health > 0:
		set_global_position(spawn)
	else:
		print("game over")
		queue_free()
		get_tree().change_scene("res://LevelScenes/LoseScreen.tscn")


func _on_Area2D_area_entered(area):
	if area.name == "BossPortal":
		pass
	health -= 1
	hitflash.play("Start")
	if area.position.x > position.x:
		motion.x -= 300
		motion.y -= 100
	else:
		motion.x += 300
		motion.y -= 100
	
	$Health.text = format_string % health
	if health == 0:
		print("game over")
		queue_free()
		get_tree().change_scene("res://LevelScenes/LoseScreen.tscn")
