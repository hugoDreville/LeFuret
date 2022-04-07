import 'article.dart';
import 'db_article.dart';
import 'db_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IHMEditeur {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("+--------------------------------------------------+");
      print("|             Menu - Gestion Editeur               |");
      print("|  1- Afficher des données de la table             |");
      print("|  2- Inserer une données dans la table            |");
      print("|  3- Modifier une données dans la table           |");
      print("|  4- Supprimer une données dans la table          |");
      print("|  5- Supprimer toutes les données dans la table   |");
      print("|  0- Quitter                                      |");
      print("+--------------------------------------------------+");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEditeur.menuSelectEditeur();
      } else if (choix == 2) {
        await IHMEditeur.insertEditeur();
      } else if (choix == 3) {
        await IHMEditeur.updateEditeur();
      } else if (choix == 4) {
        await IHMEditeur.deleteEditeur();
      } else if (choix == 5) {
        await IHMEditeur.deleteAllEditeurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectEditeur() async {
    int choix = -1;
    while (choix != 0) {
      print("+----------------------------------------+");
      print("|           Menu - Select Editeur        |");
      print("|  1- Afficher selon ID                  |");
      print("|  2- Afficher toute la table            |");
      print("|  3- Afficher tout les articles         |");
      print("|  0- Quitter                            |");
      print("+----------------------------------------+");
      choix = IHMprincipale.choixMenu(3);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEditeur.selectEditeur();
      } else if (choix == 2) {
        await IHMEditeur.selectAllEditeur();
      } else if (choix == 3) {
        await IHMEditeur.listeArticle();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Editeur
  static Future<void> insertEditeur() async {
    String nom = IHMprincipale.saisieString("le nom");
    String adresse = IHMprincipale.saisieString("l'adresse");
    if (IHMprincipale.confirmation()) {
      await DBEditeur.insertEditeur(nom, adresse);
      print("Editeur inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Editeur selon ID
  static Future<void> updateEditeur() async {
    print("Quel Editeur voulez-vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (await DBEditeur.exist(id)) {
      String nom = IHMprincipale.saisieString("le nom");
      String adresse = IHMprincipale.saisieString("l'adresse");
      if (IHMprincipale.confirmation()) {
        await DBEditeur.updateEditeur(id, nom, adresse);
        print("Editeur $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("L'éditeur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // action pour afficher un Editeur selon ID
  static Future<void> selectEditeur() async {
    print("Quel Editeur voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    Editeur edi = await DBEditeur.selectEditeur(id);
    if (!edi.estNull()) {
      IHMprincipale.afficherUneDonnee(edi);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les Editeurs
  static Future<void> selectAllEditeur() async {
    List<Editeur> listeEditeur = await DBEditeur.selectAllEditeurs();
    if (listeEditeur.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeEditeur);
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
    List<Article> listeArticle = await DBEditeur.listeArticleEditeur(id);
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

// action pour supprimer un Editeur selon ID
  static Future<void> deleteEditeur() async {
    print("Quel Editeur voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteEditeur(id);
      print("Editeur $id supprimé.");
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
  static Future<void> deleteAllEditeurs() async {
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteAllEditeur();
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
