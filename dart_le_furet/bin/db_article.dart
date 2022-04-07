import 'dart:developer';
import 'package:mysql1/mysql1.dart';
import 'db_config.dart';
import 'article.dart';

class DBArticle {
  static Future<Article> selectArticle(int id) async {
    Article art = Article.vide();
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Article WHERE id=" +
            id.toString() +
            " AND EXISTS (SELECT id FROM Article WHERE id=" +
            id.toString() +
            " );";
        Results reponse = await conn.query(requete);
        art = Article(
            reponse.first['id'],
            reponse.first['titre'],
            reponse.first['type'],
            reponse.first['quantite'],
            reponse.first['prix'],
            reponse.first['anneeParution'],
            reponse.first['idEditeur'],
            reponse.first['idAuteur']);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
    return art;
  }

  static Future<List<Article>> selectAllArticles() async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "SELECT * FROM Article;";
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

  static Future<void> insertArticle(String titre, String type, int quantite,
      double prix, String anneeParution, int idEditeur, int idAuteur) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete =
            "INSERT INTO Article (titre, type, quantite, prix, anneeParution, idEditeur, idAuteur) VALUES('" +
                titre +
                "', '" +
                type +
                "', '" +
                quantite.toString() +
                "', '" +
                prix.toString() +
                "', '" +
                anneeParution +
                "', '" +
                idEditeur.toString() +
                "', '" +
                idAuteur.toString() +
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

//update

  static Future<void> updateArticle(
      int id,
      String titre,
      String type,
      int quantite,
      double prix,
      String anneeParution,
      int idEditeur,
      int idAuteur) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Article SET titre = '" +
            titre +
            "', type = '" +
            type +
            "', quantite = '" +
            quantite.toString() +
            "', prix = '" +
            prix.toString() +
            "',  anneeParution = '" +
            anneeParution +
            "', idEditeur = '" +
            idEditeur.toString() +
            "', idAuteur = '" +
            idAuteur.toString() +
            "'  WHERE id='" +
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

  static Future<void> modifierArticle(int id, int quantite) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "UPDATE Article SET quantite = '" +
            quantite.toString() +
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

  //delete

  static Future<void> deleteArticle(int id) async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "DELETE FROM Article WHERE id='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  //delete all

  static Future<void> deleteAllArticle() async {
    try {
      MySqlConnection conn =
          await MySqlConnection.connect(DBConfig.getSettings());
      try {
        String requete = "TRUNCATE TABLE Article;";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  // verifie l'existance d'un article selon son ID
  static Future<bool> exist(int id) async {
    bool exist = false;
    if (!(await DBArticle.selectArticle(id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Article> getEtudiant(int id) async {
    dynamic r = await selectArticle(id);
    ResultRow rr = r.first;
    return Article(rr['id'], rr['titre'], rr['type'], rr['quantite'],
        rr['prix'], rr['anneeParution'], rr['idEditeur'], rr['idAuteur']);
  }
}
