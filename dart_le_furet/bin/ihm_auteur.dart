import 'package:mysql1/mysql1.dart';
import 'db_article.dart';
import 'db_auteur.dart';
import 'auteur.dart';
import 'ihm_principale.dart';
import 'article.dart';

class IHMAuteur {
  static Future<void> menu(ConnectionSettings settings) async {
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
        await IHMAuteur.menuSelectAuteur(settings);
      } else if (choix == 2) {
        await IHMAuteur.insertAuteur(settings);
      } else if (choix == 3) {
        await IHMAuteur.updateAuteur(settings);
      } else if (choix == 4) {
        await IHMAuteur.deleteAuteur(settings);
      } else if (choix == 5) {
        await IHMAuteur.deleteAllAuteurs(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectAuteur(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+----------------------------------------+");
      print("|          Menu - Select Auteur          |");
      print("|  1- Afficher selon ID                  |");
      print("|  2- Afficher toute la table            |");
      print("|  3- Afficher tout les articles         |");
      print("|  4- Afficher le nombre d'auteur(s)     |");
      print("|  5- Afficher le nombre d'article(s)    |");
      print("|  0- Quitter                            |");
      print("+----------------------------------------+");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMAuteur.selectAuteur(settings);
      } else if (choix == 2) {
        await IHMAuteur.selectAllAuteur(settings);
      } else if (choix == 3) {
        await IHMAuteur.listeArticle(settings);
      } else if (choix == 4) {
        await IHMAuteur.nombreAut(settings);
      } else if (choix == 5) {
        await IHMAuteur.nombreArt(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Auteur
  static Future<void> insertAuteur(ConnectionSettings settings) async {
    String nom = IHMprincipale.saisieString("le nom");
    String prenom = IHMprincipale.saisieString("le prenom");
    if (IHMprincipale.confirmation()) {
      await DBAuteur.insertAuteur(settings, nom, prenom);
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
  static Future<void> updateAuteur(ConnectionSettings settings) async {
    print("Quelle Auteur voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (await DBAuteur.exist(settings, id)) {
      String nom = IHMprincipale.saisieString("le nom");
      String prenom = IHMprincipale.saisieString("le prenom");
      if (IHMprincipale.confirmation()) {
        await DBAuteur.updateAuteur(settings, id, nom, prenom);
        print("Auteur $id mis à jour.");
        print("--------------------------------------------------");
      } else {
        print("Annulation de l'opération.");
        print("--------------------------------------------------");
      }
      IHMprincipale.wait();
    } else {
      print("L'auteur $id n'existe pas.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      IHMprincipale.wait();
    }
  }

  // action pour afficher un Auteur selon ID
  static Future<void> selectAuteur(ConnectionSettings settings) async {
    print("Quelle Auteur voulez vous afficher ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    Auteur aut = await DBAuteur.selectAuteur(settings, id);
    if (!aut.estNull()) {
      IHMprincipale.afficherUneDonnee(aut);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("L'auteur $id n'existe pas");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  // action pour afficher les Auteur
  static Future<void> selectAllAuteur(ConnectionSettings settings) async {
    List<Auteur> listeAuteur = await DBAuteur.selectAllAuteurs(settings);
    if (listeAuteur.isNotEmpty) {
      IHMprincipale.afficherDesDonnees(listeAuteur);
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    } else {
      print("la table est vide");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
    }
    IHMprincipale.wait();
  }

  static Future<void> listeArticle(ConnectionSettings settings) async {
    int id = IHMprincipale.saisieID("de l'editeur");
    List<Article> listeArticle =
        await DBAuteur.listeArticleEditeur(settings, id);
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

  static Future<void> nombreAut(ConnectionSettings settings) async {
    int nombreAut = await DBAuteur.nombreAut(settings);
    if (nombreAut != 0) {
      print("+----------------------+");
      print("|     " + nombreAut.toString() + " auteur(s)      |");
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

  static Future<void> nombreArt(ConnectionSettings settings) async {
    int id = IHMprincipale.saisieID("de l'auteur");
    int nombreArt = await DBAuteur.nombreArt(settings, id);
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

// action pour supprimer un Auteur selon ID
  static Future<void> deleteAuteur(ConnectionSettings settings) async {
    print("Quelle Auteur voulez vous supprimer ?");
    int id = IHMprincipale.saisieID("de l'auteur");
    if (IHMprincipale.confirmation()) {
      DBAuteur.deleteAuteur(settings, id);
      print("Auteur $id supprimé.");
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
  static Future<void> deleteAllAuteurs(ConnectionSettings settings) async {
    if (IHMprincipale.confirmation()) {
      DBAuteur.deleteAllAuteur(settings);
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
