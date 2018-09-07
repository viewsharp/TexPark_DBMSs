CREATE EXTENSION IF NOT EXISTS CITEXT;

----------- users -----------

CREATE TABLE IF NOT EXISTS users (
  id       SERIAL PRIMARY KEY,
  nickname CITEXT NOT NULL UNIQUE,
  fullname TEXT   NOT NULL,
  email    CITEXT NOT NULL UNIQUE,
  about    TEXT
);

----------- forums -----------

CREATE TABLE IF NOT EXISTS forums (
  --   id SERIAL PRIMARY KEY,
  --   posts INTEGER,
  slug    CITEXT PRIMARY KEY,
  --   threads INTEGER,
  title   TEXT                          NOT NULL,
  user_id INTEGER REFERENCES users (id) NOT NULL
);

----------- threads -----------

CREATE TABLE IF NOT EXISTS threads (
  id         SERIAL PRIMARY KEY,
  slug       CITEXT UNIQUE,
  created    TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  title      TEXT                            NOT NULL,
  message    TEXT,
  --   votes INTEGER,
  user_id    INTEGER REFERENCES users (id)   NOT NULL,
  forum_slug CITEXT REFERENCES forums (slug) NOT NULL
);

----------- posts -----------

CREATE TABLE IF NOT EXISTS posts (
  id        SERIAL PRIMARY KEY,
  created   TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  --   title     TEXT                            NOT NULL, ОТКУДА???
  isEdited  BOOLEAN                  DEFAULT FALSE,
  message   TEXT                            NOT NULL,
  --   votes INTEGER,
  parent_id INTEGER REFERENCES posts (id), -- Adjacency List
  user_id   INTEGER REFERENCES users (id)   NOT NULL,
  thread_id INTEGER REFERENCES threads (id) NOT NULL
);
