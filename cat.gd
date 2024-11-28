class_name Cat

extends CharacterBody2D

# (Left, Up, Right, Down)
const directions = {
	Vector4(1,0,0,0): "Left",
	Vector4(0,1,0,0): "Up",
	Vector4(0,0,1,0): "Down",
	Vector4(0,0,0,1): "Right",
	Vector4(1,1,0,0): "Left Up",
	Vector4(1,0,0,1): "Left Down",
	Vector4(0,1,1,0): "Right Up",
	Vector4(0,0,1,1): "Right Down",
	
}

const SPEED = 50.0

var player

var run = false

@onready var anim = get_node("AnimatedSprite2D")

func _physics_process(delta: float) -> void:
	if run == true:
		anim_walk_in_dir(velocity)
		player = get_node("../../Player/Player")
		var direction = -(player.global_position - self.position).normalized()
		velocity = direction * SPEED
	else:
		anim.play("Sit")
		velocity = Vector2(0,0)
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		run = true
		
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		run = false
		
func anim_walk_in_dir(vel: Vector2) -> void:
	#var right = vel.x > 0
	#var left = vel.x < 0
	#var up = vel.y > 0
	#var down = vel.y < 0
	#anim.play("Walk " + directions[Vector4(left, up, down, right)])
	anim.play("Walk")
