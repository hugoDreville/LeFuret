import 'db_config.dart';
import 'ihm_info_db.dart';
import 'ihm_principale.dart';

void main(List<String> arguments) async {
  IHMprincipale.titre();
  IHMDB.initBD();
  await IHMprincipale.menu();
  IHMprincipale.quitter();
}
