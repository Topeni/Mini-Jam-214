extends Area2D


func _on_body_entered(body: Node2D) -> void:
	SignalManager.clock_add_time.emit(4.0)
	queue_free()
