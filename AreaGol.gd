extends Area2D

func _process(delta):
	var formacao = get_parent().formacao.global_position
	var bola = get_parent().bola.global_position
	look_at(lerp(bola, formacao, 0.3))
