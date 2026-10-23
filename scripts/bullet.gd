extends Area3D

@export var speed := 20
@export var range := 10
@export var travelled_distance := 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	position +=  -transform.basis.z * speed * delta
	travelled_distance += speed * delta
	if travelled_distance > range:
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	print(body.name)
	if body.is_in_group("target"):
		body.queue_free()
		queue_free()
	pass # Replace with function body.
