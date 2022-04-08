import 'package:mysql1/mysql1.dart';
import 'dart:io';
import 'data.dart';
import 'db_config.dart';
import 'ihm_article.dart';
import 'ihm_auteur.dart';
import 'ihm_editeur.dart';

class IHMprincipale {
  static void titre() {
    print("");
    print("+----------------------------------------+");
    print("|             Bienvenue dans :           |");
    print("|    Le gestionnaire du Furet du Nord    |");
    print("+----------------------------------------+");
    print("");
  }

  static void quitter() {
    print("Au revoir !");
  }

  static void afficherUneDonnee(Data data) {
    print(data.getEnTete());
    print(data.getInLine());
  }

  static void afficherDesDonnees(List<Data> dataList) {
    print(dataList.first.getEnTete());
    for (var Fields in dataList) {
      print(Fields.getInLine());
    }
  }

  // methodes de saisie
  // retourne un chiffre entre 0 et nbChoix pour les menus
  static int choixMenu(int nbChoix) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir une action (0-$nbChoix)");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i >= 0 && i <= nbChoix) {
          saisieValide = true;
        } else {
          print("La saisie ne correspond à aucune action.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // retourne un boolean pour demande de confirmation
  static bool confirmation() {
    bool saisieValide = false;
    bool confirme = false;
    while (!saisieValide) {
      print("Confirmer vous l'action ? (o/n)");
      String reponse = stdin.readLineSync().toString();
      if (reponse.toLowerCase() == "o") {
        saisieValide = true;
        confirme = true;
      } else if (reponse.toLowerCase() == "n") {
        saisieValide = true;
        print("Annulation.");
      } else {
        print("Erreur dans la saisie.");
      }
    }
    return confirme;
  }

//permet de saisir un string
  static String saisieString(String sujet) {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir $sujet :");
      try {
        s = stdin.readLineSync().toString();
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

//permet de saisir un int
  static int saisieInt(String sujet) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir $sujet :");
      try {
        i = int.parse(stdin.readLineSync().toString());
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

//permet de saisir un mot de passe
  static String saisieMDP() {
    bool saisieValide = false;
    String s = "";
    while (!saisieValide) {
      print("> Veuillez saisir le mot de passe :");
      try {
        stdin.echoMode = false;
        s = stdin.readLineSync().toString();
        saisieValide = true;
        stdin.echoMode = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return s;
  }

//permet de saisir un double
  static double saisieDouble() {
    bool saisieValide = false;
    double i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir le prix (max = 99,99):");
      try {
        i = double.parse(stdin.readLineSync().toString());
        saisieValide = true;
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

//permet de saisir un id
  static int saisieID(String sujet) {
    bool saisieValide = false;
    int i = -1;
    while (!saisieValide) {
      print("> Veuillez saisir l'id $sujet correspondant:");
      try {
        i = int.parse(stdin.readLineSync().toString());
        if (i > 0) {
          saisieValide = true;
        } else {
          print("La valeur saisie est inférieur ou égale à zéro.");
        }
      } catch (e) {
        print("Erreur dans la saisie.");
      }
    }
    return i;
  }

  // methode qui met en attente le programme et attend une validation avec entré
  static void wait() {
    print("Appuyez sur entrer pour continuer ...");
    stdin.readLineSync();
  }

  // methode des menus et actions
  // menu setting
  static ConnectionSettings setting() {
    String bdd = IHMprincipale.saisieString("le nom de la BDD");
    String user = IHMprincipale.saisieString("l'utilisateur");
    String mdp = IHMprincipale.saisieMDP();

    return ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: user, // DartUser
      password: mdp, // dartmdp
      db: bdd, // DartDB
    );
  }

  // methode des menus et actions
  // menu d'accueil
  static Future<int> menu(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+-----------------------------------+");
      print("|           Menu Principal          |");
      print("|  1- Gestion de la BDD             |");
      print("|  2- Gestion de la table Article   |");
      print("|  3- Gestion de la table Editeur   |");
      print("|  4- Gestion de la table Auteur    |");
      print("|  0- Quitter                       |");
      print("+-----------------------------------+");
      choix = IHMprincipale.choixMenu(4);
      print("--------------------------------------------------");
      if (choix == 1) {
        await IHMprincipale.menuBDD(settings);
      } else if (choix == 2) {
        await IHMArticle.menu(settings);
      } else if (choix == 3) {
        await IHMEditeur.menu(settings);
      } else if (choix == 4) {
        await IHMAuteur.menu(settings);
      }
    }
    return 0;
  }

  // menu pour la gestion basic de la BDD
  static Future<void> menuBDD(ConnectionSettings settings) async {
    int choix = -1;
    while (choix != 0) {
      print("+----------------------------------------------+");
      print("|             Menu - Gestion BDD               |");
      print("|  1- Création des tables de la BDD            |");
      print("|  2- Verification des tables de la BDD        |");
      print("|  3- Afficher les tables de la BDD            |");
      print("|  4- Supprimer une table dans la BDD          |");
      print("|  5- Supprimer toutes les tables dans la BDD  |");
      print("|  0- Quitter                                  |");
      print("+----------------------------------------------+");
      choix = IHMprincipale.choixMenu(5);
      print("--------------------------------------------------");

      if (choix == 1) {
        await IHMprincipale.createTable(settings);
      } else if (choix == 2) {
        await IHMprincipale.checkTable(settings);
      } else if (choix == 3) {
        await IHMprincipale.selectTable(settings);
      } else if (choix == 4) {
        await IHMprincipale.deleteTable(settings);
      } else if (choix == 5) {
        await IHMprincipale.deleteAllTables(settings);
      }
    }
    print("Retour menu précédent.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour creer les tables
  static Future<void> createTable(ConnectionSettings settings) async {
    print("Création des tables manquantes dans la BDD ...");
    await DBConfig.createTables(settings);
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour vérifier les tables
  static Future<void> checkTable(ConnectionSettings settings) async {
    print("Verification des tables dans la BDD ...");
    if (await DBConfig.checkTables(settings)) {
      print("Toutes les tables sont présentes dans la BDD.");
    } else {
      print("Il manque des tables dans la BDD.");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

  // action pour afficher les tables
  static Future<void> selectTable(ConnectionSettings settings) async {
    List<String> listTable = await DBConfig.selectTables(settings);
    print("Liste des tables :");
    for (var table in listTable) {
      print("- $table");
    }
    print("Fin de l'opération.");
    print("--------------------------------------------------");
    await Future.delayed(Duration(seconds: 1));
  }

// action pour supprimer une table
  static Future<void> deleteTable(ConnectionSettings settings) async {
    print("Quelle table voulez vous supprimer ?");
    String table = IHMprincipale.saisieString("la table");
    if (IHMprincipale.confirmation()) {
      DBConfig.dropTable(settings, table);
      print("Table supprimée.");
      print("Fin de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    } else {
      print("Annulation de l'opération.");
      print("--------------------------------------------------");
      await Future.delayed(Duration(seconds: 1));
    }
  }

// action pour supprimer les tables
  static Future<void> deleteAllTables(ConnectionSettings settings) async {
    if (IHMprincipale.confirmation()) {
      DBConfig.dropAllTable(settings);
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
