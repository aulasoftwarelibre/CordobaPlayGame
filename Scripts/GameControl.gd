extends Control
@onready var temp = $HBoxContainer/Caja/MovPez
@onready var yMax = int($HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.size.y)
@onready var yMin = int($HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.position.y)
@onready var pez = $HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect/TextureRect
@onready var catch = $HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect/Catch
@onready var pBar = $HBoxContainer/Progreso/ColorRect/MarginContainer/ProgressBar

@export var catchPeso: float = 100
@export var tMin: float = 0.6
@export var tMax: float = 5.0
@export var pezVel: float = 0.6
@export var catchLevantar: float = 250
@export var velCompletado: float = 2 #0.125 #guarrada historica pero para que el catch no salga de la barra

var posSalto: int = 0

func _ready() -> void:
	await get_tree().process_frame  # Espera un frame para que los nodos tengan su tamaño correcto
	yMax = int($HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.size.y)  # Ahora tendrá el tamaño correcto
	nuevoSalto()
	
	
func _process(delta):
	if pBar.value>=100:
		get_tree().change_scene_to_file("res://Escenas/Niveles/WinScreenL1.tscn")
		pez.position.y = lerpf(pez.position.y, posSalto, pezVel)
	
	if Input.is_action_pressed("Pescar"):
		if catch.position.y>yMin:
			catch.position.y -= catchLevantar * delta
	if catch.position.y + catch.size.y <= yMax:
		catch.position.y += catchPeso * delta
		
	# Usar get_global_rect() para obtener las áreas exactas en coordenadas globales
	var pez_rect = pez.get_global_rect()
	var catch_rect = catch.get_global_rect()
	
	if pez_rect.intersects(catch_rect):
		pBar.value += velCompletado
		

func _on_mov_pez_timeout() -> void:
	nuevoSalto()
	
func nuevoSalto() -> void:
	posSalto = randi_range(yMin,yMax)
	temp.wait_time = randf_range(tMin, tMax)
