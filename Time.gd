extends Node2D

export var velocidade_formacao = 5
var atletas = {}
var bola

func adicionar_atleta(atleta, posicao):
	atletas[posicao] = atleta

func atleta_na_bola():
	var menor_distancia = 999999
	var mais_perto = null
	for a in atletas.values():
		a.na_bola = false
		if a.global_position.distance_to(bola.position) < menor_distancia:
			mais_perto = a
			menor_distancia = a.global_position.distance_to(bola.position)
	mais_perto.na_bola = true
	return mais_perto

func _ready():
	bola = get_parent().get_node("Bola")
	adicionar_atleta(get_parent().get_node("Atleta1"), $Posicao1)
	adicionar_atleta(get_parent().get_node("Atleta2"), $Posicao2)
	adicionar_atleta(get_parent().get_node("Atleta3"), $Posicao3)
	adicionar_atleta(get_parent().get_node("Atleta4"), $Posicao4)


func _process(delta):
	var direcao = Vector2(
		Input.get_action_strength("j1_direita") - Input.get_action_strength("j1_esquerda"),
		Input.get_action_strength("j1_baixo") - Input.get_action_strength("j1_cima")).clamped(1)
	position += direcao * velocidade_formacao * delta
	atleta_na_bola()
