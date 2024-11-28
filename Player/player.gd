extends CharacterBody2D

const SPEED = 300.0

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
		anim.play("Walk")
	else:
		velocity = Vector2(0,0)
		anim.play("Idle")

	move_and_slide()
