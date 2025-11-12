import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'EX3 - Products',
			home: const ProductsScreen(),
		);
	}
}

class ProductsScreen extends StatelessWidget {
	const ProductsScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Products'),
				backgroundColor: const Color.fromARGB(255, 255, 255, 255),
				foregroundColor: Colors.black87,
				elevation: 0,
			),
			backgroundColor: const Color(0xFF1E88E5), // blue page background like mock
			body: SafeArea(
				child: Padding(
					// Root page padding (blue margins)
					padding: const EdgeInsets.all(16.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: const [
							ProductCard(
								imagePath: 'lib/ex3/dart.png',
								title: 'Dart',
								subtitle: 'the best object language',
							),
							SizedBox(height: 16),
							ProductCard(
								imagePath: 'lib/ex3/flutter.png',
								title: 'Flutter',
								subtitle: 'the best mobile widet library',
							),
							SizedBox(height: 16),
							ProductCard(
								imagePath: 'lib/ex3/firebase.png',
								title: 'Firebase',
								subtitle: 'the best cloud database',
							),
						],
					),
				),
			),
		);
	}
}

class ProductCard extends StatelessWidget {
	final String imagePath;
	final String title;
	final String subtitle;

	const ProductCard({
		super.key,
		required this.imagePath,
		required this.title,
		required this.subtitle,
	});

	@override
	Widget build(BuildContext context) {
		return Card(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
			elevation: 2,
			color: Colors.white,
			margin: EdgeInsets.zero,
			child: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.min,
					children: [
						// Image
						SizedBox(
							height: 80,
							child: Image.asset(imagePath, fit: BoxFit.contain),
						),
						const SizedBox(height: 12),
						// Title
						Text(
							title,
							style: const TextStyle(
								fontSize: 28,
								fontWeight: FontWeight.w600,
								color: Colors.black87,
							),
						),
						const SizedBox(height: 6),
						// Subtitle/description
						Text(
							subtitle,
							style: TextStyle(
								fontSize: 12,
								color: Colors.grey.shade700,
							),
						),
					],
				),
			),
		);
	}
}
