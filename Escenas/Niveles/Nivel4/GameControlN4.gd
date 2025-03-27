extends Control
@onready var temp = $MarcoMadera/HBoxContainer/Caja/MovPez
@onready var yMax = int($MarcoMadera/HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.size.y)
@onready var yMin = int($MarcoMadera/HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.position.y)
@onready var pez = $MarcoMadera/HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect/TextureRect
@onready var catch = $MarcoMadera/HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect/Catch
@onready var pBar: BarraProgreso = $MarcoMadera/HBoxContainer/Progreso/ColorRect/MarginContainer/ProgressBar


@export var catchPeso: float = 100
@export var tMin: float = 0.4
@export var tMax: float = 4.15
@export var pezVel: float = 0.5
@export var catchLevantar: float = 250
@export var velCompletado: float = 0.08 #guarrada historica pero para que el catch no salga de la barra

var posSalto: int = 0
var anim: bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_AnimationFinished"))
	await get_tree().process_frame  # Espera un frame para que los nodos tengan su tamaño correcto
	yMax = int($MarcoMadera/HBoxContainer/Caja/ColorRect/MarginContainer/ColorRect.size.y)  # Ahora tendrá el tamaño correcto
	nuevoSalto()
	
	
func _process(delta):
	if anim==false:
		animation_player.play("new_animation")
		anim=true
	if pBar.value>=100:
		get_tree().change_scene_to_file("res://Escenas/Niveles/Nivel4/WinScreenL4.tscn")
	
	if Input.is_action_pressed("Pescar"):
		if catch.position.y>yMin:
			catch.position.y -= catchLevantar * delta
	if catch.position.y + catch.size.y <= yMax:
		catch.position.y += catchPeso * delta
		
	# Usar get_global_rect() para obtener las áreas exactas en coordenadas globales
	var pez_rect = pez.get_global_rect()
	var catch_rect = catch.get_global_rect()
	
	if pez_rect.intersects(catch_rect):
		pBar.value += velCompletado * delta * 250
	
	pez.position.y = lerpf(pez.position.y, posSalto, pezVel)
func _on_mov_pez_timeout() -> void:
	nuevoSalto()
	
func nuevoSalto() -> void:
	posSalto = randi_range(yMin,yMax)
	temp.wait_time = randf_range(tMin, tMax)


func _on_AnimationFinished(anim_name: String):
	if anim_name == "new_animation":
		var anim_length = $AnimationPlayer.current_animation_length
		$AnimationPlayer.seek(anim_length, true)
		$AnimationPlayer.speed_scale = 0.0  # Congela la animación
