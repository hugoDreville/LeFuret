import 'article.dart';
import 'db_article.dart';
import 'ihm_principale.dart';

class IHMArticle {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Article");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMArticle.menuSelectArticle();
      } else if (choix == 2) {
        await IHMArticle.insertArticle();
      } else if (choix == 3) {
        await IHMArticle.updateArticle();
      } else if (choix == 4) {
        await IHMArticle.deleteArticle();
      } else if (choix == 5) {
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
      print("Menu - Select Article");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
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
    String titre = IHMprincipale.saisieString();
    String type = IHMprincipale.saisieString();
    int quantite = IHMprincipale.saisieInt();
    int prix = IHMprincipale.saisieInt();
    String anneeParution = IHMprincipale.saisieString();
    int idEditeur = IHMprincipale.saisieID();
    int idAuteur = IHMprincipale.saisieID();
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
    int id = IHMprincipale.saisieID();
    if (await DBArticle.exist(id)) {
      String titre = IHMprincipale.saisieString();
      String type = IHMprincipale.saisieString();
      int quantite = IHMprincipale.saisieInt();
      double prix = IHMprincipale.saisieDouble();
      String anneeParution = IHMprincipale.saisieString();
      int idEditeur = IHMprincipale.saisieID();
      int idAuteur = IHMprincipale.saisieID();
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

  // action pour afficher un Article selon ID
  static Future<void> selectArticle() async {
    print("Quelle Article voulez vous afficher ?");
    int id = IHMprincipale.saisieID();
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
    int id = IHMprincipale.saisieID();
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
