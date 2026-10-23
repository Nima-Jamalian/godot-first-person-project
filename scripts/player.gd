extends CharacterBody3D

@export var mouse_sensitivity := 0.5
@export var speed := 5.0
@export var jump_velocity = 4.5
const GRAVITY := -9.8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Capture and hide the mouse cursor
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Rotating the player along the y axis
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		
		# Rotating the camera along the x axis
		%Camera3D.rotation_degrees.x -= event.relative.y
		# Limiting the camera rotation
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80.0, 80.0)
		
		# if escaped is pressed unhide the mouse cursor
		# Good practice to replace the built in ui action with your input action
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _physics_process(delta: float) -> void:
	var input_direction_2D = Input.get_vector("move_left","move_right","move_forward","move_back")
	var input_direction_3D = Vector3(input_direction_2D.x, 0.0, input_direction_2D.y)
	
	var direction = transform.basis * input_direction_3D
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Apply gravity
	velocity.y += GRAVITY * delta
	
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	
	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
		
func shoot_bullet() -> void:
	const BULLET = preload("uid://d047j0f3m0wum")
	var new_bullet := BULLET.instantiate()
	%Marker3D.add_child(new_bullet)
	new_bullet.global_transform = %Marker3D.global_transform
	%AudioStreamPlayer3D.play()
	
	
