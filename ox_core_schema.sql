-- ox_core-kompatibles Schema

CREATE TABLE IF NOT EXISTS players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(50) NOT NULL UNIQUE,
    license VARCHAR(50),
    discord VARCHAR(50),
    ip VARCHAR(50),
    name VARCHAR(50),
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_seen DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS characters (
    charid INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    fullName VARCHAR(101),
    gender VARCHAR(10),
    dateOfBirth DATE,
    x FLOAT,
    y FLOAT,
    z FLOAT,
    heading FLOAT,
    health TINYINT,
    armour TINYINT,
    statuses LONGTEXT,
    deleted DATE,
    FOREIGN KEY (user_id) REFERENCES players(id) ON DELETE CASCADE
);