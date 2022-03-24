import 'data.dart';
import 'editeur.dart';

class Article implements Data {
  // Attributs
  int _id = 0;
  int _idEditeur = -1;
  int _idAuteur = -1;
  String _titre = "";
  String _type = "";
  int _quantite = 0;
  double _prix = 0;
  String _anneeParution = "";

  //Constructeur

  Article(this._id, this._idEditeur, this._idAuteur, this._titre, this._type,
      this._quantite, this._prix, this._anneeParution);
  Article.sansID(this._idEditeur, this._idAuteur, this._titre, this._type,
      this._quantite, this._prix, this._anneeParution);

  Article.vide();

  // getter

  int getId() {
    return this._id;
  }

  int getIdEditeur() {
    return this._idEditeur;
  }

  int getIdAuteur() {
    return this._idAuteur;
  }

  String getTitre() {
    return this._titre;
  }

  String getType() {
    return this._type;
  }

  int getQuantite() {
    return this._quantite;
  }

  double getPrix() {
    return this._prix;
  }

  String getAnneeParution() {
    return this._anneeParution;
  }

  bool estNull() {
    bool estnull = false;
    if (_id == 0 &&
        _idEditeur == -1 &&
        _idAuteur == -1 &&
        _titre == "" &&
        _type == "" &&
        _quantite == 0 &&
        _prix == 0 &&
        _anneeParution == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEnTete() {
    return "| id | editeur | auteur | titre | type | quantite | prix | anneeParution |";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
        " | " +
        _idEditeur.toString() +
        "| " +
        _idAuteur.toString() +
        " | " +
        _titre +
        " | " +
        _type +
        " | " +
        _quantite.toString() +
        " | " +
        _prix.toString() +
        " | " +
        _anneeParution +
        " |";
  }
}
