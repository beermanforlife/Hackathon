extends KinematicBody2D

var SPEED = 200
const UP = Vector2(0, -1)
var motion = Vector2()

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	motion.x = -SPEED
	motion = move_and_slide(motion,  UP)

func increse_speed(speedModifyer):
	SPEED = SPEED * speedModifyer
