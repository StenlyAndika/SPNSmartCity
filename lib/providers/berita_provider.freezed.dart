// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'berita_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BeritaState {
  bool get isLoading => throw _privateConstructorUsedError;
  BeritaModel get beritaModel => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BeritaStateCopyWith<BeritaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BeritaStateCopyWith<$Res> {
  factory $BeritaStateCopyWith(
          BeritaState value, $Res Function(BeritaState) then) =
      _$BeritaStateCopyWithImpl<$Res, BeritaState>;
  @useResult
  $Res call({bool isLoading, BeritaModel beritaModel});
}

/// @nodoc
class _$BeritaStateCopyWithImpl<$Res, $Val extends BeritaState>
    implements $BeritaStateCopyWith<$Res> {
  _$BeritaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? beritaModel = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      beritaModel: null == beritaModel
          ? _value.beritaModel
          : beritaModel // ignore: cast_nullable_to_non_nullable
              as BeritaModel,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BeritaStateCopyWith<$Res>
    implements $BeritaStateCopyWith<$Res> {
  factory _$$_BeritaStateCopyWith(
          _$_BeritaState value, $Res Function(_$_BeritaState) then) =
      __$$_BeritaStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, BeritaModel beritaModel});
}

/// @nodoc
class __$$_BeritaStateCopyWithImpl<$Res>
    extends _$BeritaStateCopyWithImpl<$Res, _$_BeritaState>
    implements _$$_BeritaStateCopyWith<$Res> {
  __$$_BeritaStateCopyWithImpl(
      _$_BeritaState _value, $Res Function(_$_BeritaState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? beritaModel = null,
  }) {
    return _then(_$_BeritaState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      beritaModel: null == beritaModel
          ? _value.beritaModel
          : beritaModel // ignore: cast_nullable_to_non_nullable
              as BeritaModel,
    ));
  }
}

/// @nodoc

class _$_BeritaState extends _BeritaState {
  const _$_BeritaState({this.isLoading = true, required this.beritaModel})
      : super._();

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final BeritaModel beritaModel;

  @override
  String toString() {
    return 'BeritaState(isLoading: $isLoading, beritaModel: $beritaModel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BeritaState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.beritaModel, beritaModel) ||
                other.beritaModel == beritaModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, beritaModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BeritaStateCopyWith<_$_BeritaState> get copyWith =>
      __$$_BeritaStateCopyWithImpl<_$_BeritaState>(this, _$identity);
}

abstract class _BeritaState extends BeritaState {
  const factory _BeritaState(
      {final bool isLoading,
      required final BeritaModel beritaModel}) = _$_BeritaState;
  const _BeritaState._() : super._();

  @override
  bool get isLoading;
  @override
  BeritaModel get beritaModel;
  @override
  @JsonKey(ignore: true)
  _$$_BeritaStateCopyWith<_$_BeritaState> get copyWith =>
      throw _privateConstructorUsedError;
}
