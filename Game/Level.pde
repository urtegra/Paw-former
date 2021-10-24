public class Level{

    ArrayList <Sprite> platforms, keys, keys_double, doors, doors_open;
    ArrayList <Sprite> spikes, water, drowned, doors_bottom, enemies;
    int total_keys, rows, columns;
    float width, height;
    String filename;
    PVector copy = new PVector();

    public Level(String path) {
        filename = path;
        getDimensions();
        keys = new ArrayList <Sprite>();
        platforms = new ArrayList <Sprite>();
        doors = new ArrayList <Sprite>();
        doors_open = new ArrayList <Sprite>();
        doors_bottom = new ArrayList <Sprite>();
        spikes = new ArrayList <Sprite>();
        water = new ArrayList <Sprite>();
        drowned = new ArrayList <Sprite>();
        enemies = new ArrayList <Sprite>();
        createPlatforms();
        keys_double = new ArrayList <Sprite>(keys);
    }

    public Level clone() {
        Level level = new Level(filename);
        level.enemies = enemies;
        level.platforms = platforms;
        level.keys = keys;
        level.keys_double = keys_double;
        level.doors = doors;
        level.doors_open = doors_open;
        level.doors_bottom = doors_bottom;
        level.spikes = spikes;
        level.water = water;
        level.drowned = drowned;
        level.copy = new PVector(copy.x, copy.y, copy.z);
        return level;
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

    public void createPlatforms() {
        String[] lines = loadStrings(filename);
        for (int row = 0; row < lines.length; row++) {
            String[] values = split(lines[row], ",");
            for (int column = 0; column < values.length; column++) {
                if (values[column].equals("0")) {
                    Sprite sprite = new Sprite(spike, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    spikes.add(sprite);
                }
                else if (values[column].equals("1")) {
                    Sprite sprite = new Sprite(box, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    platforms.add(sprite);
                }
                else if (values[column].equals("2")) {
                    Sprite sprite = new Sprite(door_closed_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    doors.add(sprite);
                    doors_bottom.add(sprite);
                    Sprite sprite_2 = new Sprite(door_open_bottom, sprite_scale);
                    sprite_2.x_center = sprite_size / 2 + column * sprite_size;
                    sprite_2.y_center = sprite_size / 2 + row * sprite_size;
                    doors_open.add(sprite_2);
                }
                else if (values[column].equals("3")) {
                    Sprite sprite = new Sprite(door_closed_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    doors.add(sprite);
                    Sprite sprite_2 = new Sprite(door_open_top, sprite_scale);
                    sprite_2.x_center = sprite_size / 2 + column * sprite_size;
                    sprite_2.y_center = sprite_size / 2 + row * sprite_size;
                    doors_open.add(sprite_2);
                }
                else if (values[column].equals("4")) {
                    Sprite sprite = new Sprite(door_key, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    keys.add(sprite);
                }
                else if (values[column].equals("7")) {
                    Sprite sprite = new Sprite(grass_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    platforms.add(sprite);
                }
                else if (values[column].equals("8")) {
                    Sprite sprite = new Sprite(grass_left, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    platforms.add(sprite);
                }
                else if (values[column].equals("9")) {
                    Sprite sprite = new Sprite(grass_right, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    platforms.add(sprite);
                }
                else if (values[column].equals("10")) {
                    Sprite sprite = new Sprite(grass_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    platforms.add(sprite);
                }
                else if (values[column].equals("11")) {
                    Sprite sprite = new Sprite(water_bottom, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    water.add(sprite);
                    drowned.add(sprite);
                }
                else if (values[column].equals("12")) {
                    Sprite sprite = new Sprite(water_top, sprite_scale);
                    sprite.x_center = sprite_size / 2 + column * sprite_size;
                    sprite.y_center = sprite_size / 2 + row * sprite_size;
                    water.add(sprite);
                }
                else if (values[column].equals("13")) {
                    float x = sprite_size / 2 + column * sprite_size;
                    float y = sprite_size / 2 + row * sprite_size;
                    Sprite sprite = new Sprite(bee, sprite_scale, x, y);
                    enemies.add(sprite);
                }
            }
        }
    }

    public boolean checkCollision(Sprite sprite_one, Sprite sprite_two) {
        boolean xOverlap = sprite_one.getRight() <= sprite_two.getLeft() || sprite_one.getLeft() >= sprite_two.getRight();
        boolean yOverlap = sprite_one.getBottom() <= sprite_two.getTop() || sprite_one.getTop() >= sprite_two.getBottom();
        if (xOverlap || yOverlap) return false;
        else return true;
    }

    public ArrayList <Sprite> checkCollisionList(Sprite sprite, ArrayList <Sprite> list) {
        ArrayList <Sprite> collision_list = new ArrayList <Sprite>();
        for (Sprite player : list) if (checkCollision(sprite, player)) collision_list.add(player);
        return collision_list;
    }

    public void resolvePlatformCollisions(Sprite sprite, ArrayList <Sprite> walls) {
        // Enabling sprite freeze
        if (action != "Pause" && action != "Lost" && action != "Won") {
            acceleration = 0.5;
            speed_jump += acceleration;
            player.y_change = speed_jump;
            player.y_center += player.y_change;
        }
        ArrayList <Sprite> collision_list = checkCollisionList(sprite, walls);
        if (collision_list.size() > 0) {
            Sprite collided = collision_list.get(0);
            if (sprite.y_change > 0) {
                sprite.setBottom(collided.getTop());
                speed_jump = 0;
                acceleration = 0;
            }
            else if (sprite.y_change < 0) {
                sprite.setTop(collided.getBottom());
                speed_jump = -speed_jump / 2;
            }
            if (level.isOnPlatform(player, level.platforms)) {
                player.jumps = 0;
            }
            sprite.y_change = 0;
        }
        if (action != "Won"  && action != "Lost") sprite.x_center = sprite.x_center + sprite.x_change;
        collision_list = checkCollisionList(sprite, walls);
        if (collision_list.size() > 0) {
            Sprite collided = collision_list.get(0);
            if (sprite.x_change > 0) sprite.setRight(collided.getLeft());
            else if (sprite.x_change < 0) sprite.setLeft(collided.getRight());
            sprite.x_change = 0;
        }
    }

    public void collectKeys(Sprite sprite, ArrayList <Sprite> keys) {
        ArrayList <Sprite> collision_list = checkCollisionList(sprite, keys);
        if (collision_list.size() > 0) {
            Sprite collided = collision_list.get(0);
            keys.remove(collided);
            player.keys++;
            pickup.play();
        }
    }

    public void checkDrowned(Sprite sprite, ArrayList <Sprite> water) {
        ArrayList <Sprite> collision_list = checkCollisionList(sprite, water);
        if (collision_list.size() > 0) {
            player.hasDrowned = true;
            Sprite collided = collision_list.get(0);
            player.setBottom(collided.getBottom());
        }
    }


    public void loseLives(Sprite sprite, ArrayList <Sprite> spikes) {
        ArrayList <Sprite> collision_list = checkCollisionList(sprite, spikes);
        if (collision_list.size() > 0 && player.lives > 0) {
            player.lives--;
            player.direction = "Right";
            player.current_images = player.idle_right;
            if (player.lives > 0) {
                life.play();
                player.x_center = 0 + player.width / 2;
                player.y_center = margin_top + player.height / 2;
            }
        }
        if (player.lives == 0) {
            player.hasLost = true;
            action = "Lost";
        }
    }

    public void openDoor(Sprite sprite, ArrayList <Sprite> doors) {
        ArrayList <Sprite> collision_list = checkCollisionList(sprite, doors);
        if (collision_list.size() > 0) {
            action = "Won";
        }
    }

    public boolean isOnPlatform(Sprite sprite, ArrayList <Sprite> walls) {
        sprite.y_center = sprite.y_center + speed_move;
        ArrayList <Sprite> collision_list = level.checkCollisionList(sprite, walls);
        sprite.y_center = sprite.y_center - speed_move;
        if (collision_list.size() > 0) return true;
        else return false;
    }

    public void scroll(Boolean render) {
        if (render == true && player.getBottom() < screen_height) {
            float boundary_right = view_x + screen_width - margin_right;
            if (player.getRight() > boundary_right) view_x += player.getRight() - boundary_right;
            float boundary_left = view_x + margin_left;
            if (player.getLeft() < boundary_left) view_x -= boundary_left - player.getLeft();
            float boundary_top = view_y + margin_top;
            if (player.getTop() < boundary_top) view_y -= boundary_top + player.getTop() - player.height;
            else view_y = 0;
        }
        pushMatrix(); // Lets you revert translate() and have objects stay static
        translate( - view_x, view_y);
    }
}
