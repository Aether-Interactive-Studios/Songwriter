extends Control

var verse = "Verse"
var prechorus = "Pre-Chorus"
var chorus = "Chorus"
var verse2 = "Verse 2"
var bridge = "Bridge"
var Master = "Master"
var x

var space = "\n"
var location = "res://Lyrics.json"


var data = {
	"Verse" : "",
	"Pre-Chorus" : "",
	"Chorus" : "",
	"Verse 2" : "",
	"Bridge": "",
	"Master": ""
	}
func read():
	var lyrics = File.new()
	lyrics.open(location, File.READ)
	data = parse_json(lyrics.get_as_text())


	for keys in data.keys():
		if not keys == Master:
			print(data[keys])
			var node = get_node("TabContainer/"+keys)
			node.text = data[keys]
			$"TabContainer/Master".text += keys + ":\n" + data[keys] + "\n\n"


func _ready():

	var lyrics = File.new()

	if not lyrics.file_exists(location):

		lyrics.open(location, File.WRITE)
		lyrics.store_string(to_json(data))
		lyrics.close()
		read()

	else:
		read()


func main(part):
	var node = get_node("TabContainer/"+part)
	var text = node.text
	data[part] = text
	var lyrics = File.new()
	lyrics.open(location, File.WRITE)
	lyrics.store_string(to_json(data))


func _master_():
	var text 

	for keys in data.keys():
		text = keys + data[keys] + "\n"
		print(text)

	$"TabContainer/Master".text = text




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
func _on_Master_text_changed():
	main(Master)
	pass # Replace with function body.


func _on_TabContainer_tab_changed(_tab):

	pass # Replace with function body.
