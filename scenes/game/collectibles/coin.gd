extends Area2D

func _on_body_entered(body: Node2D) -> void:
	game.coins_collected += 1
	queue_free()
	print(game.coins_collected)
