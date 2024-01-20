extends CharacterBody2D

var player_speed: int = 500
var can_laser: bool = true
var can_grenade: bool = true


signal laser(pos, direction)
signal grenaded(pos, direction)

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_player(delta)
	player_action()

func move_player(_delta):
	var direction = Input.get_vector('left', 'right', 'up', 'down')
	#print(direction)
	velocity = direction * player_speed
	move_and_slide()
	loop_x()
	
	look_at(get_global_mouse_position())
	
func shoot():
	if Input.is_action_pressed('primary_action') and can_laser:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var direction = (get_global_mouse_position() - position).normalized()
		can_laser = false
		laser.emit(selected_laser.global_position, direction)
		$LaserCooldown.start()
		
func grenade():
	if Input.is_action_pressed('secondary_action') and can_grenade:
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		var direction = (get_global_mouse_position() - position).normalized()
		can_grenade = false
		grenaded.emit(selected_laser.global_position, direction)
		$GrenadeCooldown.start()
		
func player_action():
	shoot()
	grenade()

func loop_x():
	var view_width: int = get_viewport().size.x
	if position.x >= view_width:
		position.x = 0
	elif position.x <= 0:
		position.x = view_width

func _on_laser_cooldown_timeout():
	can_laser = true


func _on_grenade_cooldown_timeout():
	can_grenade = true
