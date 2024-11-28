extends Node2D

var captured_cats: int

func _ready() -> void:
	var captured_cats = 0

func _on_cat_detection_body_entered(body: Node2D) -> void:
	if body.name == "Cat":
		captured_cats += 1
		if captured_cats == Game.NUM_CATS:
			print("YOU WON!!!!!!!!")
		

func _on_cat_detection_body_exited(body: Node2D) -> void:
	if body.name == "Cat":
		captured_cats -= 1
