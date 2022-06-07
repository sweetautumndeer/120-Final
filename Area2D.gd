extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var transition = get_node("../CanvasLayer/TransitionScreen/AnimationPlayer")
onready var screen = get_node("../CanvasLayer/TransitionScreen")
onready var player = get_node("../Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#plays screen transition and changes to next level based on global variables
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		screen.visible = true
		
		transition.play("fade")
		yield(transition, "animation_finished")
		print(Global.currentCheckpoint)
		if Global.currentCheckpoint == "Level1":
			Global.currentCheckpoint = "Level2"
			get_tree().change_scene("res://LevelScenes/Level2.tscn")
		elif Global.currentCheckpoint == "Level2":
			Global.currentCheckpoint = "Boss"
			get_tree().change_scene("res://LevelScenes/BossLevel.tscn")
			
