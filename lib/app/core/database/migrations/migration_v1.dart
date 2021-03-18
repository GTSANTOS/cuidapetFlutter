import 'package:sqflite/sqflite.dart';

createV1(Batch batch) {
  batch.execute('''
  create table endereco (
    id Integer primary key autoincrement,
    endereco varchar(1000) not null,
    latitude varchar(1000) ,
    longitude varchar(1000),
    complemento varchar(1000) )
  ''');
}
