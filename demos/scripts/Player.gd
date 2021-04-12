extends KinematicBody

export (float) var mouse_look_sensitivity = 0.35
export (float) var speed = 4.0

onready var head = $Head
var velocity = Vector3()

var mouse_captured: bool = true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_look_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_look_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
	if event.is_action_released("ui_cancel"):
		mouse_captured = not mouse_captured
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var movement = Vector3()

	if Input.is_action_pressed("forward"):
		movement -= transform.basis.z
	if Input.is_action_pressed("back"):
		movement += transform.basis.z
	if Input.is_action_pressed("left"):
		movement -= transform.basis.x
	if Input.is_action_pressed("right"):
		movement += transform.basis.x
	movement = movement.normalized()
	velocity += movement * speed
	velocity *= delta * 45
	move_and_slide(velocity, Vector3.UP)
