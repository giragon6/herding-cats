extends Node2D

func _on_cat_detection_body_entered(body: Node2D) -> void:
	if body is Cat:
		Game.captured_cats += 1
		$"../HUD".update_cats()

func _on_cat_detection_body_exited(body: Node2D) -> void:
	if body is Cat:
		Game.captured_cats -= 1
		$"../HUD".update_cats()
