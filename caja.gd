extends Control
@onready var temp=$MovPez
@onready var yMax=int($ColorRect/MarginContainer/ColorRect.size.y)
@onready var pez=$ColorRect/MarginContainer/ColorRect/TextureRect
@onready var catch=$ColorRect/MarginContainer/ColorRect/Catch

@export var catchPeso: float =100
@export var tMin: float =0.6
@export var tMax: float =5.0
@export var pezVel: float =0.6
@export var catchLevantar: float =250

var posSalto: int =0

func _ready() -> void:
	await get_tree().process_frame  # Espera un frame para que los nodos tengan su tamaño correcto
	yMax = int($ColorRect/MarginContainer/ColorRect.size.y)  # Ahora tendrá el tamaño correcto
	nuevoSalto()

func _process(delta: float) -> void:
	pez.position.y= lerpf(pez.position.y,posSalto,pezVel)
	
	if Input.is_action_pressed("Pescar"):
		catch.position.y-=catchLevantar*delta
	if catch.position.y+catch.size.y<=yMax:
		catch.position.y+=catchPeso*delta


func _on_mov_pez_timeout() -> void:
	nuevoSalto()
	
func nuevoSalto() -> void:
	posSalto= randi()%yMax
	print("Salto", posSalto)
	temp.wait_time=randf_range(tMin,tMax)
