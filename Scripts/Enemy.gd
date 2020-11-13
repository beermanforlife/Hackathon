extends KinematicBody2D
class_name Enemy
export var speed = 100
export var gravity = 60
const MAXFALLSPEED = 600
var motion = Vector2()
var direction = 1
var UP = Vector2(0,-1)
var opositeDirection = -1
onready var sprite = get_node("AnimatedSprite")
signal colided_with_something(thing)

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	motion.y += gravity
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	if is_on_wall():
		direction = direction * opositeDirection
	if !$RayCast2D.is_colliding():
		direction = direction * opositeDirection
	
	if direction == 1:
		sprite.flip_h = false
	elif direction == -1:
		sprite.flip_h = true
	
	
	motion.x = direction * speed
	motion = move_and_slide(motion, UP)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.collider
		if i > 0:
			emit_signal("colided_with_something", collider)
		#var colliding_with_player = (collider is Player and
			#is_on_floor())

		#if colliding_with_player:
			#(collider as Player).death()


func _kill() -> void:
	queue_free()
