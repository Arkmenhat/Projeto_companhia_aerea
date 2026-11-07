CREATE DATABASE companhia_aerea;
USE companhia_aerea;

CREATE TABLE passageiro 
  ( 
     numrgipas SERIAl NOT NULL, 
     nompas    VARCHAR(45),
     PRIMARY KEY (numrgipas)
  );

CREATE TABLE aviao 
  ( 
     numseravi SERIAL NOT NULL, 
     modavi    VARCHAR(45), 
     PRIMARY KEY (numseravi) 
  );

CREATE TABLE assento
  ( 
     codass    SERIAL NOT NULL, 
     tipass    VARCHAR(45), 
     numseravi INT4 NOT NULL, 
     PRIMARY KEY (codass) 
  ); 

CREATE TABLE piloto 
  ( 
     codpil SERIAL NOT NULL, 
     nompil VARCHAR(45), 
     PRIMARY KEY (codpil) 
  ); 

CREATE TABLE aeroporto 
  ( 
     codaer SERIAL NOT NULL, 
     nomaer VARCHAR(45), 
     PRIMARY KEY (codaer) 
  ); 

CREATE TABLE voo 
  ( 
     codvoo    SERIAL NOT NULL, 
     datvoo    TIMESTAMP, 
     codaerpar INT4 NOT NULL, 
     codaerche INT4 NOT NULL, 
     numseravi INT4 NOT NULL, 
     codpil    INT4 NOT NULL, 
     PRIMARY KEY (codvoo) 
  ); 

CREATE TABLE passagem 
  ( 
     codpsg    SERIAL NOT NULL, 
     valpsg    NUMERIC(12, 2), 
     datpsg    TIMESTAMP, 
     datconpsg TIMESTAMP,
     numrgipas INT4 NOT NULL, 
     codass    INT4 NOT NULL, 
     codvoo    INT4 NOT NULL, 
     PRIMARY KEY (codpsg) 
  ); 

CREATE INDEX aviao_numseravi_fk_idx 
  ON assento (numseravi); 

CREATE INDEX aeroporto_codaer_fk1_idx 
  ON voo (codaerpar); 

CREATE INDEX aeroporto_codaer_fk2_idx 
  ON voo (codaerche); 

CREATE INDEX aviao_numseravi_fk1_idx 
  ON voo (numseravi); 

CREATE INDEX piloto_codpil_fk1_idx 
  ON voo (codpil); 

CREATE INDEX passageiro_numrgipas_fk1_idx 
  ON passagem (numrgipas); 

CREATE INDEX assento_codass_fk1_idx 
  ON passagem (codass); 

CREATE INDEX voo_codvoo_fk1_idx 
  ON passagem (codvoo); 

ALTER TABLE assento
MODIFY COLUMN numseravi BIGINT UNSIGNED NOT NULL;
ALTER TABLE assento
ADD CONSTRAINT aviao_numseravi_fk
FOREIGN KEY (numseravi)
REFERENCES aviao (numseravi)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE voo 
MODIFY COLUMN codaerpar BIGINT UNSIGNED NOT NULL,
MODIFY COLUMN codaerche BIGINT UNSIGNED NOT NULL,
MODIFY COLUMN numseravi BIGINT UNSIGNED NOT NULL,
MODIFY COLUMN codpil BIGINT UNSIGNED NOT NULL;
ALTER TABLE voo
ADD CONSTRAINT aeroporto_codaer_fk1
FOREIGN KEY (codaerpar)
REFERENCES aeroporto (codaer)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE voo 
  ADD CONSTRAINT aeroporto_codaer_fk2 FOREIGN KEY (codaerche) REFERENCES 
  aeroporto (codaer) ON UPDATE CASCADE ON DELETE CASCADE; 

ALTER TABLE voo 
  ADD CONSTRAINT aviao_numseravi_fk1 FOREIGN KEY (numseravi) REFERENCES aviao ( 
  numseravi) ON UPDATE CASCADE ON DELETE CASCADE; 

ALTER TABLE voo 
  ADD CONSTRAINT piloto_codpil_fk1 FOREIGN KEY (codpil) REFERENCES piloto ( 
  codpil) ON UPDATE CASCADE ON DELETE CASCADE; 

ALTER TABLE passagem 
MODIFY COLUMN numrgipas BIGINT UNSIGNED NOT NULL,
MODIFY COLUMN  codass BIGINT UNSIGNED NOT NULL,
MODIFY COLUMN  codvoo BIGINT UNSIGNED NOT NULL;
ALTER TABLE passagem
ADD CONSTRAINT passageiro_numrgipas_fk1 
FOREIGN KEY (numrgipas) 
REFERENCES passageiro (numrgipas) 
ON UPDATE CASCADE
ON DELETE CASCADE; 

ALTER TABLE passagem 
  ADD CONSTRAINT assento_codass_fk1
  FOREIGN KEY (codass) 
  REFERENCES assento (codass) 
  ON UPDATE CASCADE 
  ON DELETE CASCADE; 

ALTER TABLE passagem 
  ADD CONSTRAINT voo_codvoo_fk1 FOREIGN KEY (codvoo) REFERENCES voo (codvoo) ON 
  UPDATE CASCADE ON DELETE CASCADE; 