extends KinematicBody2D


export var speed = 200
export var rotationSpeed = 0.025
var on_floor = false
export var playerDir = 0
var landDir = Vector2.ZERO

func _ready():
	set_as_toplevel(true)
	
#moves bullet forward at rate of speed at the rotation of the origin of the instance
func _process(delta):
	$"Sprite".rotation -= rotationSpeed
	#changes direction and speed when landed
	if on_floor:
		position += (landDir * speed).rotated(0) * delta
	else:
		position += (Vector2.LEFT * speed).rotated(rotation) * delta
		
	
#func _physics_process(delta):
#	yield(get_tree().create_timer(1.0), "timeout")
	
	
#moves towards players last direction
func check_player_pos():
	var PlayerPos = get_parent().get_node("Player").position
	if PlayerPos.x > position.x:
		landDir = Vector2.RIGHT
	else:
		landDir = Vector2.LEFT



func _on_Area2D_area_entered(area):
	print(area.name)

#checks if it has landed on the ground
func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "FloorBounds" && not on_floor:
		on_floor = true
		check_player_pos()
	else:
		pass
