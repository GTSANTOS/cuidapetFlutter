// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriaModel _$CategoriaModelFromJson(Map<String, dynamic> json) {
  return CategoriaModel(
    json['id'] as int,
    json['nome'] as String,
    json['tipo'] as String,
  );
}

Map<String, dynamic> _$CategoriaModelToJson(CategoriaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'tipo': instance.tipo,
    };
