extends Node2D


var atletas = {}
export(String) var prefixo_controles = "j1"
var bola
onready var formacao = $FormacaoA
onready var encaixe_goleire = $AreaGol/PosicaoGoleire


func adicionar_atleta(atleta, posicao):
	$FormacaoA.get_node(posicao).atleta = atleta
	$FormacaoB.get_node(posicao).atleta = atleta
	atletas[atleta] = posicao

func encaixe_atleta(atleta):
	return formacao.get_node(atletas[atleta])


func atleta_na_bola():
	var menor_distancia = 999999
	var mais_perto = null
	for a in atletas.keys():
		a.na_bola = false
		if a.global_position.distance_to(bola.position) < menor_distancia:
			mais_perto = a
			menor_distancia = a.global_position.distance_to(bola.position)
	mais_perto.na_bola = true
	return mais_perto


func trocar_formacao():
	var nova_formacao = $FormacaoA if formacao == $FormacaoB else $FormacaoB
	formacao = nova_formacao


func _ready():
	bola = get_parent().get_node("Bola")
	adicionar_atleta($Atleta1, "Posicao1")
	adicionar_atleta($Atleta2, "Posicao2")
	adicionar_atleta($Atleta3, "Posicao3")
	adicionar_atleta($Atleta4, "Posicao4")
	for a in atletas.keys():
		a.bola = bola
	$Goleire.bola = bola


func _process(delta):
	if Input.is_action_just_released(prefixo_controles + "_acao2"):
		trocar_formacao()

