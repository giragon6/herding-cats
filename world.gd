extends Node2D

@export var cat_scene: PackedScene

const spawn_positions = [
	Vector2(128,64),
	Vector2(384,64),
	Vector2(640,64),
	Vector2(128,192),
	Vector2(640,192),
	Vector2(128,320),
	Vector2(384,320),
	Vector2(640,320),
]

func _ready() -> void:
	var cats = get_node("Cats")
	for pos in spawn_positions:
		var cat = gen_cat()
		cat.position = pos
		cats.add_child(cat)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		var gate = get_node("Gate")
		gate.visible = !gate.visible
		gate.collision_enabled = !gate.collision_enabled
		

func gen_cat() -> Cat:
	return cat_scene.instantiate()
