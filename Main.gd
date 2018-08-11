extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (PackedScene) var Mob
var score

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func game_over():
	$Music.stop()
	$DeathSound.play()
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_MobTimer_timeout():
	# Get random location on path
	$MobPath/MobSpawnLocation.set_offset(randi())
	
	# Spawn mob
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += rand_range(- PI / 4, PI / 4)
	mob.rotation = direction
	
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed), 0).rotated(direction))


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	$Music.play()
