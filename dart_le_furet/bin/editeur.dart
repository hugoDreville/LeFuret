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
  @override
  String getEnTete() {
    // TODO: implement getEnTete
    throw UnimplementedError();
  }

  @override
  String getInLine() {
    // TODO: implement getInLine
    throw UnimplementedError();
  }
}
