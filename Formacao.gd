extends Node2D

var zona_morta = 0.05
export var velocidade_formacao = 5
onready var equipe = get_parent()
var movendo = false

func _process(delta):
	var direcao = Vector2(
			Input.get_action_strength(equipe.prefixo_controles + "_direita") - Input.get_action_strength(equipe.prefixo_controles + "_esquerda"),
			Input.get_action_strength(equipe.prefixo_controles + "_baixo") - Input.get_action_strength(equipe.prefixo_controles + "_cima")).clamped(1)
	position += direcao * velocidade_formacao * delta
	get_parent().atleta_na_bola()
