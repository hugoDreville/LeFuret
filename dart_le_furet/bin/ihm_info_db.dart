import 'ihm_principale.dart';
import 'db_config.dart';

class IHMDB {
  //permet à l'utilisateur de configurer la base de donnéé avec ces propre informations
  static void initBD() {
    String d = IHMprincipale.saisieString("le nom de la  base de donnée");
    String u = IHMprincipale.saisieString("le nom de l'utilisateur");
    String p = IHMprincipale.saisieMDP();
    DBConfig.settings.db = d;
    DBConfig.settings.user = u;
    DBConfig.settings.password = p;
  }
}
