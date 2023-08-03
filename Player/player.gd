extends CharacterBody2D

const SPEED = 230
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer") #make it a runtime variable
@onready var jumpSound = $jump

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor(): #if in air
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
		jumpSound.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#flip direction according to the players movement
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run") 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0: #if not in air	
			anim.play("Idle") 
	if velocity.y > 0:
		anim.play("Fall")

	move_and_slide()
	
	if Game.playerHealth <= 0:
		self.queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		Game.playerHealth = 10
		Game.goldCount = 0
