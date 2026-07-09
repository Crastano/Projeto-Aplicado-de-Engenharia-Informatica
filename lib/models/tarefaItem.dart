import 'package:flutter/material.dart';

class TarefaItem {
  const TarefaItem({
    required this.titulo,
    required this.data,
    required this.category,
    required this.categoryBackground,
    required this.categoryText,
    this.isCompleted = false,
    this.isRepeating = false,
    this.hasNotification = false,
  });

  final String titulo;
  final String data;
  final String category;
  final Color categoryBackground;
  final Color categoryText;
  final bool isCompleted;
  final bool isRepeating;
  final bool hasNotification;

  TarefaItem copyWith({
    String? titulo,
    String? data,
    String? category,
    Color? categoryBackground,
    Color? categoryText,
    bool? isCompleted,
    bool? isRepeating,
    bool? hasNotification,
  }) {
    return TarefaItem(
      titulo: titulo ?? this.titulo,
      data: data ?? this.data,
      category: category ?? this.category,
      categoryBackground: categoryBackground ?? this.categoryBackground,
      categoryText: categoryText ?? this.categoryText,
      isCompleted: isCompleted ?? this.isCompleted,
      isRepeating: isRepeating ?? this.isRepeating,
      hasNotification: hasNotification ?? this.hasNotification,
    );
  }
}
