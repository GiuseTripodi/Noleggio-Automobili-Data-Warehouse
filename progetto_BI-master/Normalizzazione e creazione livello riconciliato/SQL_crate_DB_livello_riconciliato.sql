-- ****************************************************
-- *                  opzioni fluido                  *
-- ****************************************************
create table opzioniFluido (
   id_opzioni_fluido   INTEGER not null,
   veicolo             varchar(50),
   carburante          bigint,
   chilometri_percorsi varchar(7),
   MPG                 varchar(9),
   tipo                char(1),
   constraint PK_opzioniFluido primary key (id_opzioni_fluido)
);


-- ****************************************************
-- *                   assicurazione                  *
-- ****************************************************
create table assicurazione (
   id_assicurazione   INTEGER not null,
   NAIC               bigint,
   Nome_compagnia     varchar(100),
   Reclami_accettati  bigint,
   Reclami_rifiutati  bigint,
   Reclami_totali     bigint,
   premi_per_iscritto bigint,
   anno_di_deposito   bigint,
   constraint PK_assicurazione primary key (id_assicurazione)
);


-- ****************************************************
-- *                  patente cliente                 *
-- ****************************************************
create table patente_cliente (
   id_patente_cliente INTEGER not null,
   classe_patente     varchar(30),
   stato              varchar(50),
   privilegi          varchar(30),
   anno_scadenza      bigint,
   constraint PK_patente_cliente primary key (id_patente_cliente)
);


-- ****************************************************
-- *                    automobile                    *
-- ****************************************************
create table automobile (
   id_automobile         INTEGER not null,
   altezza               bigint,
   lughezza              bigint,
   larghezza             bigint,
   tipologia_carburante  varchar(200),
   tipo_cambio           varchar(50),
   nome_completo_modello varchar(100),
   marca                 varchar(50),
   modello               varchar(48),
   anno                  decimal,
   constraint PK_automobile primary key (id_automobile)
);


-- ****************************************************
-- *                       stato                      *
-- ****************************************************
create table stato (
   id_stato INTEGER not null,
   stato    varchar(50),
   constraint PK_stato primary key (id_stato)
);


-- ****************************************************
-- *                     pagamento                    *
-- ****************************************************
create table pagamento (
   id_pagamento               INTEGER not null,
   noleggio_auto              int,
   costo_totale_assicurazione int,
   tasse_sul_servizio         int,
   VAT                        int,
   sconto_totale              int,
   importo_netto_pagabile     int,
   constraint PK_pagamento primary key (id_pagamento)
);


-- ****************************************************
-- *                      contea                      *
-- ****************************************************
create table contea (
   id_contea INTEGER not null,
   contea    varchar(50),
   id_stato  INTEGER,
   constraint PK_contea primary key (id_contea)
);

alter table contea
   add constraint Relazione_contea_stato
   foreign key (id_stato) references stato (id_stato);


-- ****************************************************
-- *                       città                      *
-- ****************************************************
create table città (
   id_città    INTEGER not null,
   ANSICODE    bigint,
   nome        varchar(50),
   id_contea   INTEGER,
   Latitudine  decimal,
   Longitudine decimal,
   constraint PK_città primary key (id_città)
);

alter table città
   add constraint Relazione_contea_città
   foreign key (id_contea) references contea (id_contea);


-- ****************************************************
-- *                   autonoleggio                   *
-- ****************************************************
create table autonoleggio (
   id_autonoleggio   INTEGER not null,
   indirizzo         varchar(50),
   id_città          INTEGER,
   nome_autonoleggio varchar(50),
   constraint PK_autonoleggio primary key (id_autonoleggio)
);

alter table autonoleggio
   add constraint Relazione_autonoleggio_città
   foreign key (id_città) references città (id_città);


-- ****************************************************
-- *                    dipendenti                    *
-- ****************************************************
create table dipendenti (
   id_dipendente      INTEGER not null,
   email              varchar(8),
   id_manager         INTEGER(3),
   nome               varchar(11),
   numero_di_telefono bigint,
   data_di_assunzione varchar(9),
   salario            bigint,
   cognome            varchar(11),
   id_autonoleggio    INTEGER,
   constraint PK_dipendenti primary key (id_dipendente)
);

alter table dipendenti
   add constraint relazione_dipendente_manager
   foreign key (id_manager) references dipendenti (id_dipendente);

alter table dipendenti
   add constraint relaDipendenteAutonoleggio
   foreign key (id_autonoleggio) references autonoleggio (id_autonoleggio);


-- ****************************************************
-- *                      clienti                     *
-- ****************************************************
create table clienti (
   id_cliente         INTEGER not null,
   nome               varchar(30),
   congnome           varchar(30),
   email              varchar(50),
   genere             varchar(6),
   reddito_annuo      varchar(9),
   id_citta_residenza INTEGER,
   punteggio_di_spesa bigint,
   data_di_nascita    datetime,
   id_licenza         INTEGER,
   constraint PK_clienti primary key (id_cliente)
);

alter table clienti
   add constraint relazione_cliente_città
   foreign key (id_citta_residenza) references città (id_città);

alter table clienti
   add constraint relazione_cliente_patente
   foreign key (id_licenza)references patente_cliente (id_patente_cliente);


