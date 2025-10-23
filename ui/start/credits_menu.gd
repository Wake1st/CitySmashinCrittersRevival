class_name CreditsMenu
extends Menu


signal selected()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var credits_music: AudioStreamPlayer3D = $CreditsMusic

@onready var billboard: MeshInstance3D = %Billboard
@onready var sub_viewport: SubViewport = %SubViewport


func start_music() -> void:
	if not credits_music.playing:
		credits_music.play()


func display() -> void:
	animation_player.play("display_hint")


func input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		# dont show the selection play if the hint isn't displayed
		if animation_player.is_playing():
			animation_player.play("selected")
		
		selected.emit()


func _ready() -> void:
	var screen_material = StandardMaterial3D.new()
	screen_material.albedo_color = Color(1,1,1,1)
	
	var viewport_texture: ViewportTexture = sub_viewport.get_texture()
	screen_material.albedo_texture = viewport_texture
	
	(billboard.mesh as QuadMesh).material = screen_material
