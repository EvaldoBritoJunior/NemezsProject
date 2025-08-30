//Starting
ground = true;
init_step = true;
is_step = false;
step_timer = 0;
vel = 0;
can_min_jump = true;

//Acting variables
is_shoot = false;
can_shoot = true;
is_slide = false;
can_move = true;
can_sprite_change = true;

//Physics variables
grav = 0.25 * 5;
jump_speed = (4.75 + grav) * 5;
walk_speed = 1.3 * 5;
max_vspeed = 7 * 5;
step_speed = 1/7 * 5;
step_frames = 7;
slide_speed = 2.5 * 5;
slide_frames = 26;

//Sprites variables
char_spr_stand = spr_stand;
char_spr_step = spr_step;
char_spr_jump = spr_jump;
char_spr_walk = spr_walk;
char_spr_slide = spr_slide;