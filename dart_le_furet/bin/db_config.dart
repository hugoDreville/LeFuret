import 'dart:developer';

import 'package:mysql1/mysql1.dart';

class DBConfig {
  // permet la création des tables, en vérifiant si elles existes ou non
  // et créé les tables manquantes si besoin
  static Future<void> createTables(ConnectionSettings settings) async {
    bool checkArticle = false;
    bool checkAuteur = false;
    bool checkEditeur = false;

    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Article") {
              checkArticle = true;
            }
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
          }
        }
        if (!checkArticle) {
          requete =
              'CREATE TABLE Article (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, titre varchar(250), type varchar(20), quantite int, prix DECIMAL(4,2), anneeParution varchar(4), idEditeur int, idAuteur int);';
          await conn.query(requete);
        }
        if (!checkAuteur) {
          requete =
              'CREATE TABLE Auteur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(30), prenom varchar(30));';
          await conn.query(requete);
        }
        if (!checkEditeur) {
          requete =
              'CREATE TABLE Editeur (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, nom varchar(30), adresse varchar(100));';
          await conn.query(requete);
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // retourne vrai si toute les tables sont créé, faux sinon
  static Future<bool> checkTables(settings) async {
    bool checkAll = false;
    bool checkArticle = false;
    bool checkAuteur = false;
    bool checkEditeur = false;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      String requete = "SHOW TABLES;";
      try {
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            if (fields.toString() == "Article") {
              checkArticle = true;
            }
            if (fields.toString() == "Auteur") {
              checkAuteur = true;
            }
            if (fields.toString() == "Editeur") {
              checkEditeur = true;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }

    if (checkArticle && checkAuteur && checkEditeur) {
      checkAll = true;
    }
    return checkAll;
  }

  // retourne la liste des noms des tables dans la BDD;
  static Future<List<String>> selectTables(ConnectionSettings settings) async {
    List<String> listTable = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            listTable.add(fields);
          }
        }
      } catch (e) {
        print(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
    return listTable;
  }

  // permet de supprimer une table via son nom passé en parametre, si elle existe dans la database
  static Future<void> dropTable(
      ConnectionSettings settings, String table) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        await conn.query("DROP TABLES IF EXISTS " + table + ";");
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      print(e.toString());
    }
  }

  // supprime toute les tables dans la DB
  static Future<void> dropAllTable(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SHOW TABLES;";
        Results reponse = await conn.query(requete);
        for (var rows in reponse) {
          for (var fields in rows) {
            await conn.query("DROP TABLES IF EXISTS " + fields + ";");
          }
        }
      } catch (e) {
        log(e.toString());
      }

      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

//Permet d'effectuer une requète dans la BDD
  static Future<dynamic> executerRequete(
      ConnectionSettings settings, String requete) async {
    Results? reponse;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        reponse = await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return reponse;
  }
}
