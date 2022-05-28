extends Node

onready var MovementA = $MovementA
onready var MovementD = $MovementD
var jumpTutorialTriggered = false
onready var JumpW = $JumpW
onready var JumpSpace = $JumpSpace
var shootTutorialTriggered = false
onready var ShootLeftClick = $ShootLeftClick
onready var ShootArrowKeys = $ShootArrowKeys

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if jumpTutorialTriggered and Input.is_action_just_pressed("jump"):
		JumpW.visible = false
		JumpSpace.visible = false
	if shootTutorialTriggered and Input.is_action_just_pressed("fire"):
		ShootLeftClick.visible = false
		ShootArrowKeys.visible = false
	if MovementA.visible and Input.is_action_just_pressed("left"):
		MovementA.visible = false
	if MovementD.visible and Input.is_action_just_pressed("right"):
		MovementD.visible = false


func _on_JumpTutorialTrigger_area_entered(area):
	if not jumpTutorialTriggered:
		JumpW.visible = true
		JumpSpace.visible = true
		jumpTutorialTriggered = true


func _on_ShootTutorialTrigger_area_entered(area):
	if not shootTutorialTriggered:
		ShootLeftClick.visible = true
		ShootArrowKeys.visible = true
		shootTutorialTriggered = true
