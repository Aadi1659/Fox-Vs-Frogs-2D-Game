extends CharacterBody2D

var SPEED = 200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

@onready var playerHurt = $playerHurt
@onready var coins = $coins

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

#add gravity for frog
func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else: 
			get_node("AnimatedSprite2D").flip_h = false			
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Death":
			get_node("AnimatedSprite2D").play("Idle")		
		velocity.x = 0
	move_and_slide()
	
func _on_player_detection_area_2d_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_player_detection_area_2d_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_player_death_area_2d_body_entered(body):
	#when the player jumps on top of the frog
	if body.name == "Player":
		chase = false
		coins.play()
		death()

func _on_player_collsion_body_entered(body):
	if body.name == "Player":
		Game.playerHealth -= 3
		playerHurt.play()
		death()
			
func death():
	Game.goldCount += 5
	Utils.saveGame()
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free() #delete the frog
