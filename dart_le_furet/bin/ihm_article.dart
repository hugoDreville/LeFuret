import 'package:mysql1/mysql1.dart';
import 'article.dart';
import 'auteur.dart';
import 'db_article.dart';
import 'db_auteur.dart';
import 'db_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IHMArticle {
  //affiche le menu principal de Article
  static Future<void> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+--------------------------------------------------+");
      print("|           Menu - Gestion Article                 |");
      print("|  1- Afficher des données de la table             |");
      print("|  2- Inserer une données dans la table            |");
      print("|  3- Modifier le stock                            |");
      print("|  4- Modifier une données dans la table           |");
      print("|  5- Supprimer tout les articles d'un editeur     |");
      print("|  6- Supprimer tout les articles d'un auteur      |");
      print("|  7- Supprimer une données dans la tables         |");
      print("|  8- Supprimer toutes les données dans la tables  |");
      print("|  0- Quitter                                      |");
      print("+--------------------------------------------------+");
      choix = IHMprincipale.choixMenu(8);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMArticle.menuSelectArticle(settings);
      } else if (choix == 2) {
        await IHMArticle.insertArticle(settings);
      } else if (choix == 3) {
        await IHMArticle.modifierArticle(settings);
      } else if (choix == 4) {
        await IHMArticle.updateArticle(settings);
      } else if (choix == 5) {
        await IHMArticle.deleteArticleEditeur(settings);
      } else if (choix == 6) {
        await IHMArticle.deleteArticleAuteur(settings);
      } else if (choix == 7) {
        await IHMArticle.deleteArticle(settings);
      } else if (choix == 8) {
        await IHMArticle.deleteAllArticles(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

//Affiche le menu pour les Affichages
  static Future<void> menuSelectArticle(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+-----------------------------------------+");
      print("|           Menu - Select Article         |");
      print("|  1- Afficher selon ID                   |");
      print("|  2- Afficher toute la table             |");
      print("|  3- Afficher par prix (croissant)       |");
      print("|  4- Afficher par quantité (croissant)   |");
      print("|  5- Afficher des infos sur l'editeur    |");
      print("|  6- Afficher des infos sur l'auteur     |");
      print("|  0- Quitter                             |");
      print("+-----------------------------------------+");
      choix = IHMprincipale.choixMenu(6);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMArticle.selectArticle(settings);
      } else if (choix == 2) {
        await IHMArticle.selectAllArticle(settings);
      } else if (choix == 3) {
        await IHMArticle.selectAllArticlePrix(settings);
      } else if (choix == 4) {
        await IHMArticle.selectAllArticleQuantite(settings);
      } else if (choix == 5) {
        await IHMArticle.infoEditeur(settings);
      } else if (choix == 6) {
        await IHMArticle.infoAuteur(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Article
  static Future<void> insertArticle(ConnectionSettings settings) async {
    String titre = IHMprincipale.saisieString("le titre");
    String type = IHMprincipale.saisieString("le type");
    int quantite = IHMprincipale.saisieInt("la quantité");
    double prix = IHMprincipale.saisieDouble();
    String anneeParution = IHMprincipale.saisieString("l'année de parution");
    int idEditeur = IHMprincipale.saisieID("de l'editeur");
    int idAuteur = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      await DBArticle.insertArticle(settings, titre, type, quantite, prix,
          anneeParution, idEditeur, idAuteur);
      print("Article inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Article selon ID
  static Future<void> updateArticle(ConnectionSettings settings) async {
    print("Quelle Article voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'article");
    if (await DBArticle.exist(settings, id)) {
      String titre = IHMprincipale.saisieString("le titre");
      String type = IHMprincipale.saisieString("le type");
      int quantite = IHMprincipale.saisieInt("la quantité");
      double prix = IHMprincipale.saisieDouble();
      String anneeParution = IHMprincipale.saisieString("l'année de parution");
      int idEditeur = IHMprincipale.saisieID("de l'editeur");
      int idAuteur = IHMprincipale.saisieID("de l'auteur");
      if (IHMprincipale.confirmation()) {
        await DBArticle.updateArticle(settings, id, titre, type, quantite, prix,
            anneeParution, idEditeur, idAuteur);
        print("Article $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      IHMprincipale.wait();
    } else {
      print("L'article $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour mettre a jour le stock d'un Article selon ID
  static Future<void> modifierArticle(ConnectionSettings settings) async {
    print("Dans quelle Article voulez vous modifier le stock ?");
    int id = IHMprincipale.saisieID("de l'article a modifié");
    if (await DBArticle.exist(settings, id)) {
      int quantite = IHMprincipale.saisieInt("la quantité");
      if (IHMprincipale.confirmation()) {
        await DBArticle.modifierArticle(settings, id, quantite);
        print("Article $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      IHMprincipale.wait();
    } else {
      print("L'article $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour afficher un Article selon ID
  static Future<void> selectArticle(ConnectionSettings settings) async {
    print("Quelle Article voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'article");
    Article art = await DBArticle.selectArticle(settings, id);
    if (!art.estNull()) {
      IHMprincipale.afficherUneDonnee(art);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'article $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les informations sur l'editeur d'un Article selon ID
  static Future<void> infoEditeur(ConnectionSettings settings) async {
    print("De quelle Article voulez vous afficher les informations?");
    int id = IHMprincipale.saisieID("de l'article");
    Article art = await DBArticle.selectArticle(settings, id);
    if (!art.estNull()) {
      int idEdi = art.getIdEditeur();
      Editeur edi = await DBEditeur.selectEditeur(settings, idEdi);
      IHMprincipale.afficherUneDonnee(edi);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'article $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les informations sur l'auteur d'un Article selon ID
  static Future<void> infoAuteur(ConnectionSettings settings) async {
    print("De quelle Article voulez vous afficher les informations?");
    int id = IHMprincipale.saisieID("de l'article");
    Article art = await DBArticle.selectArticle(settings, id);
    if (!art.estNull()) {
      int idAut = art.getIdAuteur();
      Auteur aut = await DBAuteur.selectAuteur(settings, idAut);
      IHMprincipale.afficherUneDonnee(aut);
      print("Fin de l'opération.");

      print("--------------------------------------------------");
    } else {
      print("L'article $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les articles
  static Future<void> selectAllArticle(ConnectionSettings settings) async {
    List<Article> listeArticle = await DBArticle.selectAllArticles(settings);
    if (listeArticle.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeArticle);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les articles classé par prix(croissant)
  static Future<void> selectAllArticlePrix(ConnectionSettings settings) async {
    List<Article> listeArticle =
        await DBArticle.selectAllArticlesPrix(settings);
    if (listeArticle.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeArticle);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les articles classé par quantité(croissant)
  static Future<void> selectAllArticleQuantite(
      ConnectionSettings settings) async {
    List<Article> listeArticle =
        await DBArticle.selectAllArticlesQuantite(settings);
    if (listeArticle.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeArticle);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

// action pour supprimer un Article selon ID
  static Future<void> deleteArticle(ConnectionSettings settings) async {
    print("Quelle Article voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'article");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticle(settings, id);
      print("Article $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

// action pour supprimer les Articles d'un Editeur selon son ID
  static Future<void> deleteArticleEditeur(ConnectionSettings settings) async {
    print("De quel editeur voulez vous supprimer ces article(s) ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticleEditeur(settings, id);
      print("Les article de l'editeur $id ont étaient supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

// action pour supprimer les Articles d'un Auteur selon son ID
  static Future<void> deleteArticleAuteur(ConnectionSettings settings) async {
    print("De quel auteur voulez vous supprimer ces article(s) ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticleAuteur(settings, id);
      print("Les article de l'auteur $id ont étaient supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour supprimer les Articles
  static Future<void> deleteAllArticles(ConnectionSettings settings) async {
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteAllArticle(settings);
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }
}
