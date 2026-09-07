package model;

public class AdminPojo {

    private int adminID;
    private String username;
    private String email;
    private String password;
    private String role;

    public int getAdminID() { return adminID; }
    public void setAdminID(int adminID) { this.adminID = adminID; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}