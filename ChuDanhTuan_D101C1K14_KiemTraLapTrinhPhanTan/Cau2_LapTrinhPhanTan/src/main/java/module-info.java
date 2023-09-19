module com.example.cau2_ltptexam {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.cau2_ltptexam to javafx.fxml;
    exports com.example.cau2_ltptexam;
}