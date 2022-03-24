import 'db_editeur.dart';
import 'editeur.dart';
import 'ihm_principale.dart';

class IHMEtudiants {
  static Future<void> menu() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Gestion Editeurd");
      print("1- Afficher des données de la table");
      print("2- Inserer une données dans la table");
      print("3- Modifier une données dans la table");
      print("4- Supprimer une données dans la tables");
      print("5- Supprimer toutes les données dans la tables");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEtudiants.menuSelectEditeur();
      } else if (choix == 2) {
        await IHMEtudiants.insertEditeur();
      } else if (choix == 3) {
        await IHMEtudiants.updateEditeur();
      } else if (choix == 4) {
        await IHMEtudiants.deleteEditeur();
      } else if (choix == 5) {
        await IHMEtudiants.deleteAllEditeurs();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> menuSelectEditeur() async {
    int choix = -1;
    while (choix != 0) {
      print("Menu - Select Editeur");
      print("1- Afficher selon ID");
      print("2- Afficher toute la table.");
      print("0- Quitter");
      choix = IHMprincipale.choixMenu(2);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMEtudiants.selectEditeur();
      } else if (choix == 2) {
        await IHMEtudiants.selectAllEditeur();
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour ajouter un Etudiant
  static Future<void> insertEditeur() async {
    String nom = IHMprincipale.saisieString();
    String adresse = IHMprincipale.saisieString();
    if (IHMprincipale.confirmation()) {
      await DBEditeur.insertEditeur(nom, adresse);
      print("Etudiant inséré dans la table.");
      print("--------------------------------------------------");
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour mettre a jour un Etudiant selon ID
  static Future<void> updateEditeur() async {
    print("Quelle Etudiant voulez vous mettre à jour ?");
    int id = IHMprincipale.saisieID();
    if (await DBEditeur.exist(id)) {
      String nom = IHMprincipale.saisieString();
      String adresse = IHMprincipale.saisieString();
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

  // action pour afficher un Etudiant selon ID
  static Future<void> selectEditeur() async {
    print("Quelle Editeur voulez vous afficher ?");
    int id = IHMprincipale.saisieID();
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

  // action pour afficher les Etudiants
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

// action pour supprimer un Etudiant selon ID
  static Future<void> deleteEditeur() async {
    print("Quelle Editeur voulez vous supprimer ?");
    int id = IHMprincipale.saisieID();
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteEtudiant(id);
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

  // action pour supprimer les Etudiants
  static Future<void> deleteAllEditeurs() async {
    if (IHMprincipale.confirmation()) {
      DBEditeur.deleteAllEditeurs();
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
