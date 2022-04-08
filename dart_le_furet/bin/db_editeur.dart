import 'dart:developer';

import 'package:mysql1/mysql1.dart';

import 'article.dart';
import 'editeur.dart';

class DBEditeur {
// creer et retourne l'éditeur(son id passé en paramétre)
  static Future<Editeur> selectEditeur(
      ConnectionSettings settings, int id) async {
    Editeur edi = Editeur.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Editeur WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Editeur WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        edi = Editeur(reponse.first['id'], reponse.first['nom'],
            reponse.first['adresse']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return edi;
  }

//retourne une liste de tout les editeurs
  static Future<List<Editeur>> selectAllEditeurs(
      ConnectionSettings settings) async {
    List<Editeur> listeEdi = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Editeur;";
        Results reponse = await conn.query(requete);
        for (var row in reponse) {
          Editeur edi = Editeur(row['id'], row['nom'], row['adresse']);
          listeEdi.add(edi);
        }
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }

    return listeEdi;
  }

//retourne une liste des articles d'un editeur placé en parametres
  static Future<List<Article>> listeArticleEditeur(
      ConnectionSettings settings, int id) async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete =
            "SELECT * FROM Article WHERE idEditeur='" + id.toString() + "';";
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

//retourne le nombre editeur
  static Future<int> nombreEdi(ConnectionSettings settings) async {
    int nbr = 0;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT count(DISTINCT id) FROM Editeur;";
        Results reponse = await conn.query(requete);
        for (var fields in reponse) {
          nbr = fields['count(DISTINCT idEditeur)'];
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

//retourne le nombre d'article d'un editeur passé en parametres
  static Future<int> nombreArt(ConnectionSettings settings, id) async {
    int nbr = 0;
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT count(id) FROM Article where idEditeur=" +
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

//permet d'inserer un editeur dans la table editeur
  static Future<void> insertEditeur(
      ConnectionSettings settings, String nom, String adresse) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "INSERT INTO Editeur (nom, adresse) VALUES('" +
            nom +
            "', '" +
            adresse +
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

//permet de modifier un editeur via ces valeurs placé en paramétre
  static Future<void> updateEditeur(
      ConnectionSettings settings, int id, String nom, String adressse) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "UPDATE Editeur SET nom = '" +
            nom +
            "', adresse = '" +
            adressse +
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

  //Permet de supprimer un editeur(son id en paramertre)
  static Future<void> deleteEditeur(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "DELETE FROM Editeur WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

//supprime tout les editeurs
  static Future<void> deleteAllEditeur(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "TRUNCATE TABLE Editeur;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un editeur selon son ID
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DBEditeur.selectEditeur(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }
}
