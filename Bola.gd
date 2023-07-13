extends RigidBody2D

func _process(delta):
	$Visual.speed_scale = clamp(linear_velocity.length() * 0.005, 0, 1)


func _on_GolDireita_body_entered(body):
	if body.name == "Bola":
		print("GOOOOOLLLL")
	pass # Replace with function body.
