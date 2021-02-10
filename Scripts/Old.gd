extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var verse = "Verse"
var prechorus = "Pre-Chorus"
var chorus = "Chorus"
var verse2 = "Verse2"
var bridge = "Bridge"
var x
var space = "\n"


var data = {
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse2" : "",
	"Bridge": ""
}

# Called when the node enters the scene tree for the first time.
func _ready():



	var lyrics = File.new()

	if not lyrics.file_exists("res://Lyrics.json"):

		lyrics.open("res://Lyrics.json", File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
	else:
		lyrics.open("res://Lyrics.json", File.READ)
		data = parse_json(lyrics.get_as_text())




	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
#	var idx = data[x]
#	print (idx)
#	var last = idx.right(idx.length() - 1)
#	if last == "":
#		idx.substring(0,idx.length() - 1)
#	print(idx)
	data[x] = $TextEdit.text

func _on_Save_pressed():
#	print(x)
#
#	data[x] = $TextEdit.text
#	var file = File.new()
#	file.open("res://Lyrics.json", File.WRITE)
#	file.store_string(to_json(data))
#	file.close()
	match x: 

		verse:

			_data()

		verse2:

			_data()	



		chorus:
			_data()


		prechorus:
			_data()


		bridge:
			_data()

	var file = File.new()
	file.open("res://Lyrics.json", File.WRITE)
	file.store_string(to_json(data))
	file.close()



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

func default(json):

	$TextEdit.text = (
	 "Verse: \n" +   json["Verse"] + space +
	 "\nPre-Chorus: \n" + json["Pre-Chorus"] + space +
	 "\nChorus: \n" + json["Chorus"] + space +
	 "\nVerse: \n" + json["Verse2"] + space +
	"\nPre-Chorus: \n" + json["Pre-Chorus"] + space +
	"\nChorus: \n" + json["Chorus"] + space +	 
	 "\nBridge: \n" + json["Bridge"] + space +
	 "\nChorus: \n" + json["Chorus"] )

func _on_Master_pressed():
	see()

	var savefile = File.new()
	if savefile.file_exists("res://Lyrics.json"):
		savefile.open("res://Lyrics.json", File.READ)
		var json = parse_json(savefile.get_as_text())
		default(json)




	pass # Replace with function body.
