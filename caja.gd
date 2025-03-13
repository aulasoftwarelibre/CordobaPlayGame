extends Control
@onready var temp=$MovPez
@onready var yMax=int($ColorRect/MarginContainer/ColorRect.size.y)
@onready var pez=$ColorRect/MarginContainer/ColorRect/TextureRect
var posSalto: int =0

func _ready() -> void:
	await get_tree().process_frame  # Espera un frame para que los nodos tengan su tamaño correcto
	yMax = int($ColorRect/MarginContainer/ColorRect.size.y)  # Ahora tendrá el tamaño correcto
	nuevoSalto()

func _process(delta: float) -> void:
	pez.position.y= lerpf(pez.position.y,posSalto,0.6)

func _on_mov_pez_timeout() -> void:
	nuevoSalto()
	
func nuevoSalto() -> void:
	posSalto= randi()%yMax
	print("Salto", posSalto)
	temp.wait_time=randf_range(0.6,5)
	
