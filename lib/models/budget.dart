import 'package:flutter/material.dart';

enum Category {
  auto,
  childcare,
  education,
  entertainment,
  food,
  health,
  shopping,
  tax,
  travel,
  work,
}

class BudgetCategory {
  final Category category;
  final IconData icon;

  const BudgetCategory({
    this.category,
    this.icon,
  });

  @override
  String toString() {
    var category = this.category.toString().split('.')[1];
    return category[0].toUpperCase() + category.substring(1);
  }
}

class Budget {
  final BudgetCategory category;
  final String title;
  final double amount;

  const Budget({
    this.category,
    this.title,
    this.amount,
  });
}

const categories = [
  BudgetCategory(
    category: Category.auto,
    icon: Icons.drive_eta,
  ),
  BudgetCategory(
    category: Category.childcare,
    icon: Icons.child_care,
  ),
  BudgetCategory(
    category: Category.education,
    icon: Icons.school,
  ),
  BudgetCategory(
    category: Category.entertainment,
    icon: Icons.live_tv,
  ),
  BudgetCategory(
    category: Category.food,
    icon: Icons.restaurant_menu,
  ),
  BudgetCategory(
    category: Category.health,
    icon: Icons.favorite,
  ),
  BudgetCategory(
    category: Category.shopping,
    icon: Icons.shopping_cart,
  ),
  BudgetCategory(
    category: Category.tax,
    icon: Icons.gavel,
  ),
  BudgetCategory(
    category: Category.travel,
    icon: Icons.flight_takeoff,
  ),
  BudgetCategory(
    category: Category.work,
    icon: Icons.work,
  ),
];
