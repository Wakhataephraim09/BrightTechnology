package com.brighttech.desktop;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

public class BrightDesktopApp extends Application {
    @Override
    public void start(Stage stage) {
        Label label = new Label("Hello from BrightDesktop (JavaFX)!");
        Scene scene = new Scene(label, 400, 200);
        stage.setTitle("BrightDesktop");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        launch();
    }
}
