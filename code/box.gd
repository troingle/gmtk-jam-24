extends Node2D

@export var scale_increment = 2.0

var selected = false

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("click"):
		selected = true
	else:
		selected = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("scalable"):
		body.is_in_box = true
		body.scale = Vector2(body.scale.x * scale_increment, body.scale.y * scale_increment)

func _on_area_2d_body_exited(body):
	if body.is_in_group("scalable"):
		body.is_in_box = false
		body.scale = body.original_scale

