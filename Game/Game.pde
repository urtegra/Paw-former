/**
*    PAW-FORMER
*    Platformer game with a built-in tile map editor

*    @author Urtė Grabliauskaitė, PS3
*/

import processing.sound.*;

/* VARIABLES */

SoundFile select, hover, pickup, life, lose, win;
PFont cabin_150, cabin_120, cabin_80, cabin_40, cabin_30, cabin_25, cabin_20;
PImage cursor_default, cursor_hover, cursor_drag, cursor;
Interface all;
Editor editor;
String action, character;
Level level, level_1, level_2, level_3, level_4, level_5, level_custom;
int current_level;
Boolean loadingFinished, mouseClicked;
float mouse_scroll;

// Player Sprite
final static float speed_move = 6;
final static float sprite_scale = 1;
final static float sprite_size = 50;
static float speed_jump = 0, acceleration;
Player player;
Player default_cat, default_dog, preview_cat, preview_dog;
PImage temp;

// Game Environment
final static float screen_width = 1000;
final static float screen_height = 750;
final static float margin_right = 500;
final static float margin_left = 300;
final static float margin_top = 50;
float view_x, view_y;
PImage spike, water_bottom, water_top, door_closed_bottom, door_closed_top, door_open_bottom, door_open_top;
PImage box, grass_bottom, grass_left, grass_right, grass_top, door_key, tile;
PImage bee, bee_2, bee_3, bee_4, bee_5;
PImage background;

/* SETUP */

public void setup() {
    // Game settings
    size(1000, 750, P2D); // P2D fixed the framerate drop problem
    imageMode(CENTER);

    // Several fonts made out of the same font, so OpenGL renders text in higher quality
    String font_path = "/Data/Interface/CabinSketch-Bold.ttf";
    cabin_150 = createFont(font_path, 150);
    cabin_120 = createFont(font_path, 120);
    cabin_80 = createFont(font_path, 80);
    cabin_40 = createFont(font_path, 40);
    cabin_30 = createFont(font_path, 30);
    cabin_25 = createFont(font_path, 25);
    cabin_20 = createFont(font_path, 20);

    select = new SoundFile(this, "/Data/Interface/select.wav");
    hover = new SoundFile(this, "/Data/Interface/hover.wav");
    pickup = new SoundFile(this, "/Data/Interface/pickup.wav");
    life = new SoundFile(this, "/Data/Interface/life.wav");
    lose = new SoundFile(this, "/Data/Interface/lose.wav");
    win = new SoundFile(this, "/Data/Interface/win.wav");

    cursor_default = loadImage("/Data/Interface/cursor_default.png");
    cursor_hover = loadImage("/Data/Interface/cursor_hover.png");
    cursor_drag = loadImage("/Data/Interface/cursor_drag.png");
    cursor = cursor_default;

    // Player sprite
    temp = loadImage("/Data/Sprites/Cat/Idle/Idle (1).png");
    character = "Cat";
    default_cat = new Player(temp, 0.2);
    preview_cat = new Player(temp, 0.5);
    character = "Dog";
    default_dog = new Player(temp, 0.2);
    preview_dog = new Player(temp, 0.5);
    preview_dog.x_center = screen_width / 2 + 62;
    preview_cat.x_center = screen_width / 2 - 190;
    preview_dog.y_center = screen_height / 2 - 75;
    preview_cat.y_center = screen_height / 2 - 75;
    player = default_cat; // Default character is set to cat
    character = "Cat";

    // Graphics
    background = loadImage("/Data/Tiles/background.png");
    // Declaring here so framerate would stay consistent...
    bee = loadImage("/Data/Sprites/Bee/Fly (1).png");
    bee_2 = loadImage("/Data/Sprites/Bee/Fly (2).png");
    bee_3 = loadImage("/Data/Sprites/Bee/Fly (3).png");
    bee_4 = loadImage("/Data/Sprites/Bee/Fly (4).png");
    bee_5 = loadImage("/Data/Sprites/Bee/Fly (5).png");
    spike = loadImage("/Data/Tiles/spikes.png");
    box = loadImage("/Data/Tiles/box.png");
    door_closed_bottom = loadImage("/Data/Tiles/door_closed_bottom.png");
    door_closed_top = loadImage("/Data/Tiles/door_closed_top.png");
    door_open_bottom = loadImage("/Data/Tiles/door_open_bottom.png");
    door_open_top = loadImage("/Data/Tiles/door_open_top.png");
    door_key = loadImage("/Data/Tiles/door_key.png");
    grass_bottom = loadImage("/Data/Tiles/grass_bottom.png");
    grass_left = loadImage("/Data/Tiles/grass_left.png");
    grass_right = loadImage("/Data/Tiles/grass_right.png");
    grass_top = loadImage("/Data/Tiles/grass_top.png");
    water_bottom = loadImage("/Data/Tiles/water.png");
    water_top = loadImage("/Data/Tiles/water_top.png");
    tile = loadImage("/Data/Tiles/tile.png");

    // Functionalities
    all = new Interface();
    level = new Level("/Data/Maps/level_1.csv");
    level_1 = new Level("/Data/Maps/level_1.csv");
    level_2 = new Level("/Data/Maps/level_2.csv");
    level_3 = new Level("/Data/Maps/level_3.csv");
    level_4 = new Level("/Data/Maps/level_4.csv");
    level_5 = new Level("/Data/Maps/level_5.csv");
    editor = new Editor("/Data/Maps/level_custom.csv");
    level_custom = new Level("/Data/Maps/level_custom.csv");

    current_level = 1;
    view_x = 0;
    view_y = 0;
    mouse_scroll = 300;
    mouseClicked = false;
    loadingFinished = false;
    action = "Main";
    smooth(8);
}

