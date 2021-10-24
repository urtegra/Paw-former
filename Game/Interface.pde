public class Interface{

    PImage background, paws;
    PImage heart, heart_grey;
    int radius, loading, delay;
    float marquee;
    color accent, accent_darker, shade, shade_darker, dark, light;
    Button button_levels, button_settings, button_close;
    Button button_cat, button_dog, button_confirm, button_volume;
    Button button_level_1, button_level_2, button_level_3, button_level_4, button_level_5, button_custom, button_play;
    Button button_progress, button_continue, button_main, button_lower;
    Button last_hovered, clear;
    Boolean playedSound;

    public Interface() {
        accent = color(#c69c6d);
        accent_darker = color(#a67c52);
        shade = color(#da3832);
        shade_darker = color(#940616);
        dark = color(#000000);
        light = color(#ffffff);
        radius = 30;
        marquee = screen_width;
        loading = 0;
        delay = 0;
        playedSound = false;

        // Loading data

        background = loadImage("/Data/Interface/background.png");
        paws = loadImage("/Data/Interface/paws.png");
        heart = loadImage("/Data/Interface/heart.png");
        heart_grey = loadImage("/Data/Interface/heart.png");
        heart_grey.filter(GRAY);

        button_levels = new Button(screen_width / 2, screen_height / 2 - 130 + 50, 350, 100);
        button_settings = new Button(screen_width / 2, screen_height / 2 + 50, 350, 100);
        button_close = new Button(screen_width / 2, screen_height / 2 + 130 + 50, 350, 100);
        button_cat = new Button(screen_width / 2 - 200, screen_height / 2 + 75, 200, 50);
        button_dog = new Button(screen_width / 2 + 50, screen_height / 2 + 75, 200, 50);
        button_confirm = new Button(screen_width / 2, screen_height / 2 + 175, 300, 100);
        button_volume = new Button(screen_width / 2 + 230, 173, 50, 300);
        button_level_1 = new Button(screen_width / 2 - 150, screen_height / 2 - 50 - 100, 200, 50);
        button_level_2 = new Button(screen_width / 2 + 150, screen_height / 2 - 50 - 100, 200, 50);
        button_level_3 = new Button(screen_width / 2 - 150, screen_height / 2 - 50, 200, 50);
        button_level_4 = new Button(screen_width / 2 + 150, screen_height / 2 - 50, 200, 50);
        button_level_5 = new Button(screen_width / 2 - 150, screen_height / 2 - 50 + 100, 200, 50);
        button_custom = new Button(screen_width / 2 + 150, screen_height / 2 - 50 + 100, 200, 50);
        button_play = new Button(screen_width / 2, screen_height / 2 + 175, 300, 100);
        button_progress = new Button(screen_width / 2 - 200, screen_height / 2, 400, 50);
        button_continue = new Button(screen_width / 2, screen_height / 2, 250, 70);
        button_main = new Button(screen_width / 2, screen_height / 2 + 90, 250, 70);
        button_lower = new Button(screen_width / 2, screen_height / 2 + 90 + 90, 250, 70);

        last_hovered = new Button(0, 0, 0, 0);
        clear = new Button(0, 0, 0, 0);
    }

    public void showMain() {
        noTint();
        image(background, screen_width / 2, screen_height / 2);
        tint(accent_darker);
        image(paws, screen_width / 2, screen_height / 2);
        noTint();
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_150);
        textSize(150);
        textAlign(CENTER);
        fill(shade_darker);
        text("Paw-former", screen_width / 2 + 2, 200 + 2); // Fake Shadow
        fill(shade);
        text("Paw-former", screen_width / 2, 200);

        // Play Button (Level Selection)
        if (button_levels.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_levels) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Levels";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_levels;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_levels.x_center, button_levels.y_center, button_levels.width, button_levels.height, radius);
        fill(light);
        textFont(cabin_80);
        textSize(80);
        text("Play", button_levels.x_center, button_levels.y_center + button_levels.height / 5);

        // Settings Button
        if (button_settings.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_settings) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Settings";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_settings;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_settings.x_center, button_settings.y_center, button_settings.width, button_settings.height, radius);
        fill(light);
        textFont(cabin_80);
        textSize(80);
        text("Settings", button_settings.x_center, button_settings.y_center + button_settings.height / 5);

        // Close button
        if (button_close.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_close) hover.play();
            if (mouseClicked && mousePressed) exit();
            last_hovered = button_close;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_close.x_center, button_close.y_center, button_close.width, button_close.height, radius);
        fill(light);
        textFont(cabin_80);
        textSize(80);
        text("Close", button_close.x_center, button_close.y_center + button_close.height / 5);

        if (!button_levels.onHover() && !button_settings.onHover() && !button_close.onHover()) last_hovered = clear;

        // Info
        fill(shade);
        rectMode(CORNER);
        noStroke();
        rect(0, screen_height - 50, screen_width, 50);
        fill(light);
        textSize(25);
        textFont(cabin_25);
        textAlign(LEFT);
        marquee--;
        String message = "Welcome to Paw-former! The goal of the game is to collect all keys and go through the door.... By the way, the creator sincerely apoligizes for going all out on the design.";
        if (marquee <= -textWidth(message)) marquee = screen_width;
        text(message, marquee, screen_height - 15);
        textAlign(RIGHT);
        text("Version: 1.0", screen_width - 25, screen_height - 50 - 25);
    }

    public void showLevels() {
        image(background, screen_width / 2, screen_height / 2);
        noStroke();
        fill(light, 100);
        rectMode(CENTER);
        rect(screen_width / 2, screen_height / 2, screen_width / 1.5, screen_height / 1.5, radius);
        stroke(accent_darker);
        strokeWeight(3);
        textSize(40);
        textFont(cabin_40);
        textAlign(CENTER);

        // Level 1
        if (button_level_1.onHover()) {
            if (current_level != 1) fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_level_1) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 1;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_level_1;
        }
        else {
            if (current_level == 1) fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_level_1.x_center, button_level_1.y_center, button_level_1.width, button_level_1.height, radius);
        fill(light);
        text("Level 1", button_level_1.x_center, button_level_1.y_center + button_level_1.height / 5);

        // Level 2
        if (button_level_2.onHover()) {
            if (current_level != 2) fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_level_2) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 2;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_level_2;
        }
        else {
            if (current_level == 2) fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_level_2.x_center, button_level_2.y_center, button_level_2.width, button_level_2.height, radius);
        fill(light);
        text("Level 2", button_level_2.x_center, button_level_2.y_center + button_level_2.height / 5);

        // Level 3
        if (button_level_3.onHover()) {
            if (current_level != 3) fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_level_3) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 3;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_level_3;
        }
        else {
            if (current_level == 3) fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_level_3.x_center, button_level_3.y_center, button_level_3.width, button_level_3.height, radius);
        fill(light);
        text("Level 3", button_level_3.x_center, button_level_3.y_center + button_level_3.height / 5);

        // Level 4
        if (button_level_4.onHover()) {
            if (current_level != 4) fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_level_4) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 4;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_level_4;
        }
        else {
            if (current_level == 4) fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_level_4.x_center, button_level_4.y_center, button_level_4.width, button_level_4.height, radius);
        fill(light);
        text("Level 4", button_level_4.x_center, button_level_4.y_center + button_level_4.height / 5);

        // Level 5
        if (button_level_5.onHover()) {
            if (current_level != 5) fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_level_5) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 5;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_level_5;
        }
        else {
            if (current_level == 5) fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_level_5.x_center, button_level_5.y_center, button_level_5.width, button_level_5.height, radius);
        fill(light);
        text("Level 5", button_level_5.x_center, button_level_5.y_center + button_level_5.height / 5);

        // Custom Level
        stroke(shade_darker);
        if (button_custom.onHover()) {
            if (current_level != 0) fill(shade_darker);
            else fill(shade, 100);
            cursor = cursor_hover;
            if (last_hovered != button_custom) hover.play();
            if (mouseClicked && mousePressed) {
                current_level = 0;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_custom;
        }
        else {
            if (current_level == 0) fill(shade, 100);
            else fill(shade);
        }
        rectMode(CENTER);
        rect(button_level_4.x_center, button_custom.y_center, button_custom.width, button_custom.height, radius);
        fill(light);
        text("Custom", button_custom.x_center, button_custom.y_center + button_custom.height / 5);

        // Play button
        stroke(accent_darker);
        if (button_play.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_play) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Play";
                mouseClicked = false;
                select.play();
                if (current_level == 0) {
                    action  = "Editor";
                    editor.equipped = "Drag";
                    loadingFinished = false;
                }
            }
            last_hovered = button_play;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_play.x_center, button_play.y_center, button_play.width, button_play.height, radius);
        fill(light);
        textSize(80);
        textFont(cabin_80);
        text("Confirm", button_play.x_center, button_play.y_center + button_play.height / 5);

        if (!button_level_1.onHover() && !button_level_2.onHover() && !button_level_3.onHover() && !button_level_4.onHover() && !button_level_5.onHover() && !button_custom.onHover() && !button_play.onHover()) last_hovered = clear;

    }

    public void showSettings() {
        image(background, screen_width / 2, screen_height / 2);
        noStroke();
        fill(light, 100);
        rectMode(CENTER);
        rect(screen_width / 2, screen_height / 2, screen_width / 1.5, screen_height / 1.5, radius);
        stroke(accent_darker);
        strokeWeight(3);
        textSize(40);
        textFont(cabin_40);
        textAlign(CENTER);

        // Select Cat Button
        if (button_cat.onHover()) {
            if (character != "Cat") fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_cat) hover.play();
            if (mouseClicked && mousePressed) {
                character = "Cat";
                player = default_cat;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_cat;
        }
        else {
            if (character == "Cat") fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_cat.x_center, button_cat.y_center, button_cat.width, button_cat.height, radius);
        fill(light);
        if (character == "Cat") text("Selected", button_cat.x_center, button_cat.y_center + button_cat.height / 5);
        else text("Select", button_cat.x_center, button_cat.y_center + button_cat.height / 5);

        // Select Dog Button
        if (button_dog.onHover()) {
            if (character != "Dog") fill(accent_darker);
            else fill(accent, 100);
            cursor = cursor_hover;
            if (last_hovered != button_dog) hover.play();
            if (mouseClicked && mousePressed) {
                character = "Dog";
                player = default_dog;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_dog;
        }
        else {
            if (character == "Dog") fill(accent, 100);
            else fill(accent);
        }
        rectMode(CENTER);
        rect(button_dog.x_center, button_dog.y_center, button_dog.width, button_dog.height, radius);
        fill(light);
        if (character == "Dog") text("Selected", button_dog.x_center, button_dog.y_center + button_dog.height / 5);
        else text("Select", button_dog.x_center, button_dog.y_center + button_dog.height / 5);

        // Main Menu Button
        if (button_confirm.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_confirm) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Main";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_confirm;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_confirm.x_center, button_confirm.y_center, button_confirm.width, button_confirm.height, radius);
        fill(light);
        textSize(80);
        textFont(cabin_80);
        text("Confirm", button_confirm.x_center, button_confirm.y_center + button_confirm.height / 5);

        // Volume
        fill(dark);
        textSize(30);
        textFont(cabin_30);
        text("Scroll to adjust the volume", screen_width / 2, 175);
        rectMode(CORNER);
        fill(light, 100);
        rect(button_volume.x_center, button_volume.y_center, button_volume.width, button_volume.height);
        if (mouse_scroll == 0) {
            fill(accent, 0);
            noStroke();
        }
        else{
            fill(shade);
            stroke(shade_darker);
        }
        rect(button_volume.x_center, button_volume.y_center - mouse_scroll + 300, button_volume.width, button_volume.height - 300 + mouse_scroll);

        if (!button_cat.onHover() && !button_dog.onHover() && !button_confirm.onHover()) last_hovered = clear;

    }

    public void showInGame() {
        popMatrix(); // Disabling translate() changes

        // Controls
        fill(light, 100);
        stroke(light);
        noStroke();
        rectMode(CORNERS);
        rect(screen_width - 350, 25, screen_width - 25, 205, radius);
        fill(dark);
        textSize(30);
        textFont(cabin_30);
        textAlign(RIGHT);
        textLeading(35);
        text("TAB\nD / RIGHT\nA/ LEFT\nW / UP / SPACE", screen_width - 125, 70);
        textSize(20);
        textFont(cabin_20);
        textAlign(LEFT);
        textLeading(35);
        text("Pause\nGo Right\nGo Left\nJump", screen_width - 115, 68);

        // Level Indicator
        fill(accent);
        stroke(accent_darker);
        strokeWeight(3);
        rectMode(CORNER);
        rect(25, 25, 100, 100, radius);
        fill(light);
        textAlign(CENTER);
        textSize(80);
        textFont(cabin_80);
        rectMode(CORNER);
        if (current_level == 0) text("C", 75, 100);
        else text(current_level, 75, 100);

        // Key Count
        fill(accent, 150);
        stroke(light);
        noStroke();
        rectMode(CORNER);
        rect(140, 25, 200, 100, radius);
        fill(dark);
        textSize(30);
        textFont(cabin_30);
        textAlign(LEFT);
        text(player.keys + " / " + level.total_keys, 215, 85);  // I wish more programming languages had interpolated strings
        image(door_key, 180, 75);

        // Remaining lives
        if (player.lives == 3) {
            image(heart, 50, 155, 50, 50);
            image(heart, 110, 155, 50, 50);
            image(heart, 170, 155, 50, 50);
        }
        else if (player.lives == 2) {
            image(heart, 50, 155, 50, 50);
            image(heart, 110, 155, 50, 50);
            image(heart_grey, 170, 155, 50, 50);
        }
        else if (player.lives == 1) {
            image(heart, 50, 155, 50, 50);
            image(heart_grey, 110, 155, 50, 50);
            image(heart_grey, 170, 155, 50, 50);
        }
        else {
            image(heart_grey, 50, 155, 50, 50);
            image(heart_grey, 110, 155, 50, 50);
            image(heart_grey, 170, 155, 50, 50);
        }
    }

    public void showPause() {
        fill(light, 100);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, screen_width, screen_height);
        stroke(accent_darker);
        strokeWeight(3);
        textSize(120);
        textFont(cabin_120);
        textAlign(CENTER);
        fill(shade_darker);
        text("Paused", screen_width / 2 + 2, screen_height / 2 - 75); // fake shadow
        fill(shade);
        text("Paused", screen_width / 2, screen_height / 2 - 75);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_40);
        textSize(40);
        textAlign(CENTER);

        // Continue Button
        if (button_continue.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_continue) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Play";
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_continue;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_continue.x_center, button_continue.y_center, button_continue.width, button_continue.height, radius);
        fill(light);
        text("Continue", button_continue.x_center, button_continue.y_center + button_continue.height / 5);

        // Main Menu Button
        if (button_main.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_main) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Main";
                current_level = 1;
                loadingFinished = false;
                player.restart();
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_main;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_main.x_center, button_main.y_center, button_main.width, button_main.height, radius);
        fill(light);
        text("Main Menu", button_main.x_center, button_main.y_center + button_main.height / 5);

        if (!button_continue.onHover() && !button_main.onHover()) last_hovered = clear;

    }

    public void showLoading() {
        background(accent);
        fill(light, 100);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, screen_width, screen_height);
        tint(accent_darker);
        image(paws, screen_width / 2, screen_height / 2);
        noTint();
        int percentage = int(loading / button_progress.width * 100);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_120);
        textSize(120);
        textAlign(CENTER);
        fill(light);
        text("Loading...", screen_width / 2, screen_height / 2 - 25);
        textFont(cabin_30);
        textSize(30);
        text(percentage + "%", screen_width / 2, screen_height / 2 + 100);

        // Progress Bar
        fill(accent);
        rectMode(CORNER);
        fill(light, 100);
        rect(button_progress.x_center, button_progress.y_center, button_progress.width, button_progress.height);
        if (loading == 0) {
            fill(accent, 0);
            noStroke();
        }
        else{
            fill(shade, 200);
            stroke(shade_darker);
        }
        rect(button_progress.x_center, button_progress.y_center, loading, button_progress.height);
        loading += 4;
        if (loading >= button_progress.width) {
            delay++;
            loading = int(button_progress.width);
            if (delay == 30) {
                loadingFinished = true;
                delay = 0;
                loading = 0;
            }
        }
    }

    public void showWon() {
        if (playedSound == false) {
            win.play();
            playedSound = true;
        }
        fill(light, 100);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, screen_width, screen_height);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_120);
        textSize(120);
        textAlign(CENTER);
        fill(shade_darker);
        text("You Won!", screen_width / 2 + 2, screen_height / 2 - 75); // Fake Shadow
        fill(shade);
        text("You Won!", screen_width / 2, screen_height / 2 - 75);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_40);
        textSize(40);
        textAlign(CENTER);

        // Continue Button
        if (button_continue.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_continue) hover.play();
            if (mouseClicked && mousePressed) {
                if (current_level == 0 || current_level == 5) {
                    editor.keys = new ArrayList <Sprite>(editor.keys_double);
                    action = "Editor";
                }
                else if (current_level < 5) {
                    player.restart();
                    current_level++;
                    action = "Play";
                }
                loadingFinished = false;
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_continue;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_continue.x_center, button_continue.y_center, button_continue.width, button_continue.height, radius);
        fill(light);
        if (current_level == 0) text("Edit Map", button_continue.x_center, button_continue.y_center + button_continue.height / 5);
        else if (current_level < 5) text("Next Level", button_continue.x_center, button_continue.y_center + button_continue.height / 5);
        else text("New Level", button_continue.x_center, button_continue.y_center + button_continue.height / 5);

        // Main Menu Button
        if (button_main.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_main) hover.play();
            if (mouseClicked && mousePressed) {
                action = "Main";
                current_level = 1;
                loadingFinished = false;
                player.restart();
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_main;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_main.x_center, button_main.y_center, button_main.width, button_main.height, radius);
        fill(light);
        text("Main Menu", button_main.x_center, button_main.y_center + button_main.height / 5);

        if (!button_continue.onHover() && !button_main.onHover()) last_hovered = clear;
    }

    public void showLost() {
        if (playedSound == false) {
            lose.play();
            playedSound = true;
        }
        fill(light, 100);
        noStroke();
        rectMode(CORNER);
        rect(0, 0, screen_width, screen_height);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_120);
        textSize(120);
        textAlign(CENTER);
        fill(shade_darker);
        text("You Died", screen_width / 2 + 2, screen_height / 2 - 75); // fake shadow
        fill(shade);
        text("You Died", screen_width / 2, screen_height / 2 - 75);
        stroke(accent_darker);
        strokeWeight(3);
        textFont(cabin_40);
        textSize(40);
        textAlign(CENTER);

        // Continue Button
        if (button_continue.onHover()) {
            fill(accent_darker);
            cursor = cursor_hover;
            if (last_hovered != button_continue) hover.play();
            if (mouseClicked && mousePressed) {
                editor.keys = new ArrayList <Sprite>(editor.keys_double);
                action = "Play";
                loadingFinished = false;
                player.restart();
                mouseClicked = false;
                select.play();
            }
            last_hovered = button_continue;
        }
        else fill(accent);
        rectMode(CENTER);
        rect(button_continue.x_center, button_continue.y_center, button_continue.width, button_continue.height, radius);
        fill(light);
        text("Retry", button_continue.x_center, button_continue.y_center + button_continue.height / 5);

        // Main Menu Button
        if (current_level != 0) {
            if (button_main.onHover()) {
                fill(accent_darker);
                cursor = cursor_hover;
                if (last_hovered != button_main) hover.play();
                if (mouseClicked && mousePressed) {
                    editor.keys = new ArrayList <Sprite>(editor.keys_double);
                    action = "Main";
                    current_level = 1;
                    loadingFinished = false;
                    player.restart();
                    mouseClicked = false;
                    select.play();
                }
                last_hovered = button_main;
            }
            else fill(accent);
            rectMode(CENTER);
            rect(button_main.x_center, button_main.y_center, button_main.width, button_main.height, radius);
            fill(light);
            text("Main Menu", button_main.x_center, button_main.y_center + button_main.height / 5);
            if (!button_continue.onHover() && !button_main.onHover()) last_hovered = clear;
        }
        else{
            if (button_main.onHover()) {
                fill(accent_darker);
                cursor = cursor_hover;
                if (last_hovered != button_main) hover.play();
                if (mouseClicked && mousePressed) {
                    editor.keys = new ArrayList <Sprite>(editor.keys_double);
                    action = "Editor";
                    loadingFinished = false;
                    player.restart();
                    mouseClicked = false;
                    select.play();
                }
                last_hovered = button_main;
            }
            else fill(accent);
            rectMode(CENTER);
            rect(button_main.x_center, button_main.y_center, button_main.width, button_main.height, radius);
            fill(light);
            text("Edit Map", button_main.x_center, button_main.y_center + button_main.height / 5);
            if (button_lower.onHover()) {
                fill(accent_darker);
                cursor = cursor_hover;
                if (last_hovered != button_lower) hover.play();
                if (mouseClicked && mousePressed) {
                    action = "Main";
                    current_level = 1;
                    loadingFinished = false;
                    player.restart();
                    mouseClicked = false;
                    select.play();
                }
                last_hovered = button_lower;
            }
            else fill(accent);
            rectMode(CENTER);
            rect(button_lower.x_center, button_lower.y_center, button_lower.width, button_lower.height, radius);
            fill(light);
            text("Main Menu", button_lower.x_center, button_lower.y_center + button_lower.height / 5);
            if (!button_continue.onHover() && !button_main.onHover() && !button_lower.onHover()) last_hovered = clear;
        }
    }
}
