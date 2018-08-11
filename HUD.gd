extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over!")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "Dodge the Creeps!"
	$MessageLabel.show()

