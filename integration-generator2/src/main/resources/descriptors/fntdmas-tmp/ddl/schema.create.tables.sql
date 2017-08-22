create table ADRESSECORRESPONDANCE
(
IDADRCOR                      char(32)                 not null,
NOMDESTINATAIRE               varchar(84)             ,
COMPLEMENTADRESSE             varchar(32)             ,
NUMEROVOIE                    varchar(4)              ,
INDICENUMERO                  char(1)                  ,
TYPEVOIE                      varchar(20)             ,
LIBELLEVOIE                   varchar(32)             ,
CODEPOSTAL                    char(5)                  not null,
LIBELLECOMMUNE                varchar(32)             not null,
CEDEX                         varchar(15)             ,
NATUREORIGINE                 varchar(10)             not null
);

create table CACHETOPOCOM
(
IDCOM                         char(32)                 not null,
CODEDEP                       char(3)                  not null,
CODECOM                       char(3)                  not null,
DATEEFFET                     date                     not null,
LIBUSUEL                      varchar(30)             not null,
LIBCOMPLET                    varchar(70)             ,
ETAT                          char(1)                  not null,
CHEFLIEU                      numeric                not null,
POP                           char(1)                  not null,
POPAPART                      numeric                default 0 not null,
POPFICTIVE                    numeric                default 0 not null,
POPMUNI                       numeric                default 0 not null,
CHARNIERE                     varchar(6)              ,
CODEEVT                       char(2)                  not null,
CODEMVT                       char(2)                  not null,
DATEJURI                      date                     ,
DATECREAT                     date                     ,
CODEORIMAJ                    numeric                default 0 not null,
DATEMAJ                       date                     not null,
TYPECOM                       char(1)                  not null,
DATEINVALID                   date
);

create table CACHETOPODEP
(
IDDEP                         char(32)                 not null,
CODEDEP                       char(3)                  not null,
CODEREG                       char(3)                  ,
DATEEFFET                     date                     not null,
LIBUSUEL                      varchar(32)             ,
LIBCOMPLET                    varchar(70)             ,
ETAT                          char(1)                  ,
CHARNIERE                     varchar(6)              ,
CODEEVT                       char(2)                  not null,
CODEMVT                       char(2)                  ,
DATECREAT                     date                     ,
DATEJURI                      date                     ,
CODEORIMAJ                    numeric                default 0 not null,
DATEMAJ                       date                     not null,
DATEINVALID                   date
);

create table CAMPAGNEENCOURS
(
IDCAMPAGNE                    char(32)                 not null,
ANNEECAMPAGNE                 numeric                not null,
DATEDEBUT                     date                     ,
DATEFIN                       date
);

create table CONTEXTEUTILISATEUR
(
MATRICULE                     char(20)                 not null,
SERVICEETADRESSE1             varchar(32)             ,
SERVICEETADRESSE2             varchar(32)             ,
SERVICEETADRESSE3             varchar(32)             ,
SERVICEETADRESSE4             varchar(32)             ,
SERVICEETADRESSE5             varchar(32)             ,
TELEPHONESERVICE              varchar(20)             ,
NOMAGENT                      varchar(30)             ,
TELEPHONEAGENT                varchar(20)             ,
SELECTDADS2MAG                char(1)                  ,
SELECTDADS2PAP                char(1)                  ,
SELECT246062MAG               char(1)                  ,
SELECT2460PAP                 char(1)                  ,
SELECT2462PAP                 char(1)                  ,
SELECT2466MAG                 char(1)                  ,
SELECT2466PAP                 char(1)                  ,
SELECT2561MAG                 char(1)                  ,
SELECT2561PAP                 char(1)                  ,
SELECTIJMMAG                  char(1)                  ,
SELECTIJMPAP                  char(1)                  ,
SELECTTDSNMAG                 char(1)                  ,
SELECTSUPAP                   char(1)                  ,
AFFINECODEDEPARTEMENT         char(3)                  ,
AFFINECODECOMMUNE             char(3)                  ,
AFFINECODEVOIE                char(4)                  ,
AFFINENBRLIGNES               numeric                default 0 not null,
AFFINERELANCESANTERIEURES     char(1)
);

create table CORRESPCOMTOPAD
(
IDCORRCOM                     char(32)                 not null,
CODEDEPANC                    char(3)                  not null,
CODECOMANC                    char(3)                  not null,
CODEDEP                       char(3)                  not null,
CODECOM                       char(3)                  not null
);

create table DEFAILLANCE
(
IDDEFAILLANCE                 char(32)                 not null,
ANNEECAMPAGNE                 numeric                not null,
IDTYPEDECL                    char(32)                 not null,
IDTIERS                       char(32)                 not null,
RELANCE                       char(1)                  ,
CORRIGE                       char(1)                  not null,
IMPRIME                       char(1)                  ,
NOMBRESLIGNES1                numeric                not null,
DATERELANCE                   date                     ,
MATRICULECREATEUR             varchar(20)             ,
DATECREATION                  date                     ,
MATRICULEDERNIERMODIFICATEUR  varchar(20)             ,
DATEDERNMODIFICATION          date                     ,
TYPE1                         char(1)                  ,
TYPE2                         char(1)                  ,
TYPE3                         char(1)
);

