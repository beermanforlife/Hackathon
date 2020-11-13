extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 60
const MAXFALLSPEED = 600
const MAXSPEED = 240
const JUMPFORCE = 1200
const ACCEL = 40
const CLIMBSPEED = 200
const WATERMODIFIER = .5

onready var aniPlayer = get_node("AnimationPlayer")

 
var motion = Vector2()
var facing_right = true
var is_jumping = false
var can_climb = false
var on_platform = false
var in_water = false
var is_sprinting = false
var sprint_mod = 1
var start_location = Vector2()
var dead = false
var colliding = false

signal use_interact
signal enter

func ready():
	pass

func _physics_process(delta):
	if can_climb != true:
		motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		if in_water:
			motion.y = MAXFALLSPEED * WATERMODIFIER
		else:
			motion.y = MAXFALLSPEED
	if facing_right == true:
		$Sprite.scale.x = -1
	else:
		$Sprite.scale.x = 1
	if Input.is_action_pressed("sprint"):
		sprint_mod = 2
	else:
		sprint_mod = 1
		
		
	motion.x = clamp(motion.x, -MAXSPEED * sprint_mod, MAXSPEED * sprint_mod)
	if !dead:
		if Input.is_action_pressed("right"):
			if in_water:
				motion.x += ACCEL * sprint_mod * WATERMODIFIER
			else:
				motion.x += ACCEL * sprint_mod
			facing_right = true
			$AnimationPlayer.play("Run")
		elif Input.is_action_pressed("left"):
			if in_water:
				motion.x += -ACCEL * sprint_mod * WATERMODIFIER
			else:
				motion.x += -ACCEL * sprint_mod
			facing_right = false
			$AnimationPlayer.play("Run")
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			$AnimationPlayer.play("Idle")
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				is_jumping = true
				if in_water:
					motion.y = -JUMPFORCE*WATERMODIFIER
				else:
					motion.y = -JUMPFORCE
			
		if !is_on_floor():
			if in_water:
				if Input.is_action_just_pressed("jump"):
					motion.y = -JUMPFORCE*WATERMODIFIER
			if motion.y < 0:
				$AnimationPlayer.play("Jump")
			elif motion.y > 0 && !on_platform:
				is_jumping = false
				$AnimationPlayer.play("Jump")
	motion = move_and_slide(motion, UP)


func _on_Lader_area_entered(area):
	print("Can climb")
	can_climb = true


func _on_Lader_area_exited(area):
	print("Can't Climb")
	can_climb = false

func teleportTo(pos):
	position = pos.position
	start_location = pos
	dead = false


func _on_VEnter(area):
	on_platform = true


func WaterArea_area_entered():
	in_water = true


func WaterArea_area_exited():
	in_water = false

func death():
	dead = true
	aniPlayer.play("Death")
	yield(aniPlayer, "animation_finished")
	teleportTo(start_location)
func setSprite(value):
	get_node("Sprite").texture = load(value)
