DROP TABLE IF EXISTS article_authors;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS rubrics;
DROP TABLE IF EXISTS article_statuses;
DROP TABLE IF EXISTS user_roles;

CREATE TABLE user_roles (
    user_role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE article_statuses (
    article_status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE rubrics (
    rubric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    patronymic TEXT,
    login TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    user_role INTEGER NOT NULL,
    FOREIGN KEY (user_role) REFERENCES user_roles (user_role_id)
);

CREATE TABLE articles (
    article_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    abstract TEXT NOT NULL,
    file_path TEXT NOT NULL,
    rubric_id INTEGER NOT NULL,
    submitted_at TEXT NOT NULL,
    editor_id INTEGER,
    decided_at TEXT,
    status INTEGER NOT NULL,

    FOREIGN KEY (rubric_id) REFERENCES rubrics (rubric_id),
    FOREIGN KEY (editor_id) REFERENCES users (user_id),
    FOREIGN KEY (status) REFERENCES article_statuses (article_status_id)
);

CREATE TABLE article_authors (
    article_author_id INTEGER PRIMARY KEY AUTOINCREMENT,
    article_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    UNIQUE (article_id, user_id),
    FOREIGN KEY (article_id) REFERENCES articles (article_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

INSERT INTO user_roles (name)
VALUES ('Author'), ('Editor');

INSERT INTO article_statuses (name)
VALUES ('Under review'), ('Accepted'), ('Rejected');

INSERT INTO rubrics (name)
VALUES ('Computer science'), ('Mathematics'), ('Physics');

INSERT INTO users (name, surname, patronymic, login, password_hash, user_role)
VALUES
('Петров', 'Алексей', 'Игоревич', 'petrov', '0001', 1),
('Сидорова', 'Мария', 'Олеговна', 'sidorova', '0002', 1),

INSERT INTO articles (title, abstract, file_path, rubric_id, submitted_at, editor_id, decided_at, status)
VALUES
('Алгоритмы сортировки на C++', 'Сравнение быстродействия основных алгоритмов сортировки.', 'uploads/sorting.pdf', 1, '2026-09-10', 4, '2026-09-20', 2),
('Графы в задачах оптимизации', 'Применение теории графов к поиску кратчайших путей.', 'uploads/graphs.pdf', 2, '2026-09-15', 4, '2026-09-25', 3),

INSERT INTO article_authors (article_id, user_id)
VALUES (1, 1), (2, 2), (3, 1), (3, 3), (4, 2);
