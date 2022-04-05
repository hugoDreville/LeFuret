import 'ihm_principale.dart';
import 'db_config.dart';

class IHMDB {
  //permet à l'utilisateur de configurer la base de donnéé avec ces propre informations
  static void initBD() {
    print("saisissez le nom de votre database");
    String d = IHMprincipale.saisieString("la base de donnée");
    print("saisissez le nom de votre utilisateur");
    String u = IHMprincipale.saisieString("l'utilisateur");
    print("saisissez votre mot de passe");
    String p = IHMprincipale.saisieMDP();
    DBConfig.settings.db = d;
    DBConfig.settings.user = u;
    DBConfig.settings.password = p;
  }
}
