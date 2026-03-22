import 'package:flutter/material.dart';

void main() {
  runApp(const MaxitApp());
}

class MaxitApp extends StatelessWidget {
  const MaxitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7900),
          primary: const Color(0xFFFF7900),
        ),
      ),
      home: const ProfessionalGallery(),
    );
  }
}

class ProfessionalGallery extends StatefulWidget {
  const ProfessionalGallery({super.key});

  @override
  State<ProfessionalGallery> createState() => _ProfessionalGalleryState();
}

class _ProfessionalGalleryState extends State<ProfessionalGallery> {
  List<String> images = [
    'https://picsum.photos/seed/p1/600/800',
    'https://picsum.photos/seed/p2/600/800',
    'https://picsum.photos/seed/p3/600/800',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
  ];

  // Fonction pour afficher le menu (Modifier/Supprimer) sur appui long
  void _showActionMenu(BuildContext context, Offset position, int index) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    
    showMenu(
      context: context,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 0, 0),
        Rect.fromLTWH(0, 0, overlay.size.width, overlay.size.height),
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: const [
              Icon(Icons.edit_outlined, size: 20),
              SizedBox(width: 12),
              Text('Modifier'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: const [
              Icon(Icons.delete_outline, color: Colors.red, size: 20),
              SizedBox(width: 12),
              Text('Supprimer', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        setState(() => images.removeAt(index));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Bonjour,', style: TextStyle(color: Colors.white70, fontSize: 14)),
            Text('blanche bassiga', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('djuidje ange', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Noboussi fomena fred', style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text('Mes Services Photos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  // 1. APPUI LONG : Affiche le menu Modifier/Supprimer
                  onLongPressStart: (details) => _showActionMenu(context, details.globalPosition, index),
                  
                  // 2. DOUBLE CLIC : Affiche en plein écran
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenView(imageUrl: images[index]),
                      ),
                    );
                  },
                  child: Hero(
                    tag: images[index],
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(images[index], fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterDashboard())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, 
                  foregroundColor: Colors.white, 
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('LA PAGE SUIVANTE', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 3. PAGE PLEIN ÉCRAN : Glisser vers le bas pour quitter
class FullScreenView extends StatelessWidget {
  final String imageUrl;
  const FullScreenView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Détecte le glissement vers le bas
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 10) { // Si on glisse vers le bas
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Hero(
            tag: imageUrl,
            child: InteractiveViewer( // Permet de zoomer sur l'image
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CounterDashboard extends StatefulWidget {
  const CounterDashboard({super.key});
  @override
  State<CounterDashboard> createState() => _CounterDashboardState();
}

class _CounterDashboardState extends State<CounterDashboard> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Mon Compteur', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.black12)),
              child: Column(
                children: [
                  const Text('TOTAL DES CLICS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  Text('$_count', style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => setState(() => _count++),
              child: Container(
                height: 120, width: 120,
                decoration: const BoxDecoration(color: Color(0xFFFF7900), shape: BoxShape.circle),
                child: const Icon(Icons.touch_app, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tapez moi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
