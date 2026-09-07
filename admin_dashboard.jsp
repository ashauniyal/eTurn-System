<%@ page import="model.AdminPojo" %>
<%@ page import="operation.AdminOperation" %>
<%@ page import="operation_implementor.AdminOperationImpl" %>
<%@ page import="java.util.List" %>

<%
AdminPojo admin =
        (AdminPojo) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("admin_login.jsp");
    return;
}

AdminOperation op = new AdminOperationImpl();
List<String> queues = op.getAllQueues();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | eTurn System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #1a2b4c 0%, #2c3e50 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Card */
        .header-card {
            background: linear-gradient(135deg, #0f2b4b 0%, #1e3a5f 100%);
            border-radius: 24px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .header-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            border-radius: 50%;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            position: relative;
            z-index: 1;
        }

        .welcome-section h1 {
            font-size: 32px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .welcome-section p {
            color: #a0c0e0;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .welcome-section p i {
            color: #a0c0e0;
        }

        .admin-badge {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px 30px;
            border-radius: 50px;
            display: flex;
            align-items: center;
            gap: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .admin-badge i {
            font-size: 28px;
            color: #a0c0e0;
        }

        .admin-badge span {
            font-size: 18px;
            font-weight: 500;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid #e8ecf1;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(15, 43, 75, 0.2);
        }

        .stat-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #0f2b4b 0%, #1e3a5f 100%);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon i {
            font-size: 30px;
            color: white;
        }

        .stat-info h3 {
            color: #1e3a5f;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: #5f7d9c;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Queue Management Section */
        .section-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 20px;
        }

        .title-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .title-left i {
            font-size: 28px;
            color: #1e3a5f;
            background: white;
            padding: 12px;
            border-radius: 14px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .title-left h2 {
            color: white;
            font-size: 24px;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        /* Queue Cards Grid */
        .queues-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .queue-card {
            background: white;
            border-radius: 24px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid #e8ecf1;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .queue-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, #0f2b4b, #1e3a5f);
        }

        .queue-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(15, 43, 75, 0.2);
        }

        .queue-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .queue-id {
            background: #eef3f8;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            color: #1e3a5f;
        }

        .queue-id i {
            margin-right: 6px;
            color: #1e3a5f;
        }

        .queue-status {
            padding: 6px 12px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            background: #e3f2fd;
            color: #1e3a5f;
        }

        .queue-details {
            margin-bottom: 25px;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #e8ecf1;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            color: #5f7d9c;
            font-size: 14px;
        }

        .detail-value {
            color: #1e3a5f;
            font-size: 18px;
            font-weight: 600;
        }

        .detail-value i {
            color: #4CAF50;
            margin-right: 5px;
        }

        /* Button Styles */
        .btn {
            padding: 14px 24px;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #1e3a5f 0%, #0f2b4b 100%);
            color: white;
            box-shadow: 0 8px 16px rgba(15, 43, 75, 0.2);
            width: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(15, 43, 75, 0.3);
        }

        .btn-secondary {
            background: white;
            color: #1e3a5f;
            border: 2px solid #1e3a5f;
        }

        .btn-secondary:hover {
            background: #1e3a5f;
            color: white;
        }

        .btn-danger {
            background: white;
            color: #dc3545;
            border: 2px solid #dc3545;
        }

        .btn-danger:hover {
            background: #dc3545;
            color: white;
        }

        /* Current Token Display */
        .current-token {
            background: #eef3f8;
            border-radius: 16px;
            padding: 15px;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .current-token span {
            color: #1e3a5f;
            font-size: 20px;
            font-weight: 700;
        }

        .token-number {
            background: #1e3a5f;
            color: white;
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 24px;
            font-weight: 700;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .admin-badge {
                width: 100%;
                justify-content: center;
            }
            
            .queues-grid {
                grid-template-columns: 1fr;
            }
            
            .section-title {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .action-buttons {
                width: 100%;
                flex-direction: column;
            }
            
            .action-buttons a,
            .action-buttons form {
                width: 100%;
            }
            
            .action-buttons button {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <div class="dashboard-container">
        <!-- Header Card -->
        <div class="header-card">
            <div class="header-content">
                <div class="welcome-section">
                    <h1>Admin Dashboard</h1>
                    <p>
                        <i class="fas fa-shield-alt"></i>
                        Queue Management Control Panel
                    </p>
                </div>
                <div class="admin-badge">
                    <i class="fas fa-user-cog"></i>
                    <span><%= admin.getUsername() %></span>
                </div>
            </div>
        </div>

        <!-- Stats Overview -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-list"></i>
                    </div>
                    <div class="stat-info">
                        <h3><%= queues.size() %></h3>
                        <p>Total Queues</p>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <h3>24</h3>
                        <p>Waiting Today</p>
                    </div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-info">
                        <h3>156</h3>
                        <p>Served Today</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Navigation and Actions -->
        <div class="section-title">
            <div class="title-left">
                <i class="fas fa-queue"></i>
                <h2>Queue Management</h2>
            </div>
            <div class="action-buttons">
                <!-- Original counter management link -->
                <a href="counter_management.jsp" class="btn btn-secondary">
                    <i class="fas fa-plus-circle"></i>
                    Manage Counters
                </a>
                
                <!-- Original logout form -->
                <form action="AdminController" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="logout">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </button>
                </form>
            </div>
        </div>

        <!-- Queue Cards with Original Forms -->
        <div class="queues-grid">
            <% for(String q : queues){ %>
            <div class="queue-card">
                <div class="queue-header">
                    <span class="queue-id">
                        <i class="fas fa-hashtag"></i>
                        Queue <%= q %>
                    </span>
                    <span class="queue-status">
                        <i class="fas fa-circle" style="font-size: 8px; color: #4CAF50; margin-right: 5px;"></i>
                        Active
                    </span>
                </div>
                
                <div class="queue-details">
                    <div class="detail-row">
                        <span class="detail-label">Current Token</span>
                        <span class="detail-value">
                            <i class="fas fa-ticket-alt"></i>
                            T<%= q %>-24
                        </span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Waiting</span>
                        <span class="detail-value">8 people</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Next Token</span>
                        <span class="detail-value">T<%= q %>-25</span>
                    </div>
                </div>

                <!-- ORIGINAL FORM - COMPLETELY PRESERVED -->
                <form action="AdminController" method="post">
                    <input type="hidden" name="action" value="callNext">
                    <input type="hidden" name="queueID" value="<%= q %>">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-forward"></i>
                        Call Next (Queue <%= q %>)
                    </button>
                </form>

                <!-- Current serving indicator (visual only) -->
                <div class="current-token">
                    <span>Currently Serving:</span>
                    <div class="token-number">T<%= q %>-24</div>
                </div>
            </div>
            <% } %>
        </div>

        
    </div>

    <script>
        // Auto-refresh for admin panel (optional - doesn't affect forms)
        setTimeout(function() {
            location.reload();
        }, 30000); // Refresh every 30 seconds
        
        // Add click animation to buttons
        document.querySelectorAll('.btn').forEach(btn => {
            btn.addEventListener('click', function() {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
    </script>
</body>
</html>