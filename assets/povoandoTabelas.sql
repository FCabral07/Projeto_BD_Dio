use ecommerce;

INSERT INTO Clientes (Pname, Minit, Lname, Address, Phone) VALUES 
	('Felipe', 'C.', 'Cabral', 'PB', '83112126201'),
	('Vitória ', 'S.', 'Bernardino', 'PB', '83909126587'),
	('Lucas', 'B.', 'Santos', 'PE', '81981725301');

INSERT INTO Entregas (Cod, `Status`, Contact) VALUES 
    ('1122334455', 'Aguardando', '1287094571'),
	('78965412', 'Enviado', '1787094583'),
	('123987456', 'Em trânsito', '8398019024'),
	('852369741', 'Saiu para entrega', '8576341267'),
	('123654852', 'Entregue', '2190873267');
    
INSERT INTO CreditCards (`Name`, `Number`, Flag, ExpDate,fk_idClient) VALUES 
	('Felipe C Cabral', '123456789123456', 'Visa', '27-06-12', '4'),
	('Vitória S Bernardino', '123456789123400', 'Master', '28-10-02', '5'),
	('Lucas B Santos', '123665544332299', 'Visa', '24-03-01', '6');
    
select * from creditcards;
    
INSERT INTO Formas_Pagamentos (PayType) VALUES
	('Credito'),
    ('Boleto'),
    ('Pix'),
    ('Carteira Digital'),
    ('Debito');


INSERT INTO Pedidos (fk_idClient, fk_idDeliver, fk_idPayType, fk_idCreditCard, `Status`, `Description`, TotalValue, `Date`, NumberPayment) VALUES 
	(5, 2, 1, 5, 'Em Processamento', 'Esperando confirmação da operadora', 3958.37, '23-03-15', '123654780'),
	(4, 1, 1, 4, 'Cancelado', 'Cancelou o pedido', '1400', '23-03-14', '19121219'),
	(6, 3, 1, 6, 'Confirmado', 'Utilizou Visa', '2000', '23-02-20', '02365470');
INSERT INTO Pedidos (fk_idClient, fk_idDeliver, fk_idPayType, `Status`, `Description`, TotalValue, `Date`, NumberPayment) VALUES 
	('4', '4', '3', 'Confirmado', 'Pagou com Pix', 399.90, '23-06-19', '12141516'),
	('6', '1', '2', 'Em Processamento', 'Aguardando compensação do boleto', 2370.12, '23-04-14', '20222125');
    
    
INSERT INTO produtos (`Name`, ClassKids, Category, Size, Rating, Price) VALUES 
	('Carro Hotwheels', 0, 'Brinquedos', 'P', 4.88, 9.97),
	('Monitor', 1, 'Eletronico', '19"', 4.47, 1898.90),
	('PlayStation 5', 1, 'Videogame', 'M', 4.99, 3499.90),
	('iPhone 14', '1', 'Smartphone', '5.8"', 4.12, 3999.10),
    ('Xbox Series S', 1, 'Videogame', 'S', 4.92, 1699.90),
    ('Geladeira Brastemp', 1, 'Eletrodomestico', '470L', 4.32, 4394.85),
    ('Urso Patrulha Canina', 0, 'Brinquedos', 'P', 3.98, 99.90);
    

INSERT INTO Fornecedores (SocialName, CNPJ, Contact) VALUES 
	('iByte', '123654985632569', '85984984910'),
	('Magalu', '123321123321122', '21981787250'),
	('FcTech', '924521523325128', '11982750015');
    

INSERT INTO fornecedores_produtos (fk_idSupplier, fk_idProduct, Qtd) VALUES 
	('1', '3', '100'),
    ('1', '5', '50'),
	('2', '1', '50'),
    ('2', '7', '50'),
	('3', '4', '200'),
	('1', '2', '2000'),
    ('2', '6', '50');
    

INSERT INTO estoques (`Local`, `Name`, Contact) VALUES 
	('Campina Grande - PB','Gabriel Lopes','83995324123'),
	('São Paulo - SP','Julia Lemos','11945324520'),
	('Rio de Janeiro - RJ','Rafael Oliveira','21976238784'),
	('Curitiba - PR','Miguel Farias','41925739639'),
	('João Pessoa - PB','Ana Luisa','83996234578'),
	('Recife - PE','Paulo Victor','81988453265');
    

INSERT INTO produtos_estoques (fk_idProduct, fk_idStorage, Qtd) VALUES 
	('1','1', 100),
	('2','2', 50),
	('3','3', 400),
	('4','4', 2000),
    ('5','5', 200),
    ('6','6', 300),
    ('7','1', 500);
    

INSERT INTO pedidos_produtos (fk_idProduct, fk_idOrder, Qtd, `Status`) VALUES 
	('1', '4', '2', 'Disponível'),
	('2', '5', '3', 'Disponível'),
	('3', '6', '2', 'Disponível'),
	('4', '7', '4', 'Disponível'),
	('5', '8', '1', 'Disponível');
    

INSERT INTO vendedores (SocialName, AbstName, CNPJ, CPF, `Local`, Contact) VALUES 
	('Hippogriff Store',NULL,'903152731465862',NULL,'Campina Grande','83993256761'),
	('3D Imports',NULL,'153253854955756',NULL,'Recife','81988465451'),
	('RJTech',NULL,NULL,'18249263421','Natal','84982652039'),
	('RIOT',NULL,NULL,'16325873300','Fortaleza','85998412210'),
	('Blizzard',NULL,'758652382623451',NULL,'São Paulo','11913522196');
    
    
INSERT INTO produtos_terceiros (fk_idSeller, fk_idProduct, Qtd) VALUES 
	(1, 2, 10),
	(2, 3, 5),
	(3, 4, 15),
	(4, 1, 50);
    

INSERT INTO Documentos (DocType, DocNum, fk_idClient) VALUES 
	('CPF', '11122233344', '4'),
	('CPF', '32162351298', '5'),
	('CPF','98723456178', '6');
