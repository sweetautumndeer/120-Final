extends KinematicBody2D


var SPEED = 100
var WEIGHT = 0.1
var motion = Vector2.ZERO
var GRAVITY = 10
var MAX_SPEED = 200
var t = 0;
var can_fire = true

onready var sprite = get_node("Node2D/Sprite")
onready var idlePos = get_node("../IdlePosition")
onready var shootPos = get_node("../ShootPosition")
onready var player = get_node("../Player")
var bullet = preload("res://Enemies/EnemyBullet.tscn")
enum bossState {
	IDLE, #slowly moving around, not attacking
	TRASHSHOT, #shooting trash at the player
	SWEEP, #sweeping the ground of the arena
	DESPERATION #bullet hell mode
}
var currentState = bossState.IDLE


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#main state machine
	match (currentState):
		bossState.IDLE:
			rotation = lerp(rotation, 0, WEIGHT)
			position.x = lerp(position.x, idlePos.position.x, WEIGHT)
			position.y = lerp(position.y, idlePos.position.y, WEIGHT)
		bossState.TRASHSHOT:
			position.x = lerp(position.x, shootPos.position.x, WEIGHT)
			position.y = lerp(position.y, shootPos.position.y, WEIGHT)
			
			#aim at player
			look_at(player.get_position())
			rotation += PI
	
			if can_fire:
				var bullet_instance = bullet.instance()
				bullet_instance.rotation = rotation
		
				#creates instance at gun position
				bullet_instance.global_position = $".".global_position
				get_parent().add_child(bullet_instance)
		
				#timer until gun can be fire again
				can_fire = false
				yield(get_tree().create_timer(2.5), "timeout")
				can_fire = true;
		bossState.SWEEP:
			rotation = lerp(rotation, 0, WEIGHT)
			motion.x += -SPEED * delta
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
			motion.y += GRAVITY
		bossState.DESPERATION:
			pass
	
	motion = move_and_slide(motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	if (currentState == bossState.IDLE && t > 5):
		#randomly choose next attack
		var rand = randi() % 2
		match (rand):
			0:
				currentState = bossState.SWEEP
			1:
				currentState = bossState.TRASHSHOT
	
	if (currentState != bossState.IDLE && t > 15):
		#return to being idle
		currentState = bossState.IDLE
		t = 0;



func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "Bounds":
		SPEED = -SPEED
		$Node2D.scale.x = -$Node2D.scale.x
