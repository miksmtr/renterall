import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class Product extends BaseEntity implements ModelInterface {
  int extra;
  int id;
  int isActive;
  String name;
  int price;
  String productId;
  int quantity;
}
