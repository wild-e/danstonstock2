
       program-id. Program1 as "danstonstock.danstonstock".

       data division.
       working-storage section.

      ************************************************************
      * Connexion SQL
      ************************************************************
       77 CNXDB
           string.
           exec sql
               include sqlca
           end-exec.
           exec sql
               include sqlda
           end-exec.

      ************************************************************
      * Variables
      ************************************************************
              
       77 ChoixMenuPrincipal PIC X.
       77 ChoixMenuArticle PIC X.

       01 DateSysteme.
         10 Jour PIC 99.
         10 Mois PIC 99.
         10 Annee PIC 99.

       01 Article.
         10 code_article sql char (10).
         10 id_fournisseur pic x(9).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(10).
         10 quantite_min pic 9(10).
         10 date_crea sql date.
         10 date_modif sql date.

       77 NoLigneArticle pic 99.
       77 Choix pic x.
       77 Response pic x.
       77 EOF pic 9.
       77 EOA pic 9.

      ************************************************************
      * Paramétrage couleur écran
      ************************************************************
       77 CouleurFondEcran PIC 99 VALUE 7.
       77 CouleurCaractere PIC 99 VALUE 0.

      ************************************************************
      * Ecrans de l'application
      ************************************************************
       SCREEN SECTION.
       01 ecran-menuPrincipal background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 Blank Screen.
         10 line 3 col 32 VALUE "Menu principal".
         10 line 5 col 5 from Jour of DateSysteme.
         10 line 5 col 8 value "/".
         10 line 5 col 9 from Mois of DateSysteme.
         10 line 5 col 12 value "/".
         10 line 5 col 14 from Annee of DateSysteme.
         10 line 5 col 68 VALUE "Choix:".
         10 line 11 col 15 VALUE "1. Gestions des articles".
         10 line 12 col 15 VALUE "2. Gestion des fournisseurs".
         10 line 13 col 15 VALUE "3. Reception commande".
         10 line 17 col 15 VALUE "0. Quitter".

      ********** MENU ARTICLE ******

       01 ecran-MenuArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 Blank Screen.
         10 line 3 col 32 value " Gestion des articles ".
         10 line 5 col 5 from Jour of DateSysteme.
         10 line 5 col 8 value "/".
         10 line 5 col 9 from Mois of DateSysteme.
         10 line 5 col 12 value "/".
         10 line 5 col 14 from Annee of DateSysteme.
         10 line 5 col 68 value "Choix :".
         10 line 5 col 77 pic 9 from Choix.
         10 line 11 col 15 value "1. Liste des articles".
         10 line 12 col 15 value "2. Ajouter un article".
         10 line 13 col 15 value "3. Modifier un article".
         10 line 14 col 15 value "4. Supprimer un article".
         10 line 15 col 15 value "5. Consulter - Stock".
         10 line 17 col 15 value "0. Retour au menu principal".

      ********** LISTE ARTICLE *****

       01 ListeArticle-E background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "LISTE DES ARTICLES".
         10 line 5 col 1 reverse-video pic X(80) VALUE " Code Art     Libelle              Stock   Stock Min   Date".

       01 LigneArticle.
         05 line NoLigneArticle Col 3 from code_article of Article.
         05 line NoLigneArticle Col 15 pic X(20) from Libelle of Article.
         05 line NoLigneArticle Col 36 pic 9(5) from quantite_stock of Article.
         05 line NoLigneArticle Col 44 pic 9(5) from quantite_min of Article.
         05 line NoLigneArticle Col 57 pic X(10) from date_crea of Article.

      ********** AJOUT ARTICLE *****

       01 AjoutArticle-E background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "AJOUTER UN ARTICLE".
           10 line 5 col 68 value "Choix :".
           10 line 5 col 77 pic 9 from Choix.
           10 line 11 col 15 value "Libelle : ".
           10 line 12 col 15 value "Stock : ".
           10 line 13 col 15 value "Stock minimal : ".
           10 line 14 col 15 value "4. Supprimer un article".
           10 line 15 col 15 value "5. Consulter - Stock".
           10 line 17 col 15 value "0. Retour au menu principal".

       procedure division.

      *************************************************************
      *************************************************************
      * Gestion du menu principal
      *************************************************************
      *************************************************************
           perform MenuPrincipal-init.
           perform MenuPrincipal-trt until ChoixMenuPrincipal equal 0.
           perform MenuPrincipal-fin.

       MenuPrincipal-init.
           move 1 to ChoixMenuPrincipal.
           accept DateSysteme from date yyyymmdd.
      ******** Connection BDD
           move
             "Trusted_Connection=yes;Database=Papillon;server=DESKTOP-16DLBER\SQLEXPRESS;factory=system.Data.SqlClient;"
             to CNXDB.
           exec sql
             connect using :CNXDB
           end-exec.

           if (sqlcode not equal 0)
             then
               display "Erreur connexion base de donnée" line 4 col 15
               stop run
           end-if.

           exec sql
             set autocommit on
           end-exec.
      ********

       MenuPrincipal-trt.
           move 0 to ChoixMenuPrincipal.
           display ecran-menuPrincipal.
           accept ChoixMenuPrincipal line 5 col 75.
           evaluate ChoixMenuPrincipal
               when 1
                   perform MenuArticle
           end-evaluate.

       MenuPrincipal-fin.
           stop run.

      *************************************************************
      *************************************************************
      * Gestion du menu article
      *************************************************************
      *************************************************************
       MenuArticle.
           perform MenuArticle-init.
           perform MenuArticle-trt until ChoixMenuArticle = 0.
           perform MenuArticle-fin.

       MenuArticle-init.
           move 1 to ChoixMenuArticle.

       MenuArticle-trt.
           move 0 to ChoixMenuArticle.
           display ecran-MenuArticle.
           accept ChoixMenuArticle line 5 col 77.

           evaluate ChoixMenuArticle
               when 1
                   perform ListeArticle
               when 2
                   perform AjoutArticle

           end-evaluate.
       MenuArticle-fin.
           stop run.

       ListeArticle.
           perform ListeArticle-init.
           perform ListeArticle-trt until EOF = 1.
           perform ListeArticle-fin.

       ListeArticle-init.
           move 0 to EOF.

      * Déclaration du curseur
           exec sql
               declare C-ListeArticle cursor for
                   select code_article,id_fournisseur, libelle, quantite_stock, quantite_min, date_crea, date_modif from Article
                          Order by libelle
           end-exec.

      * Ouverture du curseur
           exec sql
               open C-ListeArticle
           End-exec.

      * Initialisation de la pagination
           display ListeArticle-E.
           move 5 to NoligneArticle.

       ListeArticle-trt.
           exec sql
               fetch C-ListeArticle into :Article.code_article,
                                         :Article.id_fournisseur,
                                         :Article.libelle,
                                         :Article.quantite_stock,
                                         :Article.quantite_min,
                                         :Article.date_crea,
                                         :Article.date_modif
           end-exec.
           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOF
               display " Fin de la liste. Tapez entrer " line 1 col 1
               accept Response

           else
               perform AffichageListeArticle
           end-if.

       ListeArticle-fin.
           exec sql
               close C-ListeArticle
           end-exec.

       AffichageListeArticle.
           Add 1 to NoLigneArticle.
           Display LigneArticle.

           if NoLigneArticle equal 23
               Display " Page [S]uivante - [m]enu : S" Line 1 Col 1 with no advancing
               Move "S" to response
               accept response line 1 col 29

               if response = "M" or response = "m"
                   move 1 to EOF
               else
                   move 5 to NoLigneArticle
               end-if
           end-if.

       AjoutArticle.
           perform AjoutArticle-init.
           perform AjoutArticle-trt until EOA = 1.
           perform AjoutArticle-fin.

       AjoutArticle-init.
           continue.
       AjoutArticle-trt.
           continue.
       AjoutArticle-fin.
           continue.

       end program Program1.