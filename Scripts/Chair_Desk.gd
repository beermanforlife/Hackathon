extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func increse_speed(speedModifyer):
	get_child(0).increse_speed(speedModifyer)
	get_child(1).increse_speed(speedModifyer)
