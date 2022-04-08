import 'dart:developer';
import 'package:mysql1/mysql1.dart';
import 'db_config.dart';
import 'article.dart';

class DBArticle {
  static Future<Article> selectArticle(
      ConnectionSettings settings, int id) async {
    Article art = Article.vide();
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  static Future<List<Article>> selectAllArticles(
      ConnectionSettings settings) async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  static Future<List<Article>> selectAllArticlesPrix(
      ConnectionSettings settings) async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Article order by prix;";
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

  static Future<List<Article>> selectAllArticlesQuantite(
      ConnectionSettings settings) async {
    List<Article> listeArt = [];
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete = "SELECT * FROM Article order by quantite;";
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

  static Future<void> insertArticle(
      ConnectionSettings settings,
      String titre,
      String type,
      int quantite,
      double prix,
      String anneeParution,
      int idEditeur,
      int idAuteur) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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
      ConnectionSettings settings,
      int id,
      String titre,
      String type,
      int quantite,
      double prix,
      String anneeParution,
      int idEditeur,
      int idAuteur) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  static Future<void> modifierArticle(
      ConnectionSettings settings, int id, int quantite) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  static Future<void> deleteArticle(ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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

  static Future<void> deleteArticleEditeur(
      ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete =
            "DELETE FROM Article WHERE idEditeur='" + id.toString() + "'";
        await conn.query(requete);
      } catch (e) {
        log(e.toString());
      }
      conn.close();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteArticleAuteur(
      ConnectionSettings settings, int id) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
      try {
        String requete =
            "DELETE FROM Article WHERE idAuteur='" + id.toString() + "'";
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

  static Future<void> deleteAllArticle(ConnectionSettings settings) async {
    try {
      MySqlConnection conn = await MySqlConnection.connect(settings);
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
  static Future<bool> exist(ConnectionSettings settings, int id) async {
    bool exist = false;
    if (!(await DBArticle.selectArticle(settings, id)).estNull()) {
      exist = true;
    }
    return exist;
  }

  // getEtudiant
  static Future<Article> getEtudiant(
      ConnectionSettings settings, int id) async {
    dynamic r = await selectArticle(settings, id);
    ResultRow rr = r.first;
    return Article(rr['id'], rr['titre'], rr['type'], rr['quantite'],
        rr['prix'], rr['anneeParution'], rr['idEditeur'], rr['idAuteur']);
  }
}
