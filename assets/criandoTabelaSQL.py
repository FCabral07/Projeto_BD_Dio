'''
This python script has coments with all the commands 
used for creating the database in MySQL Workbench.



CREATE A SCHEMA:
----------------------------------------------------------------
create schema if not exists ecommerce;
use ecommerce;

CREATE TABLE Clientes
----------------------------------------------------------------
create table Clientes(
	idClient INT NOT NULL AUTO_INCREMENT UNIQUE,
    Pname VARCHAR(10) NOT NULL,
    Minit CHAR(3),
    Lname VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    constraint pk_idClient primary key (idClient)
);

CREATE TABLE Entregas
----------------------------------------------------------------
create table Entregas(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    Cod INT NOT NULL,
    `Status` ENUM('Enviado', 'A Caminho', 'Entregue', 'Em transito', 'Saiu para entrega', 'Aguardando') NOT NULL DEFAULT 'Aguardando',
    Contact CHAR(11),
    constraint pk_Entregas primary key(id)
);

CREATE TABLE CreditCards
----------------------------------------------------------------
create table CreditCards(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    `Name` VARCHAR(45) NOT NULL,
    `Number` VARCHAR(15) NOT NULL UNIQUE,
    Flag VARCHAR(45) NOT NULL,
    ExpDate DATE NOT NULL,
    fk_idClient INT NOT NULL,
    constraint pk_CreditCards primary key(id),
    constraint fk_ClientCreditCards foreign key (fk_idClient) REFERENCES ecommerce.Clientes(idClient)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

# Na tabela acima, quando eu crio a fk_Client eu designo que, caso ela seja deletada em Clientes, não haja
mudança na tabela CreditCards, assim como caso ela tenha algum update

CREATE TABLE Formas_Pagamento
----------------------------------------------------------------
create table Formas_Pagamentos(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    PayType VARCHAR(45) NOT NULL UNIQUE DEFAULT 'Cartao de Credito',
    constraint pk_FormasPgto primary key(id)
);

CREATE TABLE Pedidos
----------------------------------------------------------------
create table Pedidos(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    fk_idClient INT NOT NULL,
    fk_idDeliver INT NOT NULL,
    fk_idPayType INT NOT NULL,
    fk_idCreditCard INT NOT NULL,
    `Status` ENUM('Confirmado', 'Cancelado', 'Em Processamento') NOT NULL DEFAULT 'Em Processamento',
    `Description` VARCHAR(255),
    TotalValue FLOAT NOT NULL,
    `Date` DATE NOT NULL,
    NumberPayment VARCHAR(45) NOT NULL,
    constraint pk_Pedidos primary key(id, fk_idClient, fk_idDeliver),
    constraint fk_ClientDeliver foreign key(fk_idClient) references ecommerce.Clientes(idClient)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_Deliver foreign key(fk_idDeliver) references ecommerce.Entregas(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_PayType foreign key(fk_idPayType) references ecommerce.Formas_Pagamentos(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_CreditCard foreign key(fk_idCreditCard) references ecommerce.CreditCards(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Produtos
----------------------------------------------------------------
create table Produtos(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    `Name`VARCHAR(20) NOT NULL,
    ClassKids TINYINT NOT NULL DEFAULT 0 COMMENT '0- Indica que é infantil, 1- Indica que é adulto',
    Category ENUM('Eletronico', 'Eletrodomestico', 'Smartphone', 'Brinquedos', 'Videogame') NOT NULL,
    Size VARCHAR(10),
    Rating FLOAT DEFAULT 0,
    Price FLOAT NOT NULL,
    constraint pk_Produto primary key(id)
);

CREATE TABLE Fornecedores
----------------------------------------------------------------
create table Fornecedores(
	id INT NOT NULL auto_increment UNIQUE,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Contact CHAR(11) NOT NULL,
    constraint pk_Fornecedores primary key(id)
);

CREATE TABLE Fornecedores_Produtos
----------------------------------------------------------------
create table Fornecedores_Produtos(
	fk_idSupplier INT NOT NULL,
    fk_idProduct INT NOT NULL,
    Qtd INT NOT NULL,
    constraint fk_FornecedorProduto foreign key(fk_idSupplier) references ecommerce.Fornecedores(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_ProdutoID foreign key(fk_idProduct) references ecommerce.Produtos(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Estoques
----------------------------------------------------------------
create table Estoques(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    `Local` VARCHAR(255) NOT NULL,
    `Name` VARCHAR(50) COMMENT 'Nome do responsável pelo estoque',
    Contact CHAR(11),
    constraint pk_Estoque primary key(id)
);

CREATE TABLE Produtos_Estoques
----------------------------------------------------------------
create table Produtos_Estoques(
	fk_idProduct INT NOT NULL,
    fk_idStorage INT NOT NULL,
    Qtd INT NOT NULL DEFAULT 0,
    constraint pk_ProdutosEmEstoque primary key(fk_idProduct, fk_idStorage),
    constraint fk_EstoqueProduto foreign key (fk_idProduct) references ecommerce.Produtos(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_Estoques foreign key (fk_idStorage) references ecommerce.Estoques(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Pedidos_Produtos
----------------------------------------------------------------
create table Pedidos_Produtos(
	fk_idProduct INT NOT NULL, 
    fk_idOrder INT NOT NULL,
    Qtd INT NOT NULL,
    Status ENUM('Disponivel', 'Sem estoque') NOT NULL DEFAULT 'Disponivel',
    constraint pk_PedidosProdutos primary key(fk_idProduct, fk_idOrder),
    constraint fk_PedidoProduto foreign key(fk_idProduct) references ecommerce.Produtos(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_PedidoNumero foreign key(fk_idOrder) references ecommerce.Pedidos(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Vendedores
----------------------------------------------------------------
create table Vendedores(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    SocialName VARCHAR(25) NOT NULL,
    AbstName VARCHAR(25),
    CNPJ CHAR(15),
    CPF CHAR(11),
    `Local` VARCHAR(100) NOT NULL,
    Contact char(11) NOT NULL,
    constraint pk_Vendedor primary key(id)
);

CREATE TABLE Produtos_Terceiros
----------------------------------------------------------------
create table Produtos_Terceiros(
	fk_idSeller INT NOT NULL,
    fk_idProduct INT NOT NULL,
    Qtd INT NOT NULL,
    constraint pk_ProdutosTerceiros primary key(fk_idSeller, fk_idProduct),
    constraint fk_VendedorTerceiros foreign key(fk_idSeller) references ecommerce.Vendedores(id)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	constraint fk_ProdutoTerceiros foreign key(fk_idProduct) references ecommerce.Pedidos_Produtos(fk_idProduct)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

CREATE TABLE Documentos
----------------------------------------------------------------
create table Documentos(
	id INT NOT NULL AUTO_INCREMENT UNIQUE,
    DocType ENUM('CPF', 'CNPJ') NOT NULL,
    DocNum VARCHAR(15) NOT NULL UNIQUE,
    fk_idClient INT NOT NULL,
    constraint pk_Documentos primary key(id, fk_idClient),
    constraint fk_ClienteDocumento foreign key(fk_idClient) references ecommerce.ClienteS(idClient)
		ON DELETE NO ACTION
        ON UPDATE NO ACTION
);

'''