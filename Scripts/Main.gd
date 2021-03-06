extends Control
var buttonHovered 
var intro = "Intro"
var verse = "Verse"
var prechorus = "Pre-Chorus"
var chorus = "Chorus"
var verse2 = "Verse 2"
var bridge = "Bridge"
var Master = "Master"
var outro = "Outro"
var x
var cn = ":\n"
var n2 = "\n\n"
var item = "Default"

var storage = "user://"
var space = "\n"
var location = storage + "Default.json"
var songs = storage + "songs.json"


var data = {
	"Intro" : "",
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse 2" : "",
	"Bridge": "",
	"Master": "",
	"Outro" : ""
	}
	
	
#func loadsaves():
#	x
	
func make_file_dialog_visible():
	$Screen.visible = true
	$Screen/LineEdit.grab_focus()

	

	
func _on_item_pressed(id):
	item = $MenuButton.get_popup().get_item_text(id)
	if item == "Save as Txt":
		$FileDialog.popup()
	elif item == "Add Song":
		
		
		make_file_dialog_visible()
	else:
		location = storage + item + ".json"
		
	
	
	newfile()
	_master_()
	pass
	
	
	
	
	
func read():
	var lyrics = File.new()
	lyrics.open(location, File.READ)
	data = parse_json(lyrics.get_as_text())
	if not data.has("Intro"):
		data["Intro"] = ""
	if not data.has("Outro"):
		data["Outro"] = ""
	for keys in data.keys():
		if not keys == Master:
			
			var node = get_node("TabContainer/"+keys)
			node.text = data[keys]
			

		
			

	lyrics.close()
	
	
func newfile():
	data = {
	"Intro": "",
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse 2" : "",
	"Bridge": "",
	"Master": "",
	"Outro": ""
	}
	
	var lyrics = File.new()

	if not lyrics.file_exists(location):

		lyrics.open(location, File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
		read()
		_master_()

	else:
		read()
		_master_()
	
	
func _ready():
	
	var lyrics = File.new()
	$MenuButton.get_popup().add_item("Add Song")
	$MenuButton.get_popup().add_item("Save as Txt")
	$MenuButton.get_popup().add_item("Default")
	
	
	
	lyrics.open(songs, File.READ)
	
	if lyrics.file_exists(songs):
		var songinfo = parse_json(lyrics.get_as_text())
		
		
		for keys in songinfo.keys():
			if not keys == "Default":
				$MenuButton.get_popup().add_item(keys)
	else:
		
		lyrics.open(songs, File.WRITE)
		lyrics.store_string("{\"Default\" : \"\" }")
	
	lyrics.close()

	
	
	$MenuButton.get_popup().connect("id_pressed", self, "_on_item_pressed")

	

	if not lyrics.file_exists(location):

		lyrics.open(location, File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
		read()

	else:
		read()
		
	_master_()
	
	
	
func main(part):
	var node = get_node("TabContainer/"+part)
	var text = node.text
	data[part] = text
	var lyrics = File.new()
	lyrics.open(location, File.WRITE)
	lyrics.store_string(to_json(data))
	
		
	_master_()


func _master_():
	if not item == "Add Song":
		
		
		
		
		$"TabContainer/Master".text = (
			item + "\n" +
			intro + cn + data[intro] + n2 +
			verse + cn + data[verse] + n2 +
			prechorus + cn + data[prechorus] + n2 +
			chorus + cn + data[chorus] + n2 +
			verse2 + cn + data[verse2] + n2 +
			prechorus + cn + data[prechorus] + n2 +
			chorus + cn + data[chorus] + n2 +
			bridge + cn + data[bridge] + n2+
			chorus + cn + data[chorus] + n2+
			outro + cn + data[outro]
			
		)



func _on_Intro_text_changed():
	main(intro)
	pass # Replace with function body.
func _on_Verse_text_changed():
	main(verse)
	pass # Replace with function body.
func _on_PreChorus_text_changed():
	main(prechorus)
	pass # Replace with function body.
func _on_Chorus_text_changed():
	main(chorus)
	pass # Replace with function body.
func _on_Verse_2_text_changed():
	main(verse2)
	pass # Replace with function body.
func _on_Bridge_text_changed():
	main(bridge)
	pass # Replace with function body.

func _on_Outro_text_changed():
	main(outro)
	pass # Replace with function body.	
	
func _on_Master_text_changed():
	
	pass # Replace with function body.



func _on_MenuButton_pressed():
	
	pass # Replace with function body.


func _on_LineEdit_focus_entered():
	
	pass # Replace with function body.


func _on_LineEdit_text_entered(new_text):
	item = new_text
	
	location = storage + new_text + ".json"
	$MenuButton.get_popup().add_item(new_text)
	var file = File.new()
	var toJson = "," + "\"" +new_text + "\"" + ": \"\" }"
	

	file.open(songs, File.READ_WRITE)
	file.seek_end(-1)
	file.store_string(toJson)
	newfile()
	item = new_text
	
	$Screen.visible = false

	
	pass # Replace with function body.




#func _on_LineEdit_focus_exited():
#
#	$LineEdit.visible = false
#
#	$Button.visible = false
#	pass # Replace with function body.


func _on_Button_pressed():
	
	_on_LineEdit_text_entered($Screen/LineEdit.text)
	
	_master_()
	$Screen.visible = false

	pass # Replace with function body.



func _on_FileDialog_file_selected(path):
	_master_()
	
	
	var txt = File.new()
	txt.open(path+".txt", File.WRITE )
	txt.store_string($"TabContainer/Master".text)
	pass # Replace with function body.



func _on_Cancel_pressed():
	$Screen.visible = false
	pass # Replace with function body.






