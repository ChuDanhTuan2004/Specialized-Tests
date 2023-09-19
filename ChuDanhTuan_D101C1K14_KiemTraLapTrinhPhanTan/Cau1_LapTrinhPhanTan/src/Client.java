import java.io.*;
import java.net.Socket;

public class Client {
    public static void main(String[] args) {
        String hostName = "localhost";
        int portNumber = 8888;

        try {
            Socket clientSocket = new Socket(hostName, portNumber);

            BufferedReader userInput = new BufferedReader(new InputStreamReader(System.in));
            System.out.println("Nhập độ F:");
            String outputFString = userInput.readLine();

            OutputStream outToServer = clientSocket.getOutputStream();
            DataOutputStream out = new DataOutputStream(outToServer);
            out.writeUTF(outputFString);

            InputStream inFromServer = clientSocket.getInputStream();
            DataInputStream in = new DataInputStream(inFromServer);
            String inputCString = in.readUTF();

            if (isNumber(inputCString)) {
                double inputC = Double.parseDouble(inputCString);
                System.out.println(inputC + " độ C");
            } else {
                System.out.println(inputCString);
            }

            clientSocket.close();
        } catch (IOException e) {
            System.out.println("Client đã xảy ra lỗi!");
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
}