import 'dart:convert';

class K_Response{
  int? rescode;
  String? message;
  dynamic data;

  String toJson() => json.encode(toMap());

  factory K_Response.fromJson(String source) =>
      K_Response.fromMap(json.decode(source));

//<editor-fold desc="Data Methods">

  K_Response({
    this.rescode,
    this.message,
    required this.data,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is K_Response &&
          runtimeType == other.runtimeType &&
          rescode == other.rescode &&
          message == other.message &&
          data == other.data);

  @override
  int get hashCode => rescode.hashCode ^ message.hashCode ^ data.hashCode;

  @override
  String toString() {
    return 'K_Response{' +
        ' rescode: $rescode,' +
        ' message: $message,' +
        ' data: $data,' +
        '}';
  }

  K_Response copyWith({
    int? rescode,
    String? message,
    dynamic? data,
  }) {
    return K_Response(
      rescode: rescode ?? this.rescode,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, String> toMap() {
    return {
      'rescode': this.rescode.toString(),
      'message': this.message.toString(),
      'data': this.data.toString(),
    };
  }

  factory K_Response.fromMap(Map<String, dynamic> map) {
    return K_Response(
      rescode: map['rescode'] as int,
      message: map['message'] as String,
      data: map['data'] as dynamic,
    );
  }

//</editor-fold>
}