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
onready var sprite = $AnimatedSprite
onready var jumpSFX = $Jump
onready var landSFX = $Land
var jumped = false
var footstepSFXPlayed = false

func _ready():
	get_node("CollisionShape2D")
	hitflash.play("Stop")
	$Health.text = format_string % health

func playFootsteps():
	if not footstepSFXPlayed and is_on_floor():
		$"Footsteps/Footsteps".play()
		footstepSFXPlayed = true

func _physics_process(delta):
	#moves player based on input strength
	var x_in = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if x_in == -1:
		sprite.set_flip_h(true)
		sprite.play("run")
		if sprite.frame == 2 or sprite.frame == 5:
			playFootsteps()
		else:
			footstepSFXPlayed = false
	elif x_in == 1:
		sprite.set_flip_h(false)
		sprite.play("run")
		if sprite.frame == 2 or sprite.frame == 5:
			playFootsteps()
		else:
			footstepSFXPlayed = false
	else:
		sprite.play("idle")
	
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
		if jumped:
			landSFX.play()
			jumped = false
		if Input.is_action_just_pressed("jump"):
			jumpSFX.play()
			motion.y = -JUMP_FORCE
			jumped = true
			
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
