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
          seedColor: const Color(0xFFFF7900), // Orange Orange
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
  // Utilisation de nouvelles images pour s'assurer qu'elles s'affichent bien
  List<String> images = [
    'https://picsum.photos/seed/p1/600/800',
    'https://picsum.photos/seed/p2/600/800',
    'https://picsum.photos/seed/p3/600/800',
    'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=600',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600',
  ];

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
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Bonjour,', style: TextStyle(color: Colors.white70, fontSize: 14)),
            Text('djuidje ange', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Noboussi fomena fred', style: TextStyle(color:Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
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
                  onDoubleTapDown: (details) => _showActionMenu(context, details.globalPosition, index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        images[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        // Gestion d'erreur si l'image ne charge pas
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
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
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterDashboard()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('LA PAGE SUIVANTE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
              ),
            ),
          ),
        ],
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
      appBar: AppBar(
        title: const Text('Mon Compteur', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: [
                  const Text('TOTAL DES CLICS', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('$_count', style: const TextStyle(fontSize: 80, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => setState(() => _count++),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7900),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: const Color(0xFFFF7900).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
                  ],
                ),
                child: const Icon(Icons.touch_app_rounded, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Tapez moi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
