extends Node2D

signal grass_entered
signal grass_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FiddleLeaf_grass_entered():
	emit_signal("grass_entered")


func _on_FiddleLeaf_grass_exited():
	emit_signal("grass_exited")

func increse_speed(speedModifyer):
	get_child(0).increse_speed(speedModifyer)
	get_child(1).increse_speed(speedModifyer)
