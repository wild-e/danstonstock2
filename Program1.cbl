
       program-id. Program1 as "danstonstock.danstonstock".

       environment division.
       input-output section.
       file-control.
           select f-fichierCommande1 assign to "E:\Emma\DUGS\fichierCommande1.csv"
           organization is line sequential.
           select f-fichierCommande2 assign to "E:\Emma\DUGS\fichierCommande2.csv"
           organization is line sequential.
           select f-fichierCommande3 assign to "E:\Emma\DUGS\fichierCommande3.csv"
           organization is line sequential.
           select f-fichierCommande4 assign to "E:\Emma\DUGS\fichierCommande4.csv"
           organization is line sequential.

           select f-fichierEtatStock assign to "E:\Emma\DUGS\fichierEtatStock.txt"
           organization is line sequential.
           select f-fichierCommandeStockBas assign to "E:\Emma\DUGS\fichierCommandeStockBas.txt"
           organization is line sequential.



       data division.

       file section.
       fd f-fichierCommande1 record varying from 0 to 255.
       01 e-fichierCommande1 pic x(255).
       fd f-fichierCommande2 record varying from 0 to 255.
       01 e-fichierCommande2 pic x(255).
       fd f-fichierCommande3 record varying from 0 to 255.
       01 e-fichierCommande3 pic x(255).
       fd f-fichierCommande4 record varying from 0 to 255.
       01 e-fichierCommande4 pic x(255).

       fd f-fichierEtatStock record varying from 0 to 255.
       01 e-fichierEtatStock pic x(255).
       fd f-fichierCommandeStockBas record varying from 0 to 255.
       01 e-fichierCommandeStockBas pic x(255).


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
       77 ChoixMenuCommande PIC X.
       77 ChoixNoCommande pic X.
       77 ChoixFournisseur PIC X(30) value "Afficher liste fournisseur".
       77 ChoixEcranFournisseur PIC 9 value 0.
       77 ChoixAjoutArticle pic x.
       77 ChoixSupprimerArticle pic x.
       77 ChoixEcranArticle PIC 99 value 0.
       77 ChoixMenuFournisseur PIC X.

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

       01 Commande.
           10 code_fournisseur sql char (10).
           10 no_commande sql char (10).
           10 date_commande pic x(8).
           10 code_article pic 9(10).
           10 quantite pic 9(10).

       77 CodeFournisseur pic x(9).
       77 QuantiteTotalCommande pic 9(6).
       77 NoLigneCommande pic 9(10).
       77 TotalLigneCommande pic 9(10).
       77 Choix pic x.
       
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

       01 ArticleDateCreationAffichage.
         10 Annee pic 9999.
         10 filler value "/".
         10 Mois pic 99.
         10 filler value "/".
         10 Jour pic 99.

       01 ArticleDateModifAffichage.
         10 Annee pic 9999.
         10 filler value "/".
         10 Mois pic 99.
         10 filler value "/".
         10 Jour pic 99.
       
       01 FournisseurDateCreationAffichage.
         10 Annee pic 9999.
         10 filler value "/".
         10 Mois pic 99.
         10 filler value "/".
         10 Jour pic 99.

       01 FournisseurDateModifAffichage.
         10 Annee pic 9999.
         10 filler value "/".
         10 Mois pic 99.
         10 filler value "/".
         10 Jour pic 99.

       01 EcranArticleInput.
           10 Ecran-QuantiteStock pic 9(5).
           10 Ecran-QuantiteMin pic 9(5).
           10 FournisseurChoisi pic X(50).

       77 LibelleArticleRecherche pic X(50).
       77 IdArticleRecherche pic 99.

       77 VerifArticlePresent pic 9.
       77 VerifFournisseurPresent pic 9.

       77 NoLigneArticle pic 99.
       77 NoLigneChoixArticle pic 99.
       77 NoLigneChoixFournisseur pic 99.

       77 NoLigneFournisseur pic 99.

       77 ReponseListeArticle pic x.
       77 ReponseListeFournisseur pic x.
       77 ResponseChoixArticle pic x.
       77 ResponseChoixFournisseur pic x.
       77 Pause pic x.

       77 EOF pic 9.
       77 EOLF pic 9.
       77 EOCA pic 9.
       77 EOR pic 9.
       77 EOA pic 9.
       77 EOCS pic 9.
       77 tally-counter pic 9.

       77 MessageErreurCommande pic x(80).
       77 EOCF pic 9.
       77 EOM pic 9.
       77 EOSUP pic 9.
       77 noPageEtatStock pic 999.
       77 nbLigneEtatStock pic 99.
       77 MaxLigneEtatStock PIC 99 VALUE 33.
       77 noPageReapprovisionnement pic 999.
       77 nbLigneReapprovisionnement pic 99.
       77 MaxLigneReapprovisionnement PIC 99 VALUE 33.


      *    Variables génération état de stock

       01 CorpsFichierEtatStock.
         10 FILLER PIC X.
         10 code_article PIC 9(10).
         10 FILLER PIC X(8).
         10 libelle PIC X(50).
         10 FILLER PIC X(5).
         10 quantite_stock PIC 9(5).
         10 FILLER PIC X(15).
         10 quantite_min PIC 9(5).

       01 EnteteFichierEtatStock.
         05 ligne1.
           10 FILLER PIC X(48).
           10 FILLER PIC X(15) VALUE "Etat des stocks".
         05 Ligne2 PIC X.
         05 ligne3.
           10 FILLER PIC X.
           10 FILLER PIC X(13) VALUE "Commande :".
           10 FILLER PIC X.
           10 no_commande PIC x(10).
           10 FILLER PIC X(65).
           10 FILLER PIC X(6) VALUE "Date :".
           10 FILLER PIC X.
           10 jour PIC X(2).
           10 FILLER PIC X VALUE "/".
           10 mois PIC X(2).
           10 FILLER PIC X VALUE "/".
           10 annee PIC X(4).
         05 Ligne4 PIC X(111) VALUE ALL "-".
         05 Ligne5.
           10 FILLER PIC X.
           10 FILLER PIC X(12) VALUE "Code article".
           10 FILLER PIC X(4).
           10 FILLER PIC X(7) VALUE "Libelle".
           10 FILLER PIC X(45).
           10 FILLER PIC X(14) VALUE "Quantite stock".
           10 FILLER PIC X(10).
           10 FILLER PIC X(14) VALUE "Quantite min".
         05 Ligne6 PIC X(111) VALUE ALL "-".

       01 PiedDePageFichierEtatStock.
         10 FILLER PIC X(4) VALUE ALL "-".
         10 FILLER PIC X.
         10 FILLER PIC X(4) VALUE "Page".
         10 FILLER PIC X.
         10 NbPage PIC Z9.
         10 FILLER PIC X.
         10 FILLER PIC X(98) VALUE ALL "-".

       01 FinPiedDePageFichierEtatStock.
         10 FILLER PIC X(4) VALUE ALL "-".
         10 FILLER PIC X.
         10 FILLER PIC X(14) VALUE "Fin traitement".
         10 FILLER PIC X.
         10 FILLER PIC X(91) VALUE ALL "-".

      *  Variable génération commande réapprovisionnement

       01 EnteteFichierReapprovisionnementStock.
         05 ligne1.
           10 FILLER PIC X.
           10 raison_sociale PIC X(50).
         05 ligne2.
           10 FILLER PIC X.
           10 adresse PIC X(80).
         05 ligne3.
           10 FILLER PIC X.
           10 cp PIC X(5).
           10 FILLER PIC X.
           10 ville PIC X(50).
         05 ligne4.
           10 FILLER PIC X.
           10 FILLER PIC X(19) VALUE "Réapprovisionnement".
         05 Ligne5 PIC X.
         05 Ligne6.
           10 filler pic x(95).
           10 jour PIC X(2).
           10 FILLER PIC X VALUE "/".
           10 mois PIC X(2).
           10 FILLER PIC X VALUE "/".
           10 annee PIC X(4).
         05 Ligne7 PIC X.
         05 Ligne8 PIC X(111) VALUE ALL "-".
         05 Ligne9.
           10 FILLER PIC X.
           10 FILLER PIC X(9) VALUE "Référence".
           10 FILLER PIC X(4).
           10 FILLER PIC X(11) VALUE "Désignation".
           10 FILLER PIC X(45).
           10 FILLER PIC X(9) VALUE "Quantités".
         05 Ligne10 PIC X(111) VALUE ALL "-".

       01 CorpsFichierReapprovisionnementStock.
         10 FILLER PIC X.
         10 code_article PIC 9(10).
         10 FILLER PIC X(8).
         10 libelle PIC X(50).
         10 FILLER PIC X(5).
         10 quantiteAReapprovisionner PIC 9(5).

       01 PiedDePageFichierReapprovisionnementStock.
         10 FILLER PIC X(4) VALUE ALL "-".
         10 FILLER PIC X.
         10 FILLER PIC X(4) VALUE "Page".
         10 FILLER PIC X.
         10 NbPage PIC Z9.
         10 FILLER PIC X.
         10 FILLER PIC X(98) VALUE ALL "-".

       01 FinPiedDePageFichierReapprovisionnementStock.
         10 FILLER PIC X(4) VALUE ALL "-".
         10 FILLER PIC X.
         10 FILLER PIC X(14) VALUE "Fin traitement".
         10 FILLER PIC X.
         10 FILLER PIC X(91) VALUE ALL "-".


      ************************************************************
      * Param�trage couleur �cran
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
         10 line 5 col 68 VALUE "Choix: ".
         10 line 5 col 77 pic 9 from ChoixMenuArticle.
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

      ********** MENU FOURNISSEUR ******

       01 ecran-MenuFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 Blank Screen.
         10 line 3 col 32 value " Gestion des Fournisseurs ".
         10 line 5 col 5 from Jour of DateSysteme.
         10 line 5 col 8 value "/".
         10 line 5 col 9 from Mois of DateSysteme.
         10 line 5 col 12 value "/".
         10 line 5 col 14 from Annee of DateSysteme.
         10 line 5 col 68 value "Choix :".
         10 line 5 col 77 pic 9 from ChoixMenuArticle.
         10 line 11 col 15 value "1. Liste des fournisseurs".
         10 line 12 col 15 value "2. Ajouter un fournisseur".
         10 line 13 col 15 value "3. Modifier un fournisseur".
         10 line 14 col 15 value "4. Supprimer un fournisseur".
         10 line 16 col 15 value "0. Retour au menu principal".

      ********** MENU commande ******

       01 ecran-MenuCommande background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 Blank Screen.
         10 line 3 col 32 value " Ajout des commandes ".
         10 line 5 col 68 value "Choix: ".
         10 line 5 col 77 pic 9 from Choix.
         10 line 12 col 15 value "1. Commande A - total article non conforme".
         10 line 13 col 15 value "2. Commande B - Mise en forme non conforme".
         10 line 14 col 15 value "3. Commande C - fichier correct".
         10 line 15 col 15 value "4. Commande D - fournisseur inconnu".
         10 line 17 col 15 VALUE "0. Quitter".

       01 ligne-MenuCommandeErreur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 6 col 7 VALUE "Le programme s'est arrete sans modifier la base de donnee car:" reverse-video.
         10 line 7 col 7 pic x(80) from MessageErreurCommande.
         10 line 17 col 15 value "          ".

       01 ligne-MenuCommandeSucces background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 6 col 7 VALUE "Commande ajoutee avec succes" reverse-video.
         10 line 17 col 15 value "          ".


      ********** LISTE ARTICLE *****

       01 ListeArticle-E background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "LISTE DES ARTICLES".
         10 line 5 col 1 reverse-video pic X(80) VALUE " Code Art     Libelle              Stock   Stock Min   Creation         Modifier".

       01 LigneArticle.
         05 line NoLigneArticle Col 3 from code_article of Article.
         05 line NoLigneArticle Col 15 pic X(20) from Libelle of Article.
         05 line NoLigneArticle Col 36 pic 9(5) from quantite_stock of Article.
         05 line NoLigneArticle Col 44 pic 9(5) from quantite_min of Article.
         05 line NoLigneArticle Col 57 pic XX from Jour of ArticleDateCreationAffichage.
         05 line NoLigneArticle Col 59 pic X value "/".
         05 line NoLigneArticle Col 60 pic XX from Mois of ArticleDateCreationAffichage.
         05 line NoLigneArticle Col 62 pic X value "/".
         05 line NoLigneArticle Col 63 pic XXXX from Annee of ArticleDateCreationAffichage.
         05 line NoLigneArticle Col 70 pic XX from Jour of ArticleDateModifAffichage.
         05 line NoLigneArticle Col 72 pic X value "/".
         05 line NoLigneArticle Col 73 pic XX from Mois of ArticleDateModifAffichage.
         05 line NoLigneArticle Col 75 pic X value "/".
         05 line NoLigneArticle Col 76 pic XXXX from Annee of ArticleDateModifAffichage.

      ********** LISTE FOURNISSEUR ********

       01 ListeFournisseur-E background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "LISTE DES FOURNISSEURS".
         10 line 5 col 1 reverse-video pic X(13) value " Ref".
         10 line 5 col 14 reverse-video pic X(21) value "Raison Sociale".
         10 line 5 col 35 reverse-video pic X(20) value " Ville".
         10 line 5 col 55 reverse-video pic X(15) value "Ajoute le".
         10 line 5 col 70 reverse-video pic X(10) value "Modifie le".

       01 LigneFournisseur.
         05 line NoLigneFournisseur Col 1  pic ZZZ99 from id_fournisseur of Fournisseur.
         05 line NoLigneFournisseur Col 14 pic X(20) from raison_sociale of Fournisseur.
         05 line NoLigneFournisseur Col 36 pic X(20) from ville of Fournisseur.
         05 line NoLigneFournisseur Col 55 pic XX from Jour of FournisseurDateCreationAffichage.
         05 line NoLigneFournisseur Col 57 pic X value "/".
         05 line NoLigneFournisseur Col 58 pic XX from Mois of FournisseurDateCreationAffichage.
         05 line NoLigneFournisseur Col 60 pic X value "/".
         05 line NoLigneFournisseur Col 61 pic XXXX from Annee of FournisseurDateCreationAffichage.
         05 line NoLigneFournisseur Col 68 pic XX from Jour of FournisseurDateModifAffichage.
         05 line NoLigneFournisseur Col 70 pic X value "/".
         05 line NoLigneFournisseur Col 71 pic XX from Mois of FournisseurDateModifAffichage.
         05 line NoLigneFournisseur Col 73 pic X value "/".
         05 line NoLigneFournisseur Col 74 pic XXXX from Annee of FournisseurDateModifAffichage.

      ********** AJOUT ARTICLE *****

       01 ecran-AjoutArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "AJOUTER UN ARTICLE".
           10 line 6 col 15 value "Libelle : ".
           10 line 6 col 25 using libelle of AjoutArticleInput.
           10 line 7 col 15 value "Stock : ".
           10 line 7 col 23 pic ZZZ99 using Ecran-QuantiteStock blank when zero.
           10 line 8 col 15 value "Stock minimal : ".
           10 line 8 col 31 pic ZZZ99 using Ecran-QuantiteMin blank when zero.
           10 line 9 col 15 value "Fournisseur : ".
           10 line 9 col 29 using ChoixFournisseur lowlight just right.

       01 ChoixAjouter background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 20 value "[A] jouter - [R] evenir : ".

       01 ArticleAjouter background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 1 pic x(80) value "                      Article Ajoute" blink.

       01 ecran-ChoixFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "CHOIX DU FOURNISSEUR".
           10 line 5 col 68 value "Choix :".
           10 line 5 col 77 pic 9 from ChoixEcranFournisseur.
           10 line 7 col 1 reverse-video pic X(80) VALUE " Ref     Nom".

       01 ecran-ChoixArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "CHOIX DE L ARTICLE".
           10 line 5 col 68 value "Choix :".
           10 line 5 col 77 pic 9 from ChoixEcranArticle.
           10 line 7 col 1 reverse-video pic X(80) VALUE " Ref     Nom".

       01 LigneChoixArticle.
         05 line NoLigneChoixArticle Col 3 pic ZZZ99 from code_article of Article.
         05 line NoLigneChoixArticle Col 15 pic X(20) from libelle of Article.

       01 LigneChoixFournisseur.
         05 line NoLigneChoixFournisseur Col 3 pic ZZZ99 from id_fournisseur of Fournisseur.
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

       01 Ligne-AlerteArticlePresent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Cet article est deja present en base de donnee.".

       01 Ligne-AnnulationAjoutArticle background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 15 value "L article n a pas ete ajoute.".

       01 Ligne-ArticleSupprime background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 15 value "L article a bien ete supprime.".


       01 EffaceLigne5 background-color is CouleurFondEcran.
         10 line 5 col 1 pic X(80).

       01 Ligne-ChampObligatoire reverse-video.
         10 line 5 col 15 value "Ce champ est obligatoire." bell.

      
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
               display "Erreur connexion base de donne    bn            e" line 4 col 15
               stop run
           end-if.

           exec sql
             set autocommit on
           end-exec.
      ********

       MenuPrincipal-trt.
           move 0 to ChoixMenuPrincipal.
           display ecran-menuPrincipal.
           accept ChoixMenuPrincipal line 5 col 75 auto.
           evaluate ChoixMenuPrincipal
               when 1
                   perform MenuArticle
               when 2
                   perform MenuFournisseur
               when 3
                   perform MenuCommande
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
           accept ChoixMenuArticle line 5 col 77 auto.

           evaluate ChoixMenuArticle
               when 1
                   perform ListeArticle
               when 2
                   perform AjoutArticle
               when 3
                   perform ModifArticle
               when 4
                   perform SuppArticle
               when 5
                   perform ComparaisonStock

           end-evaluate.
       MenuArticle-fin.
          continue.

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

           move date_crea of Article to ArticleDateCreationAffichage.
           move date_modif of Article to ArticleDateModifAffichage.
           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOF
               display " Fin de la liste. Tapez entrer " line 1 col 1
               accept ReponseListeArticle

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
               Move "S" to ReponseListeArticle
               accept ReponseListeArticle line 1 col 29

               if ReponseListeArticle = "M" or ReponseListeArticle = "m"
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
           initialize AjoutArticleInput.
       AjoutArticle-trt.
           move 1 to EOA.
           display ecran-AjoutArticle.

           if ChoixEcranFournisseur not equal 0
               display ChoixAjouter
               move ChoixEcranFournisseur to id_fournisseur of AjoutArticleInput
               move "A" to ChoixAjoutArticle 
               accept ChoixAjoutArticle line 5 col 46 auto reverse-video


               if ChoixAjoutArticle = "a" or ChoixAjoutArticle = "A"

      *            On v�rifie si l'article est d�j� dans la base de donn�e

                   exec sql
                     SELECT COUNT(*) INTO :VerifArticlePresent
                     FROM Article
                     WHERE Article.Libelle = :AjoutArticleInput.libelle
                   end-exec

                   if VerifArticlePresent equal 0

                       exec sql
                          INSERT INTO Article (id_fournisseur, libelle, quantite_stock, quantite_min)
                          VALUES (:AjoutArticleInput.id_fournisseur, :AjoutArticleInput.libelle, :AjoutArticleInput.quantite_stock, :AjoutArticleInput.quantite_min)
                       end-exec
                                            
                       display ArticleAjouter
                       accept Pause
                       initialize ChoixEcranFournisseur
                       initialize EcranArticleInput
                   else
                       display Ligne-AlerteArticlePresent
                       accept Pause
                       initialize ChoixEcranFournisseur
                   end-if
               else
                   move 1 to EOA
                   display EffaceLigne5
                   display Ligne-AnnulationAjoutArticle
                   accept Pause
               end-if  
           else
               move "Afficher liste fournisseur" to ChoixFournisseur
               display ecran-AjoutArticle
               accept libelle of AjoutArticleInput line 6 col 25 prompt
               if libelle of AjoutArticleInput not equal ' '
                   accept quantite_stock of AjoutArticleInput line 7 col 23 prompt just right
                   accept quantite_min of AjoutArticleInput line 8 col 31 prompt just right
               else
      *            move space to ChoixFournisseur
               end-if
           end-if.

           move quantite_stock of AjoutArticleInput to Ecran-QuantiteStock
           move quantite_min of AjoutArticleInput to Ecran-QuantiteMin

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
           initialize AjoutArticleInput EcranArticleInput.
           move "Afficher liste fournisseur" to ChoixFournisseur.
           

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

           if libelle of ModifArticleInput equal ' '
               perform ChoixArticle
               move ChoixEcranArticle to IdArticleRecherche
               perform RechercheArticleParId
               initialize IdArticleRecherche
           else
               move libelle of ModifArticleInput to LibelleArticleRecherche
               perform RechercheArticleParNom
               initialize LibelleArticleRecherche
           end-if.

          
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
           perform RechercheArticleParNom.
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

      *************************************************************
      *************************************************************
      * Comparaison stock article
      *************************************************************
      *************************************************************

       ComparaisonStock.
           perform ComparaisonStock-init.
           perform ComparaisonStock-trt until EOCS = 1.
           perform ComparaisonStock-fin.

       ComparaisonStock-init.
           move 0 to EOCS.
           move spaces to article.
           move spaces to Commande.
           move 0 to noPageReapprovisionnement.
           move 0 to nbLigneReapprovisionnement.
           exec sql
               declare C-ComparaisonStock cursor for
                   select code_article, libelle, quantite_stock, quantite_min, id_fournisseur from Article
                   where quantite_stock <= quantite_min
                   order by id_fournisseur
           end-exec.
           exec sql
             open C-ComparaisonStock
           end-exec.

       ComparaisonStock-trt.
           exec sql
               fetch C-ComparaisonStock into
               :Article.code_article,
               :Article.libelle,
               :Article.quantite_stock,
               :Article.quantite_min,
               :Commande.code_fournisseur
           end-exec.
           if (sqlcode not equal 0 and sqlcode not equal 1) then
               move 1 to EOCS
           end-if.
           perform EcritureFichierReapprovisionnement.

       ComparaisonStock-fin.
           continue.

      *************************************************************
      *************************************************************
      * Ecriture fichier Réapprovisionnement
      *************************************************************
      *************************************************************

       EcritureFichierReapprovisionnement.
           if nbLigneReapprovisionnement equal 1
               perform EcritureFichierReapprovisionnement-init
           end-if.
           perform EcritureFichierReapprovisionnement-trt.
           if EOCS equal 1
               perform EcritureFichierReapprovisionnement-fin
           end-if.


       EcritureFichierReapprovisionnement-init.
           move jour of DateSysteme to jour of EnteteFichierReapprovisionnementStock.
           move mois of DateSysteme to mois of EnteteFichierReapprovisionnementStock.
           move annee of DateSysteme to annee of EnteteFichierReapprovisionnementStock.
           move raison_sociale of Fournisseur to raison_sociale of EnteteFichierReapprovisionnementStock.
           move adresse of Fournisseur to adresse of EnteteFichierReapprovisionnementStock.
           move cp of Fournisseur to cp of EnteteFichierReapprovisionnementStock.
           move ville of Fournisseur to ville of EnteteFichierReapprovisionnementStock.
           add 1 to nbLigneReapprovisionnement.

           write e-fichierEtatStock from ligne1 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne2 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne3 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne4 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne5 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne6 of EnteteFichierEtatStock.

       EcritureFichierReapprovisionnement-trt.

       EcritureFichierReapprovisionnement-fin.


      *************************************************************
      *************************************************************
      * Menu fournisseur
      *************************************************************
      *************************************************************

       MenuFournisseur.
           perform MenuFournisseur-init.
           perform MenuFournisseur-trt until ChoixMenuFournisseur = 0.
           perform MenuFournisseur-fin.

       MenuFournisseur-init.
           move 1 to ChoixMenuFournisseur.
       MenuFournisseur-trt.
           move 0 to ChoixMenuFournisseur.
           display ecran-MenuFournisseur.
           accept ChoixMenuFournisseur line 5 col 77 auto.
           evaluate ChoixMenuFournisseur
               when 1
                   perform ListeFournisseur

           end-evaluate.
       MenuFournisseur-fin.
           continue.
       ListeFournisseur.
           perform ListeFournisseur-init.
           perform ListeFournisseur-trt until EOLF = 1.
           perform ListeFournisseur-fin.
       ListeFournisseur-init.
           move 0 to EOLF.

      * Déclaration du curseur
           exec sql
               declare C-ListeFournisseur cursor for
                   select id_fournisseur, raison_sociale, siret, adresse, cp, ville, pays,tel, date_crea, date_modif
                       from Fournisseur
                          Order by raison_sociale
           end-exec.

      * Ouverture du curseur
           exec sql
               open C-ListeFournisseur
           End-exec.

      * Initialisation de la pagination
           display ListeFournisseur-E.
           move 5 to NoligneFournisseur.

       ListeFournisseur-trt.
           exec sql
               fetch C-ListeFournisseur into :Fournisseur.id_fournisseur,
                                         :Fournisseur.raison_sociale,
                                         :Fournisseur.siret,
                                         :Fournisseur.adresse,
                                         :Fournisseur.cp,
                                         :Fournisseur.ville,
                                         :Fournisseur.pays,
                                         :Fournisseur.tel,
                                         :Fournisseur.date_crea,
                                         :Fournisseur.date_modif
           end-exec.

           move date_crea of Fournisseur to FournisseurDateCreationAffichage.
           move date_modif of Fournisseur to FournisseurDateModifAffichage.
           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOLF
               display " Fin de la liste. Tapez entrer " line 1 col 1 with no advancing
               accept ReponseListeFournisseur

           else
               perform AffichageListeFournisseur
           end-if.

       ListeFournisseur-fin.
           exec sql
               close C-ListeFournisseur
           end-exec.

       AffichageListeFournisseur.
           Add 1 to NoLigneFournisseur.
           Display LigneFournisseur.

           if NoLigneFournisseur equal 23
               Display " Page [S]uivante - [m]enu : S" Line 1 Col 1 with no advancing
               Move "S" to ReponseListeFournisseur
               accept ReponseListeFournisseur line 1 col 29

               if ReponseListeFournisseur = "M" or ReponseListeFournisseur = "m"
                   move 1 to EOLF
               else
                   move 5 to NoLigneFournisseur
               end-if
           end-if.
       ChoixArticle.
           perform ChoixArticle-init.
           perform ChoixArticle-trt until EOCA = 1.
           perform ChoixArticle-fin.
       ChoixArticle-init.
           move 0 to EOCA.
           exec sql
               declare C-ListeChoixArticle cursor for
                   select code_article, libelle from Article
                          Order by libelle
           end-exec.
           exec sql
             open C-ListeChoixArticle
           end-exec.
           display ecran-ChoixArticle.
           move 7 to NoLigneChoixArticle.
       ChoixArticle-trt.
           exec sql
             fetch C-ListeChoixArticle into :Article.code_article, :Article.libelle
          end-exec.

           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOCA
               display " Selectionnez l article (0 pour retour) " line 5 col 10 reverse-video
               accept ChoixEcranArticle line 5 col 77

           else

               perform AffichageChoixArticle

           end-if.
       ChoixArticle-fin.
           exec sql
             close C-ListeChoixArticle
           end-exec.
       AffichageChoixArticle.
           Add 1 to NoLigneChoixArticle.

           Display LigneChoixArticle.

           if NoLigneChoixArticle equal 23

               Display " Page [S]uivante - [m]enu : S" Line 1 Col 1 with no advancing
               Move "S" to responseChoixArticle
               accept responseChoixArticle line 1 col 29

               if responseChoixArticle = "M" or responseChoixArticle = "m"
                   move 1 to EOCA

               else
                   move 7 to NoLigneChoixArticle
               end-if
           end-if.

      *************************************************************
      *************************************************************
      * Gestion menu commande
      *************************************************************
      *************************************************************

       MenuCommande.
           perform MenuCommande-init.
           perform MenuCommande-trt until ChoixMenuCommande equal 0.
           perform MenuCommande-fin.

       MenuCommande-init.
           move 1 to ChoixMenuCommande.

       MenuCommande-trt.
           move 0 to ChoixMenuCommande.
           move 0 to ChoixNoCommande
           display ecran-MenuCommande.
           accept ChoixNoCommande line 5 col 77.

           evaluate ChoixNoCommande
               when 0
                   move 0 to ChoixMenuCommande
               when other
                   perform TraitementFichierCommande
           end-evaluate.
      
       MenuCommande-fin.
           continue.

      *************************************************************
      *************************************************************
      * Evaluates correspondant au bon noms de fichiers
      *************************************************************
      *************************************************************
       OpenInput.
           evaluate ChoixNoCommande
               when 1
                   open input f-fichierCommande1
               when 2
                   open input f-fichierCommande2
               when 3
                   open input f-fichierCommande3
               when 4
                   open input f-fichierCommande4

           end-evaluate.

       ReadFichier.
           evaluate ChoixNoCommande
               when 1
                   read f-fichierCommande1
               when 2
                   read f-fichierCommande2
               when 3
                   read f-fichierCommande3
               when 4
                   read f-fichierCommande4
           end-evaluate.

       ReadFichierToEnd.
           evaluate ChoixNoCommande
               when 1
                   read f-fichierCommande1
                       at end
                           perform VerificationFichier-derniereLigne
                       not at end
                           perform VerificationFichier-corps
                   end-read
               when 2
                   read f-fichierCommande2
                       at end
                           perform VerificationFichier-derniereLigne
                       not at end
                           perform VerificationFichier-corps
                   end-read
               when 3
                   read f-fichierCommande3
                       at end
                           perform VerificationFichier-derniereLigne
                       not at end
                           perform VerificationFichier-corps
                   end-read
               when 4
                   read f-fichierCommande4
                       at end
                           perform VerificationFichier-derniereLigne
                       not at end
                           perform VerificationFichier-corps
                   end-read

           end-evaluate.

       UnstringCommandeEntete.
           evaluate ChoixNoCommande
               when 1
                   unstring e-fichierCommande1 delimited by ","
                     into
                     code_fournisseur of Commande
                     no_commande of Commande
                     date_commande of Commande
                   end-unstring
               when 2
                   unstring e-fichierCommande2 delimited by ","
                     into
                     code_fournisseur of Commande
                     no_commande of Commande
                     date_commande of Commande
                   end-unstring
               when 3
                   unstring e-fichierCommande3 delimited by ","
                     into
                     code_fournisseur of Commande
                     no_commande of Commande
                     date_commande of Commande
                   end-unstring
               when 4
                   unstring e-fichierCommande4 delimited by ","
                     into
                     code_fournisseur of Commande
                     no_commande of Commande
                     date_commande of Commande
                   end-unstring
           end-evaluate.


       CloseInput.
           evaluate ChoixNoCommande
               when 1
                   close f-fichierCommande1
               when 2
                   close f-fichierCommande2
               when 3
                   close f-fichierCommande3
               when 4
                   close f-fichierCommande4

           end-evaluate.

       UnstringEnregistrementCommande.
           evaluate ChoixNoCommande
               when 1
                   unstring e-fichierCommande1 delimited by ","
                     into
                     code_article of Commande
                     quantite of Commande
                   end-unstring
               when 2
                   unstring e-fichierCommande2 delimited by ","
                     into
                     code_article of Commande
                     quantite of Commande
                   end-unstring
               when 3
                   unstring e-fichierCommande3 delimited by ","
                     into
                     code_article of Commande
                     quantite of Commande
                   end-unstring
               when 4
                   unstring e-fichierCommande4 delimited by ","
                     into
                     code_article of Commande
                     quantite of Commande
                   end-unstring

           end-evaluate.

      *************************************************************
      *************************************************************
      * Gestion lecture fichier commande
      *************************************************************
      *************************************************************

       TraitementFichierCommande.
           perform VerificationFichier.
           if MessageErreurCommande equal spaces
               perform TraitementCommande
           else
               perform SortieErreurCommande
           end-if.

       SortieErreurCommande.
           display ligne-MenuCommandeErreur.
           accept ChoixNoCommande line 5 col 77.

       VerificationFichier.
           perform VerificationFichier-init.
           perform VerificationFichier-trt until EOR = 1.
           perform VerificationFichier-fin.

       VerificationFichier-init.
           move space to MessageErreurCommande
           move 0 to EOR.
           move 0 to NoligneCommande.
           move 0 to QuantiteTotalCommande.
           perform openInput.
           perform VerificationEntete.

       VerificationEntete.
           perform ReadFichier.

      *    On vérifie que l'entête est conforme
           perform UnstringCommandeEntete.
           inspect date_commande of Commande tallying tally-counter for all '/'.

           if (code_fournisseur of Commande equal low-value
               or no_commande of Commande equal low-value
               or date_commande of Commande equal low-value
               or tally-counter not equal 2
               )
               move "Entete du fichier non conforme" to MessageErreurCommande
               move 1 to EOR
           end-if.

      *    On vérifie que le fournisseur existe en BDD
           move zero to CodeFournisseur.
           exec sql
             SELECT id_fournisseur INTO :CodeFournisseur FROM fournisseur WHERE id_fournisseur = :code_fournisseur 
           end-exec.
           if (CodeFournisseur equal zero)
               move "Fournisseur inconnu" to MessageErreurCommande
               move 1 to EOR
           end-if.

       VerificationFichier-trt.
           perform ReadFichierToEnd.

       VerificationFichier-corps.
           add 1 to NoligneCommande.

      *    On vérifie que la ligne article est conforme
           perform UnstringEnregistrementCommande.

           if (code_article of Commande equal low-value
               or code_article of Commande equal zero
               or quantite of Commande equal low-value
               or quantite of Commande equal zero
               )
               move "Corps du fichier non conforme" to MessageErreurCommande
               move 1 to EOR
           end-if.
           add quantite of Commande to QuantiteTotalCommande.

       VerificationFichier-derniereLigne.
           move 1 to EOR.
      *    on enlève la dernière ligne
           subtract 1 from NoligneCommande.
           string NoligneCommande delimited by size into TotalLigneCommande.
           subtract quantite of Commande from QuantiteTotalCommande.

      *    vérification du total de la quantite et du nombre de lignes
           if (QuantiteTotalCommande not equal quantite of Commande
               or TotalLigneCommande not equal code_article of Commande)
               move "Quantite d'articles ou nombre de lignes totales non conforme" to MessageErreurCommande
           end-if.

       VerificationFichier-fin.
           perform CloseInput.

      *************************************************************
      *************************************************************
      * Génération fichier état stock
      *************************************************************
      *************************************************************

       TraitementCommande.
           perform TraitementCommande-init.
           perform TraitementCommande-trt until NoligneCommande = TotalLigneCommande.
           perform TraitementCommande-fin.

       TraitementCommande-init.
           move spaces to Article.
           move 1 to NoligneCommande.
           perform OpenInput.

      *    On passe la première ligne
           perform ReadFichier.
      *    Insertion entête commande
           exec sql
               INSERT INTO Commande (date_commande, id_fournisseur)
                   VALUES (
                       CAST(:Commande.date_commande as date),
                       :Commande.code_fournisseur
                       )
           end-exec.
      *    On récupère l'id de la commande nouvellement insérée
           exec sql
               SELECT scope_identity() into :Commande.no_commande
           end-exec.

      *    Init génération de l'etat de stock
           move 0 to noPageEtatStock.
           move 0 to nbLigneEtatStock.
           open output f-fichierEtatStock.

      *    Ecriture entête
           move jour of DateSysteme to jour of ligne3.
           move mois of DateSysteme to mois of ligne3.
           move Annee of DateSysteme to annee of ligne3.
           move no_commande of commande to no_commande of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne1 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne2 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne3 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne4 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne5 of EnteteFichierEtatStock.
           write e-fichierEtatStock from ligne6 of EnteteFichierEtatStock.

       TraitementCommande-trt.
           perform ReadFichier.
           perform unstringEnregistrementCommande.
           move zero to code_article of Article.
           exec sql
               select
                   code_article,
                   quantite_stock,
                   quantite_min,
                   libelle
                   into
                   :article.code_article,
                   :article.quantite_stock,
                   :article.quantite_min,
                   :article.libelle
                   from article
                   WHERE code_article = :commande.code_article AND id_fournisseur = :CodeFournisseur
           end-exec.
      *    MAJ quantite et stock article
           add quantite of commande to quantite_stock of article.
           exec sql
               UPDATE article
                   SET quantite_stock = :article.quantite_stock,
                       date_modif = getdate()
                       WHERE code_article = :commande.code_article AND id_fournisseur = :CodeFournisseur
           end-exec.
      *    Insertion commande article
           exec sql
               INSERT INTO ligne_commande (id_commande, code_article, quantite)
                   VALUES (
                       :commande.no_commande,
                       :article.code_article,
                       :commande.quantite
                       )
           end-exec.
           add 1 to NoLigneCommande.

      *    Ecriture etat stock
           move code_article of article to code_article of CorpsFichierEtatStock.
           move libelle of article to libelle of CorpsFichierEtatStock.
           move quantite_stock of article to quantite_stock of CorpsFichierEtatStock.
           move quantite_min of article to quantite_min of CorpsFichierEtatStock.

           write e-fichierEtatStock from CorpsFichierEtatStock.
           add 1 to nbLigneEtatStock.

      *    ecriture pied de page nouvelle page
           if nbLigneEtatStock equal MaxLigneEtatStock
               add 1 to noPageEtatStock
               move noPageEtatStock to NbPage of PiedDePageFichierEtatStock
               write e-fichierEtatStock from PiedDePageFichierEtatStock
               move 0 to nbLigneEtatStock
           end-if.


       TraitementCommande-fin.
           perform CloseInput.

           write e-fichierEtatStock from FinPiedDePageFichierEtatStock
           close f-fichierEtatStock.

           display ligne-MenuCommandeSucces.
           accept ChoixNoCommande line 5 col 77.

           
      *************************************************************
      *************************************************************
      * Traitement fournisseur
      *************************************************************
      *************************************************************
           
       ChoixDuFournisseur.
           perform ChoixFournisseur-init.
           perform ChoixFournisseur-trt until EOCF = 1.
           perform ChoixFournisseur-fin.
       ChoixFournisseur-init.
           move 0 to EOCF.
           exec sql
               declare C-ListeChoixFournisseur cursor for
                   select id_fournisseur, raison_sociale from Fournisseur
                          Order by id_fournisseur
           end-exec.
           exec sql
             open C-ListeChoixFournisseur
           end-exec.
           display ecran-ChoixFournisseur.
           move 7 to NoLigneChoixFournisseur.

       ChoixFournisseur-trt.
           exec sql
              fetch C-ListeChoixFournisseur into :Fournisseur.id_fournisseur, :Fournisseur.raison_sociale
           end-exec.

           if (sqlcode not equal 0 and SQLCODE not equal 1) then

               move 1 to EOCF
               display " Selectionnez le fournisseur (0 pour retour / 1 pour creer) " line 5 col 5 reverse-video
               accept ChoixEcranFournisseur line 5 col 77
              
           else

               perform AffichageChoixFournisseur

           end-if.

       ChoixFournisseur-fin.
           exec sql
               close C-ListeChoixFournisseur
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
       RechercheArticleParNom.
           exec sql
              SELECT code_article,id_fournisseur, libelle, quantite_stock, quantite_min, date_crea, date_modif, raison_sociale
                                                       INTO :ArticleRecupere.code_article, :ArticleRecupere.id_fournisseur, :ArticleRecupere.libelle, :ArticleRecupere.quantite_stock,
                                :ArticleRecupere.quantite_min, :ArticleRecupere.date_crea, :ArticleRecupere.date_modif, :ArticleRecupere.raison_sociale
              FROM ArticleFournisseur
              WHERE libelle = :LibelleArticleRecherche
          end-exec.

      **********************************************************
      *   Recherche un article dans la BDD par son ID          *
      *                                                        *
      *   Renseigner IdArticleRecherche avec le code_article   *
      **********************************************************
       RechercheArticleParId.
           exec sql
              SELECT code_article,id_fournisseur, libelle, quantite_stock, quantite_min, date_crea, date_modif, raison_sociale
                                                       INTO :ArticleRecupere.code_article, :ArticleRecupere.id_fournisseur, :ArticleRecupere.libelle, :ArticleRecupere.quantite_stock,
                                :ArticleRecupere.quantite_min, :ArticleRecupere.date_crea, :ArticleRecupere.date_modif, :ArticleRecupere.raison_sociale
              FROM ArticleFournisseur
              WHERE code_article = :IdArticleRecherche
          end-exec.
       end program Program1.