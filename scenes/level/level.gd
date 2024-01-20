extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#$Logo.read_input()
	#$Player.move_player(delta)


func _on_gate_player_entered_gate(body):
	print('player has entered gate ', body)


func _on_player_laser(random_position, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = random_position
	laser.direction = direction
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	$Projectiles.add_child(laser) # adds an instantiated PackedScene	
	#laser.laser_gone.emit(laser)
	#$Projectiles.remove_child(laser)


func _on_player_grenaded(random_position, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = Vector2(random_position.x, random_position.y - grenade.get_child(1).texture.get_height() / 8)
	grenade.linear_velocity = direction * grenade.grenade_speed
	$Projectiles.add_child(grenade) # adds an instantiated PackedScene	
