
extends ProgressBar

@export var val: int = 1

func _on_timer_timeout() -> void:
	value-= val
	if value<=0:
		get_tree().change_scene_to_file("res://Escenas/GameOver.tscn")
