// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_create.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActivityCreate extends ActivityCreate {
  @override
  final String title;
  @override
  final String? description;
  @override
  final Date date;
  @override
  final String? location;

  factory _$ActivityCreate([void Function(ActivityCreateBuilder)? updates]) =>
      (ActivityCreateBuilder()..update(updates))._build();

  _$ActivityCreate._(
      {required this.title,
      this.description,
      required this.date,
      this.location})
      : super._();
  @override
  ActivityCreate rebuild(void Function(ActivityCreateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActivityCreateBuilder toBuilder() => ActivityCreateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActivityCreate &&
        title == other.title &&
        description == other.description &&
        date == other.date &&
        location == other.location;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActivityCreate')
          ..add('title', title)
          ..add('description', description)
          ..add('date', date)
          ..add('location', location))
        .toString();
  }
}

class ActivityCreateBuilder
    implements Builder<ActivityCreate, ActivityCreateBuilder> {
  _$ActivityCreate? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  Date? _date;
  Date? get date => _$this._date;
  set date(Date? date) => _$this._date = date;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  ActivityCreateBuilder() {
    ActivityCreate._defaults(this);
  }

  ActivityCreateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _date = $v.date;
      _location = $v.location;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActivityCreate other) {
    _$v = other as _$ActivityCreate;
  }

  @override
  void update(void Function(ActivityCreateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActivityCreate build() => _build();

  _$ActivityCreate _build() {
    final _$result = _$v ??
        _$ActivityCreate._(
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'ActivityCreate', 'title'),
          description: description,
          date: BuiltValueNullFieldError.checkNotNull(
              date, r'ActivityCreate', 'date'),
          location: location,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
