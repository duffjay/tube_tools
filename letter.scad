// letter
// - emboss
module letter(strg, letter_height, letter_size, font) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(strg, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
	}
}

font = "Liberation Sans";


// letter("jay", 5, 20, "Liberation Sans");