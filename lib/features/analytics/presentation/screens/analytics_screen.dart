import 'package:balance_tracker/features/categories/data/repositories/category_provider.dart';
import 'package:balance_tracker/features/transactions/data/repositories/transaction_provider.dart';
import 'package:balance_tracker/features/transactions/domain/models/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final categoriesAsync = ref.watch(allCategoriesProvider);
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'es_ES', symbol: '€');
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('Análisis',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ),
      body: Builder(builder: (context) {
        if (transactionsAsync.isLoading || categoriesAsync.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (transactionsAsync.hasError || categoriesAsync.hasError) {
          return const Center(child: Text('Error cargando datos'));
        }

        final transactions = transactionsAsync.value ?? [];
        final categories = categoriesAsync.value ?? [];

        // Mapa categoryId -> nombre
        final categoryMap = {
          for (final c in categories) c.id: c.name,
        };

        // Últimos 6 meses
        final months = List.generate(6, (i) {
          return DateTime(now.year, now.month - (5 - i), 1);
        });

        final monthlyData = months.map((month) {
          final filtered = transactions.where((t) =>
              t.date.month == month.month && t.date.year == month.year);
          final income = filtered
              .where((t) => t.type == TransactionType.income)
              .fold(0.0, (sum, t) => sum + t.amount);
          final expense = filtered
              .where((t) => t.type == TransactionType.expense)
              .fold(0.0, (sum, t) => sum + t.amount);
          return (month: month, income: income, expense: expense);
        }).toList();

        // Gastos por categoría del mes actual
        final monthExpenses = transactions.where((t) =>
            t.type == TransactionType.expense &&
            t.date.month == now.month &&
            t.date.year == now.year);

        final categoryTotals = <String, double>{};
        for (final t in monthExpenses) {
          final name = categoryMap[t.categoryId] ?? 'Otros';
          categoryTotals[name] = (categoryTotals[name] ?? 0) + t.amount;
        }

        final totalExpense =
            categoryTotals.values.fold(0.0, (a, b) => a + b);

        final categoryColors = [
          const Color(0xFFFF7675),
          const Color(0xFF74B9FF),
          const Color(0xFFA29BFE),
          const Color(0xFF55EFC4),
          const Color(0xFFFDCB6E),
          const Color(0xFFE17055),
          const Color(0xFF00B894),
          const Color(0xFFB2BEC3),
        ];

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Barras — ingresos vs gastos
            Text('Ingresos vs Gastos',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('Últimos 6 meses',
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.5))),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final label =
                              rodIndex == 0 ? 'Ingresos' : 'Gastos';
                          return BarTooltipItem(
                            '$label\n${currencyFormat.format(rod.toY)}',
                            GoogleFonts.inter(
                                color: Colors.white, fontSize: 12),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final month = months[value.toInt()];
                            return Text(
                              DateFormat('MMM', 'es_ES').format(month),
                              style: GoogleFonts.inter(fontSize: 11),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: List.generate(monthlyData.length, (i) {
                      final data = monthlyData[i];
                      return BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: data.income,
                            color: const Color(0xFF55EFC4),
                            width: 10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          BarChartRodData(
                            toY: data.expense,
                            color: const Color(0xFFFF7675),
                            width: 10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _LegendDot(
                    color: const Color(0xFF55EFC4), label: 'Ingresos'),
                const SizedBox(width: 16),
                _LegendDot(
                    color: const Color(0xFFFF7675), label: 'Gastos'),
              ],
            ),
            const SizedBox(height: 32),

            // Dona — gastos por categoría
            Text('Gastos por categoría',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(DateFormat('MMMM yyyy', 'es_ES').format(now),
                style: GoogleFonts.inter(
                    fontSize: 13,
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.5))),
            const SizedBox(height: 16),
            if (categoryTotals.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text('No hay gastos este mes',
                      style: GoogleFonts.inter(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4))),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 50,
                          sections: categoryTotals.entries
                              .toList()
                              .asMap()
                              .entries
                              .map((e) {
                            final color = categoryColors[
                                e.key % categoryColors.length];
                            final pct = totalExpense > 0
                                ? (e.value.value / totalExpense * 100)
                                : 0.0;
                            return PieChartSectionData(
                              color: color,
                              value: e.value.value,
                              title: '${pct.toStringAsFixed(0)}%',
                              radius: 60,
                              titleStyle: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...categoryTotals.entries
                        .toList()
                        .asMap()
                        .entries
                        .map((e) {
                      final color =
                          categoryColors[e.key % categoryColors.length];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            _LegendDot(
                                color: color, label: e.value.key),
                            const Spacer(),
                            Text(
                              currencyFormat.format(e.value.value),
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            const SizedBox(height: 32),
          ],
        );
      }),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.inter(fontSize: 13)),
      ],
    );
  }
}