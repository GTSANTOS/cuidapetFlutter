// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fornecedor_busca_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FornecedorBuscaModel _$FornecedorBuscaModelFromJson(Map<String, dynamic> json) {
  return FornecedorBuscaModel(
    json['id'] as int,
    json['nome'] as String,
    json['logo'] as String,
    (json['distancia'] as num)?.toDouble(),
    json['categoria'] == null
        ? null
        : CategoriaModel.fromJson(json['categoria'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FornecedorBuscaModelToJson(
        FornecedorBuscaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'logo': instance.logo,
      'distancia': instance.distancia,
      'categoria': instance.categoria,
    };
