
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

       01 Commande.
           10 code_fournisseur sql char (10).
           10 no_commande sql char (10).
           10 date_commande pic x(8).
           10 code_article pic 9(10).
           10 quantite pic 9(10).

       77 CodeFournisseur pic x(9).
       77 QuantiteTotalCommande pic 9(6).
       77 NoLigneArticle pic 9(10).
       77 NoLigneCommande pic 9(10).
       77 TotalLigneCommande pic 9(10).
       77 Choix pic x.
       77 Response pic x.
       77 EOF pic 9.
       77 EOR pic 9.
       77 EOA pic 9.
       77 tally-counter pic 9.

       01 MessageErreurCommande pic x(80).

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
         10 line 5 col 77 pic 9 from Choix.
         10 line 11 col 15 value "1. Liste des articles".
         10 line 12 col 15 value "2. Ajouter un article".
         10 line 13 col 15 value "3. Modifier un article".
         10 line 14 col 15 value "4. Supprimer un article".
         10 line 15 col 15 value "5. Consulter - Stock".
         10 line 17 col 15 value "0. Retour au menu principal".

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
             "Trusted_Connection=yes;Database=danstonstock2;server=DESKTOP-16DLBER\SQLEXPRESS;factory=system.Data.SqlClient;"
             to CNXDB.
           exec sql
             connect using :CNXDB
           end-exec.

           if (sqlcode not equal 0)
             then
               display "Erreur connexion base de donn�e" line 4 col 15
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

      * D�claration du curseur
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

      *    On v�rifie que l'ent�te est conforme
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

      *    On v�rifie que le fournisseur existe en BDD
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

      *    On v�rifie que la ligne article est conforme
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
      *    on enl�ve la derni�re ligne
           subtract 1 from NoligneCommande.
           string NoligneCommande delimited by size into TotalLigneCommande.
           subtract quantite of Commande from QuantiteTotalCommande.

      *    v�rification du total de la quantite et du nombre de lignes
           if (QuantiteTotalCommande not equal quantite of Commande
               or TotalLigneCommande not equal code_article of Commande)
               move "Quantite d'articles ou nombre de lignes totales non conforme" to MessageErreurCommande
           end-if.

       VerificationFichier-fin.
           perform CloseInput.

       TraitementCommande.
           perform TraitementCommande-init.
           perform TraitementCommande-trt until NoligneCommande = TotalLigneCommande.
           perform TraitementCommande-fin.

       TraitementCommande-init.
           move spaces to Article.
           move 1 to NoligneCommande.
           perform OpenInput.

      *    On passe la premi�re ligne
           perform ReadFichier.
      *    Insertion ent�te commande
           exec sql
               INSERT INTO Commande (date_commande, id_fournisseur)
                   VALUES (
                       CAST(:Commande.date_commande as date),
                       :Commande.code_fournisseur
                       )
           end-exec.
      *    On r�cup�re l'id de la commande nouvellement ins�r�e
           exec sql
               SELECT scope_identity() into :Commande.no_commande
           end-exec.

       TraitementCommande-trt.
           perform ReadFichier.
           perform unstringEnregistrementCommande.
           move zero to code_article of Article.
           exec sql
               select
                   code_article,
                   quantite_stock,
                   quantite_min
                   into
                   :article.code_article,
                   :article.quantite_stock,
                   :article.quantite_min
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
       TraitementCommande-fin.
           perform CloseInput.
           display ligne-MenuCommandeSucces.
           accept ChoixNoCommande line 5 col 77.

       end program Program1.