DROP DATABASE IF EXISTS  uvv;
DROP USER IF EXISTS pedroh;


/* Criação do usuario para acesso ao banco de dados */
  
CREATE USER                              pedroh 
WITH
ENCRYPTED PASSWORD                    'senha321'
                                        CREATEDB
                                      CREATEROLE
                                          LOGIN
;
                                          
/* comando para criação do banco de dados e conexão do mesmo */

CREATE                                  DATABASE uvv 
OWNER =                                 pedroh
template =                              template0
encoding =                               UTF8
lc_collate =                           'pt_BR.UTF-8'
lc_ctype =                             'pt_BR.UTF-8'
ALLOW_CONNECTIONS =                      true
;

/*  comentario do banco de dados*/
COMMENT ON DATABASE                               uvv
IS                                               'banco de dados lojas uvv'


/* conexao entre o ususario e o banco de dados atual */
  \c "host=localhost dbname=uvv user=pedroh password=senha321"
;
  
/* criaçao do esquema e conexao com o usuario pedroh*/

CREATE   SCHEMA lojas;
ALTER    SCHEMA lojas OWNER TO pedroh;

COMMENT ON SCHEMA lojas            is        'esquematizacao lojas uvv';
/* configura o esquema incial para o usuario pedroh*/
SET SEARCH_PATH TO lojas,            "$user", public;
ALTER USER                           pedroh
SET SEARCH_PATH TO lojas,            "$user", public;

/* criacao da tabela produtos*/

CREATE TABLE produtos (
                produto_id NUMERIC(38)             NOT NULL,
                nome VARCHAR(255)                  NOT NULL,
                preco_unitario NUMERIC(10,2)       NOT NULL,
                detalhes BYTEA                     NOT NULL,
                imagem BYTEA                      NOT NULL,
                imagem_mime_type VARCHAR(512)    NOT NULL,
                imagem_arquivo VARCHAR(512)          NOT NULL,
                imagem_charset VARCHAR(512)          NOT NULL,
                imagem_ultima_atualizacao DATE        NOT NULL,
                CONSTRAINT pk_produto PRIMARY KEY (produto_id)
);

COMMENT ON TABLE produtos IS 'tabelas referente aos produtos das lojas uvv';

COMMENT ON COLUMN produtos.produto_id IS 'Coluna que contém a pk da tabela produto';
COMMENT ON COLUMN produtos.nome IS 'armazena os nomes ';
COMMENT ON COLUMN produtos.preco_unitario IS 'armazena os precos unitarios';
COMMENT ON COLUMN produtos.detalhes IS 'armazena os detalhes ';
COMMENT ON COLUMN produtos.imagem IS 'armazena as imagens';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'armazena  imagens';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'armazena  imagens arquivo';
COMMENT ON COLUMN produtos.imagem_charset IS 'armazena  imagens charset';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'armazena  imagens atualizadas';

CREATE TABLE cliente (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20) NOT NULL,
                telefone2 VARCHAR(20) NOT NULL,
                telefone3 VARCHAR(20) NOT NULL,
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);

COMMENT ON TABLE cliente IS 'tabela referente a clientes das lojas uvv';

COMMENT ON COLUMN  cliente.cliente_id IS 'coluna referente a pk da tabela clientes';
COMMENT ON COLUMN  cliente.email IS 'armazena os emails dos clientes';
COMMENT ON COLUMN  cliente.nome IS 'armazena os nomes dos clientes';
COMMENT ON COLUMN  cliente.telefone1 IS'armazena o telefone principal do cliente';
COMMENT ON COLUMN  cliente.telefone2 IS 'armazena o telefone secundario do cliente';
COMMENT ON COLUMN  cliente.telefone3 IS 'armazena o telefone terciario do cliente';

CREATE TABLE loja (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100) NOT NULL,
                endereco_fisico VARCHAR(512) NOT NULL,
                latitude NUMERIC NOT NULL,
                longitude NUMERIC NOT NULL,
                logo BYTEA NOT NULL,
                logo_mime_type VARCHAR(512) NOT NULL,
                logo_arquivo VARCHAR(512) NOT NULL,
                logo_charset VARCHAR(512) NOT NULL,
                logo_ultima_atualizacao DATE NOT NULL,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);

COMMENT ON TABLE loja IS 'tabela referente as lojas uvv';

