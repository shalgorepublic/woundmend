import 'package:derm_pro/scoped_models/skin_model.dart';
import 'package:scoped_model/scoped_model.dart';
import './connected_models.dart';


class MainModel extends Model with  ConnectedModel ,SkinModel, UserModel , UtilityModel {
}