/* DISPLAY */

public void draw(){
cursor = cursor_default;
background(255);
image(background, screen_width / 2, screen_height / 2);
if (current_level == 1) level = level_1.clone();
else if (current_level == 2) level = level_2.clone();
else if (current_level == 3) level = level_3.clone();
else if (current_level == 4) level = level_4.clone();
else if (current_level == 5) level = level_5.clone();
else if (current_level == 0){
level.platforms = editor.platforms;
level.keys = editor.keys;
level.keys_double = editor.keys_double;
level.doors = editor.doors;
level.doors_open = editor.doors_open;
level.doors_bottom = editor.doors_bottom;
level.spikes = editor.spikes;
level.water = editor.water;
level.drowned = editor.drowned;
level.enemies = editor.enemies;
    }

if (action == "Play" || action == "Pause" || action == "Won" || action == "Lost"){
if (!loadingFinished) all.showLoading();
else {
if (action == "Play") level.scroll(true);
else level.scroll(false);

for (Sprite sprite: level.platforms) sprite.display();
for (Sprite sprite: level.spikes) sprite.display();
for (Sprite sprite: level.water) sprite.display();
level.total_keys = player.keys;
for (Sprite sprite: level.keys){
level.total_keys++;
sprite.display();
}

if (player.keys == level.total_keys && action != "Lost"){
level.openDoor(player, level.doors_bottom);
for (Sprite sprite: level.doors_open) sprite.display();
}
else for (Sprite sprite: level.doors) sprite.display();

level.loseLives(player, level.spikes);
level.loseLives(player, level.enemies);
level.resolvePlatformCollisions(player, level.platforms);
level.collectKeys(player, level.keys);
level.checkDrowned(player, level.drowned);

if (player.getTop() > level.height){
view_y = 0;
player.lives = 0;
}
else player.display();
if (player.hasDrowned){
player.lives = 0;
action = "Lost";
}
else player.display();

for (Sprite sprite: level.water) sprite.displayOpacity();
for (Sprite sprite: level.enemies){
sprite.display();
if (action != "Pause"){
sprite.update();
sprite.updateAnimation();
}
}

all.showInGame();

if (action != "Pause") player.updateAnimation();
if (action == "Pause") all.showPause();

if (action == "Won"){
all.showWon();
if (player.direction == "Right") player.current_images = player.idle_right;
else player.current_images = player.idle_left;
}

if (action == "Lost"){
all.showLost();
if (player.direction == "Right") player.current_images = player.idle_right;
else player.current_images = player.idle_left;
}
}
    }
else if (action == "Main") all.showMain();
else if (action == "Settings"){
all.showSettings();
preview_cat.display();
preview_cat.updateAnimation();
preview_dog.display();
preview_dog.updateAnimation();
    }
else if (action == "Levels"){
all.showLevels();
}
else if (action == "Editor"){
if (!loadingFinished) all.showLoading();
else editor.display();
    }
if (action != "Main") all.marquee = screen_width;

// "Fixing" where cursor() makes the custom cursor look low quality
noCursor();
image(cursor, mouseX, mouseY, 30, 30);

// Displaying FPS
fill(all.dark);
textAlign(LEFT);
textFont(cabin_30);
textSize(30);
text("FPS: " + int(frameRate), 75, screen_height - 75);

float volume = mouse_scroll / 300;
select.amp(volume);
hover.amp(volume);
pickup.amp(volume);
life.amp(volume);
lose.amp(volume);
win.amp(volume);
}

/* PLAYER EVENTS */

public void keyPressed() {
    if (action == "Play" && (keyCode == 9) && loadingFinished) {
        action = "Pause";
        player.x_change = 0;
        player.y_change = 0;
    }
    else if (action == "Play" && (keyCode == RIGHT || key == 'D' || key == 'd')) {
        player.x_change = speed_move;
    }
    else if (action == "Play" && (keyCode == LEFT || key == 'A' || key == 'a')) {
        player.x_change = -speed_move;
    }
    else if (action == "Play" && (keyCode == UP || key == 'W' || key == 'w' || keyCode == 32) && player.jumps < 2) {
        speed_jump = -13;
        player.jumps++;
    }
    else if (action == "Pause" && (keyCode == 9)) {
        action = "Play";
    }
}

public void keyReleased() {
    if (keyCode == RIGHT || key == 'D' || key == 'd') {
        player.x_change = 0;
    }
    else if (keyCode == LEFT || key == 'A' || key == 'a') {
        player.x_change = 0;
    }
    else if (keyCode == UP || key == 'W' || key == 'w' || keyCode == 32) {
        player.y_change = 0;
    }
}

public void mousePressed() {
    // Fixing where click might trigger another button after switching page
    mouseClicked = true;
}

public void mouseWheel(MouseEvent event) {
    if (action == "Settings") {
        if (mouse_scroll <= 300 && mouse_scroll >= 0) mouse_scroll += -event.getCount() * 15;
        if (mouse_scroll > 300) mouse_scroll = 300;
        if (mouse_scroll < 0) mouse_scroll = 0;
    }
}

public void mouseDragged() {
    if (action == "Editor" && editor.equipped == "Drag") {
        float mouseX_change = mouseX - pmouseX;
        float mouseY_change = mouseY - pmouseY;
        for (Sprite sprite : editor.platforms) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.keys) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.doors) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.spikes) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.water) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.tiles) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
        for (Sprite sprite : editor.enemies) {
            sprite.x_center = sprite.x_center + mouseX_change;
            sprite.y_center = sprite.y_center + mouseY_change;
        }
    }
}
