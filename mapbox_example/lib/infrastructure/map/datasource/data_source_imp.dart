import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../gen/assets.gen.dart';
import '../models/data.dart';
import 'data_source.dart';

final mapboxDataSourceProvider = Provider<DataSource>((ref) {
  return DataSourceImp();
});

class DataSourceImp extends DataSource {
  @override
  Future<List<Result>> getData() async {
    final dataSource = await rootBundle.loadString(Assets.data);
    final dataJson = jsonDecode(dataSource) as Map<String, dynamic>;
    final data = Data.fromJson(dataJson);
    return data.results;
  }
}
