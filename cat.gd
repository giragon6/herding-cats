extends CharacterBody2D

const SPEED = 50.0

var player
var chase = false

@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	if chase == true:
		anim.play("Walk")
		player = get_node("../../Player/Player")
		var direction = (player.global_position - self.position).normalized()
		velocity = direction * SPEED
	else:
		anim.play("Sit")
		velocity = Vector2(0,0)
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
		
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false
