import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) {
        int portNumber = 8888;

        try {
            ServerSocket serverSocket = new ServerSocket(portNumber);
            System.out.println("Server đang lắng nghe kết nối...");

            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client đã kết nối!");

                InputStream inFromClient = clientSocket.getInputStream();
                DataInputStream in = new DataInputStream(inFromClient);

                String inputData = in.readUTF();
                if (isNumber(inputData)) {
                    double inputF = Double.parseDouble(inputData);

                    double outputC = convertFahrenheitToCelsius(inputF);

                    OutputStream outToClient = clientSocket.getOutputStream();
                    DataOutputStream out = new DataOutputStream(outToClient);
                    out.writeUTF(Double.toString(outputC));
                } else {
                    OutputStream outToClient = clientSocket.getOutputStream();
                    DataOutputStream out = new DataOutputStream(outToClient);
                    out.writeUTF("Thông tin đầu vào không hợp lệ");
                }

                clientSocket.close();
            }
        } catch (IOException e) {
            System.out.println("Server đã xảy ra lỗi!");
            e.printStackTrace();
        }
    }

    public static boolean isNumber(String data) {
        try {
            Double.parseDouble(data);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static double convertFahrenheitToCelsius(double fahrenheit) {
        return (fahrenheit - 32) * 5 / 9;
    }
}