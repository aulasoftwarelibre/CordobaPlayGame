class_name BarraProgreso
extends ProgressBar

func _on_timer_timeout() -> void:
	value-= 1
	if value<=0:
		get_tree().change_scene_to_file("res://GameOver.tscn")
