
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
       77 ChoixFournisseur PIC X(30) value "Afficher liste fournisseur".
       77 ChoixEcranFournisseur PIC 9 value 0.
       77 ChoixAjoutArticle pic x.
       77 ChoixSupprimerArticle pic x.

       01 DateSysteme.
         10 Annee PIC 9999.
         10 Mois PIC 99.
         10 Jour PIC 99.

       01 Article.
         10 code_article pic 9(5).
         10 id_fournisseur pic 9(9).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 date_crea sql date.
         10 date_modif sql date.

       01 Fournisseur.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 siret sql char(14).
         10 adresse sql char-varying (50).
         10 cp sql char(5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).
         10 date_crea sql date.
         10 date_modif sql date.

       01 AjoutArticleInput.
         10 id_fournisseur pic 9(5).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).

       01 ModifArticleInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).

       01 SuppArticleInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).

       01 ArticleRecupere.
         10 code_article pic 9(5).
         10 id_fournisseur pic 9(5).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 date_crea sql date.
         10 date_modif sql date.
         10 raison_sociale sql char-varying (50).
         10 ReqSql1 pic x(5).
         10 ReqSql2 pic x(2) value "%'".
         10 ReqSql3 pic x(7).

       01 EcranArticleInput.
           10 Ecran-QuantiteStock pic X(5).
           10 Ecran-QuantiteMin pic X(5).
           10 FournisseurChoisi pic X(50).

       77 LibelleArticleRecherche pic X(50).
       77 VerifFournisseurPresent pic 9.
       77 NoLigneArticle pic 99.
       77 NoLigneFournisseur pic 99.
       77 NoLigneChoixFournisseur pic 99.
       77 Response pic x.
       77 ResponseChoixFournisseur pic x.
       77 Pause pic x.
       77 EOF pic 9.
       77 EOCF pic 9.
       77 EOA pic 9.
       77 EOM pic 9.
       77 EOSUP pic 9.
       77 essai pic x(50).

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
         10 line 5 col 77 pic 9 from ChoixMenuArticle.
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
         10 line 5 col 1 reverse-video pic X(80) VALUE " Code Art     Libelle              Stock   Stock Min   Création         Modifier".

       01 LigneArticle.
         05 line NoLigneArticle Col 3 from code_article of Article.
         05 line NoLigneArticle Col 15 pic X(20) from Libelle of Article.
         05 line NoLigneArticle Col 36 pic 9(5) from quantite_stock of Article.
         05 line NoLigneArticle Col 44 pic 9(5) from quantite_min of Article.
         05 line NoLigneArticle Col 57 pic X(10) from date_crea of Article.
         05 line NoLigneArticle Col 70 pic X(10) from date_modif of Article.

      ********** AJOUT ARTICLE *****

       01 ecran-AjoutArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "AJOUTER UN ARTICLE".
           10 line 6 col 15 value "Libelle : ".
           10 line 6 col 25 using libelle of AjoutArticleInput.
           10 line 7 col 15 value "Stock : ".
           10 line 7 col 23 using Ecran-QuantiteStock.
           10 line 8 col 15 value "Stock minimal : ".
           10 line 8 col 31 using Ecran-QuantiteMin.
           10 line 9 col 15 value "Fournisseur : ".
           10 line 9 col 29 using ChoixFournisseur.

       01 ChoixAjouter background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 20 value "[A] jouter - [R] evenir : ".

       01 ArticleAjouter background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 1 pic x(80) value "                      Article Ajoute".

       01 ecran-ChoixFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "CHOIX DU FOURNISSEUR".
           10 line 5 col 68 value "Choix :".
           10 line 5 col 77 pic 9 from ChoixEcranFournisseur.
           10 line 7 col 1 reverse-video pic X(80) VALUE " Ref     Nom".

       01 LigneChoixFournisseur.
         05 line NoLigneChoixFournisseur Col 3 from id_fournisseur of Fournisseur.
         05 line NoLigneChoixFournisseur Col 15 pic X(20) from raison_sociale of Fournisseur.
      *************************************************************
      *   MODIFICATION ARTICLE
      *************************************************************
       
       01 ecran-ModifArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "MODIFIER UN ARTICLE".
         10 line 6 col 15 value "Libelle : ".
         10 line 6 col 25 using libelle of ModifArticleInput.
         10 line 7 col 15 value "Stock : ".
         10 line 7 col 23 using quantite_stock of ModifArticleInput.
         10 line 8 col 15 value "Stock minimal : ".
         10 line 8 col 31 using quantite_min of ModifArticleInput.
         10 line 9 col 15 value "Fournisseur : ".
         10 line 9 col 29 using raison_sociale of ModifArticleInput.

      *************************************************************
      *   SUPPRESSION ARTICLE
      *************************************************************
       
       01 ecran-SuppArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "SUPPRIMER UN ARTICLE".
         10 line 6 col 15 value "Libelle : ".
         10 line 6 col 25 using libelle of SuppArticleInput.
         10 line 7 col 15 value "Stock : ".
         10 line 7 col 23 using quantite_stock of SuppArticleInput.
         10 line 8 col 15 value "Stock minimal : ".
         10 line 8 col 31 using quantite_min of SuppArticleInput.
         10 line 9 col 15 value "Fournisseur : ".
         10 line 9 col 29 using raison_sociale of SuppArticleInput.

       01 Ligne-DemandeSuppression background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Voulez vous supprimer cet article ? [O]ui / [N]on : ".

       01 Ligne-AlerteStock background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Le stock doit etre a zero pour supprimer un article.".

       01 Ligne-ArticleSupprime background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 15 value "L article a bien ete supprime.".


       01 EffaceLigne5 background-color is CouleurFondEcran.
         10 line 5 col 1 pic X(80).

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
             "Trusted_Connection=yes;Database=danstonstock2;server=DESKTOP-16DLBER\SQLEXPRESS;factory=system.Data.SqlClient;"
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
               when 3
                   perform ModifArticle
               when 4
                   perform SuppArticle

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
           move 0 to EOA.
       AjoutArticle-trt.
           move 1 to EOA.
           display ecran-AjoutArticle.
           if ChoixEcranFournisseur not equal 0
               display ChoixAjouter
               move ChoixEcranFournisseur to id_fournisseur of AjoutArticleInput
               move "A" to ChoixAjoutArticle
               accept ChoixAjoutArticle line 5 col 46

               if ChoixAjoutArticle = "a" or ChoixAjoutArticle = "A"
                   exec sql
                      INSERT INTO Article (id_fournisseur, libelle, quantite_stock, quantite_min)
                      VALUES (:AjoutArticleInput.id_fournisseur, :AjoutArticleInput.libelle, :AjoutArticleInput.quantite_stock, :AjoutArticleInput.quantite_min)
                   end-exec
               end-if
               initialize EcranArticleInput
               display ArticleAjouter
               accept Pause
           else
               accept libelle of AjoutArticleInput line 6 col 25
               accept quantite_stock of AjoutArticleInput line 7 col 23
               accept quantite_min of AjoutArticleInput line 8 col 31
           end-if.
           move quantite_stock of AjoutArticleInput to Ecran-QuantiteStock.
           move quantite_min of AjoutArticleInput to Ecran-QuantiteMin.
           if ChoixFournisseur = "Afficher liste fournisseur"
               move 0 to EOA
               perform ChoixDuFournisseur
               exec sql
                 SELECT raison_sociale INTO :FournisseurChoisi
                 FROM Fournisseur
                 WHERE id_fournisseur = :ChoixEcranFournisseur
               end-exec
               move FournisseurChoisi to ChoixFournisseur
               
           end-if.
       AjoutArticle-fin.
           continue.

       ModifArticle.
           perform ModifArticle-init
           perform ModifArticle-trt until EOM = 1.
           perform ModifArticle-fin.

       ModifArticle-init.
           move 0 to EOM.
           exec sql
           declare C-ModifArticle cursor for
               select code_article,id_fournisseur, libelle, quantite_stock, quantite_min, date_crea, date_modif, raison_sociale from ArticleFournisseur
                      Order by libelle
           end-exec.

           exec sql
               open C-ModifArticle
           End-exec.
       ModifArticle-trt.
           move 1 to EOM.
           initialize ArticleRecupere.
           initialize ModifArticleInput.
           display ecran-ModifArticle.
           accept libelle of ModifArticleInput line 6 col 25.
      *    string "'" libelle of ModifArticleInput into ReqSql1.
      *    string ReqSql1 ReqSql2 into ReqSql3.

           move libelle of ModifArticleInput to LibelleArticleRecherche.
           perform RechercheArticle.
           initialize LibelleArticleRecherche.
          
           move libelle of ArticleRecupere to libelle of ModifArticleInput.
           move quantite_stock of ArticleRecupere to quantite_stock of ModifArticleInput.
           move quantite_min of ArticleRecupere to quantite_min of ModifArticleInput.
           move raison_sociale of ArticleRecupere to raison_sociale of ModifArticleInput.

           display ecran-ModifArticle.

           accept libelle of ModifArticleInput line 6 col 25 with update.
           accept quantite_stock of ModifArticleInput line 7 col 23.
           accept quantite_min of ModifArticleInput line 8 col 31.

           accept raison_sociale of ModifArticleInput line 9 col 29.

           if raison_sociale of ModifArticleInput <> raison_sociale of ArticleRecupere
               exec sql
                 SELECT COUNT(*) INTO :VerifFournisseurPresent
                 FROM Fournisseur
                 WHERE raison_social = :ModifArticleInput.raison_sociale
               end-exec
               display VerifFournisseurPresent line 6 col 25 reverse-video
               accept Pause
           end-if.
               exec sql
                   UPDATE article
                   SET libelle = :ModifArticleInput.libelle,
                       id_fournisseur = :ArticleRecupere.id_fournisseur,
                       quantite_stock = :ModifArticleInput.quantite_stock,
                       quantite_min = :ModifArticleInput.quantite_min,
                       date_modif = getdate()
                   WHERE
                       code_article = :ArticleRecupere.code_article
               end-exec.
       ModifArticle-fin.
           initialize ArticleRecupere.
           initialize ModifArticleInput.

       SuppArticle.
           perform SuppArticle-init
           perform SuppArticle-trt until EOSUP = 1.
           perform SuppArticle-fin.
       SuppArticle-init.
           move 0 to EOSUP.
       SuppArticle-trt.
           initialize ArticleRecupere.
           initialize SuppArticleInput.
           move 1 to EOSUP.
           display ecran-SuppArticle.
           accept libelle of SuppArticleInput line 6 col 25.

           move libelle of SuppArticleInput to LibelleArticleRecherche.
           perform RechercheArticle.
           initialize LibelleArticleRecherche.

           move libelle of ArticleRecupere to libelle of SuppArticleInput.
           move quantite_stock of ArticleRecupere to quantite_stock of SuppArticleInput.
           move quantite_min of ArticleRecupere to quantite_min of SuppArticleInput.
           move raison_sociale of ArticleRecupere to raison_sociale of SuppArticleInput.

           display ecran-SuppArticle.

           move "O" to ChoixSupprimerArticle.
           display Ligne-DemandeSuppression.
           accept ChoixSupprimerArticle line 5 col 63.

           if ChoixSupprimerArticle = "O" or ChoixSupprimerArticle = "o"
               if quantite_stock of ArticleRecupere equal 0
                   exec sql
                     DELETE FROM Article
                     WHERE code_article = :ArticleRecupere.code_article
                   end-exec
                   initialize ArticleRecupere
                   initialize SuppArticleInput
                   display ecran-SuppArticle
                   display EffaceLigne5
                   display Ligne-ArticleSupprime
                   accept Pause line 1 col 1
               else
                   display Ligne-AlerteStock
                   accept Pause line 1 col 1
               end-if
           else
               move 0 to EOSUP
           end-if.


       SuppArticle-fin.
           initialize ArticleRecupere.
       ChoixDuFournisseur.
           perform ChoixFournisseur-init.
           perform ChoixFournisseur-trt until EOCF = 1.
           perform ChoixFournisseur-fin.
       ChoixFournisseur-init.
           move 0 to EOCF.
           exec sql
               declare C-ListeFournisseur cursor for
                   select id_fournisseur, raison_sociale from Fournisseur
                          Order by id_fournisseur
           end-exec.
           exec sql
             open C-ListeFournisseur
           end-exec.
           display ecran-ChoixFournisseur.
           move 7 to NoLigneChoixFournisseur.

       ChoixFournisseur-trt.
           exec sql
              fetch C-ListeFournisseur into :Fournisseur.id_fournisseur, :Fournisseur.raison_sociale
          end-exec.
           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOCF
               display " Fin de la liste. Tapez entrer " line 1 col 1

              accept ChoixEcranFournisseur line 5 col 77
           else
               perform AffichageChoixFournisseur
           end-if.

       ChoixFournisseur-fin.
           exec sql
               close C-ListeFournisseur
           end-exec.
       AffichageChoixFournisseur.
           Add 1 to NoLigneChoixFournisseur.

           Display LigneChoixFournisseur.

           if NoLigneChoixFournisseur equal 23
               Display " Page [S]uivante - [m]enu : S" Line 1 Col 1 with no advancing
               Move "S" to responseChoixFournisseur
               accept responseChoixFournisseur line 1 col 29

               if responseChoixFournisseur = "M" or responseChoixFournisseur = "m"
                   move 1 to EOCF
                   
               else
                   move 7 to NoLigneChoixFournisseur
               end-if
           end-if.
      **********************************************************
      *   Recherche un article dans la BDD par son libellé     *
      *                                                        *
      *   Renseigner LibelleArticleRecherche avec le libellé   *
      **********************************************************
       RechercheArticle.
           exec sql
              SELECT code_article,id_fournisseur, libelle, quantite_stock, quantite_min, date_crea, date_modif, raison_sociale
                           INTO :ArticleRecupere.code_article, :ArticleRecupere.id_fournisseur, :ArticleRecupere.libelle, :ArticleRecupere.quantite_stock,
                                :ArticleRecupere.quantite_min, :ArticleRecupere.date_crea, :ArticleRecupere.date_modif, :ArticleRecupere.raison_sociale
              FROM ArticleFournisseur
              WHERE libelle = :LibelleArticleRecherche
          end-exec.

       end program Program1.