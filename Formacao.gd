extends Node2D


export var velocidade_formacao = 5


func _process(delta):
	var direcao = Vector2(
			Input.get_action_strength("j1_direita") - Input.get_action_strength("j1_esquerda"),
			Input.get_action_strength("j1_baixo") - Input.get_action_strength("j1_cima")).clamped(1)
	position += direcao * velocidade_formacao * delta
	get_parent().atleta_na_bola()
