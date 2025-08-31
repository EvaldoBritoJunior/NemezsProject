// Draw Event
var _old_blend = image_blend;
var _old_alpha = image_alpha;

image_blend = c_yellow;   // any color you want; multiplies the sprite’s pixels
image_alpha = 1;          // keep your alpha (optional)

draw_self();

image_blend = _old_blend; // restore
image_alpha = _old_alpha;