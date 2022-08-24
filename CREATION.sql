-- Active: 1661245990856@@127.0.0.1@5432@postgres@public
create table emp
(
	noemp numeric not null,
	nom VARCHAR(20),
	prenom VARCHAR(20),
	emploi VARCHAR(20),
	sup numeric,
	embauche date,
	sal numeric,
	comm numeric,
	noserv numeric
);

alter table emp
add constraint PK_EMP primary key (noemp);


create table serv
(
noserv numeric not null,
service varchar(20),
ville varchar(20)
);

alter table serv
add constraint PK_SERV primary key(noserv);

insert into emp values (1000,'LEROY','PAUL','PRESIDENT',null,to_date('25/10/87','dd/MM/yy'),55005.5,null,1);
insert into emp values (1100,'DELPIERRE','DOROTHEE','SECRETAIRE',1000,to_date('25/10/87','dd/MM/yy'),12351.24,null,1);
insert into emp values (1101,'DUMONT','LOUIS','VENDEUR',1300,to_date('25/10/87','dd/MM/yy'),9047.9,0,1);
insert into emp values (1102,'MINET','MARC','VENDEUR',1300,to_date('25/10/87','dd/MM/yy'),8085.81,17230,1);
insert into emp values (1104,'NYS','ETIENNE','TECHNICIEN',1200,to_date('25/10/87','dd/MM/yy'),12342.23,null,1);
insert into emp values (1105,'DENIMAL','JEROME','COMPTABLE',1600,to_date('25/10/87','dd/MM/yy'),15746.57,null,1);
insert into emp values (1200,'LEMAIRE','GUY','DIRECTEUR',1000,to_date('11/03/87','dd/MM/yy'),36303.63,null,2);
insert into emp values (1201,'MARTIN','JEAN','TECHNICIEN',1200,to_date('25/06/87','dd/MM/yy'),11235.12,null,2);
insert into emp values (1202,'DUPONT','JACQUES','TECHNICIEN',1200,to_date('30/10/88','dd/MM/yy'),10313.03,null,2);
insert into emp values (1300,'LENOIR','GERARD','DIRECTEUR',1000,to_date('02/04/87','dd/MM/yy'),31353.14,13071,3);
insert into emp values (1301,'GERARD','ROBERT','VENDEUR',1300,to_date('16/04/99','dd/MM/yy'),7694.77,12430,3);
insert into emp values (1303,'MASURE','EMILE','TECHNICIEN',1200,to_date('17/06/88','dd/MM/yy'),10451.05,null,3);
insert into emp values (1500,'DUPONT','JEAN','DIRECTEUR',1000,to_date('23/10/87','dd/MM/yy'),28434.84,null,5);
insert into emp values (1501,'DUPIRE','PIERRE','ANALYSTE',1500,to_date('24/10/84','dd/MM/yy'),23102.31,null,5);
insert into emp values (1502,'DURAND','BERNARD','PROGRAMMEUR',1500,to_date('30/07/87','dd/MM/yy'),13201.32,null,5);
insert into emp values (1503,'DELNATTE','LUC','PUPITREUR',1500,to_date('15/01/99','dd/MM/yy'),8801.01,null,5);
insert into emp values (1600,'LAVARE','PAUL','DIRECTEUR',1000,to_date('13/12/91','dd/MM/yy'),31238.12,null,6);
insert into emp values (1601,'CARON','ALAIN','COMPTABLE',1600,to_date('16/09/85','dd/MM/yy'),33003.3,null,6);
insert into emp values (1602,'DUBOIS','JULES','VENDEUR',1300,to_date('20/12/90','dd/MM/yy'),9520.95,35535,6);
insert into emp values (1603,'MOREL','ROBERT','COMPTABLE',1600,to_date('18/07/85','dd/MM/yy'),33003.3,null,6);
insert into emp values (1604,'HAVET','ALAIN','VENDEUR',1300,to_date('01/01/91','dd/MM/yy'),9388.94,33415,6);
insert into emp values (1605,'RICHARD','JULES','COMPTABLE',1600,to_date('22/10/85','dd/MM/yy'),33503.35,null,5);
insert into emp values (1615,'DUPREZ','JEAN','BALAYEUR',1000,to_date('22/10/98','dd/MM/yy'),6000.6,null,5);

commit;


insert into serv values (1,'DIRECTION','PARIS');
insert into serv values (2,'LOGISTIQUE','SECLIN');
insert into serv values (3,'VENTES','ROUBAIX');
insert into serv values (4,'FORMATION','VILLENEUVE D''ASCQ');
insert into serv values (5,'INFORMATIQUE','LILLE');
insert into serv values (6,'COMPTABILITE','LILLE');
insert into serv values (7,'TECHNIQUE','ROUBAIX');


