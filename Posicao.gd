extends Node2D

export var desenhar_debug = false
var atleta

func _draw():
	if not desenhar_debug:
		return
	var cor = Color.red
	cor.a = 0.25
	draw_circle(Vector2.ZERO, 16, cor)

