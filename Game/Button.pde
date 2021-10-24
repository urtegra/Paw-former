public class Button{

    float x_center, y_center;
    float width, height;
    float top, bottom, left, right;

    public Button(float x, float y, float w, float h) {
        x_center = x;
        y_center = y;
        width = w;
        height = h;
    }

    public Boolean onHover() {
        if (mouseX <= getRight() && mouseX >= getLeft() && mouseY <= getBottom() && mouseY >= getTop()) {
            cursor = cursor_hover;
            return true;
        }
        else return false;
    }

    public float getLeft() {
        return x_center - width / 2;
    }

    public float getRight() {
        return x_center + width / 2;
    }

    public float getTop() {
        return y_center - height / 2;
    }

    public float getBottom() {
        return y_center + height / 2;
    }
}
