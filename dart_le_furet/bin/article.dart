import 'data.dart';

class Article implements Data {
  // Attributs
  int _id = 0;
  String _titre = "";
  String _type = "";
  int _quantite = 0;
  double _prix = 0;
  String _anneeParution = "";

  //Constructeur

  Article(this._id, this._titre, this._type, this._quantite, this._prix,
      this._anneeParution);
  Article.sansID(
      this._titre, this._type, this._quantite, this._prix, this._anneeParution);
  Article.fromListString(List<String> unActi) {
    if (unActi.length == 6) {
      this._id = int.parse(unActi[0]);
      this._titre = unActi[1];
      this._type = unActi[2];
      this._quantite = int.parse(unActi[3]);
      this._prix = double.parse(unActi[4]);
      this._anneeParution = unActi[5];
    }
  }
  Article.vide();

  // getter

  int getId() {
    return this._id;
  }

  String getNom() {
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
    return "| id | titre | type | quantite | prix | anneeParution |";
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
        " |";
  }
}
