extends Node2D

func _draw():
	var cor = Color.orange
	cor.a = 0.15
	draw_circle(Vector2.ZERO, 32, cor)
