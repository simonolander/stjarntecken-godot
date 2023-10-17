extends CharacterBody3D

@export var speed = 5
var MOUSE_SENSITIVITY = 0.05

var GRAVITY = 10

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _physics_process(delta):
	var move_direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		move_direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		move_direction.z += 1
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1
	if not move_direction.is_zero_approx():
		move_direction = move_direction.normalized()
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	
	if is_on_floor():
		if Input.is_action_pressed("move_jump"):
			velocity.y = 5
	else:
		velocity.y -= GRAVITY * delta
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$Pivot.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY))
		rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = $Pivot.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		$Pivot.rotation_degrees = camera_rot
