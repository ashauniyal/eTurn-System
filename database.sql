DROP DATABASE IF EXISTS eTurnDB;
CREATE DATABASE eTurnDB;
USE eTurnDB;

-- =========================
-- 1️⃣ ADMIN TABLE
-- =========================
CREATE TABLE Admin (
    adminID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- 2️⃣ USER TABLE
-- =========================
CREATE TABLE Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contactNumber VARCHAR(15) NOT NULL,
    password VARCHAR(255) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from users;
-- =========================
-- 3️⃣ COUNTER TABLE
-- =========================
CREATE TABLE Counter (
    counterID VARCHAR(10) PRIMARY KEY,
    serviceType VARCHAR(100) NOT NULL,
    status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- =========================
-- 4️⃣ QUEUE TABLE
-- =========================
CREATE TABLE Queue (
    queueID VARCHAR(10) PRIMARY KEY,
    counterID VARCHAR(10),
    currentToken INT DEFAULT 0,
    FOREIGN KEY (counterID) REFERENCES Counter(counterID) ON DELETE CASCADE
);

-- =========================
-- 5️⃣ TOKEN TABLE
-- =========================
CREATE TABLE Token (
    tokenID INT AUTO_INCREMENT PRIMARY KEY,
    queueID VARCHAR(10),
    userID INT,
    tokenNumber INT NOT NULL,
    position INT,
    status ENUM('Waiting','Called','Completed') DEFAULT 'Waiting',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (queueID) REFERENCES Queue(queueID) ON DELETE CASCADE,
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE
);

-- =========================
-- 6️⃣ NOTIFICATION TABLE
-- =========================
CREATE TABLE Notification (
    notificationID INT AUTO_INCREMENT PRIMARY KEY,
    tokenID INT,
    message VARCHAR(255),
    status ENUM('Sent','Pending') DEFAULT 'Pending',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (tokenID) REFERENCES Token(tokenID) ON DELETE CASCADE
);

-- =========================
-- INDEXES
-- =========================
CREATE INDEX idx_user_token ON Token(userID);
CREATE INDEX idx_queue_token ON Token(queueID);
CREATE INDEX idx_counter_queue ON Queue(counterID);

-- =========================
-- TRIGGER: AUTO TOKEN NUMBER
-- =========================
DELIMITER $$

CREATE TRIGGER before_token_insert
BEFORE INSERT ON Token
FOR EACH ROW
BEGIN

    DECLARE maxToken INT;

    SELECT IFNULL(MAX(tokenNumber),0)
    INTO maxToken
    FROM Token
    WHERE queueID = NEW.queueID;

    SET NEW.tokenNumber = maxToken + 1;

END$$

DELIMITER ;

-- =========================
-- TRIGGER: AUTO NOTIFICATION
-- =========================
DELIMITER $$

CREATE TRIGGER after_token_update
AFTER UPDATE ON Token
FOR EACH ROW
BEGIN

    IF NEW.status = 'Called' THEN

        INSERT INTO Notification(tokenID, message, status)
        VALUES(
            NEW.tokenID,
            CONCAT('Token ', NEW.tokenNumber, ' is now called'),
            'Sent'
        );

    END IF;

END$$

DELIMITER ;

-- =========================
-- PREVENT MULTIPLE ACTIVE TOKENS
-- =========================
DELIMITER $$

CREATE TRIGGER prevent_multiple_active_tokens
BEFORE INSERT ON Token
FOR EACH ROW
BEGIN

    IF EXISTS (
        SELECT 1
        FROM Token
        WHERE userID = NEW.userID
        AND status IN ('Waiting','Called')
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User already has active token';

    END IF;

END$$

DELIMITER ;

-- =========================
-- STORED PROCEDURE: GENERATE TOKEN
-- =========================
DELIMITER $$

CREATE PROCEDURE GenerateToken(
    IN p_queueID VARCHAR(10),
    IN p_userID INT
)
BEGIN

    INSERT INTO Token(queueID, userID, tokenNumber, position)
    VALUES(p_queueID, p_userID, 0, 0);

END$$

DELIMITER ;

-- =========================
-- STORED PROCEDURE: CALL NEXT TOKEN
-- =========================
DELIMITER $$

CREATE PROCEDURE CallNextToken(
    IN p_queueID VARCHAR(10)
)
BEGIN

    DECLARE nextID INT;

    SELECT tokenID
    INTO nextID
    FROM Token
    WHERE queueID = p_queueID
    AND status = 'Waiting'
    ORDER BY tokenNumber
    LIMIT 1;

    IF nextID IS NOT NULL THEN

        UPDATE Token
        SET status = 'Called'
        WHERE tokenID = nextID;

        UPDATE Queue
        SET currentToken =
        (
            SELECT tokenNumber
            FROM Token
            WHERE tokenID = nextID
        )
        WHERE queueID = p_queueID;

    END IF;

END$$

DELIMITER ;

-- =========================
-- FUNCTION: GET USER POSITION
-- =========================
DELIMITER $$

CREATE FUNCTION GetUserPosition(p_tokenID INT)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE pos INT;

    SELECT COUNT(*)
    INTO pos
    FROM Token
    WHERE queueID =
        (
            SELECT queueID
            FROM Token
            WHERE tokenID = p_tokenID
        )
    AND tokenNumber <=
        (
            SELECT tokenNumber
            FROM Token
            WHERE tokenID = p_tokenID
        )
    AND status = 'Waiting';

    RETURN pos;

END$$

DELIMITER ;

-- =========================
-- VIEW: QUEUE STATUS
-- =========================
CREATE VIEW QueueStatusView AS

SELECT
    u.name AS UserName,
    t.tokenNumber,
    t.status,
    q.queueID,
    c.serviceType,
    c.counterID

FROM Token t
JOIN Users u ON t.userID = u.userID
JOIN Queue q ON t.queueID = q.queueID
JOIN Counter c ON q.counterID = c.counterID;

-- =========================
-- ADMIN DATA
-- =========================
INSERT INTO Admin(username,email,password,role)
VALUES(
    'Admin',
    'admin@eturn.com',
    '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
    'System Admin'
);



SELECT * FROM Counter;
