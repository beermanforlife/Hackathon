extends KinematicBody2D


var SPEED = 200
const UP = Vector2(0, -1)
var motion = Vector2()
signal grass_entered
signal grass_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.x = -SPEED
	motion = move_and_slide(motion,  UP)



func _on_Area2D_area_entered(area):
	emit_signal("grass_entered")


func _on_Area2D_area_exited(area):
	emit_signal("grass_exited")

func increse_speed(speedModifyer):
	SPEED = SPEED * speedModifyer
