extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal hit

export (int) var speed
var screensize


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hide()
	screensize = get_viewport_rect().size


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var velocity = Vector2() # player's movement vector
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1;
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1;
	
	# Play animation if key pressed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	
	# Stop animation if no input detected
	else:
		$AnimatedSprite.stop()
	
	position  += velocity * delta;
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	
	if velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


