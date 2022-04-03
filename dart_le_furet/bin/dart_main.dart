import 'db_config.dart';
import 'ihm_info_db.dart';
import 'ihm_principale.dart';

void main(List<String> arguments) async {
  //IHMDB.initBD();
  IHMprincipale.titre();
  await IHMprincipale.menu();
  IHMprincipale.quitter();
}