commit;

commit;
/* un bloc de commentaire */
-- 1. Afficher la table emp (en requete SQL)
select * from emp;

/*23 : Sélectionner les employés qui ne sont ni directeur, ni technicien et
travaillant dans le service 1.*/
select *
from emp
where emploi not in ('DIRECTEUR','TECHNICIEN')
and noserv=1;

/*24 : Sélectionner les employés qui sont techniciens, comptables ou vendeurs.*/
select *
from emp
where emploi in('TECHNICIEN','COMPTABLE','VENDEUR');
/* 25 : Sélectionner les employés qui ne sont ni technicien, ni comptable, ni vendeur.*/
select *
from emp
where emploi not in('TECHNICIEN','COMPTABLE','VENDEUR');
/* 26 : Sélectionner les directeurs des services 2, 4 et 5.*/
select *
from emp
where emploi='DIRECTEUR'
and noserv in(2,4,5);

/*27 : Sélectionner les subalternes qui ne sont pas dans les services 1, 3, 5.*/
select * 
from emp
where sup is not null
and noserv not in(1,3,5);
/* 28 : Sélectionner les employés qui gagnent entre 20000 et 40000 euros, bornes comprises.*/
select *, sal+coalesce(comm,0) as revenu
from emp
where sal+coalesce(comm,0) BETWEEN 20000 and 40000;
/*29 : Sélectionner les employés qui gagnent moins de 20000 et plus de 40000 euros.*/
select *,sal+coalesce(comm,0) as revenu
from emp
where sal+coalesce(comm,0) not BETWEEN 20000 and 40000;

/* 30 : Sélectionner les employés qui ne sont pas directeur et qui ont été embauchés en 88.*/
select * 
from emp
where emploi<>'DIRECTEUR'
and to_char(embauche,'yy') like '88';

/*ou*/
select * 
from emp
where not emploi='DIRECTEUR'
and embauche between '01/01/1988' and '31/12/1988';


/* 31 : Sélectionner les directeurs des services 2 ,3 , 4, 5 sans le IN.*/
select *
from emp
where emploi='DIRECTEUR'
and noserv between 2 and 5;

/*32 :Sélectionner les employés dont le nom commence par la lettre M.*/
select nom, prenom, emploi, noserv
from emp
where nom like 'M%';
/*33 : Sélectionner les employés dont le nom se termine par T.*/
select nom, prenom, emploi, noserv
from emp
where nom like '%T';
/* 34 : Sélectionner les employés ayant au moins deux E dans leur nom.*/
select nom, prenom, emploi, noserv
from emp
where nom like '%E%E%';

/*35 : Sélectionner les employés ayant exactement un E dans leur nom.*/
select nom, prenom, emploi, noserv
from emp
where nom like '%E%'
except 
select nom, prenom, emploi, noserv
from emp
where nom like '%E%E%';

/*ou*/
select nom, prenom, emploi, noserv
from emp
where nom like '%E%'
and nom not like '%E%E%';

/*36 : Sélectionner les employés ayant au moins un N et un O dans leur nom.*/
select nom, prenom, emploi, noserv
from emp
where nom like '%N%'
and nom like '%O%';

/* ou */
select *
from emp
where nom like '%O%N%'
or nom like '%N%O%';

/*37 : Sélectionner les employés dont le nom s'écrit avec 6 caractéres et qui se termine par N.*/
select nom, prenom, emploi, noserv
from emp
where nom like '%N'
and nom like '______';
/*ou*/
select nom, prenom, emploi, noserv
from emp
where nom like '_____N';
/*38 : Sélectionner les employés dont la troisiéme lettre du nom est un R.*/
select nom, prenom, emploi, noserv
from emp
where nom like '__R%';

/* 39 : Sélectionner les employés dont le nom ne s'écrit pas avec 5 caractéres.*/
select nom, prenom, emploi, noserv
from emp
where nom not like '_____';

/*ou*/
select *
from emp
where length(nom) <> 5;

/*51 : Sélectionner les nom et date d'embauche des employés suivi des nom et
date d'embauche de leur supérieur pour les employés plus ancien que leur
supérieur, dans l'ordre nom employés, noms supérieurs.*/

select employe.nom, employe.embauche, superieur.nom, superieur.embauche
from emp as employe, emp as superieur
where employe.sup= superieur.noemp
and employe.embauche<superieur.embauche
order by employe.nom, superieur.nom;