-- ****************************************************
-- *                   prenotazione                   *
-- ****************************************************
create table prenotazione (
   id_prenotazione           INTEGER not null,
   id_locazione_ritiro       INTEGER,
   id_locazione_restituzione INTEGER,
   id_automobile             INTEGER,
   id_cliente                INTEGER,
   constraint PK_prenotazione primary key (id_prenotazione)
);

alter table prenotazione
   add constraint relazione_prenotazione_città
   foreign key (id_locazione_restituzione) references città (id_città);

alter table prenotazione
   add constraint relazione_città_prenotazione
   foreign key (id_locazione_ritiro) references città (id_città);

alter table prenotazione
   add constraint relazione_cliente_prenotazione
   foreign key (id_cliente) references clienti (id_cliente);

alter table prenotazione
   add constraint relazione_prenotazione_automobile
   foreign key (id_prenotazione) references automobile (id_automobile);

alter table prenotazione
   add constraint relazionePrenotazioneAutomobile
   foreign key (id_automobile) references automobile (id_automobile);


-- ****************************************************
-- *                       voli                       *
-- ****************************************************
create table voli (
   id_volo                 bigint not null,
   TailNum                 varchar(6),
   origine                 varchar(3),
   destinazione            varchar(3),
   cancellato              bigint,
   deviato                 bigint,
   id_prenotazione_noleggo INTEGER,
   id_cliente              INTEGER,
   constraint PK_voli primary key (id_volo)
);

alter table voli
   add constraint relazione_volo_prenotazione
   foreign key (id_prenotazione_noleggo) references prenotazione (id_prenotazione);

alter table voli
   add constraint relazione_volo_cliente
   foreign key (id_cliente) references clienti (id_cliente);


-- ****************************************************
-- *                   campagna_pub                   *
-- ****************************************************
create table campagna_pub (
   id_campagna     int not null,
   id_autonoleggio INTEGER,
   Categoria       varchar(63),
   Sotto_categoria varchar(63),
   Azienda         varchar(63),
   Dominio_website varchar(63),
   constraint PK_campagna_pub primary key (id_campagna)
);

alter table campagna_pub
   add constraint relazione_autonoleggio_campagna_pubblicitaria
   foreign key (id_autonoleggio) references autonoleggio (id_autonoleggio);


-- ****************************************************
-- *                     magazzino                    *
-- ****************************************************
create table magazzino (
   id_magazzino    bigint not null,
   Volume          decimal,
   Score           varchar(5),
   Facility        varchar(59),
   Address1        varchar(100),
   Address2        varchar(100),
   Address3        varchar(100),
   id_cities       INTEGER,
   id_autonoleggio INTEGER,
   constraint PK_magazzino primary key (id_magazzino)
);

alter table magazzino
   add constraint Relazione_autonoleggio_magazzino
   foreign key (id_autonoleggio) references autonoleggio (id_autonoleggio);

alter table magazzino
   add constraint relazione_magazzino_città
   foreign key (id_cities) references città (id_città);


-- ****************************************************
-- *                   noleggio auto                  *
-- ****************************************************
create table noleggio_auto (
   id_noleggio_auto        INTEGER not null,
   id_locazione_ritiro     INTEGER,
   id_locazione_consegna   INTEGER,
   id_pagamento            INTEGER,
   id_dipendente           INTEGER,
   id_auto                 INTEGER,
   id_cliente              INTEGER,
   id_opzioni_fluido       INTEGER,
   id_assicurazione        INTEGER,
   anno                    int,
   mese                    int,
   trimestre               int,
   durata_noleggio         int,
   giorno_dell_anno_numero int,
   giorno_del_mese_numero  int,
   giorno_nome             varchar(30),
   mese_nome               varchar(30),
   trimestre_nome          varchar(2),
   data_completa           varchar(63),
   settimana               int,
   trimestre_numero        int,
   constraint PK_noleggio_auto primary key (id_noleggio_auto)
);

alter table noleggio_auto
   add constraint Relazione_noleggio_auto_città
   foreign key (id_locazione_consegna) references città (id_città);

alter table noleggio_auto
   add constraint Relazione_noleggio_auto_dipendente
   foreign key (id_dipendente) references dipendenti (id_dipendente);

alter table noleggio_auto
   add constraint Relazione_noleggio_auto_automobile
   foreign key (id_auto) references automobile (id_automobile);

alter table noleggio_auto
   add constraint relazione_noleggioAuto_Pagamento
   foreign key (id_pagamento) references pagamento (id_pagamento);

alter table noleggio_auto
   add constraint Relazione_noleggioAuto_città
   foreign key (id_locazione_ritiro) references città (id_città);

alter table noleggio_auto
   add constraint Relazione_noleggioAuto_assicurazione
   foreign key (id_assicurazione) references assicurazione (id_assicurazione);

alter table noleggio_auto
   add constraint Relazione_noleggioAuto_cliente
   foreign key (id_cliente) references clienti (id_cliente);

alter table noleggio_auto
   add constraint relazione_noleggioA_opzioniFluido
   foreign key (id_opzioni_fluido) references opzioniFluido (id_opzioni_fluido);


