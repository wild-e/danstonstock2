
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
              
       77 ChoixMenuPrincipal pic X.
       77 ChoixMenuArticle pic X.
       77 ChoixMenuFournisseur pic X.
       77 ChoixMenuCommande pic X.

       77 ChoixNoCommande pic X.
       77 ChoixFournisseur pic X(30).
       77 ChoixEcranFournisseur pic 99 value 0.

       77 ChoixDetailArticle pic x.
       77 ChoixAjoutArticle pic x.
       77 ChoixModifArticle pic x.
       77 ChoixSupprimerArticle pic x.
       77 ChoixEcranArticle pic 99 value 0.

       77 ChoixDetailFournisseur pic x.
       77 ChoixAjoutFournisseur pic x.
       77 ChoixModifFournisseur pic x.
       77 ChoixSupprimerFournisseur pic x.
       77 ChoixCreationFournisseur pic X.

       77 ChoixChampObligatoire pic x.

       01 DateSysteme.
         10 Annee pic 9999.
         10 Mois pic 99.
         10 Jour pic 99.

       01 Article.
         10 code_article pic 9(5).
         10 id_fournisseur pic 9(9).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).
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
       
       01 DetailArticleInput.
         10 code_article pic 9(5).
         10 id_fournisseur pic 9(5).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).
         10 date_crea sql date.
         10 date_modif sql date.
         10 raison_sociale sql char-varying (50).

       01 AjoutArticleInput.
         10 id_fournisseur pic 9(5).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).
         10 raison_sociale sql char-varying (50).


       01 ModifArticleInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).


       01 SuppArticleInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).


       01 ArticleRecupere.
         10 code_article pic 9(5).
         10 id_fournisseur pic 9(5).
         10 libelle sql char-varying (50).
         10 quantite_stock pic 9(5).
         10 quantite_min pic 9(5).
         10 quantite_mediane pic 9(5).
         10 date_crea sql date.
         10 date_modif sql date.
         10 raison_sociale sql char-varying (50).
       
       01 DetailFournisseurInput.
         10 raison_sociale sql char-varying (50).
         10 siret sql char (14).
         10 adresse sql char-varying (50).
         10 cp sql char (5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).
         10 date_crea sql date.
         10 date_modif sql date.

       01 AjoutFournisseurInput.
         10 raison_sociale sql char-varying (50).
         10 siret sql char (14).
         10 adresse sql char-varying (50).
         10 cp sql char (5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).

       01 ModifFournisseurInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 siret sql char (14).
         10 adresse sql char-varying (50).
         10 cp sql char (5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).

       01 SuppFournisseurInput.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 siret sql char (14).
         10 adresse sql char-varying (50).
         10 cp sql char (5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).
        
       01 FournisseurRecupere.
         10 id_fournisseur pic 9(5).
         10 raison_sociale sql char-varying (50).
         10 siret sql char (14).
         10 adresse sql char-varying (50).
         10 cp sql char (5).
         10 ville sql char-varying (50).
         10 pays sql char-varying (50).
         10 tel sql char-varying (15).
         10 date_crea sql date.
         10 date_modif sql date.

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
           10 Ecran-QuantiteMed pic 9(5).
           10 FournisseurChoisi pic X(50).

       77 IdModifArticle pic 9(5).
       77 IdSuppArticle pic 9(5).

       77 IdModifFournisseur pic 9(5).
       77 IdSuppFournisseur pic 9(5).

       77 LibelleArticleRecherche pic X(50).
       77 RaisonSocialeFournisseurRecherche pic X(50).
       77 IdArticleRecherche pic 99.

       77 VerifArticlePresent pic 9.
       77 VerifFournisseurPresent pic 9.
       77 VerifArticleFournisseurPresent pic 9.
       77 IdFournisseurRecherche pic 9(5).

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
       77 EOAF pic 9.
       77 EOCS pic 9.
       77 tally-counter pic 9.

       77 MessageErreurCommande pic x(80).
       77 EOCF pic 9.
       77 EOM pic 9.
       77 EOMF pic 9.
       77 EOSUP pic 9.
       77 EOSUPF pic 9.
       77 noPageEtatStock pic 999.
       77 nbLigneEtatStock pic 99.
       77 MaxLigneEtatStock pic 99 VALUE 33.
       77 noPageReapprovisionnement pic 999.
       77 nbLigneReapprovisionnement pic 99.
       77 MaxLigneReapprovisionnement pic 99 VALUE 33.
       77 ecritureFichierDeCommande pic 9.
       77 MessageComparaison pic x(80).


      *    Variables génération état de stock

       01 CorpsFichierEtatStock.
         10 filler pic X.
         10 code_article pic 9(10).
         10 filler pic X(8).
         10 libelle pic X(50).
         10 filler pic X(5).
         10 quantite_stock pic 9(5).
         10 filler pic X(15).
         10 quantite_min pic 9(5).

       01 EnteteFichierEtatStock.
         05 ligne1.
           10 filler pic X(48).
           10 filler pic X(15) VALUE "Etat des stocks".
         05 Ligne2 pic X.
         05 ligne3.
           10 filler pic X.
           10 filler pic X(13) VALUE "Commande :".
           10 filler pic X.
           10 no_commande pic x(10).
           10 filler pic X(65).
           10 filler pic X(6) VALUE "Date :".
           10 filler pic X.
           10 jour pic X(2).
           10 filler pic X VALUE "/".
           10 mois pic X(2).
           10 filler pic X VALUE "/".
           10 annee pic X(4).
         05 Ligne4 pic X(111) VALUE ALL "-".
         05 Ligne5.
           10 filler pic X.
           10 filler pic X(12) VALUE "Code article".
           10 filler pic X(4).
           10 filler pic X(7) VALUE "Libelle".
           10 filler pic X(45).
           10 filler pic X(14) VALUE "Quantite stock".
           10 filler pic X(10).
           10 filler pic X(14) VALUE "Quantite min".
         05 Ligne6 pic X(111) VALUE ALL "-".

       01 PiedDePageFichierEtatStock.
         10 filler pic X(4) VALUE ALL "-".
         10 filler pic X.
         10 filler pic X(4) VALUE "Page".
         10 filler pic X.
         10 NbPage pic Z9.
         10 filler pic X.
         10 filler pic X(98) VALUE ALL "-".

       01 FinPiedDePageFichierEtatStock.
         10 filler pic X(4) VALUE ALL "-".
         10 filler pic X.
         10 filler pic X(14) VALUE "Fin traitement".
         10 filler pic X.
         10 filler pic X(91) VALUE ALL "-".

      *  Variable génération commande réapprovisionnement

       77 totalReapprovisionnement pic 9(5).
       77 CodeFournisseurPrecedent pic X(5).
       77 testPagi pic 9.

       01 VueReapproArticleFournisseur.
         10 code_article pic 9(5).
         10 libelle pic x(50).
         10 quantite_stock pic 9(5).
         10 quantite_mediane pic 9(5).
         10 code_fournisseur  pic x(5).
         10 raison_sociale pic x(50).
         10 adresse pic x(50).
         10 cp pic x(5).
         10 ville pic x(50).

       01 EnteteFichierReapprovisionnementStock.
         05 ligne1.
           10 filler pic X.
           10 raison_sociale pic X(50).
         05 ligne2.
           10 filler pic X.
           10 adresse pic X(80).
         05 ligne3.
           10 filler pic X.
           10 cp pic X(5).
           10 filler pic X.
           10 ville pic X(50).
         05 ligne4.
           10 filler pic X(36).
           10 filler pic X(33) VALUE "Réapprovisionnement stock - page".
           10 filler pic x.
           10 NbPage pic Z9.
         05 Ligne5 pic X.
         05 Ligne6.
           10 filler pic x(92).
           10 filler pic x(6) value "Date :".
           10 filler pic x.
           10 jour pic X(2).
           10 filler pic X VALUE "/".
           10 mois pic X(2).
           10 filler pic X VALUE "/".
           10 annee pic X(4).
         05 Ligne7 pic X.
         05 Ligne8 pic X(111) VALUE ALL "-".
         05 Ligne9.
           10 filler pic X.
           10 filler pic X(11) VALUE "Référence".
           10 filler pic X(5).
           10 filler pic X(12) VALUE "Désignation".
           10 filler pic X(45).
           10 filler pic X(10) VALUE "Quantités".
           10 filler pic X(5).
           10 filler pic X(15) VALUE "Conditionnement".
         05 Ligne10 pic X(111) VALUE ALL "-".

       01 CorpsFichierReapprovisionnementStock.
         05 donneeArticle.
           10 filler pic X.
           10 code_article pic 9(5).
           10 filler pic x(9).
           10 libelle pic x(50).
           10 filler pic x(6).
           10 quantite pic x(5).
         05 filler pic x(9).
         05 filler pic x(7) value "unités".

       01 PiedDePageFichierReapprovisionnementStock.
         10 filler pic X(4) VALUE ALL "-".
         10 filler pic X.
         10 filler pic X(4) VALUE "Page".
         10 filler pic X.
         10 NbPage pic Z9.
         10 filler pic X.
         10 filler pic X(98) VALUE ALL "-".

       01 FinPiedDePageFichierReapprovisionnementStock.
         10 filler pic X(4) VALUE ALL "-".
         10 filler pic X.
         10 filler pic X(4) VALUE "Page".
         10 filler pic X.
         10 NbPage pic Z9.
         10 filler pic X.
         10 filler pic X VALUE "-".
         10 filler pic X.
         10 filler pic X(12) VALUE "Fin commande".
         10 filler pic X.
         10 filler pic X(82) VALUE ALL "-".

       01 LigneVide pic x(111) value all space.


      ************************************************************
      * Param�trage couleur �cran
      ************************************************************
       77 CouleurFondEcran pic 99 VALUE 3.
       77 CouleurCaractere pic 99 VALUE 0.

      ************************************************************
      * Ecrans de l'application
      ************************************************************
       SCREEN SECTION.
       01 ecran-menuPrincipal background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 Blank Screen.
         10 line 3 col 32 VALUE "Menu principal".
         10 line 5 col 5 from Jour of DateSysteme.
         10 line 5 col 7 value "/".
         10 line 5 col 8 from Mois of DateSysteme.
         10 line 5 col 10 value "/".
         10 line 5 col 11 from Annee of DateSysteme.
         10 line 5 col 68 VALUE "Choix: ".
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
         10 line 6 col 7 VALUE "Le programme s'est arrete sans modifier la base de donnees car:" reverse-video.
         10 line 7 col 7 pic x(80) from MessageErreurCommande.
         10 line 17 col 15 value "          ".

       01 ligne-MenuCommandeSucces background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 6 col 7 VALUE "Commande ajoutee avec succes" reverse-video.
         10 line 17 col 15 value "          ".

       01 ligne-MenuReapprovisionnement background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 6 col 7 pic x(80) from MessageComparaison.


      ***************************************************************
      *        DETAILS ARTICLE
      ***************************************************************

       01 ecran-DetailArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "INFORMATIONS ARTICLES".
         10 line 7 col 15 value "Libelle ...... : ".
         10 line 7 col 32 using libelle of DetailArticleInput.
         10 line 8 col 15 value "Fournisseur... : ".
         10 line 8 col 32 using raison_sociale of DetailArticleInput.
         10 line 9 col 15 value "Qtt Stock .... : ".
         10 line 9 col 32 using quantite_stock of DetailArticleInput.
         10 line 10 col 15 value "Qtt Min ...... : ".
         10 line 10 col 32 using quantite_min of DetailArticleInput.
         10 line 11 col 15 value "Qtt Mediane . : ".
         10 line 11 col 32 using quantite_mediane of DetailArticleInput.
         10 line 12 col 15 value "Cree le ..... : ".
         10 line 12 col 32 pic XX from Jour of ArticleDateCreationAffichage.
         10 line 12 col 34 pic X value "/".
         10 line 12 col 35 pic XX from Mois of ArticleDateCreationAffichage.
         10 line 12 col 37 pic X value "/".
         10 line 12 col 38 pic XXXX from Annee of ArticleDateCreationAffichage.
         10 line 13 col 15 value "Modifie le .. : ".
         10 line 13 col 32 pic XX from Jour of ArticleDateModifAffichage.
         10 line 13 col 34 pic X value "/".
         10 line 13 col 35 pic XX from Mois of ArticleDateModifAffichage.
         10 line 13 col 37 pic X value "/".
         10 line 13 col 38 pic XXXX from Annee of ArticleDateModifAffichage.
     
      *************************************************************
      *   AJOUT ARTICLE
      *************************************************************

       01 ecran-AjoutArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "AJOUTER UN ARTICLE".
           10 line 6 col 15 value "Libelle ...... : ".
           10 line 6 col 32 pic x(15) using libelle of AjoutArticleInput.
           10 line 7 col 15 value "Stock ........ : ".
           10 line 7 col 32 pic ZZZ99 using Ecran-QuantiteStock.
           10 line 8 col 15 value "Stock min .... : ".
           10 line 8 col 32 pic ZZZ99 using Ecran-QuantiteMin.
           10 line 9 col 15 value "Stock median . : ".
           10 line 9 col 32 pic ZZZ99 using Ecran-QuantiteMed.
           10 line 10 col 15 value "Fournisseur .. : ".
           10 line 10 col 32 using raison_sociale of AjoutArticleInput.
    
       01 ecran-ChoixFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
           10 line 1 col 1 blank screen.
           10 line 3 col 32 value "CHOIX DU FOURNISSEUR".
           10 line 5 col 68 value "Choix :".
           10 line 5 col 77 pic 99 from ChoixEcranFournisseur.
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
         10 line 6 col 15 value "Libelle ...... : ".
         10 line 6 col 32 using libelle of ModifArticleInput.
         10 line 7 col 15 value "Stock ........ : ".
         10 line 7 col 32 using quantite_stock of ModifArticleInput.
         10 line 8 col 15 value "Stock min .... : ".
         10 line 8 col 32 using quantite_min of ModifArticleInput.
         10 line 9 col 15 value "Qtt Mediane .. : ".
         10 line 9 col 32 using quantite_mediane of ModifArticleInput.
         10 line 10 col 15 value "Fournisseur  : ".
         10 line 10 col 32 using raison_sociale of ModifArticleInput.

      *************************************************************
      *   SUPPRESSION ARTICLE
      *************************************************************
       
       01 ecran-SuppArticle background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "SUPPRIMER UN ARTICLE".
         10 line 6 col 15 value "Libelle ........ : ".
         10 line 6 col 32 using libelle of SuppArticleInput.
         10 line 7 col 15 value "Stock .......... : ".
         10 line 7 col 32 using quantite_stock of SuppArticleInput.
         10 line 8 col 15 value "Stock minimal .. : ".
         10 line 8 col 32 using quantite_min of SuppArticleInput.
         10 line 9 col 15 value "Stock median ... : ".
         10 line 9 col 32 using quantite_min of SuppArticleInput.
         10 line 10 col 15 value "Fournisseur .... : ".
         10 line 10 col 32 using raison_sociale of SuppArticleInput.

      ************ Lignes d'affichage Article
       01 Ligne-ChoixDetailArticle background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "[R]evenir - [M]odifier - [S]pprimer : ".

       01 Ligne-ChoixArticleAjoute background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 20 value "[A]jouter - [R]evenir : ".

       01 Ligne-ArticleAjoute background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 1 pic x(80) value "                      Article Ajoute".
       
       01 Ligne-ArticleModifie background-color is CouleurCaractere foreground-color is CouleurFondEcran.
           10 line 5 col 1 pic x(80) value "                      Article Modifie".

       01 Ligne-ChoixArticleModifie background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 20 value "[M]odifier - [R]evenir : ".

       01 Ligne-DemandeSuppression background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Voulez vous supprimer cet article ? [O]ui / [N]on : ".

       01 Ligne-AlerteStock background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Le stock doit etre a zero pour supprimer un article.".

       01 Ligne-AlerteArticlePresent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Cet article est deja present en base de donnees.".

       01 Ligne-AlerteArticleAbsent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Cet article n'existe pas.".

       01 Ligne-AnnulationAjoutArticle background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 15 value "L article n a pas ete ajoute.".

       01 Ligne-ArticleSupprime background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 15 value "L article a bien ete supprime.".
       
      **************************************************************
      *      DETAILS FOURNISSEUR
      **************************************************************

       01 ecran-DetailFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "INFORMATIONS FOURNISSEUR".
         10 line 6 col 15 value "Raison Sociale : ".
         10 line 6 col 32 using raison_sociale of DetailFournisseurInput.
         10 line 7 col 15 value "SIRET ........ : ".
         10 line 7 col 32 using siret of DetailFournisseurInput.
         10 line 8 col 15 value "Adresse ...... : ".
         10 line 8 col 32 using adresse of DetailFournisseurInput.
         10 line 9 col 15 value "Code Postal .. : ".
         10 line 9 col 32 using cp of DetailFournisseurInput.
         10 line 10 col 15 value "Ville ........ : ".
         10 line 10 col 32 using ville of DetailFournisseurInput.
         10 line 11 col 15 value "Pays ......... : ".
         10 line 11 col 32 using pays of DetailFournisseurInput.
         10 line 12 col 15 value "No Tel ....... : ".
         10 line 12 col 32 using tel of DetailFournisseurInput.
         10 line 13 col 15 value "Cree le ..... : ".
         10 line 13 col 32 pic XX from Jour of FournisseurDateCreationAffichage.
         10 line 13 col 34 pic X value "/".
         10 line 13 col 35 pic XX from Mois of FournisseurDateCreationAffichage.
         10 line 13 col 37 pic X value "/".
         10 line 13 col 38 pic XXXX from Annee of FournisseurDateCreationAffichage.
         10 line 14 col 15 value "Modifie le .. : ".
         10 line 14 col 32 pic XX from Jour of FournisseurDateModifAffichage.
         10 line 14 col 34 pic X value "/".
         10 line 14 col 35 pic XX from Mois of FournisseurDateModifAffichage.
         10 line 14 col 37 pic X value "/".
         10 line 14 col 38 pic XXXX from Annee of FournisseurDateModifAffichage.

      *************************************************************
      *   AJOUT FOURNISSEUR
      *************************************************************

       01 ecran-AjoutFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "AJOUTER UN FOURNISSEUR".
         10 line 6 col 15 value "Raison Sociale : ".
         10 line 6 col 32 using raison_sociale of AjoutFournisseurInput.
         10 line 7 col 15 value "SIRET ........ : ".
         10 line 7 col 32 using siret of AjoutFournisseurInput.
         10 line 8 col 15 value "Adresse ...... : ".
         10 line 8 col 32 using adresse of AjoutFournisseurInput.
         10 line 9 col 15 value "Code Postal .. : ".
         10 line 9 col 32 using cp of AjoutFournisseurInput.
         10 line 10 col 15 value "Ville ........ : ".
         10 line 10 col 32 using ville of AjoutFournisseurInput.
         10 line 11 col 15 value "Pays ......... : ".
         10 line 11 col 32 using pays of AjoutFournisseurInput.
         10 line 12 col 15 value "No Tel ....... : ".
         10 line 12 col 32 using tel of AjoutFournisseurInput.

      *************************************************************
      *   MODIFIER FOURNISSEUR
      *************************************************************

       01 ecran-ModifFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "MODIFIER UN FOURNISSEUR".
         10 line 6 col 15 value "Raison Sociale : ".
         10 line 6 col 32 using raison_sociale of ModifFournisseurInput.
         10 line 7 col 15 value "SIRET ........ : ".
         10 line 7 col 32 using siret of ModifFournisseurInput.
         10 line 8 col 15 value "Adresse ...... : ".
         10 line 8 col 32 using adresse of ModifFournisseurInput.
         10 line 9 col 15 value "Code Postal .. : ".
         10 line 9 col 32 using cp of ModifFournisseurInput.
         10 line 10 col 15 value "Ville ........ : ".
         10 line 10 col 32 using ville of ModifFournisseurInput.
         10 line 11 col 15 value "Pays ......... : ".
         10 line 11 col 32 using pays of ModifFournisseurInput.
         10 line 12 col 15 value "No Tel ....... : ".
         10 line 12 col 32 using tel of ModifFournisseurInput.

      *************************************************************
      *   SUPPRIMER FOURNISSEUR
      *************************************************************

       01 ecran-SuppFournisseur background-color is CouleurFondEcran foreground-color is CouleurCaractere.
         10 line 1 col 1 blank screen.
         10 line 3 col 32 value "SUPPRIMER UN FOURNISSEUR".
         10 line 6 col 15 value "Raison Sociale : ".
         10 line 6 col 32 using raison_sociale of SuppFournisseurInput.
         10 line 7 col 15 value "SIRET ........ : ".
         10 line 7 col 32 using siret of SuppFournisseurInput.
         10 line 8 col 15 value "Adresse ...... : ".
         10 line 8 col 32 using adresse of SuppFournisseurInput.
         10 line 9 col 15 value "Code Postal .. : ".
         10 line 9 col 32 using cp of SuppFournisseurInput.
         10 line 10 col 15 value "Ville ........ : ".
         10 line 10 col 32 using ville of SuppFournisseurInput.
         10 line 11 col 15 value "Pays ......... : ".
         10 line 11 col 32 using pays of SuppFournisseurInput.
         10 line 12 col 15 value "No Tel ....... : ".
         10 line 12 col 32 using tel of SuppFournisseurInput.
         
      ************ Lignes d'affichage Fournisseur ***************
       01 Ligne-ChoixDetailFournisseur background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "[R]evenir - [M]odifier - [S]pprimer : ".

       01 Ligne-FournisseurAjoute background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 1 pic x(80) value "                      Fournisseur Ajoute".

       01 Ligne-FournisseurModifie background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 1 pic x(80) value "                      Fournisseur Modifie".

       01 Ligne-FournisseurSupprime background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 1 pic x(80) value "                      Fournisseur Supprime".

       01 Ligne-SelectionFournisseur background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Selectionnez le fournisseur (00 pour quitter)".

       01 Ligne-ChoixFournisseurModifie background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 20 value "[M]odifier - [R]evenir : ".

       01 Ligne-AlerteFournisseurPresent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Ce fournisseur est deja present en base de donnees.".

       01 Ligne-AlerteArticleFournisseurPresent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Ce fournisseur a encore des articles en base de donnees.".

       01 Ligne-AlerteFournisseurAbsent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Ce fournisseur n'existe pas, voulez-vous le creer ? ".

       01 Ligne-AlerteSuppFournisseurAbsent background-color is CouleurCaractere foreground-color is CouleurFondEcran.
         10 line 5 col 10 value "Ce fournisseur n'existe pas.".

       01 Ligne-ChampRaisonSocialeObligatoire reverse-video.
         10 line 5 col 10 value "Le champ Raison Sociale est obligatoire." bell.

      ************ Lignes d'affichage generales ***************
       01 EffaceLigne5 background-color is CouleurFondEcran.
         10 line 5 col 1 pic X(80).

       01 Ligne-ChampObligatoire reverse-video.
         10 line 5 col 10 value "Ce champ est obligatoire. [Q]uitter - [R]evenir : " bell.

       01 Ligne-AlerteErreurBDD reverse-video.
         10 line 5 col 10 value "Erreur Base de donnees".

      
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
               display "Erreur connexion base de donnees" line 4 col 15
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
           perform DetailArticle-init.
           perform DetailArticle-trt until EOF = 1.
           perform DetailArticle-fin.

       DetailArticle-init.
           move 0 to EOF.

       DetailArticle-trt.
           move 1 to EOF
           initialize ChoixEcranArticle.
           initialize IdArticleRecherche.
           perform ChoixArticle.
           move ChoixEcranArticle to IdArticleRecherche.
           if ChoixEcranArticle <> 0
               perform RechercheArticleParId
               move code_article of ArticleRecupere to code_article of DetailArticleInput
               move raison_sociale of ArticleRecupere to raison_sociale of DetailArticleInput
               move libelle of ArticleRecupere to libelle of DetailArticleInput
               move quantite_stock of ArticleRecupere to quantite_stock of DetailArticleInput
               move quantite_min of ArticleRecupere to quantite_min of DetailArticleInput
               move quantite_mediane of ArticleRecupere to quantite_mediane of DetailArticleInput
               move date_crea of ArticleRecupere to ArticleDateCreationAffichage
               move date_modif of ArticleRecupere to ArticleDateModifAffichage
               perform AffichageDetailArticle
           end-if.
          
       DetailArticle-fin.
           continue.
       AffichageDetailArticle.
           move "R" to ChoixDetailArticle
           display ecran-DetailArticle.
           display Ligne-ChoixDetailArticle
           accept ChoixDetailArticle line 5 col 47 reverse-video auto.
           evaluate ChoixDetailArticle
               when "M"
               when "m"
                   move code_article of ArticleRecupere to IdModifArticle
                   perform ModifArticle
               when "S"
               when "s"
                   move code_article of ArticleRecupere to IdSuppArticle
                   perform SuppArticle
               when other
                   continue
           end-evaluate.

       AjoutArticle.
           perform AjoutArticle-init.
           perform AjoutArticle-trt until EOA = 1.
           perform AjoutArticle-fin.
       AjoutArticle-init.
           move 0 to EOA.
           initialize AjoutArticleInput.
           initialize ChoixAjoutArticle.
       AjoutArticle-trt.
           move 1 to EOA.
           display ecran-AjoutArticle.

           if ChoixAjoutArticle = "a" or ChoixAjoutArticle = "A"
               perform AjoutArticleBDD
               if sqlcode = 0
                   display Ligne-ArticleAjoute
                   accept Pause
                   initialize ChoixEcranFournisseur
                   initialize EcranArticleInput
               else
                   display Ligne-AlerteErreurBDD
                   accept Pause
               end-if
           else
               display ecran-AjoutArticle
               accept libelle of AjoutArticleInput line 6 col 32 prompt
               
      *    On verifie que le champ obligatoire est rempli
               if libelle of AjoutArticleInput not equal ' '
      *        On verifie si l 'article est deja dans la base de donnees
                   exec sql
                       SELECT COUNT(*) INTO :VerifArticlePresent
                       FROM Article
                       WHERE Article.Libelle = :AjoutArticleInput.libelle
                   end-exec

                   if VerifArticlePresent equal 0
                       accept quantite_stock of AjoutArticleInput line 7 col 32 prompt
                       accept quantite_min of AjoutArticleInput line 8 col 32 prompt
                       accept quantite_mediane of AjoutArticleInput line 9 col 32 prompt
                       accept raison_sociale of AjoutArticleInput line 10 col 32 prompt
                       if raison_sociale of AjoutArticleInput not equal ' '
                           move raison_sociale of AjoutArticleInput to RaisonSocialeFournisseurRecherche
                           perform RechercheFournisseurParNom
                           initialize RaisonSocialeFournisseurRecherche
                           if sqlcode <> 0
                               move "O" to ChoixCreationFournisseur
                               display Ligne-AlerteFournisseurAbsent
                               accept ChoixCreationFournisseur line 5 col 62 reverse-video
                               if ChoixCreationFournisseur = "O" or ChoixCreationFournisseur = "o"
                                   exec sql
                                     INSERT INTO Fournisseur(raison_sociale)
                                     VALUES (:AjoutArticleInput.raison_sociale)
                                   end-exec
                                   if sqlcode equal 0
                                       display Ligne-FournisseurAjoute
                                       accept Pause
                                       exec sql
                                         SELECT id_fournisseur into :AjoutArticleInput.id_fournisseur
                                         FROM Fournisseur
                                         WHERE raison_sociale = :AjoutArticleInput.raison_sociale
                                       end-exec
                                       if sqlcode not equal 0
                                           display Ligne-AlerteErreurBDD
                                           accept Pause
                                       end-if
                                   end-if
                               else
                                   move 0 to EOA
                               end-if
                           end-if
                       else
                           perform ChoixDuFournisseur
                           move ChoixEcranFournisseur to IdFournisseurRecherche
                           perform RechercheFournisseurParId
                           initialize IdFournisseurRecherche
                       end-if
                       move quantite_stock of AjoutArticleInput to Ecran-QuantiteStock
                       move quantite_min of AjoutArticleInput to Ecran-QuantiteMin
                       move quantite_mediane of AjoutArticleInput to Ecran-QuantiteMed
                       if raison_sociale of AjoutArticleInput = raison_sociale of FournisseurRecupere
                           move id_fournisseur of FournisseurRecupere to id_fournisseur of AjoutArticleInput
                           move raison_sociale of FournisseurRecupere to raison_sociale of AjoutArticleInput
                       end-if

                       move "A" to ChoixAjoutArticle
                       display ecran-AjoutArticle
                       display Ligne-ChoixArticleAjoute
                       accept ChoixAjoutArticle line 5 col 44 auto reverse-video
                       if ChoixAjoutArticle = "A" or ChoixAjoutArticle = "a"
                           move 0 to EOA
                       else
                           move 1 to EOA
                       end-if
                   else
                       display Ligne-AlerteArticlePresent
                       accept Pause
                       initialize ChoixEcranFournisseur
                       initialize raison_sociale of AjoutArticleInput
                   end-if
                                      
               else
      *    On signale que le champ est obligatoire on propose de quitte le menu ajout
                   move "Q" to ChoixChampObligatoire
                   display Ligne-ChampObligatoire
                   accept ChoixChampObligatoire line 5 col 59 reverse-video
                   if ChoixChampObligatoire = "Q" or ChoixChampObligatoire = "q"
                       move 1 to EOA
                   else
                       move 0 to EOA
                   end-if
               end-if
           end-if.
     

       AjoutArticle-fin.
           initialize AjoutArticleInput EcranArticleInput.
       AjoutArticleBDD.
           exec sql
               INSERT INTO Article (id_fournisseur, libelle, quantite_stock, quantite_min, quantite_mediane)
               VALUES (:AjoutArticleInput.id_fournisseur, :AjoutArticleInput.libelle, :AjoutArticleInput.quantite_stock, :AjoutArticleInput.quantite_min, :AjoutArticleInput.quantite_mediane)
           end-exec.
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
           initialize Article.
           initialize ArticleRecupere.
           initialize ModifArticleInput.
           display ecran-ModifArticle.
      *    On controle si l arrivee dans le paragraphe se fait via le menu ou via les details de l article.
           if IdModifArticle <> 0
      *    Si par les details, on recherche l article avec l ID
               move IdModifArticle to IdArticleRecherche
               initialize IdModifArticle
               perform RechercheArticleParId
               initialize IdArticleRecherche
           else
      *    Sinon on accept le libelle et on recherche par le nom
               accept libelle of ModifArticleInput line 6 col 32 prompt
               if libelle of ModifArticleInput not equal ' '
                   move libelle of ModifArticleInput to LibelleArticleRecherche
                   perform RechercheArticleParNom
                   initialize LibelleArticleRecherche
               else
      *    Si le champ est vide on selectionne le produit dans la liste des produits
                   perform ChoixArticle
                   move ChoixEcranArticle to IdArticleRecherche
                   perform RechercheArticleParId
                   initialize IdArticleRecherche
               end-if
           end-if.
      *    On vérifie si l 'article a modifié est déjà en base de données
           if ChoixEcranArticle <> 0 or libelle of ArticleRecupere <> ' ' or libelle of ModifArticleInput <> ' '
               exec sql
                   SELECT COUNT(*) INTO :VerifArticlePresent
                   FROM Article
                   WHERE Article.Libelle = :ModifArticleInput.libelle
                   OR    Article.Libelle = :ArticleRecupere.libelle
               end-exec
      *        S il est present on affiche ses infos et on accept les modifications
               if VerifArticlePresent <> 0
                   move libelle of ArticleRecupere to libelle of ModifArticleInput
                   move quantite_stock of ArticleRecupere to quantite_stock of ModifArticleInput
                   move quantite_min of ArticleRecupere to quantite_min of ModifArticleInput
                   move quantite_mediane of ArticleRecupere to quantite_mediane of ModifArticleInput
                   move raison_sociale of ArticleRecupere to raison_sociale of ModifArticleInput

                   display ecran-ModifArticle

                   accept libelle of ModifArticleInput line 6 col 32 prompt
                   if libelle of ModifArticleInput not equal ' '
                  
                       accept quantite_stock of ModifArticleInput line 7 col 32 prompt
                       accept quantite_min of ModifArticleInput line 8 col 32 prompt
                       accept quantite_mediane of ModifArticleInput line 9 col 32 prompt

                       accept raison_sociale of ModifArticleInput line 10 col 32 prompt
                       if raison_sociale of ModifArticleInput equal ' '
                           perform ChoixDuFournisseur
                           move ChoixEcranFournisseur to IdFournisseurRecherche
                           perform RechercheFournisseurParId
                           initialize IdFournisseurRecherche
                           move raison_sociale of FournisseurRecupere to raison_sociale of ModifArticleInput
                           move id_fournisseur of FournisseurRecupere to id_fournisseur of ModifArticleInput
                       end-if
                       if raison_sociale of ModifArticleInput <> raison_sociale of ArticleRecupere or ChoixEcranFournisseur <> 0
                           exec sql
                               SELECT COUNT(*) INTO :VerifFournisseurPresent
                               FROM Fournisseur
                               WHERE raison_sociale = :ModifArticleInput.raison_sociale
                               OR id_fournisseur = :ChoixEcranFournisseur
                           end-exec
                           if VerifFournisseurPresent equal 0
                               display Ligne-AlerteFournisseurAbsent
                               move "O" to ChoixCreationFournisseur
                               accept ChoixCreationFournisseur line 5 col 60

                               if ChoixCreationFournisseur equal "O" or ChoixCreationFournisseur equal "O"
                                   exec sql
                                       INSERT INTO Fournisseur(raison_sociale)
                                       VALUES (:ModifArticleInput.raison_sociale)
                                   end-exec
                                   if sqlcode equal 0
                                       display Ligne-FournisseurAjoute
                                       accept Pause
                                       exec sql
                                           SELECT id_fournisseur into :ModifArticleInput.id_fournisseur
                                           FROM Fournisseur
                                           WHERE raison_sociale = :ModifArticleInput.raison_sociale
                                       end-exec
                                       if sqlcode equal 0
                                           perform ModifArticleBDD
                                       else
                                           display Ligne-AlerteErreurBDD
                                       end-if
                                   else
                                       display Ligne-AlerteErreurBDD
                                   end-if
                               end-if
                           else
                               display ecran-ModifArticle
                               perform ModifArticleBDD
                           end-if
                       else
                           exec sql
                               SELECT id_fournisseur INTO :ModifArticleInput.id_fournisseur
                               FROM Fournisseur
                               WHERE raison_sociale = : ModifArticleInput.raison_sociale
                           end-exec
                           perform ModifArticleBDD
                       end-if
                   else
                       move "Q" to ChoixChampObligatoire
                       display Ligne-ChampObligatoire
                       accept ChoixChampObligatoire line 5 col 59 reverse-video
                       if ChoixChampObligatoire = "Q" or ChoixChampObligatoire = "q"
                           move 1 to EOM
                       else
                           move 0 to EOM
                       end-if
                   end-if
               else
                   display Ligne-AlerteArticleAbsent
                   accept Pause
               end-if
           else
               continue
           end-if.
       ModifArticle-fin.
           continue.
       ModifArticleBDD.
           move "M" to ChoixModifArticle.
           display EffaceLigne5.
           display Ligne-ChoixArticleModifie.
           accept ChoixModifArticle line 5 col 45 reverse-video.
           if ChoixModifArticle = "M" or ChoixModifArticle = "m"
               exec sql
                   UPDATE Article
                   SET libelle          =  :ModifArticleInput.libelle,
                       id_fournisseur   =  :ModifArticleInput.id_fournisseur,
                       quantite_stock   =  :ModifArticleInput.quantite_stock,
                       quantite_min     =  :ModifArticleInput.quantite_min,
                       quantite_mediane =  :ModifArticleInput.quantite_mediane,
                       date_modif       =  getdate()
                   WHERE
                       code_article = :ArticleRecupere.code_article
               end-exec
               if sqlcode equal 0
                   move 1 to EOM
                   display Ligne-ArticleModifie
                   accept Pause
               end-if
           else
               move 0 to EOM
           end-if.
       SuppArticle.
           perform SuppArticle-init
           perform SuppArticle-trt until EOSUP = 1.
           perform SuppArticle-fin.
       SuppArticle-init.
           move 0 to EOSUP.
       SuppArticle-trt.
           initialize ArticleRecupere.
           initialize SuppArticleInput.
           initialize ChoixEcranArticle.
           move 1 to EOSUP.
           display ecran-SuppArticle.

           if IdSuppArticle <> 0
               move IdSuppArticle to IdArticleRecherche
               initialize IdSuppArticle
               perform RechercheArticleParId
               initialize IdArticleRecherche
           else
               accept libelle of SuppArticleInput line 6 col 32 prompt
               if libelle of SuppArticleInput not equal ' '
                   move libelle of SuppArticleInput to LibelleArticleRecherche
                   perform RechercheArticleParNom
                   initialize LibelleArticleRecherche
               else
                   perform ChoixArticle
                   move ChoixEcranArticle to IdArticleRecherche
                   perform RechercheArticleParId
                   initialize IdArticleRecherche
               end-if
           end-if.
           if ChoixEcranArticle <> 0 or libelle of ArticleRecupere <> ' ' or libelle of SuppArticleInput <> ' '
               move libelle of ArticleRecupere to libelle of SuppArticleInput
               move quantite_stock of ArticleRecupere to quantite_stock of SuppArticleInput
               move quantite_min of ArticleRecupere to quantite_min of SuppArticleInput
               move quantite_mediane of ArticleRecupere to quantite_mediane of SuppArticleInput
               move raison_sociale of ArticleRecupere to raison_sociale of SuppArticleInput

               display ecran-SuppArticle

               move "O" to ChoixSupprimerArticle
               display Ligne-DemandeSuppression
               accept ChoixSupprimerArticle line 5 col 62 reverse-video

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
                   move 1 to EOSUP
               end-if
           else
               continue
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
           move 0 to nbLigneReapprovisionnement.
           move 1 to noPageReapprovisionnement.
           move 0 to ecritureFichierDeCommande.
           initialize VueReapproArticleFournisseur.
           move space to CodeFournisseurPrecedent.

           exec sql
               declare C-ComparaisonStock cursor for
                   select code_article, libelle, quantite_stock, quantite_mediane, id_fournisseur, raison_sociale, adresse, cp, ville from ArticleFournisseur
                   where quantite_stock <= quantite_min
                   order by id_fournisseur
           end-exec.
           exec sql
             open C-ComparaisonStock
           end-exec.
           open output f-fichierCommandeStockBas.

       ComparaisonStock-trt.
           move code_fournisseur of VueReapproArticleFournisseur to CodeFournisseurPrecedent.

           exec sql
               fetch C-ComparaisonStock into
               :VueReapproArticleFournisseur.code_article,
               :VueReapproArticleFournisseur.libelle,
               :VueReapproArticleFournisseur.quantite_stock,
               :VueReapproArticleFournisseur.quantite_mediane,
               :VueReapproArticleFournisseur.code_fournisseur,
               :VueReapproArticleFournisseur.raison_sociale,
               :VueReapproArticleFournisseur.adresse,
               :VueReapproArticleFournisseur.cp,
               :VueReapproArticleFournisseur.ville
           end-exec.
           if (sqlcode not equal 0 and sqlcode not equal 1) then
               move 1 to EOCS
               if ecritureFichierDeCommande equal 1
                   perform EcritureFichierReapprovisionnement-piedDePageFin
                   move "Fichier(s) de commande genere(s) - Appuyez sur entree pour continuer" to MessageComparaison
                   display ligne-MenuReapprovisionnement
                   accept Pause line 5 col 77
               else
                   move "Le stock ne necessite pas de commande - Appuyez sur entree pour continuer" to MessageComparaison
                   display ligne-MenuReapprovisionnement
                   accept Pause line 5 col 77
               end-if
           else
               perform EcritureFichierReapprovisionnement
               move 1 to ecritureFichierDeCommande
           end-if.

       ComparaisonStock-fin.
           close f-fichierCommandeStockBas.

      *************************************************************
      *************************************************************
      * Ecriture fichier Réapprovisionnement
      *************************************************************
      *************************************************************

       EcritureFichierReapprovisionnement.
      *    On change de page à chaque nouveau fournisseur 
           if CodeFournisseurPrecedent not equal code_fournisseur of VueReapproArticleFournisseur
           and CodeFournisseurPrecedent not equal space
               perform EcritureFichierReapprovisionnement-piedDePageFin
               perform SautDePageNouveauFournisseur until nbLigneReapprovisionnement equal MaxLigneReapprovisionnement
               move 0 to nbLigneReapprovisionnement
               move 1 to noPageReapprovisionnement
           end-if.

      *    On ecrit l'entete si nouveau fournisseur ou 1er passage, ou nouvelle page
           if nbLigneReapprovisionnement equal 0
               perform EcritureFichierReapprovisionnement-entete
           end-if.

      *    On écrit les lignes d'articles quoi qu'il arrive
           perform EcritureFichierReapprovisionnement-corps
           
      *    Pagination
           if nbLigneReapprovisionnement equal MaxLigneReapprovisionnement
               perform EcritureFichierReapprovisionnement-piedDePageNouvellePage
           end-if.

       SautDePageNouveauFournisseur.
           write e-fichierCommandeStockBas from LigneVide.
           add 1 to nbLigneReapprovisionnement.

       EcritureFichierReapprovisionnement-entete.
           move noPageReapprovisionnement to NbPage of EnteteFichierReapprovisionnementStock.
           move jour of DateSysteme to jour of EnteteFichierReapprovisionnementStock.
           move mois of DateSysteme to mois of EnteteFichierReapprovisionnementStock.
           move annee of DateSysteme to annee of EnteteFichierReapprovisionnementStock.
           move raison_sociale of VueReapproArticleFournisseur to raison_sociale of EnteteFichierReapprovisionnementStock.
           move adresse of VueReapproArticleFournisseur to adresse of EnteteFichierReapprovisionnementStock.
           move cp of VueReapproArticleFournisseur to cp of EnteteFichierReapprovisionnementStock.
           move ville of VueReapproArticleFournisseur to ville of EnteteFichierReapprovisionnementStock.

           write e-fichierCommandeStockBas from ligne1 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne2 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne3 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne4 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne5 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne6 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne7 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne8 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne9 of EnteteFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from ligne10 of EnteteFichierReapprovisionnementStock.
           add 10 to nbLigneReapprovisionnement.

       EcritureFichierReapprovisionnement-corps.
           move spaces to donneeArticle of CorpsFichierReapprovisionnementStock.

           subtract quantite_stock of VueReapproArticleFournisseur from quantite_mediane of VueReapproArticleFournisseur giving totalReapprovisionnement.
           move totalReapprovisionnement to quantite of CorpsFichierReapprovisionnementStock.
           move code_article of VueReapproArticleFournisseur to code_article of CorpsFichierReapprovisionnementStock.
           move libelle of VueReapproArticleFournisseur to libelle of CorpsFichierReapprovisionnementStock.

           write e-fichierCommandeStockBas from CorpsFichierReapprovisionnementStock.
           add 1 to nbLigneReapprovisionnement.
           add 1 to testPagi.

       EcritureFichierReapprovisionnement-piedDePageFin.
           add 1 to nbLigneReapprovisionnement.
           move noPageReapprovisionnement to NbPage of FinPiedDePageFichierReapprovisionnementStock.

           write e-fichierCommandeStockBas from FinPiedDePageFichierReapprovisionnementStock.

       EcritureFichierReapprovisionnement-piedDePageNouvellePage.
           move noPageReapprovisionnement to NbPage of PiedDePageFichierReapprovisionnementStock.
           write e-fichierCommandeStockBas from PiedDePageFichierReapprovisionnementStock.
           add 1 to noPageReapprovisionnement.
           move 0 to nbLigneReapprovisionnement.

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
               when 2
                   perform AjoutFournisseur
               when 3
                   perform ModifFournisseur
               when 4
                   perform SuppFournisseur

           end-evaluate.
       MenuFournisseur-fin.
           continue.
       ListeFournisseur.
           perform DetailFournisseur-init.
           perform DetailFournisseur-trt until EOF = 1.
           perform DetailFournisseur-fin.
       DetailFournisseur-init.
           move 0 to EOF.

       DetailFournisseur-trt.
           move 1 to EOF.
           initialize ChoixEcranFournisseur.
           initialize IdFournisseurRecherche.
           perform ChoixDuFournisseur.
           move ChoixEcranFournisseur to IdFournisseurRecherche.
           if ChoixEcranFournisseur <> 0
               perform RechercheFournisseurParId
               move raison_sociale of FournisseurRecupere to raison_sociale of DetailFournisseurInput
               move siret of FournisseurRecupere to siret of DetailFournisseurInput
               move adresse of FournisseurRecupere to adresse of DetailFournisseurInput
               move cp of FournisseurRecupere to cp of DetailFournisseurInput
               move ville of FournisseurRecupere to ville of DetailFournisseurInput
               move pays of FournisseurRecupere to pays of DetailFournisseurInput
               move tel of FournisseurRecupere to tel of DetailFournisseurInput
               move date_crea of FournisseurRecupere to FournisseurDateCreationAffichage
               move date_modif of FournisseurRecupere to FournisseurDateModifAffichage
               perform AffichageDetailFournisseur
           end-if.
       DetailFournisseur-fin.
           continue.

       AffichageDetailFournisseur.
           move "R" to ChoixDetailFournisseur
           display ecran-DetailFournisseur.
           display Ligne-ChoixDetailFournisseur
           accept ChoixDetailFournisseur line 5 col 47 reverse-video auto.
           evaluate ChoixDetailFournisseur
               when "M"
               when "m"
                   move id_fournisseur of FournisseurRecupere to IdModifFournisseur
                   perform ModifFournisseur
               when "S"
               when "s"
                   move id_fournisseur of FournisseurRecupere to IdSuppFournisseur
                   perform SuppFournisseur
               when other
                   continue
           end-evaluate.
       AjoutFournisseur.
           perform AjoutFournisseur-init.
           perform AjoutFournisseur-trt until EOAF = 1.
           perform AjoutFournisseur-fin.
       AjoutFournisseur-init.
           move 0 to EOAF.
           initialize AjoutFournisseurInput.
       AjoutFournisseur-trt.
           
           display ecran-AjoutFournisseur.

           if ChoixAjoutFournisseur = "a" or ChoixAjoutFournisseur = "A"
      *    On verifie si le fournisseur est deja dans la base de donnees
               exec sql
                   SELECT COUNT(*) INTO :VerifFournisseurPresent
                   FROM Fournisseur
                   WHERE Fournisseur.raison_sociale = :AjoutFournisseurInput.raison_sociale
               end-exec

      *    Si absent on ajoute le fournisseur
               if VerifFournisseurPresent equal 0
                   exec sql
                       INSERT INTO Fournisseur (raison_sociale, siret, adresse, cp, ville, pays, tel)
                       VALUES (:AjoutFournisseurInput.raison_sociale, :AjoutFournisseurInput.siret, :AjoutFournisseurInput.adresse, :AjoutFournisseurInput.cp, :AjoutFournisseurInput.ville, :AjoutFournisseurInput.pays, :AjoutFournisseurInput.tel)
                   end-exec
                   display Ligne-FournisseurAjoute
                   move 1 to EOAF
                   accept Pause
               else
                   display Ligne-AlerteFournisseurPresent
                   initialize ChoixAjoutFournisseur
                   accept Pause
               end-if
               
           else
               display ecran-AjoutFournisseur
               accept raison_sociale of AjoutFournisseurInput line 6 col 32 prompt
      *    On verifie que le champ obligatoire est bien rempli
               if raison_sociale of AjoutFournisseurInput not equal ' '
                   accept siret of AjoutFournisseurInput line 7 col 32 prompt
                   accept adresse of AjoutFournisseurInput line 8 col 32 prompt
                   accept cp of AjoutFournisseurInput line 9 col 32 prompt
                   accept ville of AjoutFournisseurInput line 10 col 32 prompt
                   accept pays of AjoutFournisseurInput line 11 col 32 prompt
                   accept tel of AjoutFournisseurInput line 12 col 32 prompt
                   move "A" to ChoixAjoutFournisseur
                   display Ligne-ChoixArticleAjoute
                   accept ChoixAjoutFournisseur line 5 col 44 auto reverse-video
               else
      *    On signale que le champ est obligatoire on propose de quitte le menu ajout
                   move "Q" to ChoixChampObligatoire
                   display Ligne-ChampObligatoire
                   accept ChoixChampObligatoire line 5 col 59 reverse-video
                   if ChoixChampObligatoire = "Q" or ChoixChampObligatoire = "q"
                       move 1 to EOAF
                   end-if
               end-if
           end-if.

       AjoutFournisseur-fin.
           initialize AjoutFournisseurInput.
           initialize ChoixAjoutFournisseur.

       ModifFournisseur.
           perform ModifFournisseur-init
           perform ModifFournisseur-trt until EOMF = 1.
           perform ModifFournisseur-fin.

       ModifFournisseur-init.
           move 0 to EOMF.
           exec sql
           declare C-ModifFournisseur cursor for
                      select id_fournisseur, raison_sociale, siret, adresse, cp, ville, pays,tel, date_crea, date_modif
                              from Fournisseur
                                 Order by raison_sociale
           end-exec.

           exec sql
               open C-ModifFournisseur
           End-exec.
       ModifFournisseur-trt.
           move 1 to EOMF.
           initialize FournisseurRecupere.
           initialize ModifFournisseurInput.
           display ecran-ModifFournisseur.

           if IdModifFournisseur <> 0
               move IdModifFournisseur to IdFournisseurRecherche
               initialize IdModifFournisseur
               perform RechercheFournisseurParId
               initialize IdFournisseurRecherche
           else
               accept raison_sociale of ModifFournisseurInput line 6 col 32 prompt
               if raison_sociale of ModifFournisseurInput not equal ' '
                   move raison_sociale of ModifFournisseurInput to RaisonSocialeFournisseurRecherche
                   perform RechercheFournisseurParNom
                   initialize RaisonSocialeFournisseurRecherche
               else
                   perform ChoixDuFournisseur
                   move ChoixEcranFournisseur to IdFournisseurRecherche
                   perform RechercheFournisseurParId
                   initialize IdFournisseurRecherche
               end-if
           end-if.

           if ChoixEcranFournisseur <> 0 or raison_sociale of FournisseurRecupere <> ' ' or raison_sociale of ModifFournisseurInput <> ' '
               exec sql
                   SELECT COUNT(*) INTO :VerifFournisseurPresent
                   FROM Fournisseur
                   WHERE raison_sociale = :ModifFournisseurInput.raison_sociale
                   OR    raison_sociale = :FournisseurRecupere.raison_sociale
               end-exec
               if VerifFournisseurPresent <> 0
                   move raison_sociale of FournisseurRecupere to raison_sociale of ModifFournisseurInput
                   move siret of FournisseurRecupere to siret of ModifFournisseurInput
                   move adresse of FournisseurRecupere to adresse of ModifFournisseurInput
                   move cp of FournisseurRecupere to cp of ModifFournisseurInput
                   move ville of FournisseurRecupere to ville of ModifFournisseurInput
                   move pays of FournisseurRecupere to pays of ModifFournisseurInput
                   move tel of FournisseurRecupere to tel of ModifFournisseurInput

                   display ecran-ModifFournisseur

                   accept raison_sociale of ModifFournisseurInput line 6 col 32 prompt
                   accept siret of ModifFournisseurInput line 7 col 32 prompt
                   accept adresse of ModifFournisseurInput line 8 col 32 prompt
                   accept cp of ModifFournisseurInput line 9 col 32 prompt
                   accept ville of ModifFournisseurInput line 10 col 32 prompt
                   accept pays of ModifFournisseurInput line 11 col 32 prompt
                   accept tel of ModifFournisseurInput line 12 col 32 prompt
                   if  raison_sociale of ModifFournisseurInput = ' '
                       display Ligne-ChampRaisonSocialeObligatoire
                       accept Pause
                   else
                       if raison_sociale of ModifFournisseurInput = ' ' and
                         siret of ModifFournisseurInput = ' ' and
                         adresse of ModifFournisseurInput = ' ' and
                         cp of ModifFournisseurInput = ' ' and
                         ville of ModifFournisseurInput = ' ' and
                         pays of ModifFournisseurInput = ' ' and
                         tel of ModifFournisseurInput = ' ' then
                           continue
                       else
                           if raison_sociale of ModifFournisseurInput <> raison_sociale of FournisseurRecupere
                               initialize VerifFournisseurPresent
                               exec sql
                                   SELECT COUNT(*) INTO :VerifFournisseurPresent
                                   FROM Fournisseur
                                   WHERE raison_sociale = :ModifFournisseurInput.raison_sociale
                               end-exec
                               if VerifFournisseurPresent <> 0
                                   display Ligne-AlerteFournisseurPresent
                                   accept Pause
                               else
                                   if raison_sociale of ModifFournisseurInput = ' ' and raison_sociale of FournisseurRecupere
                                     <> ' '
                                       display Ligne-ChampRaisonSocialeObligatoire
                                       accept Pause
                                   else
                                       perform ModifFournisseurBDD
                                   end-if
                               end-if
                           else
                               perform ModifFournisseurBDD
                           end-if
                       end-if
                   end-if
               else
                   display Ligne-AlerteSuppFournisseurAbsent
                   accept Pause
               end-if
           else
               continue
           end-if.

       ModifFournisseur-fin.
           initialize FournisseurRecupere.
           initialize ModifFournisseurInput.
       
       ModifFournisseurBDD.
           if raison_sociale of FournisseurRecupere <> raison_sociale of ModifFournisseurInput 
           or siret of FournisseurRecupere <> siret of ModifFournisseurInput
           or adresse of FournisseurRecupere <> adresse of ModifFournisseurInput
           or cp of FournisseurRecupere <> cp of ModifFournisseurInput
           or ville of FournisseurRecupere <> ville of ModifFournisseurInput
           or pays of FournisseurRecupere <> pays of ModifFournisseurInput
           or tel of FournisseurRecupere <> tel of ModifFournisseurInput then
               move "M" to ChoixModifFournisseur
               display EffaceLigne5
               display Ligne-ChoixFournisseurModifie
               accept ChoixModifFournisseur line 5 col 45 reverse-video
               if ChoixModifFournisseur = "M" or ChoixModifFournisseur = "m"
                   exec sql
                   UPDATE Fournisseur
                       SET raison_sociale =    :ModifFournisseurInput.raison_sociale,
                           siret =             :ModifFournisseurInput.siret,
                           adresse =           :ModifFournisseurInput.adresse,
                           cp =                :ModifFournisseurInput.cp,
                           ville =             :ModifFournisseurInput.ville,
                           pays =              :ModifFournisseurInput.pays,
                           tel =               :ModifFournisseurInput.tel,
                           date_modif =        getdate()
                       WHERE
                           id_Fournisseur = :FournisseurRecupere.id_Fournisseur
                   end-exec
               
                   if sqlcode equal 0
                       move 1 to EOM
                       display Ligne-FournisseurModifie
                       accept Pause
                   end-if
               end-if
           end-if.
       SuppFournisseur.
           perform SuppFournisseur-init
           perform SuppFournisseur-trt until EOSUPF = 1.
           perform SuppFournisseur-fin.
       SuppFournisseur-init.
           move 0 to EOSUPF.
       SuppFournisseur-trt.
           initialize FournisseurRecupere.
           initialize VerifArticleFournisseurPresent.
           initialize VerifFournisseurPresent.
           initialize SuppFournisseurInput
           initialize ChoixEcranFournisseur
           move 1 to EOSUPF.
           display ecran-SuppFournisseur.

           if IdSuppFournisseur <> 0
               move IdSuppFournisseur to IdFournisseurRecherche
               initialize IdSuppFournisseur
               perform RechercheFournisseurParId
               initialize IdFournisseurRecherche
           else
               accept raison_sociale of SuppFournisseurInput line 6 col 32 prompt
               if raison_sociale of SuppFournisseurInput not equal ' '
                   move raison_sociale of SuppFournisseurInput to RaisonSocialeFournisseurRecherche
                   perform RechercheFournisseurParNom
                   initialize RaisonSocialeFournisseurRecherche
               else
                   perform ChoixDuFournisseur
                   move ChoixEcranFournisseur to IdFournisseurRecherche
                   perform RechercheFournisseurParId
                   initialize IdFournisseurRecherche
               end-if
           end-if.



           if ChoixEcranFournisseur <> 0 or raison_sociale of FournisseurRecupere <> ' ' or raison_sociale of SuppFournisseurInput <> ' '
               exec sql
                   SELECT COUNT(*) INTO :VerifFournisseurPresent
                   FROM Fournisseur
                   WHERE raison_sociale = :SuppFournisseurInput.raison_sociale
                   OR    raison_sociale = :FournisseurRecupere.raison_sociale
               end-exec
               if VerifFournisseurPresent <> 0
                   move raison_sociale of SuppFournisseurInput to RaisonSocialeFournisseurRecherche
                   perform RechercheFournisseurParNom
                   initialize RaisonSocialeFournisseurRecherche

                   move raison_sociale of FournisseurRecupere to raison_sociale of SuppFournisseurInput
                   move siret of FournisseurRecupere to siret of SuppFournisseurInput
                   move adresse of FournisseurRecupere to adresse of SuppFournisseurInput
                   move cp of FournisseurRecupere to cp of SuppFournisseurInput
                   move ville of FournisseurRecupere to ville of SuppFournisseurInput
                   move pays of FournisseurRecupere to pays of SuppFournisseurInput
                   move tel of FournisseurRecupere to tel of SuppFournisseurInput

                   display ecran-SuppFournisseur

                   move "O" to ChoixSupprimerFournisseur
                   display Ligne-DemandeSuppression
                   accept ChoixSupprimerFournisseur line 5 col 62 reverse-video

                   if ChoixSupprimerFournisseur = "O" or ChoixSupprimerFournisseur = "o"
                       exec sql
                           SELECT COUNT(*) INTO :VerifArticleFournisseurPresent
                           FROM Article
                           WHERE id_fournisseur = :FournisseurRecupere.id_fournisseur
                       end-exec
                       if VerifArticleFournisseurPresent equal 0
                           perform SuppFournisseurBDD
                       else
                           move 1 to EOSUPF
                           display Ligne-AlerteArticleFournisseurPresent
                           accept Pause line 1 col 1
                       end-if
                   else
                       move 1 to EOSUPF
                   end-if
               else
                   display Ligne-AlerteSuppFournisseurAbsent
                   accept Pause
               end-if
           else
              continue
           end-if.
       SuppFournisseur-fin.
           initialize FournisseurRecupere.
       SuppFournisseurBDD.
           exec sql
               DELETE FROM Fournisseur
               WHERE id_fournisseur = :FournisseurRecupere.id_fournisseur
           end-exec.
           if sqlcode = 0
               move 1 to EOSUPF
               initialize FournisseurRecupere
               initialize SuppFournisseurInput
               display ecran-SuppFournisseur
               display EffaceLigne5
               display Ligne-FournisseurSupprime
               accept Pause line 1 col 1
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
             SELECT id_fournisseur INTO :CodeFournisseur FROM fournisseur WHERE id_fournisseur = :commande.code_fournisseur
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
      * CHOIX ARTICLE
      *************************************************************
      *************************************************************
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
               display Ligne-SelectionFournisseur
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
               accept responseChoixArticle line 1 col 29 reverse-video

               if responseChoixArticle = "M" or responseChoixArticle = "m"
                   move 1 to EOCA

               else
                   move 7 to NoLigneChoixArticle
               end-if
           end-if.
           
      *************************************************************
      *************************************************************
      * CHOIX FOURNISSEUR
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
               display Ligne-SelectionFournisseur
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
               accept responseChoixFournisseur line 1 col 29 reverse-video

               if responseChoixFournisseur = "M" or responseChoixFournisseur = "m"
                   move 1 to EOCF
               else
                   move 7 to NoLigneChoixFournisseur
               end-if

            end-if.

      **************************************************************
      **************************************************************
      ** METHODES DE RECHERCHE ARTICLE ET FOURNISSEUR
      **************************************************************
      **************************************************************

      **********************************************************
      *   Recherche un article dans la BDD par son libellé     *
      *                                                        *
      *   Renseigner LibelleArticleRecherche avec le libellé   *
      **********************************************************
       RechercheArticleParNom.
           exec sql
              SELECT code_article,id_fournisseur, libelle, quantite_stock, quantite_min, quantite_mediane, date_crea, date_modif, raison_sociale
              INTO :ArticleRecupere.code_article,
                   :ArticleRecupere.id_fournisseur,
                   :ArticleRecupere.libelle,
                   :ArticleRecupere.quantite_stock,
                   :ArticleRecupere.quantite_min,
                   :ArticleRecupere.quantite_mediane,
                   :ArticleRecupere.date_crea,
                   :ArticleRecupere.date_modif,
                   :ArticleRecupere.raison_sociale
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
              SELECT   code_article,id_fournisseur, libelle, quantite_stock, quantite_min, quantite_mediane, date_crea, date_modif, raison_sociale
              INTO :ArticleRecupere.code_article,
                   :ArticleRecupere.id_fournisseur,
                   :ArticleRecupere.libelle,
                   :ArticleRecupere.quantite_stock,
                   :ArticleRecupere.quantite_min,
                   :ArticleRecupere.quantite_mediane,
                   :ArticleRecupere.date_crea,
                   :ArticleRecupere.date_modif,
                   :ArticleRecupere.raison_sociale
              FROM ArticleFournisseur
              WHERE code_article = :IdArticleRecherche
          end-exec.

      ***************************************************************************
      *   Recherche un Fournisseur dans la BDD par sa raison sociale            *
      *                                                                         *
      *   Renseigner RaisonSocialeFournisseurRecherche avec la raison sociale   *
      ***************************************************************************
       RechercheFournisseurParNom.
           exec sql
              SELECT id_fournisseur, raison_sociale, siret, adresse, cp, ville, pays, tel, date_crea, date_modif
              INTO :FournisseurRecupere.id_fournisseur, :FournisseurRecupere.raison_sociale, :FournisseurRecupere.siret,
                                :FournisseurRecupere.adresse, :FournisseurRecupere.cp, :FournisseurRecupere.ville, :FournisseurRecupere.pays, :FournisseurRecupere.tel, :FournisseurRecupere.date_crea, :FournisseurRecupere.date_modif
              FROM Fournisseur
              WHERE raison_sociale = :RaisonSocialeFournisseurRecherche
          end-exec.

      ***************************************************************************
      *   Recherche un Fournisseur dans la BDD par son ID                       *
      *                                                                         *
      *   Renseigner IdFournisseurRecherche avec l id_fournisseur               *
      ***************************************************************************
       RechercheFournisseurParId.
           exec sql
              SELECT id_fournisseur, raison_sociale, siret, adresse, cp, ville, pays, tel, date_crea, date_modif
              INTO :FournisseurRecupere.id_fournisseur,
                   :FournisseurRecupere.raison_sociale,
                   :FournisseurRecupere.siret,
                   :FournisseurRecupere.adresse,
                   :FournisseurRecupere.cp,
                   :FournisseurRecupere.ville,
                   :FournisseurRecupere.pays,
                   :FournisseurRecupere.tel,
                   :FournisseurRecupere.date_crea,
                   :FournisseurRecupere.date_modif
              FROM Fournisseur
              WHERE id_fournisseur = :IdFournisseurRecherche
          end-exec.






       end program Program1.