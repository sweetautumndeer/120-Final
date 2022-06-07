extends Node

var tutorialMaxTime = 15
var movementTutorialTimer = 0
onready var MovementA = $MovementA
onready var MovementD = $MovementD
var jumpTutorialTriggered = false
var jumpTutorialTimer = 0
onready var JumpW = $JumpW
onready var JumpSpace = $JumpSpace
var shootTutorialTriggered = false
var shootTutorialTimer = 0
onready var ShootLeftClick = $ShootLeftClick
onready var ShootArrowKeys = $ShootArrowKeys

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#plays tutorials based on if player has reached input, then delete tutorial based on timer
func _process(delta):
	if jumpTutorialTriggered:
		jumpTutorialTimer += delta
		if jumpTutorialTimer > tutorialMaxTime and Input.is_action_just_pressed("jump"):
			JumpW.visible = false
			JumpSpace.visible = false
	if shootTutorialTriggered:
		shootTutorialTimer += delta
		if shootTutorialTimer > tutorialMaxTime and Input.is_action_just_pressed("fire"):
			ShootLeftClick.visible = false
			ShootArrowKeys.visible = false
		if shootTutorialTimer > tutorialMaxTime and (Input.is_action_just_pressed("arrow_right") or Input.is_action_just_pressed("arrow_down") or Input.is_action_just_pressed("arrow_left") or Input.is_action_just_pressed("arrow_up")):
			ShootLeftClick.visible = false
			ShootArrowKeys.visible = false
	if MovementA.visible or MovementD.visible:
		movementTutorialTimer += delta
		if movementTutorialTimer > tutorialMaxTime and Input.is_action_just_pressed("left"):
			MovementA.visible = false
		if movementTutorialTimer > tutorialMaxTime and Input.is_action_just_pressed("right"):
			MovementD.visible = false

#sets visibility of tutorials
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
