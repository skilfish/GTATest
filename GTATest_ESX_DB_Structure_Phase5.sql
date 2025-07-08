
-- PHASE 5: Optimierte SQL-Struktur für neue ESX-Datenbank

-- Jobs
CREATE TABLE IF NOT EXISTS jobs (
    name VARCHAR(50) PRIMARY KEY,
    label VARCHAR(100),
    whitelisted BOOLEAN DEFAULT FALSE
);

-- Job Grades
CREATE TABLE IF NOT EXISTS job_grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_name VARCHAR(50),
    grade INT,
    name VARCHAR(50),
    label VARCHAR(100),
    salary INT DEFAULT 0,
    skin LONGTEXT,
    FOREIGN KEY (job_name) REFERENCES jobs(name) ON DELETE CASCADE
);

-- Items (optimiert für ox_inventory)
CREATE TABLE IF NOT EXISTS items (
    name VARCHAR(100) PRIMARY KEY,
    label VARCHAR(100),
    weight INT DEFAULT 1,
    rare BOOLEAN DEFAULT FALSE,
    can_remove BOOLEAN DEFAULT TRUE,
    type VARCHAR(50) DEFAULT 'item',
    unique_item BOOLEAN DEFAULT FALSE,
    useable BOOLEAN DEFAULT TRUE,
    image VARCHAR(100)
);

-- Addon Accounts
CREATE TABLE IF NOT EXISTS addon_account (
    name VARCHAR(100) PRIMARY KEY,
    label VARCHAR(100),
    shared BOOLEAN DEFAULT TRUE
);

-- Addon Inventory
CREATE TABLE IF NOT EXISTS addon_inventory (
    name VARCHAR(100) PRIMARY KEY,
    label VARCHAR(100),
    shared BOOLEAN DEFAULT TRUE
);

-- Shops
CREATE TABLE IF NOT EXISTS shops (
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(100),
    shop_type VARCHAR(50),
    coords VARCHAR(255),
    items LONGTEXT
);

-- Vehicles
CREATE TABLE IF NOT EXISTS vehicles (
    name VARCHAR(50) PRIMARY KEY,
    model VARCHAR(100),
    label VARCHAR(100),
    price INT
);

-- Owned Vehicles
CREATE TABLE IF NOT EXISTS owned_vehicles (
    plate VARCHAR(20) PRIMARY KEY,
    owner VARCHAR(60),
    vehicle LONGTEXT,
    stored BOOLEAN DEFAULT TRUE,
    garage VARCHAR(50) DEFAULT 'pillbox'
);

-- Beispieldaten
INSERT INTO jobs (name, label, whitelisted) VALUES
('police', 'Polizei', TRUE),
('ambulance', 'Rettungsdienst', TRUE),
('mechanic', 'Mechaniker', TRUE),
('unemployed', 'Arbeitslos', FALSE);

INSERT INTO job_grades (job_name, grade, name, label, salary) VALUES
('police', 0, 'recruit', 'Anwärter', 400),
('police', 1, 'officer', 'Polizist', 600),
('police', 2, 'sergeant', 'Sergeant', 800),
('ambulance', 0, 'medic', 'Sanitäter', 500),
('ambulance', 1, 'chief', 'Leiter', 700);

INSERT INTO items (name, label, weight, type) VALUES
('bread', 'Brot', 1, 'item'),
('water', 'Wasser', 1, 'item'),
('phone', 'Telefon', 1, 'item'),
('bandage', 'Verband', 1, 'item');

INSERT INTO addon_account (name, label) VALUES
('society_police', 'Polizei-Konto'),
('society_ambulance', 'Rettungsdienst-Konto');

INSERT INTO addon_inventory (name, label) VALUES
('society_police', 'Polizei-Inventar'),
('society_ambulance', 'Rettungsdienst-Inventar');
