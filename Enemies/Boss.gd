extends KinematicBody2D


var SPEED = 100
var motion = Vector2.ZERO
var GRAVITY = 10
var MAX_SPEED = 200

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	
	motion.x += -SPEED * delta
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	
	motion.y += GRAVITY
	
	motion = move_and_slide(motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.name == "Bounds":
		SPEED = -SPEED
		$Node2D.scale.x = -$Node2D.scale.x
