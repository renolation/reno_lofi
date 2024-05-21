import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/enums/entities.dart';

part 'filter.freezed.dart';

@freezed
class Filter with _$Filter {
  const factory Filter({
    required EntityFilter orderBy,
    @Default(false) bool desc,
  }) = _Filter;
}