create table DEPOTARECYCLER
(
IDDEPOTRECYCLER               char(32)                 not null,
SIREN                         char(9)                  ,
NIC                           char(5)                  ,
TYPERECYCLAGE                 varchar(10)             not null,
ANNEEREVENU                   char(4)                  ,
CODEDEP                       char(3)                  ,
CODECOMMUNE                   char(3)                  ,
CODEVOIE                      char(4)                  ,
RAISONSOCIALEENTREPRISE       varchar(50)             ,
RAISONSOCIALEETAB             varchar(50)             ,
COMPLEMENTADRESSEETAB         varchar(32)             ,
NUMEROVOIEETAB                varchar(4)              ,
INDICENUMEROETAB              char(1)                  ,
CODEAPE                       varchar(6)              ,
TYPEETABLISSEMENT             varchar(10)             ,
ETATDEPOTARECYCLER            char(1)                  not null,
TYPEDEPOT                     varchar(10)             not null,
TYPEPROCEDURE                 varchar(10)             not null,
DATEDEPOT                     date                     ,
NOMBRESALAIRES                numeric                default 0 not null,
NOMBREHONORAIRES              numeric                default 0 not null,
NOMBREBENEFICIAIRES           numeric                default 0 not null,
CODESECTION246062BILATERALE   varchar(2)              ,
NOMPRENOMCORRESPONDANT        varchar(50)             ,
NOTELCORRESPONDANT            varchar(20)             ,
EMAILCORRESPONDANT            varchar(60)
);

create table DEPOTVALIDE
(
IDDEPOTVALIDE                 char(32)                 not null,
ANNEEREVENUS                  char(4)                  not null,
DATEDEPOT                     date                     not null,
NBRELIGNES1                   numeric                default 0,
NBRELIGNES2                   numeric                default 0,
MATRICULECREATEUR             varchar(20)             not null,
DATECREATIONDEPOT             date                     not null,
MATRICULEDERNIERMODIFICATEUR  varchar(20)             not null,
DATEDERNMODIFICATIONDEPOT     date                     not null,
CODESECTION246062BILATERALE   varchar(2)              ,
IDTIERS                       char(32)                 not null,
IDTYPEDECL                    char(32)                 not null
);

create table ENUMERATION
(
IDENUM                        char(32)                 not null,
DOMAINE                       varchar(20)             not null,
CODE                          varchar(10)             not null,
VALEUR                        varchar(150)            not null,
COMMENTAIRES                  varchar(150)
);

create table TYPEDECLARATION
(
IDTYPEDECL                    varchar(32) not null,
TYPEDEPOT                     varchar(10) not null,
TYPEPROCEDURE                 varchar(10) not null,
DATELIMITEDEPOT               varchar(4),
TRAITEPARBATCH                varchar(1) not null
);

create table STATISTIQUES
(
ID                            char(32)                not null,
ANNEE                         numeric                 not null,
IDTYPEDECLARATION             char(32)                not null,
CODEDSF                       char(3)                 not null,
CODECDI                       char(7)                 not null,
NBRDECLARATIONS1              numeric                 not null,
NBRLIGNES1                    numeric                 not null,
NBRDECLARATIONS2              numeric                 not null,
NBRLIGNES2                    numeric                not null
);

create table SUPPORTJURIDIQUE
(
IDSJU                         char(32)                 not null,
SIREN                         char(9)                  not null,
TITRE                         varchar(10)             ,
RAISONSOCIALE                 varchar(40)             not null,
COMPLEMENTNOM                 varchar(40)             ,
TOPEAMBRE                     char(1)                  default 0 not null,
NATUREORIGINE                 varchar(10)             not null,
MATRICULECREATEUR             varchar(20)             not null,
MATRICULEDERNIERMODIFICATEUR  varchar(20)             not null,
DATECREATION                  date                     not null,
DATEMODIFICATION              date                     not null
);

create table TELEPHONESDSF
(
CODEDSF                       char(3)                  not null,
TELEPHONEDSF                  varchar(20)             ,
MATRICULEDERNIERMODIFICATEUR  varchar(20)             ,
DATEDERNIEREMODIFICATION      date
);

create table TIERS
(
IDTIERS                       char(32)                 not null,
NIC                           char(5)                  not null,
COMPLEMENTNOMETAB             varchar(40)             ,
CODECREATION                  varchar(10)             ,
DATECREATION                  date,
CODECESSATION                 varchar(10)             ,
DATECESSATION                 date                     ,
ETAT                          varchar(10)             ,
TYPEETABLISSEMENT             varchar(10)             ,
DATECLOTUREEXERCICE           date                     ,
INDICATEURDGE                 char(1)                  default 0,
TOPEAMBRE                     char(1)                  default 0 not null,
COMPTEENSOMMEIL               char(1)                  default 0,
NATUREORIGINE                 varchar(10)             not null,
CODEDEPADRLOC                 char(3)                  not null,
CODECOMADRLOC                 char(3)                  not null,
CODEVOIEADRLOC                char(4)                  ,
COMPLEMENTADRLOC              varchar(32)             ,
NUMEROVOIEADRLOC              varchar(4)              ,
INDICENUMEROADRLOC            char(1)                  ,
CEDEXADRLOC                   varchar(15)             ,
CODEAPE                       varchar(6)              ,
OBSERVATIONS                  varchar(3000)           ,
COCHEAMBRE                    char(1)                  ,
MATRICULECREATEUR             varchar(20)             not null,
MATRICULEDERNIERMODIFICATEUR  varchar(20)             not null,
DATECREATIONTIERS             date                     not null,
DATEMODIFICATIONTIERS         date                     not null,
IDADRCOR                      char(32)                 ,
IDSJU                         char(32)                 not null,
NOMPRENOMCORRESPONDANT        varchar(50)             ,
NOTELCORRESPONDANT            varchar(20)             ,
EMAILCORRESPONDANT            varchar(60)
);

create table TIERSAMBRESUPPRIMES
(
IDTIERS                       varchar(32)             ,
IDSJU                         varchar(32)             ,
IDADRCOR                      varchar(32)             ,
LOT                           char(2)                  not null
);
