import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<Document> documents = List.generate(
    20,
    (index) => Document(
      title: 'Баримт $index',
      barcode: '1234567890$index',
      price: '\1${(index + 1) * 10}.00₮',
      description: 'Баталгаажсан $index',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сайн байна уу, Ганхуяг'),
        // Add a back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Dashboard part
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DashboardCard(title: 'Улиралд бүртгэгдсэн', value: '101'),
                DashboardCard(title: 'Хүлээгдэж буй', value: '20'),
                DashboardCard(title: 'Урамшуулал', value: '29,264.27₮'),
                DashboardCard(title: 'Хонжвор', value: '0₮'),
              ],
            ),
          ),
          // List of registered documents
          Expanded(
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documents[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Barcode: ${documents[index].barcode}'),
                      Text('Үнэ: ${documents[index].price}'),
                      Text('Тайлбар: ${documents[index].description}'),
                    ],
                  ),
                  leading: Icon(Icons.description),
                  onTap: () {
                    // Handle document tap
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Гомдол',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            label: '+',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.other_houses),
            label: 'Бусад',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCamera(context);
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: firstCamera),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;

  DashboardCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class Document {
  final String title;
  final String barcode;
  final String price;
  final String description;

  Document({
    required this.title,
    required this.barcode,
    required this.price,
    required this.description,
  });
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
