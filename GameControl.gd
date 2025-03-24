extends Control
@onready var Barra=$HBoxContainer/Progreso/ColorRect/MarginContainer/ProgressBar

func _process(delta):
	if Barra.value>=100:
		get_tree().change_scene_to_file("res://WinScreen.tscn")
		
