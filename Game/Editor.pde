public class Editor {

    ArrayList <Sprite> platforms, keys, keys_double, doors, doors_open, doors_bottom;
    ArrayList <Sprite> spikes, water, drowned, enemies, tiles;
    String filename, equipped;
    String[][] table;
    Button button_main, button_play, button_drag, button_eraser, button_clear, last_hovered, clear;
    Button button_box, button_door_bottom, button_door_top, button_key;
    Button button_grass_bottom, button_grass_left, button_grass_right, button_grass_top;
    Button button_spikes, button_water, button_water_top, button_bee;
    PImage image, eraser, trash;
    int rows, columns;
    float width, height;
    color background;

    public Editor(String path) {
        filename = path;
        getDimensions();
        table = new String[rows][columns];

        enemies = new ArrayList <Sprite>();
        keys = new ArrayList <Sprite>();
        platforms = new ArrayList <Sprite>();
        doors = new ArrayList <Sprite>();
        doors_open = new ArrayList <Sprite>();
        doors_bottom = new ArrayList <Sprite>();
        spikes = new ArrayList <Sprite>();
        water = new ArrayList <Sprite>();
        drowned = new ArrayList <Sprite>();
        tiles = new ArrayList <Sprite>();
        createTiles();
        keys_double = new ArrayList <Sprite>(keys);

        eraser = loadImage("/Data/Interface/eraser.png");
        trash = loadImage("/Data/Interface/trash.png");
        background = (#534741);
        equipped = "Drag";

        button_main = new Button(150, 75, 200, 50);
        button_play = new Button(screen_width - 150, 75, 200, 50);
        button_drag = new Button(125, screen_height - 125, 46, 46);
        button_eraser = new Button(button_drag.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_clear = new Button(button_eraser.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_grass_top = new Button(button_clear.x_center + 100, button_drag.y_center, button_drag.width, button_drag.height);
        button_grass_bottom = new Button(button_grass_top.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_grass_left = new Button(button_grass_bottom.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_grass_right = new Button(button_grass_left.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_box = new Button(button_grass_right.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_water = new Button(button_box.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_water_top = new Button(button_water.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_spikes = new Button(button_water_top.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_door_bottom = new Button(button_spikes.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_door_top = new Button(button_door_bottom.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_key = new Button(button_door_top.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);
        button_bee = new Button(button_key.x_center + 50, button_drag.y_center, button_drag.width, button_drag.height);

        last_hovered = new Button(0, 0, 0, 0);
        clear = new Button(0, 0, 0, 0);
    }

    public void display() {
        background(background);
        if (equipped == "Drag") cursor = cursor_drag;

        fill(all.light, 100);
        noStroke();
        rectMode(CENTER);
        rect(screen_width / 2, screen_height - 125, screen_width - 100, 150, all.radius);

        for (Sprite sprite : platforms) sprite.display();
        for (Sprite sprite : keys) sprite.display();
        for (Sprite sprite : spikes) sprite.display();
        for (Sprite sprite : water) sprite.display();
        for (Sprite sprite : doors) sprite.display();
        for (Sprite sprite : tiles) sprite.display();
        for (Sprite sprite : enemies) sprite.display();

        // Main Menu Button
        noStroke();
        fill(all.light, 100);
        rectMode(CENTER);
        rect(screen_width / 2, screen_height - 125, screen_width - 100, 150, all.radius);
        strokeWeight(3);
        stroke(all.accent_darker);
        textSize(40);
        textFont(cabin_40);
        textAlign(CENTER);
        if (button_main.onHover()) {
            fill(all.accent_darker);
            if (last_hovered != button_main) hover.play();
            if (mouseClicked && mousePressed) {
                for (Sprite sprite : platforms) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : keys) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : doors) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : spikes) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : water) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : tiles) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : enemies) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                action = "Main";
                current_level = 1;
                loadingFinished = false;
                player.restart();
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_main;
        }
        else fill(all.accent);
        rectMode(CENTER);
        rect(button_main.x_center, button_main.y_center, button_main.width, button_main.height, all.radius);
        fill(all.light);
        text("Main Menu", button_main.x_center, button_main.y_center + button_main.height / 5);

        // Save Button
        if (button_play.onHover()) {
            fill(all.accent_darker);
            if (last_hovered != button_play) hover.play();
            if (mouseClicked && mousePressed) {
                saveMap();
                action = "Play";
                for (Sprite sprite : platforms) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : keys) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : doors) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : spikes) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : water) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : tiles) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                for (Sprite sprite : enemies) {
                    sprite.x_center = sprite.x_center_default;
                    sprite.y_center = sprite.y_center_default;
                }
                current_level = 0;
                loadingFinished = false;
                player.restart();
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_play;
        }
        else fill(all.accent);
        rectMode(CENTER);
        rect(button_play.x_center, button_play.y_center, button_play.width, button_play.height, all.radius);
        fill(all.light);
        text("Save", button_play.x_center, button_play.y_center + button_play.height / 5);

        if (mousePressed && !onHover() && !button_main.onHover() && !button_play.onHover()) {
            removeTiles(platforms);
            removeTiles(keys);
            removeTiles(keys_double);
            removeTiles(doors);
            removeTiles(doors_open);
            removeTiles(doors_bottom);
            removeTiles(spikes);
            removeTiles(water);
            removeTiles(drowned);
            removeTiles(enemies);
            addTiles(tiles);
        }

        // Editing Tools
        strokeWeight(4);
        stroke(all.accent);
        fill(all.accent, 0);
        if (button_drag.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_drag) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Drag";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_drag;
        }
        if (equipped == "Drag") stroke(all.shade);
        image(cursor_drag, button_drag.x_center, button_drag.y_center, button_drag.width, button_drag.height);
        rect(button_drag.x_center, button_drag.y_center, button_drag.width, button_drag.height);

        stroke(all.accent);
        if (button_eraser.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_eraser) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Eraser";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_eraser;
        }
        if (equipped == "Eraser") stroke(all.shade);
        image(eraser, button_eraser.x_center, button_eraser.y_center, button_eraser.width, button_eraser.height);
        rect(button_eraser.x_center, button_eraser.y_center, button_eraser.width, button_eraser.height);

        stroke(all.accent);
        if (button_clear.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_clear) hover.play();
            if (mouseClicked && mousePressed) {
                for (int row = 0; row < rows; row++) {
                    for (int column = 0; column < columns; column++) table[row][column] = "-1";
                }
                platforms.clear();
                keys.clear();
                keys_double.clear();
                doors.clear();
                doors_open.clear();
                doors_bottom.clear();
                spikes.clear();
                water.clear();
                drowned.clear();
                enemies.clear();
                equipped = "Clear";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_clear;
        }
        image(trash, button_clear.x_center, button_clear.y_center, button_clear.width, button_clear.height);
        rect(button_clear.x_center, button_clear.y_center, button_clear.width, button_clear.height);

        // Add Tiles
        stroke(all.accent);
        if (button_grass_top.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_grass_top) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Grass Top";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_grass_top;
        }
        if (equipped == "Grass Top") stroke(all.shade);
        image(grass_top, button_grass_top.x_center, button_grass_top.y_center, button_grass_top.width, button_grass_top.height);
        rect(button_grass_top.x_center, button_grass_top.y_center, button_grass_top.width, button_grass_top.height);

        stroke(all.accent);
        if (button_grass_bottom.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_grass_bottom) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Grass Bottom";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_grass_bottom;
        }
        if (equipped == "Grass Bottom") stroke(all.shade);
        image(grass_bottom, button_grass_bottom.x_center, button_grass_bottom.y_center, button_grass_bottom.width, button_grass_bottom.height);
        rect(button_grass_bottom.x_center, button_grass_bottom.y_center, button_grass_bottom.width, button_grass_bottom.height);

        stroke(all.accent);
        if (button_grass_left.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_grass_left) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Grass Left";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_grass_left;
        }
        if (equipped == "Grass Left") stroke(all.shade);
        image(grass_left, button_grass_left.x_center, button_grass_left.y_center, button_grass_left.width, button_grass_left.height);
        rect(button_grass_left.x_center, button_grass_left.y_center, button_grass_left.width, button_grass_left.height);

        stroke(all.accent);
        if (button_grass_right.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_grass_right) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Grass Right";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_grass_right;
        }
        if (equipped == "Grass Right") stroke(all.shade);
        image(grass_right, button_grass_right.x_center, button_grass_right.y_center, button_grass_right.width, button_grass_right.height);
        rect(button_grass_right.x_center, button_grass_right.y_center, button_grass_right.width, button_grass_right.height);

        stroke(all.accent);
        if (button_box.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_box) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Box";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_box;
        }
        if (equipped == "Box") stroke(all.shade);
        image(box, button_box.x_center, button_box.y_center, button_box.width, button_box.height);
        rect(button_box.x_center, button_box.y_center, button_box.width, button_box.height);

        stroke(all.accent);
        if (button_water_top.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_water_top) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Water Top";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_water_top;
        }
        if (equipped == "Water Top") stroke(all.shade);
        image(water_top, button_water_top.x_center, button_water_top.y_center, button_water_top.width, button_water_top.height);
        rect(button_water_top.x_center, button_water_top.y_center, button_water_top.width, button_water_top.height);

        stroke(all.accent);
        if (button_water.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_water) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Water Bottom";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_water;
        }
        if (equipped == "Water Bottom") stroke(all.shade);
        image(water_bottom, button_water.x_center, button_water.y_center, button_water.width, button_water.height);
        rect(button_water.x_center, button_water.y_center, button_water.width, button_water.height);


        stroke(all.accent);
        if (button_spikes.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_spikes) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Spikes";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_spikes;
        }
        if (equipped == "Spikes") stroke(all.shade);
        image(spike, button_spikes.x_center, button_spikes.y_center, button_spikes.width, button_spikes.height);
        rect(button_spikes.x_center, button_spikes.y_center, button_spikes.width, button_spikes.height);


        stroke(all.accent);
        if (button_door_bottom.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_door_bottom) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Door Bottom";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_door_bottom;
        }
        if (equipped == "Door Bottom") stroke(all.shade);
        image(door_closed_bottom, button_door_bottom.x_center, button_door_bottom.y_center, button_door_bottom.width, button_door_bottom.height);
        rect(button_door_bottom.x_center, button_door_bottom.y_center, button_door_bottom.width, button_door_bottom.height);

        stroke(all.accent);
        if (button_door_top.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_door_top) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Door Top";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_door_top;
        }
        if (equipped == "Door") stroke(all.shade);
        image(door_closed_top, button_door_top.x_center, button_door_top.y_center, button_door_top.width, button_door_top.height);
        rect(button_door_top.x_center, button_door_top.y_center, button_door_top.width, button_door_top.height);

        stroke(all.accent);
        if (button_key.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_key) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Key";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_key;
        }
        if (equipped == "Key") stroke(all.shade);
        image(door_key, button_key.x_center, button_key.y_center, button_key.width, button_key.height);
        rect(button_key.x_center, button_key.y_center, button_key.width, button_key.height);

        stroke(all.accent);
        if (button_bee.onHover()) {
            stroke(all.accent_darker);
            if (last_hovered != button_bee) hover.play();
            if (mouseClicked && mousePressed) {
                equipped = "Bee";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_bee;
        }
        if (equipped == "Bee") stroke(all.shade);
        image(bee, button_bee.x_center, button_bee.y_center, button_bee.width, button_bee.height);
        rect(button_bee.x_center, button_bee.y_center, button_bee.width, button_bee.height);

        if (equipped != "Drag" && equipped != "Clear") {
            if (equipped == "Eraser") image = eraser;
            else if (equipped == "Grass Top") image = grass_top;
            else if (equipped == "Grass Bottom") image = grass_bottom;
            else if (equipped == "Grass Left") image = grass_left;
            else if (equipped == "Grass Right") image = grass_right;
            else if (equipped == "Box") image = box;
            else if (equipped == "Door Bottom") image = door_closed_bottom;
            else if (equipped == "Door Top") image = door_closed_top;
            else if (equipped == "Key") image = door_key;
            else if (equipped == "Spikes") image = spike;
            else if (equipped == "Water Bottom") image = water_bottom;
            else if (equipped == "Water Top") image = water_top;
            else if (equipped == "Bee") image = bee;
            image(image, mouseX + 25, mouseY + 25, 50, 50);
        }

        if (!button_main.onHover() && !button_play.onHover() && !button_drag.onHover() && !button_eraser.onHover()  && !button_clear.onHover() && !button_grass_top.onHover() && !button_grass_bottom.onHover() && !button_grass_left.onHover() && !button_grass_right.onHover() && !button_box.onHover()  && !button_water_top.onHover() && !button_water.onHover() && !button_door_bottom.onHover() && !button_door_top.onHover() && !button_key.onHover()  && !button_spikes.onHover() && !button_water.onHover() && !button_water_top.onHover() && !button_bee.onHover()) last_hovered = clear;
    }

    public boolean checkCollision(Sprite sprite) {
        boolean xOverlap = mouseX <= sprite.getLeft() || mouseX >= sprite.getRight();
        boolean yOverlap = mouseY <= sprite.getTop() || mouseY >= sprite.getBottom();
        if (xOverlap || yOverlap) return false;
        else return true;
    }

    public ArrayList <Sprite> checkCollisionList(ArrayList <Sprite> list) {
        ArrayList <Sprite> collision_list = new ArrayList <Sprite>();
        for (Sprite sprite : list) if (checkCollision(sprite)) collision_list.add(sprite);
        return collision_list;
    }

    public void removeTiles(ArrayList <Sprite> objects) {
        ArrayList <Sprite> collision_list = checkCollisionList(objects);
        if (collision_list.size() > 0) {
            Sprite collided = collision_list.get(0);
            if (equipped != "Drag") {
                objects.remove(collided);
                table[getCell(collided, "row")][getCell(collided, "column")] = "-1";
            }
        }
    }
    public void addTiles(ArrayList <Sprite> objects) {
        ArrayList <Sprite> collision_list = checkCollisionList(objects);
        if (collision_list.size() > 0) {
            Sprite collided = collision_list.get(0);
            if (equipped == "Grass Top") {
                Sprite sprite = new Sprite(grass_top, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                platforms.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "10";
            }
            else if (equipped == "Grass Bottom") {
                Sprite sprite = new Sprite(grass_bottom, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                platforms.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "7";
            }
            else if (equipped == "Grass Left") {
                Sprite sprite = new Sprite(grass_left, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                platforms.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "8";
            }
            else if (equipped == "Grass Right") {
                Sprite sprite = new Sprite(grass_right, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                platforms.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "9";
            }
            else if (equipped == "Box") {
                Sprite sprite = new Sprite(box, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                platforms.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "1";
            }
            else if (equipped == "Water Bottom") {
                Sprite sprite = new Sprite(water_bottom, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                water.add(sprite);
                drowned.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "11";
            }
            else if (equipped == "Water Top") {
                Sprite sprite = new Sprite(water_top, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                water.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "12";
            }
            else if (equipped == "Spikes") {
                Sprite sprite = new Sprite(spike, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                spikes.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "0";
            }
            else if (equipped == "Door Bottom") {
                Sprite sprite = new Sprite(door_closed_bottom, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                doors.add(sprite);
                doors_bottom.add(sprite);
                Sprite sprite_2 = new Sprite(door_open_bottom, sprite_scale);
                sprite_2 = sprite;
                doors_open.add(sprite_2);
                table[getCell(collided, "row")][getCell(collided, "column")] = "2";
            }
            else if (equipped == "Door Top") {
                Sprite sprite = new Sprite(door_closed_top, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                doors.add(sprite);
                Sprite sprite_2 = new Sprite(door_open_top, sprite_scale);
                sprite_2 = sprite;
                doors_open.add(sprite_2);
                table[getCell(collided, "row")][getCell(collided, "column")] = "3";
            }
            else if (equipped == "Key") {
                Sprite sprite = new Sprite(door_key, sprite_scale);
                sprite.x_center = collided.x_center;
                sprite.y_center = collided.y_center;
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                keys.add(sprite);
                keys_double.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "4";
            }
            else if (equipped == "Bee") {
                float x = collided.x_center;
                float y = collided.y_center;
                Sprite sprite = new Sprite(bee, sprite_scale, x, y);
                sprite.x_center_default = collided.x_center_default;
                sprite.y_center_default = collided.y_center_default;
                enemies.add(sprite);
                table[getCell(collided, "row")][getCell(collided, "column")] = "13";
            }
        }
    }

    public void getDimensions() {
        String[] lines = loadStrings(filename);

        rows = lines.length;
        height = sprite_size * rows;

        for (int row = 0; row < rows; row++) {
            String[] values = split(lines[row], ",");
            columns = values.length;
            width = sprite_size * columns;
        }
    }

    public void createTiles() {
        String[] lines = loadStrings(filename);
        for (int row = 0; row < rows; row++) {
            String[] values = split(lines[row], ",");
            for (int column = 0; column < columns; column++) {
                if (values[column].equals("0")) {
                    Sprite sprite = new Sprite(spike, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    spikes.add(sprite);
                    table[row][column] = "0";
                }
                else if (values[column].equals("1")) {
                    Sprite sprite = new Sprite(box, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    platforms.add(sprite);
                    table[row][column] = "1";
                }
                else if (values[column].equals("2")) {
                    Sprite sprite = new Sprite(door_closed_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    doors.add(sprite);
                    doors_bottom.add(sprite);
                    Sprite sprite_2 = new Sprite(door_open_bottom, sprite_scale);
                    sprite_2.x_center = sprite_size / 2 + column * sprite_size;
                    sprite_2.y_center = sprite_size / 2 + row * sprite_size;
                    sprite_2.x_center_default = sprite_2.x_center;
                    sprite_2.y_center_default = sprite_2.y_center;
                    doors_open.add(sprite_2);
                    table[row][column] = "2";
                }
                else if (values[column].equals("3")) {
                    Sprite sprite = new Sprite(door_closed_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    doors.add(sprite);
                    Sprite sprite_2 = new Sprite(door_open_top, sprite_scale);
                    sprite_2.x_center = sprite_size / 2 + column * sprite_size;
                    sprite_2.y_center = sprite_size / 2 + row * sprite_size;
                    sprite_2.x_center_default = sprite_2.x_center;
                    sprite_2.y_center_default = sprite_2.y_center;
                    doors_open.add(sprite_2);
                    table[row][column] = "3";
                }
                else if (values[column].equals("4")) {
                    Sprite sprite = new Sprite(door_key, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    keys.add(sprite);
                    table[row][column] = "4";
                }
                else if (values[column].equals("7")) {
                    Sprite sprite = new Sprite(grass_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    platforms.add(sprite);
                    table[row][column] = "7";
                }
                else if (values[column].equals("8")) {
                    Sprite sprite = new Sprite(grass_left, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    platforms.add(sprite);
                    table[row][column] = "8";
                }
                else if (values[column].equals("9")) {
                    Sprite sprite = new Sprite(grass_right, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    platforms.add(sprite);
                    table[row][column] = "9";
                }
                else if (values[column].equals("10")) {
                    Sprite sprite = new Sprite(grass_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    platforms.add(sprite);
                    table[row][column] = "10";
                }
                else if (values[column].equals("11")) {
                    Sprite sprite = new Sprite(water_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    water.add(sprite);
                    drowned.add(sprite);
                    table[row][column] = "11";
                }
                else if (values[column].equals("12")) {
                    Sprite sprite = new Sprite(water_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    water.add(sprite);
                    table[row][column] = "12";
                }
                else if (values[column].equals("13")) {
                    float x = sprite_size / 2 + column * sprite_size;
                    float y = sprite_size / 2 + row * sprite_size;
                    Sprite sprite = new Sprite(bee, sprite_scale, x, y);
                    sprite.x_center_default = sprite.x_center;
                    sprite.y_center_default = sprite.y_center;
                    enemies.add(sprite);
                    table[row][column] = "13";
                }
                else table[row][column] = "-1";
                Sprite sprite = new Sprite(tile, sprite_scale);
                sprite.x_center = sprite_size / 2 + column * sprite_size;
                sprite.y_center = sprite_size / 2 + row * sprite_size;
                sprite.x_center_default = sprite.x_center;
                sprite.y_center_default = sprite.y_center;
                tiles.add(sprite);
            }
        }
    }

    public void saveMap() {
        String[] lines = new String[rows];
        for (int row = 0; row < rows; row++) lines[row] = "";
        for (int row = 0; row < rows; row++) {
            for (int column = 0; column < columns - 1; column++) {
                if (row == columns - 1) lines[row] += String.valueOf(table[row][column]);
                else lines[row] += String.valueOf(table[row][column]) + ",";
            }
        }
        saveStrings(filename, lines);
    }

    public int getCell(Sprite sprite, String what) {
        float sprite_left = sprite.x_center_default - sprite.width / 2;
        float sprite_right = sprite.x_center_default + sprite.width / 2;
        float sprite_top = sprite.y_center_default - sprite.height / 2;
        float sprite_bottom = sprite.y_center_default + sprite.height / 2;
        for (int row = 0; row < rows; row++) {
            for (int column = 0; column < columns; column++) {
                float cell_left = column * sprite_size;
                float cell_right = cell_left + sprite_size;
                float cell_top = row * sprite_size;
                float cell_bottom = cell_top + sprite_size;
                if (sprite_left == cell_left && sprite_right == cell_right && sprite_top == cell_top && sprite_bottom == cell_bottom) {
                    if (what == "row") return row;
                    if (what == "column") return column;
                }
            }
        }
        return 0;
    }

    public Boolean onHover() {
        float left = screen_width / 2 - (screen_width - 100) / 2;
        float right = screen_width / 2 + screen_width - 100 / 2;
        float top = screen_height - 125 - 150 / 2;
        float bottom = screen_height - 125 + 150 / 2;
        if (mouseX <= right && mouseX >= left && mouseY <= bottom && mouseY >= top) return true;
        else return false;
    }
}
