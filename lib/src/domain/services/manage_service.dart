import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';

import '../models/product_model.dart';


abstract class ManageService {
  Future<Either<ErrorObject, List<Data>>> getPersonalPosts();
}