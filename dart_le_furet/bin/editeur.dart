import 'data.dart';

class Editeur implements Data {
  //Attributs
  int _id = 0;
  String _nom = "";
  String _adresse = "";
  //Constructeur
  Editeur(this._id, this._nom, this._adresse);
  Editeur.vide();
  //Getter & Setter

  //Autres méthodes
  bool estNull() {
    bool estnull = false;
    if (_id == 0 && _nom == "" && _adresse == "") {
      estnull = true;
    }
    return estnull;
  }

  @override
  String getEnTete() {
    return "| id | nom | adresse |";
  }

  @override
  String getInLine() {
    return "| " + _id.toString() + " | " + _nom + " | " + _adresse + " |";
  }
}
