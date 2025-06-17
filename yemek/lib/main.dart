import 'package:flutter/material.dart';

void main() {
  runApp(RecipeApp());
}

class Recipe {
  final String title;
  final String description;
  final String imageUrl;
  final String instructions;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.instructions,
  });
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Tarifleri',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: RecipeListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> recipes = [
    Recipe(
      title: "Karnıyarık",
      description: "Patlıcan, kıyma ve salçayla yapılır.",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7fYnaesu-jgC_ELcpKlV8FfepMAFkf1-9iw&s",
      instructions:
          "Patlıcanları kızart, kıymayı kavur, salçayı ekle, karıştır ve patlıcanların içine koy.", // örnek
    ),
    Recipe(
      title: "Mantı",
      description: "Kayseri mantısı, yoğurt ve sos ile servis edilir.",
      imageUrl:
          "https://i.lezzet.com.tr/images-xxlarge-secondary/manti-nasil-pisirilir-9853d099-517c-4e89-be1c-960b703dcb8e.jpg",
      instructions: "Mantıları hazırlayıp haşla, yoğurt ve sos ile servis et.",
    ),
    Recipe(
      title: "Köfte",
      description:
          "Kıyma, soğan, ekmek içi, yumurta, tuz, karabiber, kimyon, maydanoz..",
      imageUrl:
          "https://cdn.ye-mek.net/App_UI/Img/out/650/2022/12/ev-koftesi-resimli-yemek-tarifi(11).jpg",
      instructions: "Malzemeleri karıştır, şekil ver, kızart veya fırınla.",
    ),
    Recipe(
      title: "Cacık",
      description: "Yoğurt, salatalık, sarımsak, su, tuz, nane, zeytinyağı..",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZd2oQFycTFP1GGcFrBgx-6bz0HHsuNYHgdg&s",
      instructions:
          "Salatalıkları rendele, yoğurdu çırp, sarımsağı ezin, su ve tuz ekle, karıştır, üzerine nane ve zeytinyağı koy.", // senin istediğin yapılış
    ),
    Recipe(
      title: "Ramen",
      description:
          "Erişte, et suyu, soya sosu, miso, sarımsak, zencefil, haşlanmış yumurta, yeşil soğan, susam yağı, nori.",
      imageUrl:
          "https://www.kikkoman.com.tr/fileadmin/_processed_/6/5/csm_1101-recipe-page-Authentic-Japanese-soy-sauce-ramen_desktop_4a77d9bc95.jpg",
      instructions:
          "Erişteyi haşla. Et suyunu kaynat, içine soya sosu, miso, sarımsak, zencefil ekle. Kaseye erişeyi koy, üstüne sıcak suyu dök. Üzerine yumurta, yeşil soğan, nori diz, susam yağı gezdir.",
    ),
    Recipe(
      title: "Rus salatası",
      description:
          "Haşlanmış patates, havuç, bezelye, kornişon turşu, mayonez, yoğurt, tuz. Sebzeleri doğra, hepsini karıştır, dolaba at, soğuk ye.",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQp4UXqvxgQl8ergpBvfGusF3P5AEEgoBrvfw&s",
      instructions:
          "Sebzeleri küp doğra, turşuyu ekle, yoğurtla mayonezi karıştır, hepsini birleştir, karıştır, dolaba koy, soğuk ye.",
    ),
    Recipe(
      title: "Dut Pilav",
      description: "Kuru dut, pirinç, soğan, tereyağı, su, tuz, karabiber.",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjGxgequueoarKw7wRI6928V5MPZPpyf9dvw&s",
      instructions:
          "Soğanı kavur, dutu ekle biraz çevir, pirinci kat kavur, suyu ve tuzu koy, kısık ateşte pişir, demlendir.",
    ),
  ];

  String searchQuery = '';

  void _addRecipeDialog() {
    String newTitle = '';
    String newDesc = '';
    String newImageUrl = '';
    String newInstructions = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Yeni Tarif Ekle"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Başlık"),
                onChanged: (val) => newTitle = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Açıklama"),
                onChanged: (val) => newDesc = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Resim URL"),
                onChanged: (val) => newImageUrl = val,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Yapılış"),
                onChanged: (val) => newInstructions = val,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("İptal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text("Ekle"),
            onPressed: () {
              if (newTitle.isNotEmpty &&
                  newDesc.isNotEmpty &&
                  newImageUrl.isNotEmpty &&
                  newInstructions.isNotEmpty) {
                setState(() {
                  recipes.add(Recipe(
                      title: newTitle,
                      description: newDesc,
                      imageUrl: newImageUrl,
                      instructions: newInstructions));
                });
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> filtered = recipes
        .where((recipe) =>
            recipe.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tarifler'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addRecipeDialog,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tarif ara...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) {
                setState(() {
                  searchQuery = val;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final recipe = filtered[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(recipe.imageUrl,
                  width: 60, height: 60, fit: BoxFit.cover),
              title: Text(recipe.title),
              subtitle: Text(recipe.description),
              onTap: () => _showRecipeDetail(recipe),
            ),
          );
        },
      ),
    );
  }

  void _showRecipeDetail(Recipe recipe) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(recipe.title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(recipe.imageUrl),
              SizedBox(height: 10),
              Text("Malzemeler:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(recipe.description),
              SizedBox(height: 10),
              Text("Yapılışı:", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(recipe.instructions),
            ],
          ),
        ),
        actions: [
          TextButton(
              child: Text("Kapat"), onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}
