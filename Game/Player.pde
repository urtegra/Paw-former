public class Player extends Sprite{

    boolean onPlatform, inPlace, hasLost, hasDrowned, hasJumped;
    PImage[] idle_right, idle_left;
    PImage[] jump_right, jump_left;
    PImage[] fall_right, fall_left;
    PImage[] dead_right, dead_left;
    int lives, keys, jumps;
    float acceleration;

    public Player(PImage image, float scale) {
        super(image, scale);
        index = 1;
        frame = 0;
        lives = 3;
        jumps = 0;
        keys = 0;
        direction = "Right";
        onPlatform = false;
        inPlace = true;
        hasLost = false;
        hasDrowned = false;
        hasJumped = false;
        acceleration = -1;

        // Loading assets for cat sprite
        if (character == "Cat") {
            idle_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                idle_right[i] = loadImage("/Data/Sprites/Cat/Idle/Idle (" + i + ").png");
                width = int(idle_right[i].width * scale);
                height = int(idle_right[i].height * scale);
                idle_right[i].resize(width, height);
        }
            jump_right = new PImage[9];
            for (int i = 1; i <= 8; i++) {
                jump_right[i] = loadImage("/Data/Sprites/Cat/Jump/Jump (" + i + ").png");
                jump_right[i].resize(width, height);
        }
            move_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                move_right[i] = loadImage("/Data/Sprites/Cat/Move/Walk (" + i + ").png");
                move_right[i].resize(width, height);
        }
            fall_right = new PImage[9];
            for (int i = 1; i <= 8; i++) {
                fall_right[i] = loadImage("/Data/Sprites/Cat/Fall/Fall (" + i + ").png");
                fall_right[i].resize(width, height);
        }
            dead_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                dead_right[i] = loadImage("/Data/Sprites/Cat/Dead/Dead (" + i + ").png");
                dead_right[i].resize(width, height);
        }
        }

        // Loading assets for dog sprite
        if (character == "Dog") {
            idle_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                idle_right[i] = loadImage("/Data/Sprites/Dog/Idle/Idle (" + i + ").png");
                width = int(idle_right[i].width * scale);
                height = int(idle_right[i].height * scale);
                idle_right[i].resize(width, height);
        }
            jump_right = new PImage[9];
            for (int i = 1; i <= 8; i++) {
                jump_right[i] = loadImage("/Data/Sprites/Dog/Jump/Jump (" + i + ").png");
                jump_right[i].resize(width, height);
        }
            move_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                move_right[i] = loadImage("/Data/Sprites/Dog/Move/Walk (" + i + ").png");
                move_right[i].resize(width, height);
        }
            fall_right = new PImage[9];
            for (int i = 1; i <= 8; i++) {
                fall_right[i] = loadImage("/Data/Sprites/Dog/Fall/Fall (" + i + ").png");
                fall_right[i].resize(width, height);
        }
            dead_right = new PImage[11];
            for (int i = 1; i <= 10; i++) {
                dead_right[i] = loadImage("/Data/Sprites/Dog/Dead/Dead (" + i + ").png");
                dead_right[i].resize(width, height);
        }
        }

        idle_left = new PImage[11];
        for (int i = 1; i <= 10; i++) {
            idle_left[i] = flipPixels(idle_right[i]);
            idle_left[i].resize(width, height);
        }
        jump_left = new PImage[9];
        for (int i = 1; i <= 8; i++) {
            jump_left[i] = flipPixels(jump_right[i]);
            jump_left[i].resize(width, height);
        }
        move_left = new PImage[11];
        for (int i = 1; i <= 10; i++) {
            move_left[i] = flipPixels(move_right[i]);
            move_left[i].resize(width, height);
        }
        fall_left = new PImage[9];
        for (int i = 1; i <= 8; i++) {
            fall_left[i] = flipPixels(fall_right[i]);
            fall_left[i].resize(width, height);
        }
        dead_left = new PImage[11];
        for (int i = 1; i <= 10; i++) {
            dead_left[i] = flipPixels(dead_right[i]);
            dead_left[i].resize(width, height);
        }
        width -= 60;
        height -= 10;
        current_images = idle_right;
        x_center = 0 + width / 2;
        y_center = margin_top + height / 2;
    }

    public void restart() {
        x_center = 0 + width / 2;
        y_center = margin_top + height / 2;
        lives = 3;
        keys = 0;
        direction = "Right";
        onPlatform = false;
        inPlace = true;
        hasLost = false;
        hasDrowned = false;
        hasJumped = false;
        current_images = idle_right;
        level.keys = new ArrayList <Sprite>(level.keys_double);
        level_1.keys = new ArrayList <Sprite>(level_1.keys_double);
        level_2.keys = new ArrayList <Sprite>(level_2.keys_double);
        level_3.keys = new ArrayList <Sprite>(level_3.keys_double);
        level_4.keys = new ArrayList <Sprite>(level_4.keys_double);
        level_5.keys = new ArrayList <Sprite>(level_5.keys_double);
        editor.keys = new ArrayList <Sprite>(editor.keys_double);
        view_x = 0;
        view_y = 0;
        all.playedSound = false;
    }

    public void updateAnimation() {
        onPlatform = level.isOnPlatform(this, level.platforms);
        inPlace = x_change == 0 && y_change == 0;
        frame++;
        if (frame % 5 == 0) {
            selectDirection();
            selectCurrentImages();
            advanceToNextImage();
        }
    }

    public void selectDirection() {
        if (x_change > 0) direction = "Right";
        else if (x_change < 0) direction = "Left";
    }

    public void selectCurrentImages() {
        if (direction == "Right") {
            if (onPlatform) current_images = move_right;
            if (hasLost) current_images = dead_right;
            else if (inPlace && onPlatform) {
                current_images = idle_right;
                hasJumped = false;
            }
            else if (!onPlatform && hasJumped) current_images = fall_right;
            else if (!onPlatform && !hasJumped) current_images = jump_right;
            else if (onPlatform && keyPressed && (keyCode == UP || key == 'W' || key == 'w' || keyCode == 32))current_images = jump_right;
            else {
                current_images = move_right;
                hasJumped = false;
            }
        }
        else if (direction == "Left") {
            if (onPlatform) current_images = move_left;
            if (hasLost) current_images = dead_left;
            else if (inPlace && onPlatform) {
                current_images = idle_left; hasJumped = false;
            }
            else if (!onPlatform && hasJumped) current_images = fall_left;
            else if (!onPlatform && !hasJumped) current_images = jump_left;
            else if (onPlatform && keyPressed && (keyCode == UP || key == 'W' || key == 'w' || keyCode == 32)) current_images = jump_left;
            else {
                current_images = move_left;
                hasJumped = false;
            }
        }
    }

    public void advanceToNextImage() {
        index++;
        if (index >= current_images.length && (current_images == dead_right || current_images == dead_left)) {
            index = current_images.length - 1;
        }
        if (index >= current_images.length) {
            index = 1;
        }
        if (index >= current_images.length - 1 && (current_images == jump_right || current_images == jump_left)) {
            hasJumped = true;
        }
        image = current_images[index];
    }
}
