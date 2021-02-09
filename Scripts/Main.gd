extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var verse = "Verse"
var prechorus = "Pre-Chorus"
var chorus = "Chorus"
var verse2 = "Verse 2"
var bridge = "Bridge"
var x

var data = {
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse 2" : "",
	"Bridge": ""
}

# Called when the node enters the scene tree for the first time.
func _ready():

	
	
	var lyrics = File.new()
	
	if not lyrics.file_exists("res://Lyrics.json"):
		lyrics.open("res://Lyrics.json", File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
	
	



	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _display(part):
	see()
	$TextEdit.text = ""
	x = part
	
	var save = File.new()
	
	save.open("res://Lyrics.json", File.READ)
		
	
	var text = parse_json(save.get_as_text())
	
	save.close()
	
	$TextEdit.text = str(text[x])
	


func _on_Verse_pressed():
	_display(verse)
	
	
	pass # Replace with function body.
	
	
func _on_Chorus_pressed():
	
	_display(chorus)


func _on_PreChorus_pressed():
	
	_display(prechorus)
	pass # Replace with function body.


func _on_Verse2_pressed():
	
	_display(verse2)
	pass # Replace with function body.


func _on_Bridge_pressed():
	_display(bridge)
	pass # Replace with function body.

func _data():
	data[x] = $TextEdit.text

func _on_Save_pressed():
	print(x)
	
	data[x] = $TextEdit.text
	var file = File.new()
	file.open("res://Lyrics.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()
#	match x: 
#
#		verse:
#
#			_data()
#
##			var file = File.new()
#
##			file.open("res://Lyrics.json", File.WRITE)
##			file.store_string(to_json(data))
##			file.close()
#
#
#
#		chorus:
#			_data()
#
#
#		prechorus:
#			_data()
#
#
#		bridge:
#			_data()
			
			
			
#			var file = File.new()
#			file.open("res://Bridge.txt", File.WRITE)
#			file.store_string($TextEdit.text)
#			file.close()
			
				
	
	pass # Replace with function body.


func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)


func _on_TextEdit_text_changed():
	_on_Save_pressed()
	pass # Replace with function body.
	
func see():
	$TextEdit.visible = true
	pass
	
