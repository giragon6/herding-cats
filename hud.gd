@tool
extends CanvasLayer

func show_msg(text: String) -> void:
	$Message.text = text
	$Message.show()
	
func show_submsg(text: String) -> void:
	$Submessage.text = text
	$Submessage.show()
	
func hide_msg() -> void:
	$Message.hide()
	
func hide_submsg() -> void:
	$Submessage.hide()
	
func update_cats() -> void:
	$CatsLabel.text = "Cats Contained: " + str(Game.captured_cats) + "/" + str(Game.NUM_CATS)
	
func start() -> void:
	show_msg("HERDING CATS")
	show_submsg("CONTAIN THE FELINES\nPress any key to start\nPress space to open/close gate")
	update_cats()
	
func game_over() -> void:
	show_msg("SUCCESS!!!")
