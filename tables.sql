-- Tabla de roles
CREATE TABLE roles 
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    role_name VARCHAR(100) NOT NULL,
    role_code VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    CONSTRAINT roles_role_code_unique UNIQUE (role_code),
    CONSTRAINT roles_role_name_unique UNIQUE (role_name)
);
-- Tabla de usuarios
CREATE TABLE users 
(
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    role_id BIGINT NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    CONSTRAINT users_username_unique UNIQUE (username),
    CONSTRAINT users_email_unique UNIQUE (email),
    CONSTRAINT users_role_id_fk FOREIGN KEY (role_id) REFERENCES roles(id)
);
