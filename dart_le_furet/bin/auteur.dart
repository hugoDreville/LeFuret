import 'data.dart';

class Auteur implements Data {
  // Attributs
  int _id = 0;
  String _nom = "";
  String _prenom = "";

  //Constructeur

  Auteur(this._id, this._nom, this._prenom);
  Auteur.sansID(this._nom, this._prenom);

  Auteur.vide();

  //getter

  int getId() {
    return this._id;
  }

  String getNom() {
    return this._nom;
  }

  String getEmail() {
    return this._prenom;
  }

//Autres méthodes
  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _prenom == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEnTete() {
    return "| id | name | prenom |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _prenom + " |";
  }
}
