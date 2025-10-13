class_name Option3D
extends Node3D


var letters: Array[Letter]


func normal() -> void:
	for letter in letters:
		letter.normal()


func focus() -> void:
	for letter in letters:
		letter.focus()


func select() -> void:
	for letter in letters:
		letter.select()


func _ready() -> void:
	for child in get_children():
		letters.push_back(child)
