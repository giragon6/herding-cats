class_name Cat

extends CharacterBody2D

const Direction = {
	Vector2(-1,0): { # Left
		"SIT": {
			"NAME": "Sit Left",
			"TILES": [
				Vector2(1,6),
			]
		},
		"WALK": {
			"NAME": "Walk Left",
			"TILES": [
				Vector2(12,5),
				Vector2(13,5),
				Vector2(14,5),
				Vector2(15,5)
			]
		},
	},
	Vector2(-1,1): { # Left Down
		"SIT": {
			"NAME": "Sit Left Down",
			"TILES": [
				Vector2(1,4),
			]
		},
		"WALK": {
			"NAME": "Walk Left Down",
			"TILES": [
				Vector2(12,3),
				Vector2(13,3),
				Vector2(14,3),
				Vector2(15,3)
			]
		},
	},
	Vector2(-1,-1): { # Left Up
		"SIT": {
			"NAME": "Sit Left Up",
			"TILES": [
				Vector2(1,8),
			]
		},
		"WALK": {
			"NAME": "Walk Left Up",
			"TILES": [
				Vector2(12,7),
				Vector2(13,7),
				Vector2(14,7),
				Vector2(15,7)
			]
		},
	},
	Vector2(0,-1): { # Up
		"SIT": {
			"NAME": "Sit Up",
			"TILES": [
				Vector2(2,10),
			]
		},
		"WALK": {
			"NAME": "Walk Up",
			"TILES": [
				Vector2(12,9),
				Vector2(13,9),
				Vector2(14,9),
				Vector2(15,9)
			]
		},
	},
	Vector2(1,-1): { # Right Up
		"SIT": {
			"NAME": "Sit Right Up",
			"TILES": [
				Vector2(1,12),
			]
		},
		"WALK": {
			"NAME": "Walk Right Up",
			"TILES": [
				Vector2(12,11),
				Vector2(13,11),
				Vector2(14,11),
				Vector2(15,11)
			]
		},
	},
	Vector2(1,0): { # Right
		"SIT": {
			"NAME": "Sit Right",
			"TILES": [
				Vector2(1,14),
			]
		},
		"WALK": {
			"NAME": "Walk Right",
			"TILES": [
				Vector2(12,13),
				Vector2(13,13),
				Vector2(14,13),
				Vector2(15,13)
			]
		},
	},
	Vector2(1,1): { # Right Down
		"SIT": {
			"NAME": "Sit Right Down",
			"TILES": [
				Vector2(1,16),
			]
		},
		"WALK": {
			"NAME": "Walk Right Down",
			"TILES": [
				Vector2(12,15),
				Vector2(13,15),
				Vector2(14,15),
				Vector2(15,15)
			]
		},
	},
	Vector2(0,1): { # Down
		"NAME": "Down",
		"SIT": {
			"NAME": "Sit Down",
			"TILES": [
				Vector2(2,2),
			]
		},
		"WALK": {
			"NAME": "Walk Down",
			"TILES": [
				Vector2(12,1),
				Vector2(13,1),
				Vector2(14,1),
				Vector2(15,1)
			]
		},
	},
}

var rand_dir = Vector2(0,0)
@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")
var speed = 25.0

var player

var run = false
var direction := random_dir()

func _ready() -> void:
	init_anim()
	
	while get_tree().paused == false:
		var rand_delay : float = randf_range(1.0, 5.0)
		await get_tree().create_timer(rand_delay).timeout
		direction = random_dir()

func _physics_process(delta: float) -> void:
	if run == true:
		speed = 50.0
		player = get_node("../../Player/Player")
		direction = -(player.global_position - self.position).normalized()			
	else:
		speed = 25.0
	var x_dir = roundf(direction.x)
	var y_dir = roundf(direction.y)
	if x_dir == 0 and y_dir == 0:
		anim.play(Direction[Vector2(0,1)].SIT.NAME)
	else:
		anim.play(Direction[Vector2(x_dir,y_dir)].WALK.NAME)
	velocity = direction * speed
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		run = true
		
func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		run = false
		
func random_dir() -> Vector2:
	return Vector2(randi_range(-1,1), randi_range(-1,1))
	
func init_anim() -> void:
	var sprite_frames := SpriteFrames.new()
	var texture_size := Vector2(1024,544)
	var sprite_size := Vector2(32,32)
	var cat_assets_dir := DirAccess.open("res://cat-assets")
	var file_names := cat_assets_dir.get_files()
	var cat_textures: Array
	for file in file_names:
		cat_textures.append(file.trim_suffix(".import"))
	var random_cat_texture : String = cat_textures[randi() % cat_textures.size()]
	var full_spritesheet : Texture = load("res://cat-assets/"+random_cat_texture)
	for dir_key in Direction.keys():
		var dir = Direction[dir_key]
		Utils.add_animation(sprite_frames, full_spritesheet, sprite_size, dir.WALK.TILES, dir.WALK.NAME)
		Utils.add_animation(sprite_frames, full_spritesheet, sprite_size, dir.SIT.TILES, dir.SIT.NAME)
	anim.sprite_frames = sprite_frames
	anim.play("Sit Left")
