import 'db_auteur.dart';
import 'auteur.dart';
import 'ihm_principale.dart';
import 'article.dart';

class IHMAuteur {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("+--------------------------------------------------+");
      print("|             Menu - Gestion Auteur                |");
      print("|  1- Afficher des données de la table             |");
      print("|  2- Inserer une données dans la table            |");
      print("|  3- Modifier une données dans la table           |");
      print("|  4- Supprimer une données dans la tables         |");
      print("|  5- Supprimer toutes les données dans la tables  |");
      print("|  0- Quitter                                      |");
      print("+--------------------------------------------------+");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMAuteur.menuSelectAuteur();
      } else if (choix == 2) {
        await IHMAuteur.insertAuteur();
      } else if (choix == 3) {
        await IHMAuteur.updateAuteur();
      } else if (choix == 4) {
        await IHMAuteur.deleteAuteur();
      } else if (choix == 5) {
        await IHMAuteur.deleteAllAuteurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectAuteur() async {
    int choix = -1;
    while (choix != 0) {
      print("+----------------------------------------+");
      print("|          Menu - Select Auteur          |");
      print("|  1- Afficher selon ID                  |");
      print("|  2- Afficher toute la table            |");
      print("|  3- Afficher tout les articles         |");
      print("|  0- Quitter                            |");
      print("+----------------------------------------+");
      choix = IHMprincipale.choixMenu(3);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMAuteur.selectAuteur();
      } else if (choix == 2) {
        await IHMAuteur.selectAllAuteur();
      } else if (choix == 3) {
        await IHMAuteur.listeArticle();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Auteur
  static Future<void> insertAuteur() async {
    String nom = IHMprincipale.saisieString("le nom");
    String prenom = IHMprincipale.saisieString("le prenom");
    if (IHMprincipale.confirmation()) {
      await DBAuteur.insertAuteur(nom, prenom);
      print("Auteur  inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Auteur selon ID
  static Future<void> updateAuteur() async {
    print("Quelle Auteur voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (await DBAuteur.exist(id)) {
      String nom = IHMprincipale.saisieString("le nom");
      String prenom = IHMprincipale.saisieString("le prenom");
      if (IHMprincipale.confirmation()) {
        await DBAuteur.updateAuteur(id, nom, prenom);
        print("Auteur $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'auteur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un Auteur selon ID
  static Future<void> selectAuteur() async {
    print("Quelle Auteur voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    Auteur aut = await DBAuteur.selectAuteur(id);
    if (!aut.estNull()) {
      IHMprincipale.afficherUneDonnee(aut);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'auteur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les Auteur
  static Future<void> selectAllAuteur() async {
    List<Auteur> listeAuteur = await DBAuteur.selectAllAuteurs();
    if (listeAuteur.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeAuteur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> listeArticle() async {
    int id = IHMprincipale.saisieID("de l'editeur");
    List<Article> listeArticle = await DBAuteur.listeArticleEditeur(id);
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

// action pour supprimer un Auteur selon ID
  static Future<void> deleteAuteur() async {
    print("Quelle Auteur voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      DBAuteur.deleteAuteur(id);
      print("Auteur $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour supprimer les Editeurs
  static Future<void> deleteAllAuteurs() async {
    if (IHMprincipale.confirmation()) {
      DBAuteur.deleteAllAuteur();
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
