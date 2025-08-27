CREATE SCHEMA IF NOT EXISTS restoranas_db
DEFAULT CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;
USE restoranas_db;
CREATE TABLE IF NOT EXISTS klientu_tipai (
   id_klientu_tipai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pavadinimas VARCHAR(50) NOT NULL UNIQUE,
   aprasymas VARCHAR(255) NULL,
   nuolaida_procentais DECIMAL(5,2) NULL,   
   unikalus_kodas VARCHAR(20) NULL                   
);
CREATE TABLE IF NOT EXISTS klientai (
   id_klientai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   vardas_pavarde VARCHAR(100) NULL,
   klientu_tipai_id INT UNSIGNED NULL, 
   registracijos_data DATE NULL,
   gimimo_data DATE NULL,
   el_pastas VARCHAR(100) NULL,
   unikalus_kodas VARCHAR(20) NULL, 
   CONSTRAINT fk_klientu_tipai
    FOREIGN KEY (klientu_tipai_id)
    REFERENCES klientu_tipai(id_klientu_tipai)
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS patiekalu_tipai (
  id_patiekalu_tipai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pavadinimas VARCHAR(50) NOT NULL UNIQUE,
   aprasymas VARCHAR(255) NULL
);
CREATE TABLE IF NOT EXISTS patiekalai (
   id_patiekalai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pavadinimas VARCHAR(100) NOT NULL,
   kaina DECIMAL(6,2) NOT NULL,
   patiekalu_tipai_id INT UNSIGNED NULL, 
   aprasymas VARCHAR(255) NULL,
   CONSTRAINT fk_patiekalai_tipai
      FOREIGN KEY (patiekalu_tipai_id)
      REFERENCES patiekalu_tipai(id_patiekalu_tipai)
      ON DELETE SET NULL
      ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS apsilankymai (
   id_apsilankymai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   klientai_id INT UNSIGNED NULL,    
   apsilankymo_data DATETIME NOT NULL,   
   sveciu_skaicius INT UNSIGNED DEFAULT 1, 
   pastabos VARCHAR(255) NULL,       
   CONSTRAINT fk_apsilankymai_klientai
     FOREIGN KEY (klientai_id) 
     REFERENCES klientai(id_klientai )
     ON DELETE SET NULL
     ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS pardavimai (
   id_pardavimai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   apsilankymai_id INT UNSIGNED NOT NULL,
   suma_eur DECIMAL(7,2) NOT NULL,
   data_laikas DATETIME NOT NULL,
   CONSTRAINT fk_pardavimai_apsilankymai
     FOREIGN KEY (apsilankymai_id) 
     REFERENCES apsilankymai(id_apsilankymai)
     ON DELETE CASCADE
     ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS mokejimu_tipai (
   id_mokejimu_tipai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pavadinimas VARCHAR(50) NOT NULL UNIQUE,
   aprasymas VARCHAR(255) NULL
);
CREATE TABLE IF NOT EXISTS mokejimai (
   id_mokejimai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pardavimai_id INT UNSIGNED NOT NULL,
   mokejimu_tipai_id INT UNSIGNED NULL,
   suma_eur DECIMAL(7,2) NOT NULL,
   CONSTRAINT fk_mokejimai_pardavimai
     FOREIGN KEY (pardavimai_id) 
     REFERENCES pardavimai(id_pardavimai)
     ON DELETE CASCADE 
     ON UPDATE CASCADE,
   CONSTRAINT fk_mokejimu_tipai
     FOREIGN KEY (mokejimu_tipai_id) 
     REFERENCES mokejimu_tipai(id_mokejimu_tipai)
     ON DELETE SET NULL 
     ON UPDATE CASCADE
);
CREATE TABLE IF NOT EXISTS parduoti_patiekalai (
  id_parduoti_patiekalai INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pardavimai_id INT UNSIGNED NOT NULL,
  patiekalai_id INT UNSIGNED NOT NULL,
  kiekis INT UNSIGNED NOT NULL,
  CONSTRAINT fk_pp_pardavimai
    FOREIGN KEY (pardavimai_id) 
    REFERENCES pardavimai(id_pardavimai)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT fk_pp_patiekalai
    FOREIGN KEY (patiekalai_id) 
    REFERENCES patiekalai(id_patiekalai)
    ON DELETE RESTRICT 
    ON UPDATE CASCADE
);