COMMENT ON COLUMN    loja.loja_id IS 'coluna referente a pk da tabela loja';
COMMENT ON COLUMN    loja.nome IS 'armazena o nome da loja ';
COMMENT ON COLUMN    loja.endereco_web IS 'armazena o endereco web';
COMMENT ON COLUMN    loja.endereco_fisico IS 'armazena o endereco fisico';
COMMENT ON COLUMN    loja.latitude IS 'armazena a latitude';
COMMENT ON COLUMN    loja.longitude IS 'armazena  a longitude';
COMMENT ON COLUMN    loja.logo IS 'armazena a logo';
COMMENT ON COLUMN    loja.logo_arquivo IS 'armazena o arquivo da logo';
COMMENT ON COLUMN    loja.logo_charset IS 'armazena  o logo charset';
COMMENT ON COLUMN    loja.logo_ultima_atualizacao IS 'armazena a logo atualizada';

CREATE INDEX lojas_idx
 ON loja
 ( nome );

CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);

COMMENT ON TABLE pedidos IS 'tabela referente  a pedidos das lojas uvv';

COMMENT ON COLUMN pedidos.pedido_id  IS 'Coluna que contém a pk da tabela pedidos';
COMMENT ON COLUMN pedidos.data_hora  IS 'armazena a data e hora';
COMMENT ON COLUMN pedidos.cliente_id  IS 'coluna que contem a fk da tabela clientes';
COMMENT ON COLUMN pedidos.status     IS 'armazena os status dos pedidos ';
COMMENT ON COLUMN pedidos.loja_id    IS 'coluna que contem a fk da tabela loja';

CREATE TABLE estoque (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);

COMMENT ON TABLE estoque IS 'tabela referente ao estoque das lojas uvv';

COMMENT ON COLUMN estoque.estoque_id  IS 'Coluna que contém a pk da tabela estoque';
COMMENT ON COLUMN estoque.loja_id  IS 'coluna que contem a fk da tabela loja';
COMMENT ON COLUMN estoque.produto_id  IS 'coluna que contem a fk da tabela produtos';
COMMENT ON COLUMN estoque.quantidade  IS 'armazena a quantidade no estoque ';


CREATE TABLE envio (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);

COMMENT ON TABLE envio IS 'tabela referente a pedidos das lojas uvv';

COMMENT ON COLUMN envio.envio_id  IS 'Coluna que contém a pk da tabela envio';
COMMENT ON COLUMN envio.loja_id  IS 'coluna que contem a fk da tabela loja';
COMMENT ON COLUMN envio.cliente_id  IS 'coluna que contem a fk da tabela clientes';
COMMENT ON COLUMN envio.endereco_entrega  IS 'armazena o endereco de entrega ';
COMMENT ON COLUMN envio.status  IS 'armazena o status do envio ';

CREATE TABLE pedidositens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedido_itens PRIMARY KEY (pedido_id, produto_id)
);

COMMENT ON TABLE pedidositens IS 'tabela referente aos pedidos dos itens das lojas uvv';

COMMENT ON COLUMN pedidositens.pedido_id  IS 'Coluna que contém a pfk, envios, produtos e pedidos';
COMMENT ON COLUMN pedidositens.produto_id  IS 'coluna que contem a pfk, envios, produtos e pedidos ';
COMMENT ON COLUMN pedidositens.numero_da_linha  IS 'armazena o nmero da linha';
COMMENT ON COLUMN pedidositens.preco_unitario  IS 'armazena o preco unitario ';
COMMENT ON COLUMN pedidositens.quantidade  IS 'armazena a quantidade ';
COMMENT ON COLUMN pedidositens.envio_id  IS 'coluna que contem a fk da tabela envios ';

ALTER TABLE estoque ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidositens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envio ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envio ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoque ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES loja (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidositens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidositens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envio (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

/* adicionando as CONSTRAINTS */

/*Status_pedidos podem somente possuir os seguintes parametros*/
ALTER TABLE pedidos		
ADD CONSTRAINT status	CHECK (status IN ('cancelado', 'aberto', 'pago', 'completo', 'enviado', 'enviado'));

/*Status_envios podem somente possuir os seguintes parametros*/
ALTER TABLE	envio		
ADD CONSTRAINT status CHECK (status IN('criado', 'transito', 'entregue', 'enviado'));

/*preco unitario pode somente possuir os seguintes parametros*/

ALTER TABLE	pedidositens 	
ADD CONSTRAINT preco_unitario CHECK (preco_unitario > 0);

/*quantidade pode somente possuir os seguintes parametros*/

ALTER TABLE	estoque	
ADD CONSTRAINT quantidade CHECK (quantidade > 0);

/*Status_pedidos podem somente possuir os seguintes parametros*/

ALTER TABLE	produtos	
ADD CONSTRAINT preco_unitario	CHECK (preco_unitario > 0);
