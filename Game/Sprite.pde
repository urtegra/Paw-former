public class Sprite{

    PImage image;
    float x_center, y_center, x_change, y_change;
    float x_center_default, y_center_default;
    int width, height;
    float scale;
    PImage[] move_right, move_left;
    PImage[] current_images;
    String direction;
    int index;
    int frame;
    float boundary_left, boundary_right;

    public Sprite(String filename, float scale, float x, float y) {
        image = loadImage(filename);
        width = int(image.width * scale);
        height = int(image.height * scale);
        x_center = x;
        y_center = y;
        x_change = 0;
        y_change = 0;
    }

    public Sprite(String filename, float scale) {
        this(filename, scale, 0, 0);
    }

    public Sprite(PImage image_main, float scale) {
        image = image_main;
        width = int(image.width * scale);
        height = int(image.height * scale);
        image.resize(width, height);
        x_center = 0;
        y_center = 0;
        x_change = 0;
        y_change = 0;
    }

    public Sprite(PImage image_main, float scale, float x, float y) {
        image = image_main;
        width = int(image.width * scale);
        height = int(image.height * scale);
        image.resize(width, height);
        x_center = x;
        y_center = y;
        index = 1;
        direction = "Right";

        // Loading Assets
        move_right = new PImage[6];
        move_right[1] = bee;
        move_right[2] = bee_2;
        move_right[3] = bee_3;
        move_right[4] = bee_4;
        move_right[5] = bee_5;
        move_left = new PImage[6];
        for (int i = 1; i <= 5; i++) {
            move_left[i] = flipPixels(move_right[i]);
        }
        boundary_left = x_center - 4 * sprite_size;
        boundary_right = x_center + 4 * sprite_size;
        x_change = 1;
        y_change = 0;
    }

    public void display() {
        image(image, x_center, y_center);
    }

    public void displayOpacity() {
        tint(255, 150);
        image(image, x_center, y_center);
        noTint();
    }

    public float getLeft() {
        return x_center - width / 2;
    }

    public float getRight() {
        return x_center + width / 2;
    }

    public float getTop() {
        if (image == spike) return y_center - height / 2 + sprite_size / 2;
        else return y_center - height / 2;
    }

    public float getBottom() {
        return y_center + height / 2;
    }

    public void setLeft(float left) {
        x_center = left + width / 2;
    }

    public void setRight(float right) {
        x_center = right - width / 2;
    }

    public void setTop(float top) {
        y_center = top + height / 2;
    }

    public void setBottom(float bottom) {
        y_center = bottom - height / 2;
    }

    public void update() {
        x_center += x_change;
        if (getLeft() <= boundary_left) {
            setLeft(boundary_left);
            x_change *= -1;
        }
        else if (getRight() >= boundary_right) {
            setRight(boundary_right);
            x_change *= -1;
        }
    }

    public void updateAnimation() {
        frame++;
        if (frame % 5 == 0) {
            selectDirection();
            selectCurrentImages();
            advanceToNextImage();
        }
    }

    public void selectCurrentImages() {
        if (direction == "Right") current_images = move_right;
        else current_images = move_left;
    }

    public void selectDirection() {
        if (x_change > 0) direction = "Right";
        else if (x_change < 0) direction = "Left";
    }

    public void advanceToNextImage() {
        index++;
        if (index >= current_images.length) {
            index = 1;
        }
        image = current_images[index];
    }

    public PImage flipPixels(PImage image) {
        PImage flipped = createImage(image.width, image.height, ARGB);
        for (int i = 0; i < flipped.pixels.length; i++) {
            int srcX = i % flipped.width;
            int dstX = flipped.width - srcX - 1;
            int y = i / flipped.width;
            flipped.pixels[y * flipped.width + dstX] = image.pixels[i];
        }
        flipped.updatePixels();
        return flipped;
    }
}
