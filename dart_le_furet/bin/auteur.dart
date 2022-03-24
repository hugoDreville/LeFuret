import 'data.dart';

class Auteur implements Data {
  // Attributs
  int _id = 0;
  String _nom = "";
  String _prenom = "";

  //Constructeur

  Auteur(this._id, this._nom, this._prenom);
  Auteur.sansID(this._nom, this._prenom);
  Auteur.fromListString(List<String> unAut) {
    if (unAut.length == 3) {
      this._id = int.parse(unAut[0]);
      this._nom = unAut[1];
      this._prenom = unAut[2];
    }
  }
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

  @override
  String getEnTete() {
    return "| id | name | prenom |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _prenom + " |";
  }
}
