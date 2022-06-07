extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var healthbar = $Camera2D/HealthBar/ProgressBar
onready var transition = $CanvasLayer/TransitionScreen/AnimationPlayer
onready var screen = $CanvasLayer/TransitionScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	#transitions in and set level
	Global.currentCheckpoint = "Level1"
	transition.play_backwards("fade")
	yield(transition, "animation_finished")
	screen.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
