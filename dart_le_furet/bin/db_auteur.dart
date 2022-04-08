import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'db_config.dart';
import 'auteur.dart';
import 'article.dart';

class DBAuteur {
  //creer l'auteur avec l'id qui nous ai donné et le retourne
  static Future<Auteur> selectAuteur(
      ConnectionSettings settings, int id) async {
    Auteur aut = Auteur.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Auteur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Auteur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        aut = Auteur(
            reponse.first['id'], reponse.first['nom'], reponse.first['prenom']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return aut;
  }

//creer une liste avec tout les auteurs et la retourne
  static Future<List<Auteur>> selectAllAuteurs(
      ConnectionSettings settings) async {
    List<Auteur> listeAut = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Auteur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Auteur aut = Auteur(row['id'], row['nom'], row['prenom']);
          listeAut.add(aut);
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeAut;
  }

//retourne le nombre d'auteur
  static Future<int> nombreAut(ConnectionSettings settings) async {
    int nbr = 0;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT count(DISTINCT id) FROM Auteur;";
        Results reponse = await conn.query(requete);
        for (var fields in reponse) {
          nbr = fields['count(DISTINCT idAuteur)'];
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return nbr;
  }

//retourne le nombre d'article de l'auteur donné
  static Future<int> nombreArt(ConnectionSettings settings, id) async {
    int nbr = 0;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT count(id) FROM Article where idAuteur=" +
            id.toString() +
            ";";
        Results reponse = await conn.query(requete);
        for (var fields in reponse) {
          nbr = fields['count(id)'];
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return nbr;
  }

//Permet d'inserer un auteur dans la table Auteur
  static Future<void> insertAuteur(
      ConnectionSettings settings, String nom, String prenom) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "INSERT INTO Auteur (nom, prenom) VALUES('" +
            nom +
            "', '" +
            prenom +
            "');";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

//permet de mettre a jour un Auteur avec las valeurs placées en paramétres
  static Future<void> updateAuteur(
      ConnectionSettings settings, int id, String nom, String prenom) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Auteur SET nom = '" +
            nom +
            "', prenom = '" +
            prenom +
            "' WHERE id='" +
            id.toString() +
            "';";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

//retourne la liste des articles d'un Auteur
  static Future<List<Article>> listeArticleAuteur(
      ConnectionSettings settings, int id) async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete =
            "SELECT * FROM Article WHERE idAuteur='" + id.toString() + "';";
        Results reponse = await conn.query(requete);
        for (var fields in reponse) {
          Article art = Article(
              fields['id'],
              fields['titre'],
              fields['type'],
              fields['quantite'],
              fields['prix'],
              fields['anneeParution'],
              fields["idEditeur"],
              fields["idAuteur"]);
          listeArt.add(art);
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return listeArt;
  }

  //supprime l'auteur grace a son id placé en paramétre
  static Future<void> deleteAuteur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Auteur WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //supprime tout les auteurs de la table Auteur
  static Future<void> deleteAllAuteur(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "TRUNCATE TABLE Auteur;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un Auteur selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DBAuteur.selectAuteur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }
}
