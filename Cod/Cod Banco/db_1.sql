use empresadeeventos;

set foreign_key_checks = 0;

drop database empresadeeventos;

set foreign_key_checks = 1;

create database empresaDeEventos;

use empresaDeEventos;

CREATE TABLE localdeevento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(50),
    logradouro VARCHAR(80),
    cep VARCHAR(9),
    numero VARCHAR(12),
    capacidade INT,
    fileiras int,
    colunas int
);

CREATE TABLE evento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(40) NOT NULL,
    idadeMin INT NOT NULL,
    duracao varchar(20) NOT NULL,
    dataInicio varchar(10) NOT NULL,
    dataFim varchar(10) NOT NULL,
    horaInicio varchar(10) NOT NULL,
    horaFim varchar(10) NOT NULL,
    valorIngresso DECIMAL(10, 2) NOT NULL,
    id_localdeevento INT NOT NULL,
    FOREIGN KEY (id_localdeevento) REFERENCES localdeevento (id) ON DELETE CASCADE
);

CREATE TABLE assento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    coluna int not null,
    fileira int not null,
    especial BIT NOT NULL,
    id_localdeevento INT NOT NULL,
    FOREIGN KEY (id_localdeevento) REFERENCES localdeevento (id) ON DELETE CASCADE
);

CREATE TABLE ingresso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comprado BIT NOT NULL,
    id_evento INT NOT NULL,
    id_assento INT,
    FOREIGN KEY (id_evento) REFERENCES evento (id) ON DELETE CASCADE,
    FOREIGN KEY (id_assento) REFERENCES assento (id) ON DELETE CASCADE
);

CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(70) UNIQUE NOT NULL,
    senha VARCHAR(80) NOT NULL
);

CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dataNascimento varchar(10) NOT NULL,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE CASCADE
);

-- Tabela: Organizador
CREATE TABLE organizador (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id) ON DELETE CASCADE
);

-- Tabela: Venda
CREATE TABLE venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    dataCompra varchar(10) NOT NULL,
    dataPagamento varchar(10),
    id_evento INT NOT NULL,
    id_cliente INT NOT NULL,
    id_ingresso INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento (id) ON DELETE CASCADE,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id) ON DELETE CASCADE,
    FOREIGN KEY (id_ingresso) REFERENCES ingresso (id) ON DELETE CASCADE
);

-- Cadastro de local de evento
insert into
    localdeevento (
        nome,
        logradouro,
        cep,
        numero,
        capacidade,
        fileiras,
        colunas
    )
values (
        "Teatro Lopes",
        "R. São Pedro",
        "09320-890",
        "129",
        16,
        4,
        4
    ),
    (
        "Parque Anhembi",
        "Av. Olavo Fontoura",
        "02012-021",
        "1209",
        4000,
        0,
        0
    );


-- Cadastro de usuário

insert into
    usuario (email, nome, senha)
values (
        "administrador@gmail.com",
        "Rafael Carrenho",
        CONCAT(
            '*',
            UPPER(SHA1(UNHEX(SHA1('admin123'))))
        )
    ),
    (
        "client@gmail.com",
        "Charlie",
        CONCAT(
            '*',
            UPPER(SHA1(UNHEX(SHA1('client12'))))
        )
    );

-- Cadastro de organizador
insert into organizador (id_usuario) values (1);

-- Cadastro de cliente
insert into
    cliente (dataNascimento, id_usuario)
values ("2001-03-20", 2);

select usuario.id as 'Id', usuario.nome as 'Nome', usuario.email as 'Email', cliente.id_usuario as 'Id Cli', organizador.id_usuario as 'Id Org'
from
    usuario
    left join cliente on cliente.id_usuario = usuario.id
    left join organizador on organizador.id_usuario = usuario.id
where
    usuario.email = 'client@gmail.com'
    and usuario.senha = CONCAT(
        '*',
        UPPER(SHA1(UNHEX(SHA1('client12'))))
    );
-- Cadastro de evento
insert into
    evento (
        nome,
        idadeMin,
        duracao,
        dataInicio,
        dataFim,
        horaInicio,
        horaFim,
        valorIngresso,
        id_localdeevento
    )
values (
        "Expo Arte Moderna",
        14,
        "10 horas",
        "20/05/2024",
        "20/05/2024",
        "09:00",
        "19:00",
        40.00,
        2
    ),
    (
        "Apresentação de Balé",
        0,
        "4 horas",
        "18/05/2024",
        "18/05/2024",
        "10:00",
        "14:00",
        5.00,
        1
    );
