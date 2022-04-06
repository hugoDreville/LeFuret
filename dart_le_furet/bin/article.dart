import 'data.dart';
import 'editeur.dart';

class Article implements Data {
  // Attributs
  int _id = 0;
  String _titre = "";
  String _type = "";
  int _quantite = 0;
  double _prix = 0;
  String _anneeParution = "";
  int _idEditeur = 0;
  int _idAuteur = 0;

  //Constructeur

  Article(this._id, this._titre, this._type, this._quantite, this._prix,
      this._anneeParution, this._idEditeur, this._idAuteur);
  Article.sansID(this._titre, this._type, this._quantite, this._prix,
      this._anneeParution, this._idEditeur, this._idAuteur);

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
        _idEditeur == 0 &&
        _idAuteur == 0 &&
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
    return "| id | titre | type | quantite | prix | anneeParution | id editeur | id auteur |";
  }

  @override
  String getInLine() {
    return "| " +
        _id.toString() +
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
        " | " +
        _idEditeur.toString() +
        " | " +
        _idAuteur.toString() +
        " |";
  }
}
