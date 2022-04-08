import 'package:mysql1/mysql1.dart';
import 'article.dart';
import 'db_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IHMEditeur {
  //affiche le menu principal de Editeur
  static Future<void> menu(ConnectionSettings settings) async {
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
        await IHMEditeur.menuSelectEditeur(settings);
      } else if (choix == 2) {
        await IHMEditeur.insertEditeur(settings);
      } else if (choix == 3) {
        await IHMEditeur.updateEditeur(settings);
      } else if (choix == 4) {
        await IHMEditeur.deleteEditeur(settings);
      } else if (choix == 5) {
        await IHMEditeur.deleteAllEditeurs(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

//Affiche le menu pour les Affichages
  static Future<void> menuSelectEditeur(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+----------------------------------------+");
      print("|           Menu - Select Editeur        |");
      print("|  1- Afficher selon ID                  |");
      print("|  2- Afficher toute la table            |");
      print("|  3- Afficher tout les articles         |");
      print("|  4- Afficher le nombre d'editeur(s)    |");
      print("|  5- Afficher le nombre d'article(s)    |");
      print("|  0- Quitter                            |");
      print("+----------------------------------------+");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEditeur.selectEditeur(settings);
      } else if (choix == 2) {
        await IHMEditeur.selectAllEditeur(settings);
      } else if (choix == 3) {
        await IHMEditeur.listeArticle(settings);
      } else if (choix == 4) {
        await IHMEditeur.nombreEdi(settings);
      } else if (choix == 5) {
        await IHMEditeur.nombreArt(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Editeur
  static Future<void> insertEditeur(ConnectionSettings settings) async {
    String nom = IHMprincipale.saisieString("le nom");
    String adresse = IHMprincipale.saisieString("l'adresse");
    if (IHMprincipale.confirmation()) {
      await DBEditeur.insertEditeur(settings, nom, adresse);
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
  static Future<void> updateEditeur(ConnectionSettings settings) async {
    print("Quel Editeur voulez-vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (await DBEditeur.exist(settings, id)) {
      String nom = IHMprincipale.saisieString("le nom");
      String adresse = IHMprincipale.saisieString("l'adresse");
      if (IHMprincipale.confirmation()) {
        await DBEditeur.updateEditeur(settings, id, nom, adresse);
        print("Editeur $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      IHMprincipale.wait();
    } else {
      print("L'éditeur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour afficher un Editeur selon ID
  static Future<void> selectEditeur(ConnectionSettings settings) async {
    print("Quel Editeur voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    Editeur edi = await DBEditeur.selectEditeur(settings, id);
    if (!edi.estNull()) {
      IHMprincipale.afficherUneDonnee(edi);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'editeur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les Editeurs
  static Future<void> selectAllEditeur(ConnectionSettings settings) async {
    List<Editeur> listeEditeur = await DBEditeur.selectAllEditeurs(settings);
    if (listeEditeur.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeEditeur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les Articles de l'Editeur selon ID
  static Future<void> listeArticle(ConnectionSettings settings) async {
    int id = IHMprincipale.saisieID("de l'editeur");
    List<Article> listeArticle =
        await DBEditeur.listeArticleEditeur(settings, id);
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

  // action pour afficher le nombre d'editeurs
  static Future<void> nombreEdi(ConnectionSettings settings) async {
    int nombreEdi = await DBEditeur.nombreEdi(settings);
    if (nombreEdi != 0) {
      print("+----------------------+");
      print("|     " + nombreEdi.toString() + " editeur(s)     |");
      print("+----------------------+");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

// action pour afficher le nombre d'articles d'un editeur selon ID
  static Future<void> nombreArt(ConnectionSettings settings) async {
    int id = IHMprincipale.saisieID("de l'editeur");
    int nombreArt = await DBEditeur.nombreArt(settings, id);
    if (nombreArt != 0) {
      print("+----------------------+");
      print("|     " + nombreArt.toString() + " editeur(s)     |");
      print("+----------------------+");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

// action pour supprimer un Editeur selon ID
  static Future<void> deleteEditeur(ConnectionSettings settings) async {
    print("Quel Editeur voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'editeur");
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteEditeur(settings, id);
      print("Editeur $id supprimé.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour supprimer les Editeurs
  static Future<void> deleteAllEditeurs(ConnectionSettings settings) async {
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteAllEditeur(settings);
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
