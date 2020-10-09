extends CollisionShape2D

var cor = Color.red

func _draw():
	draw_circle(position, 50, cor)


func _on_GolDireita_body_entered(body):
	if body.name == "Bola":
		print(body.name)
		cor = Color.white
		update()
	pass # Replace with function body.
