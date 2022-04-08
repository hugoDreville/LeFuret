import 'article.dart';
import 'db_article.dart';
import 'ihm_principale.dart';

class IHMArticle {
  static Future<void> menu() async {
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
        await IHMArticle.menuSelectArticle();
      } else if (choix == 2) {
        await IHMArticle.insertArticle();
      } else if (choix == 3) {
        await IHMArticle.modifierArticle();
      } else if (choix == 4) {
        await IHMArticle.updateArticle();
      } else if (choix == 5) {
        await IHMArticle.deleteArticleEditeur();
      } else if (choix == 6) {
        await IHMArticle.deleteArticleAuteur();
      } else if (choix == 7) {
        await IHMArticle.deleteArticle();
      } else if (choix == 8) {
        await IHMArticle.deleteAllArticles();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectArticle() async {
    int choix = -1;
    while (choix != 0) {
      print("+-----------------------------------------+");
      print("|           Menu - Select Article         |");
      print("|  1- Afficher selon ID                   |");
      print("|  2- Afficher toute la table             |");
      print("|  0- Quitter                             |");
      print("+-----------------------------------------+");
      choix = IHMprincipale.choixMenu(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMArticle.selectArticle();
      } else if (choix == 2) {
        await IHMArticle.selectAllArticle();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Article
  static Future<void> insertArticle() async {
    String titre = IHMprincipale.saisieString("le titre");
    String type = IHMprincipale.saisieString("le type");
    int quantite = IHMprincipale.saisieInt("la quantité");
    double prix = IHMprincipale.saisieDouble();
    String anneeParution = IHMprincipale.saisieString("l'année de parution");
    int idEditeur = IHMprincipale.saisieID("de l'editeur");
    int idAuteur = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      await DBArticle.insertArticle(
          titre, type, quantite, prix, anneeParution, idEditeur, idAuteur);
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
  static Future<void> updateArticle() async {
    print("Quelle Article voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'article");
    if (await DBArticle.exist(id)) {
      String titre = IHMprincipale.saisieString("le titre");
      String type = IHMprincipale.saisieString("le type");
      int quantite = IHMprincipale.saisieInt("la quantité");
      double prix = IHMprincipale.saisieDouble();
      String anneeParution = IHMprincipale.saisieString("l'année de parution");
      int idEditeur = IHMprincipale.saisieID("de l'editeur");
      int idAuteur = IHMprincipale.saisieID("de l'auteur");
      if (IHMprincipale.confirmation()) {
        await DBArticle.updateArticle(id, titre, type, quantite, prix,
            anneeParution, idEditeur, idAuteur);
        print("Article $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'article $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  static Future<void> modifierArticle() async {
    print("Dans quelle Article voulez vous modifier le stock ?");
    int id = IHMprincipale.saisieID("de l'article a modifié");
    if (await DBArticle.exist(id)) {
      int quantite = IHMprincipale.saisieInt("la quantité");
      if (IHMprincipale.confirmation()) {
        await DBArticle.modifierArticle(id, quantite);
        print("Article $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'article $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un Article selon ID
  static Future<void> selectArticle() async {
    print("Quelle Article voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'article");
    Article art = await DBArticle.selectArticle(id);
    if (!art.estNull()) {
      IHMprincipale.afficherUneDonnee(art);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'article $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les articles
  static Future<void> selectAllArticle() async {
    List<Article> listeArticle = await DBArticle.selectAllArticles();
    if (listeArticle.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeArticle);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer un Article selon ID
  static Future<void> deleteArticle() async {
    print("Quelle Article voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'article");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticle(id);
      print("Article $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  static Future<void> deleteArticleEditeur() async {
    print("De quel editeur voulez vous supprimer ces article(s) ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticleEditeur(id);
      print("Les article de l'editeur $id ont étaient supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  static Future<void> deleteArticleAuteur() async {
    print("De quel auteur voulez vous supprimer ces article(s) ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteArticleAuteur(id);
      print("Les article de l'auteur $id ont étaient supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour supprimer les Articles
  static Future<void> deleteAllArticles() async {
    if (IHMprincipale.confirmation()) {
      DBArticle.deleteAllArticle();
      print("Tables supprimées.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }
}
