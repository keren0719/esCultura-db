-- Tabla de roles
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_code VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY roles_role_code_unique (role_code),
    UNIQUE KEY roles_role_name_unique (role_name)
);


INSERT INTO roles(role_name,role_code,is_active)
VALUES('ADMINISTRADOR','ADMIN',1)

INSERT INTO roles(role_name,role_code,is_active)
VALUES('PARTICIPANTE','PARTI',1)

INSERT INTO roles(role_name,role_code,is_active)
VALUES('ORGANIZADOR','ORGA',1)

-- Tabla de usuarios
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    role_id BIGINT NOT NULL,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY users_username_unique (username),
    UNIQUE KEY users_email_unique (email),
    CONSTRAINT users_role_id_fk FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- este es un comentario de prueba

-- 1) Categorías
CREATE TABLE categorias (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  slug VARCHAR(120) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE lugar (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(200) NOT NULL,
  direccion VARCHAR(300),
  ciudad VARCHAR(100),
  capacidad INT UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE eventos (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(250) NOT NULL,
  slug VARCHAR(300) NOT NULL UNIQUE,
  descripcion_corta VARCHAR(500),
  descripcion_larga TEXT,
  categoria_id BIGINT UNSIGNED NULL,
  sede_id BIGINT UNSIGNED NULL,
  organizador_nombre VARCHAR(200),       -- simplificado: nombre del organizador
  inicio DATETIME NOT NULL,
  fin DATETIME NULL,
  moneda CHAR(3) NOT NULL DEFAULT 'COP',
  precio DECIMAL(12,2) NULL,             -- NULL => gratis
  capacidad INT UNSIGNED NULL,           -- si NULL usar sedes.capacidad
  inscritos INT UNSIGNED NOT NULL DEFAULT 0,
  estado ENUM('publicado','borrador','cancelado','pendiente','rechazado') NOT NULL DEFAULT 'publicado',
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  reject_reason VARCHAR(500),
  FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL,
  FOREIGN KEY (sede_id) REFERENCES lugar(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE fotos_evento (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  evento_id BIGINT UNSIGNED NOT NULL,
  url VARCHAR(1000) NOT NULL,
  texto_alternativo VARCHAR(255),
  destacada TINYINT(1) NOT NULL DEFAULT 0,
  orden INT NOT NULL DEFAULT 0,
  FOREIGN KEY (evento_id) REFERENCES eventos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE valoraciones (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  evento_id BIGINT UNSIGNED NOT NULL,
  nombre_autor VARCHAR(150) NOT NULL,         -- o correo si no hay usuarios registrados
  comentario TEXT,
  calificacion TINYINT UNSIGNED NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
  fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (evento_id) REFERENCES eventos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
