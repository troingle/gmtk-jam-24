extends CharacterBody2D

@onready var point = $"../ComparePoint"
@onready var tilemap = $"../TileMap"
@onready var anim = $AnimationPlayer
@onready var sprite = $SpriteObj
@onready var camera_obj = $"../CameraObj"

@onready var box = $"../Box"

var speed = 350.0
const JUMP_VELOCITY = -600.0
const speeds = [350.0, 500.0, 750.0]

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var sprite_original_scale = Vector2.ZERO
var in_air = false
var change_speed = 2

var is_in_box = false
var original_scale = Vector2.ZERO

func _ready():
	original_scale = scale
	sprite_original_scale = sprite.scale

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		in_air = true
	elif in_air:
		sprite.scale = Vector2(sprite_original_scale.x + 0.26, sprite_original_scale.y - 0.16)
		in_air = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.scale = Vector2(original_scale.x - 0.2, original_scale.y + 0.34)
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		anim.play("wobble")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if !anim.is_playing() or anim.current_animation == "wobble":
			anim.play("RESET")
	
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	
	sprite.scale.x = move_toward(sprite.scale.x, sprite_original_scale.x, change_speed * delta)
	sprite.scale.y = move_toward(sprite.scale.y, sprite_original_scale.y, change_speed * delta)

	move_and_slide()
	
	print(is_in_box)
	
	


