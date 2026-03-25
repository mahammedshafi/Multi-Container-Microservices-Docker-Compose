-- ============================================================
-- init.sql — Database initialization script
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    email     VARCHAR(150) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    price       DECIMAL(10, 2),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO users (name, email) VALUES
    ('Admin User', 'admin@example.com'),
    ('Test User',  'test@example.com');

INSERT INTO products (name, description, price) VALUES
    ('Product A', 'Sample product A', 99.99),
    ('Product B', 'Sample product B', 149.99);
