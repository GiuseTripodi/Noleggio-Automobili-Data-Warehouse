-- ****************************************************
-- *                 DT_assicurazione                 *
-- ****************************************************
create table DT_assicurazione (
   id_assicurazione INTEGER not null,
   nome_compagnia   varchar(100),
   constraint PK_assicurazione primary key (id_assicurazione)
);


-- ****************************************************
-- *                     DT_citta                     *
-- ****************************************************
create table DT_citta (
   id_citta INTEGER not null,
   nome     varchar(50),
   contea   VARCHAR(100),
   stato    VARCHAR(100),
   constraint PK_citt� primary key (id_citta)
);


-- ****************************************************
-- *             DT_campagna_pubblicitaria            *
-- ****************************************************
create table DT_campagna_pubblicitaria (
   id_campagna INTEGER not null,
   Categoria   varchar(63),
   Azienda     varchar(63),
   constraint PK_campagna_pub primary key (id_campagna)
);


-- ****************************************************
-- *                   DT_automobile                  *
-- ****************************************************
create table DT_automobile (
   id_automobile        INTEGER not null,
   tipologia_carburante varchar(200),
   tipo_cambio          varchar(50),
   marca                varchar(50),
   modello              varchar(48),
   nome                 VARCHAR,
   constraint PK_automobile primary key (id_automobile)
);


-- ****************************************************
-- *                   DT_temporale                   *
-- ****************************************************
create table DT_temporale (
   id_data     INTEGER not null,
   giorno      INTEGER,
   mese        INTEGER,
   trimestre   INTEGER,
   anno        INTEGER,
   giorno_nome VARCHAR(30),
   mese_nome   VARCHAR(30),
   constraint PK_DT_tempo primary key (id_data)
);


-- ****************************************************
-- *                  DT_autonoleggio                 *
-- ****************************************************
create table DT_autonoleggio (
   id_autonoleggio           INTEGER not null,
   id_citta                  INTEGER,
   nome_autonoleggio         varchar(50),
   numero_dipendenti         INTEGER,
   salario_medio             FLOAT,
   id_campagna_pubblicitaria INTEGER,
   constraint PK_autonoleggio primary key (id_autonoleggio)
);

alter table DT_autonoleggio
   add constraint citta
   foreign key (id_citta) references DT_citta (id_citta);

alter table DT_autonoleggio
   add constraint relazione_autonoleggio_campagna
   foreign key (id_campagna_pubblicitaria) references DT_campagna_pubblicitaria (id_campagna);


-- ****************************************************
-- *                 FT_noleggio_auto                 *
-- ****************************************************
create table FT_noleggio_auto (
   id_autonoleggio           INTEGER not null,
   id_locazione_ritiro       INTEGER not null,
   id_locazione_consegna     INTEGER not null,
   id_automobile             INTEGER not null,
   id_assicurazione          INTEGER not null,
   id_data                   INTEGER not null,
   carburante_medio          FLOAT,
   chilometri_medi           FLOAT,
   numero_noleggi            INTEGER,
   MPC_medio                 FLOAT,
   costo_assicurazione_medio FLOAT,
   tasse_medie               FLOAT,
   sconto_medio              FLOAT,
   numero_clienti            INTEGER,
   eta_media_clienti         FLOAT,
   importo_pagato_medio      FLOAT,
   constraint PK_noleggio_auto primary key (id_autonoleggio, id_locazione_ritiro, id_locazione_consegna, id_automobile, id_assicurazione, id_data)
);

alter table FT_noleggio_auto
   add constraint noleggio_assicurazione
   foreign key (id_assicurazione) references DT_assicurazione (id_assicurazione);

alter table FT_noleggio_auto
   add constraint noleggio_automobile
   foreign key (id_automobile) references DT_automobile (id_automobile);

alter table FT_noleggio_auto
   add constraint autonoleggio
   foreign key (id_autonoleggio) references DT_autonoleggio (id_autonoleggio);

alter table FT_noleggio_auto
   add constraint autonoleggio_consegno
   foreign key (id_locazione_consegna) references DT_citta (id_citta);

alter table FT_noleggio_auto
   add constraint tempo
   foreign key (id_data) references DT_temporale (id_data);

alter table FT_noleggio_auto
   add constraint noleggio_locazione_ritiro
   foreign key (id_locazione_ritiro) references DT_citta (id_citta);


