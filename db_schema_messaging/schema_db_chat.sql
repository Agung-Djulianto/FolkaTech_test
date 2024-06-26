-- Tabel untuk pengguna
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    username VARCHAR(50) NOT NULL
);

-- Tabel untuk pesan 1 on 1
CREATE TABLE one_on_one_messages (
    message_id SERIAL PRIMARY KEY,
    sender_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    receiver_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    content TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) CHECK (status IN ('sent', 'read', 'pending')) DEFAULT 'sent'
);

-- Tabel untuk grup
CREATE TABLE groups (
    group_id SERIAL PRIMARY KEY,
    group_name VARCHAR(50) NOT NULL,
    created_by INT REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabel untuk anggota grup
CREATE TABLE group_members (
    group_id INT REFERENCES groups(group_id) ON DELETE CASCADE,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    role VARCHAR(10) CHECK (role IN ('admin', 'member')),
    PRIMARY KEY (group_id, user_id)
);

-- Tabel untuk pesan grup
CREATE TABLE group_messages (
    message_id SERIAL PRIMARY KEY,
    group_id INT REFERENCES groups(group_id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    content TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(10) CHECK (status IN ('sent', 'read', 'pending')) DEFAULT 'sent'
);

-- Tabel untuk status pesan (read/sent/pending)
CREATE TABLE message_status (
    status_id SERIAL PRIMARY KEY,
    message_id INT NOT NULL,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(10) CHECK (status IN ('sent', 'read', 'pending')),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (message_id, user_id)
);

-- Tabel untuk berbagi gambar/file
CREATE TABLE shared_files (
    file_id SERIAL PRIMARY KEY,
    message_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) CHECK (file_type IN ('image', 'file')),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (message_id) REFERENCES one_on_one_messages(message_id) ON DELETE CASCADE
);

-- Tabel untuk berbagi gambar/file dalam grup
CREATE TABLE group_shared_files (
    file_id SERIAL PRIMARY KEY,
    message_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_type VARCHAR(50) CHECK (file_type IN ('image', 'file')),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (message_id) REFERENCES group_messages(message_id) ON DELETE CASCADE
);
