package util;

public class PasswordTest {

    public static void main(String[] args) {

        String password = "admin";   // Change this if needed

        String hashed = PasswordUtil.hashPassword(password);

        System.out.println("Original Password: " + password);
        System.out.println("Hashed Password: " + hashed);
    }
}