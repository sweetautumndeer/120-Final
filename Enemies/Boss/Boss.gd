extends KinematicBody2D


var SPEED = 300
var WEIGHT = 0.1
var motion = Vector2.ZERO
var GRAVITY = 10
var MAX_SPEED = 150
var t = 0
var can_fire = true
export var BOSSHEALTH = 100
export var BOSSHEALTH_MAX = 100
var format_string = "Health = %d"

onready var trashShot = $TrashShot
onready var hurtbox = get_node("BossHurtbox")
onready var bossHealthbar = get_node("../CanvasLayer/BossHealthBar/ProgressBar")
onready var playerHealthbar = get_node("../CanvasLayer/PlayerHealthBar")
onready var hitboxCheck = $BossHitbox/CollisionShape2D
onready var areaCheck = $Node2D/Area2D/CollisionShape2D
onready var collisionshape = $CollisionShape2D
onready var sprite = get_node("AnimatedSprite")
onready var idlePos = get_node("../IdlePosition")
onready var shootPos = get_node("../ShootPosition")
onready var player = get_node("../Player")
onready var hitflash = $AnimationPlayer
onready var transition = get_node("../CanvasLayer/TransitionScreen/AnimationPlayer")
onready var screen = get_node("../CanvasLayer/TransitionScreen")
var bullet = preload("res://Enemies/Boss/TrashShot.tscn")
var initialScale
enum bossState {
	IDLE, #slowly moving around, not attacking
	TRASHSHOT, #shooting trash at the player
	SWEEP, #sweeping the ground of the arena
	DESPERATION, #bullet hell mode
	DEATH
}
var currentState = bossState.IDLE


# Called when the node enters the scene tree for the first time.
func _ready():
	#$Health.text = format_string % BOSSHEALTH
	initialScale = $Node2D.scale.x
	hitflash.play("Stop")
	Global.currentCheckpoint = "Boss"
	
	#sets boss healthbar
	bossHealthbar.max_value = BOSSHEALTH_MAX
	bossHealthbar.value = BOSSHEALTH 

func _physics_process(delta):
	#main state machine
	match (currentState):
		bossState.IDLE:
			sprite.play("idle")
			sprite.flip_h = false
			hurtbox.monitorable = false
			motion.x = 0
			motion.y = 0
			rotation = lerp(rotation, 0, WEIGHT)
			position.x = lerp(position.x, idlePos.position.x, WEIGHT)
			position.y = lerp(position.y, idlePos.position.y, WEIGHT)
			if nearPosition(position, idlePos.position):
				hurtbox.monitorable = true
				position = idlePos.position
		bossState.TRASHSHOT:
			#sprite.play("attack")
			#sprite.play("attacking")
			hurtbox.monitorable = false
			motion.x = 0
			motion.y = 0
			
			#move to shooting position
			position.x = lerp(position.x, shootPos.position.x, WEIGHT)
			position.y = lerp(position.y, shootPos.position.y, WEIGHT)
			if nearPosition(position, shootPos.position):
				hurtbox.monitorable = true
				position = shootPos.position
			
			#aim at player
			look_at(player.get_position())
			rotation += PI
			
			# only fires when in position
			if can_fire && nearPosition(position, shootPos.position):
				trashShot.play()
				var bullet_instance = bullet.instance()
				bullet_instance.rotation = rotation
				if BOSSHEALTH <= 50:
					bullet_instance.speed = 300
				sprite.play("attacking")
				#creates instance at gun position
				bullet_instance.global_position = $".".global_position
				get_parent().add_child(bullet_instance)
		
				#timer until gun can be fire again
				can_fire = false
				yield(get_tree().create_timer(2.5), "timeout")
				can_fire = true;
		bossState.SWEEP:
			#plays sweep animation
			sprite.play("sweep")
			
			#moves boss back and forth between two walls
			rotation = lerp(rotation, 0, WEIGHT)
			motion.x += -SPEED * delta
			print(motion.x)
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
			motion.y += GRAVITY
		bossState.DESPERATION:
			pass
		
		bossState.DEATH:
			#plays death animation
			if not is_on_wall():
				motion.y += SPEED * delta
				rotation_degrees += 10
	
	motion = move_and_slide(motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	if (currentState == bossState.IDLE && t > 2):
		#randomly choose next attack
		var rand = randi() % 2
		if BOSSHEALTH <= 50:
			MAX_SPEED = MAX_SPEED * 2
		match (rand):
			0:
				currentState = bossState.SWEEP
			1:
				currentState = bossState.TRASHSHOT
	
	if (currentState != bossState.IDLE && t > 12 && currentState != bossState.DEATH):
		#return to being idle
		currentState = bossState.IDLE
		t = 0;
	

# check if the two positions are close enough to each other to basically be the same
func nearPosition(pos1, pos2):
	return pos1.x < pos2.x + 0.01 && pos1.x > pos2.x - 0.01 && pos1.y < pos2.y + 0.01 && pos1.y > pos2.y - 0.01

func _on_Area2D_body_entered(body):
	#flips sprite and direction if bouncing into a wall
	if body.name == "WallBounds":
		sprite.flip_h = not sprite.flip_h
		SPEED = -SPEED
		
		#$Node2D.scale.x = -$Node2D.scale.x


func _on_HitBox_area_entered(area):
	print("collision")
	#loses health if hit by bullet
	if area.name == "PlayerBulletHitbox":
		BOSSHEALTH -= 1
		
		#changes health bar
		bossHealthbar.value = BOSSHEALTH
		
		#plays hitflash animation
		hitflash.play("Start")
		
		#$Health.text = format_string % BOSSHEALTH
		if BOSSHEALTH <= 0:
			# play death sound
			$DeathSound.play()
			# disable hitbox/hurtbox
			hurtbox.queue_free()
			areaCheck.set_deferred("disabled", true)
			hitboxCheck.set_deferred("disabled", true)
			collisionshape.set_deferred("disabled", true)
			currentState = bossState.DEATH
			t = 0
			yield(get_tree().create_timer(3.5), "timeout")
			# fade to black
			screen.visible = true
			playerHealthbar.visible = false
			transition.play("fade")
			yield(transition, "animation_finished")
			get_tree().change_scene("res://LevelScenes/WinScreen.tscn")
			
