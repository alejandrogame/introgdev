
depth = -y;

text_1 = "Yo I heard there's a key east of here.";

text_2 = "Yoooo you found it! My friend knows how to escape this place.";

text = text_1;

function update_text() {
	
	if (obj_player.has_key) text = text_2;
	
}
