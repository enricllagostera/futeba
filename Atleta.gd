extends RigidBody2D

export var cor_bola := Color.white
var zona_morta = 2.5
onready var equipe = get_parent()
export var velocidade_base := 10
export var desenhar_debug = true
var bola
var acumulo_pique = 0
export var pique_poder = 4000
export var acumulo_pique_taxa := 1.1
export var distancia_min_encaixe = 20
var na_bola = false
export var intervalo_recuperacao = 1.1
export var damping_pique = 10
export var goleire := false
var no_pique = 0


func _draw():
	# Your draw commands here
	if not desenhar_debug:
		return
	var cor = Color.blueviolet
	cor.a = 0.2
	if na_bola:
		draw_circle(Vector2.ZERO, 32, cor_bola)
		draw_circle(Vector2.ZERO, 120 * acumulo_pique, cor)
		if acumulo_pique > 0.2:
			draw_line(Vector2.ZERO, (bola.global_position-global_position).normalized() * 128,cor_bola, 4 * acumulo_pique)
#	draw_line(Vector2.ZERO, , Color.red, 2)
	pass


func _on_Atleta_body_entered(body):
	print("toque")
#	if body.name == "Bola":
#		body.apply_central_impulse(self.linear_velocity)
	pass # Replace with function body.


func _physics_process(delta):
	var velocidade = 0
	var encaixe 
	if goleire:
		encaixe = equipe.encaixe_goleire
	else:
		encaixe = equipe.encaixe_atleta(self)
	var direcao_desejada = encaixe.global_position - global_position
	var distancia_relativa = direcao_desejada.length()
	var rampa_chegada = distancia_relativa / distancia_min_encaixe if distancia_relativa < distancia_min_encaixe else 1
	var direcao = direcao_desejada.clamped(1)
	var soltou_pique = Input.is_action_just_released(equipe.prefixo_controles + "_acao1")
	if soltou_pique and na_bola:
		direcao = (bola.position - self.position).normalized()
		velocidade = pique_poder * acumulo_pique
		acumulo_pique = 0
		no_pique = intervalo_recuperacao
		linear_damp = damping_pique
		apply_central_impulse(direcao * velocidade)
		return
	velocidade = velocidade_base
	$Visual.flip_h = (bola.global_position - global_position).dot(Vector2.RIGHT) <= 0
	
	var carregando_chute = Input.is_action_pressed(equipe.prefixo_controles + "_acao1") and na_bola
	if carregando_chute:
		linear_velocity = direcao * velocidade * 0.5 * rampa_chegada
		return		
	if not (no_pique > 0):
		linear_velocity = direcao * velocidade * rampa_chegada


func _process(delta):
	var olhar_pra_bola = bola.global_position
	if no_pique > 0:
		no_pique -= delta
	else:
		linear_damp = -1
		if na_bola:
			if Input.is_action_just_pressed(equipe.prefixo_controles + "_acao1"):
				acumulo_pique = 0
			if Input.is_action_pressed(equipe.prefixo_controles + "_acao1"):
				acumulo_pique += acumulo_pique_taxa * delta
				acumulo_pique = clamp(acumulo_pique, 0, 1)
		else:
			acumulo_pique = 0
	if linear_velocity.length_squared() > zona_morta:
		moveu()
	else: 
		parou()
	update()

func moveu():
	print("moveu")
	var encaixe 
	if goleire:
		encaixe = equipe.encaixe_goleire
	else:
		encaixe = equipe.encaixe_atleta(self)
	if global_position.distance_to(encaixe.global_position) > distancia_min_encaixe * 0.2:
		$Visual.animation = "correndo"

func parou():
	$Visual.animation = "parade"
