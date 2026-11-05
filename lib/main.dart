
import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(const MiniKatalogApp());

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3457D5),
          surface: const Color(0xFFF7F8FC),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        fontFamily: 'Roboto',
      ),
      home: const CatalogHomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailPage.routeName) {
          final product = settings.arguments! as Product;
          return MaterialPageRoute<void>(
            builder: (_) => ProductDetailPage(product: product),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
    required this.tag,
    this.imageAsset,
  });

  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final IconData icon;
  final Color color;
  final String tag;
  final String? imageAsset;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        icon: _iconFor(json['icon'] as String),
        color: Color(int.parse(
          (json['color'] as String).replaceFirst('0x', ''),
          radix: 16,
        )),
        tag: json['tag'] as String,
        imageAsset: json['imageAsset'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        'price': price,
        'icon': _iconName(icon),
        'color': '0x${color.toARGB32().toRadixString(16).padLeft(8, '0')}',
        'tag': tag,
        'imageAsset': imageAsset,
      };
}

IconData _iconFor(String name) => switch (name) {
      'headphones' => Icons.headphones_rounded,
      'watch' => Icons.watch_rounded,
      'laptop' => Icons.laptop_mac_rounded,
      'speaker' => Icons.speaker_rounded,
      'camera' => Icons.camera_alt_rounded,
      'phone' => Icons.smartphone_rounded,
      _ => Icons.devices_other_rounded,
    };

String _iconName(IconData icon) {
  if (icon == Icons.headphones_rounded) return 'headphones';
  if (icon == Icons.watch_rounded) return 'watch';
  if (icon == Icons.laptop_mac_rounded) return 'laptop';
  if (icon == Icons.speaker_rounded) return 'speaker';
  if (icon == Icons.camera_alt_rounded) return 'camera';
  if (icon == Icons.smartphone_rounded) return 'phone';
  return 'device';
}

// Demo data is written as JSON so the app can demonstrate parsing without an API.
const _catalogJson = '''
[
{"id":1,"name":"Studio Kulaklık","category":"Ses","description":"Gün boyu rahat kullanım için yumuşak kulak yastıkları ve dengeli ses sunan kablosuz kulaklık.","price":2499,"icon":"headphones","color":"0xFFE9E7FF","tag":"ÇOK SATAN","imageAsset":"assets/images/airpods_max.png"},
  {"id":2,"name":"Akıllı Saat S2","category":"Giyilebilir","description":"Günlük hareketini takip et, bildirimlerini gör ve sade tasarımın keyfini çıkar.","price":3199,"icon":"watch","color":"0xFFFFE8D9","tag":"YENİ","imageAsset":"assets/images/watch.png"},
  {"id":3,"name":"AirBook 14","category":"Bilgisayar","description":"Hafif gövdesi ve güçlü piliyle ders, iş ve günlük kullanım için pratik bir dizüstü bilgisayar.","price":28999,"icon":"laptop","color":"0xFFE2F1F0","tag":"ÖNE ÇIKAN","imageAsset":"assets/images/macbook.png"},
  {"id":4,"name":"Mini Bluetooth Hoparlör","category":"Ses","description":"Kompakt boyutuna rağmen güçlü ses verir. Evde veya dışarıda müziğin yanında.","price":1799,"icon":"speaker","color":"0xFFFFE7EC","tag":"FIRSAT","imageAsset":"assets/images/homepod_mini.png"},
  {"id":5,"name":"İphone","category":"Telefon","description":"Canlı ekranı, gün boyu dayanan pili ve geniş depolama alanıyla her güne hazır.","price":18999,"icon":"phone","color":"0xFFE4EDFF","tag":"YENİ","imageAsset":"assets/images/iphone.png"},
  {"id":6,"name":"Quiet Buds","category":"Ses","description":"Küçük kutusu cebine sığar; dokunmatik kontrollerle müziğini kolayca yönet.","price":2299,"icon":"headphones","color":"0xFFE8F3E2","tag":"ÇOK SATAN","imageAsset":"assets/images/airpods.png"},
  {"id":7,"name":"Desk Speaker","category":"Ses","description":"Masaüstünde az yer kaplayan, net ve sıcak ses karakterine sahip hoparlör.","price":3999,"icon":"speaker","color":"0xFFF0E7FF","tag":"ÖNE ÇIKAN","imageAsset":"assets/images/homepod.png"},
  {"id":8,"name":"iPhone Pembe","category":"Telefon","description":"Canlı pembe rengi, akıcı ekranı ve güçlü kamerasıyla günlük kullanım için tasarlandı.","price":19499,"icon":"phone","color":"0xFFFFE7EF","tag":"YENİ","imageAsset":"assets/images/iphone_pink.png"},
  {"id":9,"name":"iPhone Mavi","category":"Telefon","description":"Modern mavi tasarımı, hızlı performansı ve gün boyu dayanan piliyle yanında.","price":19499,"icon":"phone","color":"0xFFE4F0FF","tag":"POPÜLER","imageAsset":"assets/images/iphone_blue.png"},
  {"id":10,"name":"MacBook Silver","category":"Bilgisayar","description":"Gümüş renkli ince tasarımı ve uzun pil ömrüyle çalışma alanına uyum sağlar.","price":29999,"icon":"laptop","color":"0xFFE9EEF5","tag":"ÖNE ÇIKAN","imageAsset":"assets/images/macbook_silver.png"},
  {"id":11,"name":"MacBook Starlight","category":"Bilgisayar","description":"Açık tonlu şık görünümüyle ders, iş ve günlük işler için güçlü bir dizüstü bilgisayar.","price":29999,"icon":"laptop","color":"0xFFFFF0D8","tag":"YENİ","imageAsset":"assets/images/macbook_starlight.png"},
  {"id":12,"name":"iMac","category":"Bilgisayar","description":"Geniş ekranı ve hepsi bir arada tasarımıyla masaüstünde düzenli bir çalışma alanı sunar.","price":49999,"icon":"laptop","color":"0xFFE6F1FF","tag":"ÖNE ÇIKAN","imageAsset":"assets/images/imac.png"},
  {"id":13,"name":"iPad","category":"Tablet","description":"Hafif ve taşınabilir yapısıyla not almak, içerik izlemek ve günlük işlerini yapmak için ideal.","price":16999,"icon":"device","color":"0xFFE8F3E2","tag":"ÇOK SATAN","imageAsset":"assets/images/ipad.png"},
  {"id":14,"name":"Vision Pro","category":"Giyilebilir","description":"Dijital içerikleri çevrenle buluşturan gelişmiş bir uzamsal deneyim sunar.","price":89999,"icon":"device","color":"0xFFE8E9FF","tag":"YENİ","imageAsset":"assets/images/vision_pro.png"}
]
''';

final List<Product> _products = (jsonDecode(_catalogJson) as List<dynamic>)
    .map((item) => Product.fromJson(item as Map<String, dynamic>))
    .toList(growable: false);

class CartStore {
  static final ValueNotifier<int> count = ValueNotifier<int>(0);
  static final ValueNotifier<List<Product>> items =
      ValueNotifier<List<Product>>([]);

  static void add(Product product) {
    items.value = [...items.value, product];
    count.value = items.value.length;
  }
}

class CatalogHomePage extends StatefulWidget {
  const CatalogHomePage({super.key});

  @override
  State<CatalogHomePage> createState() => _CatalogHomePageState();
}

class _CatalogHomePageState extends State<CatalogHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Tümü';
  String _query = '';
  int get _cartCount => CartStore.count.value;

  List<String> get _categories => [
        'Tümü',
        ..._products.map((product) => product.category).toSet(),
      ];

  List<Product> get _visibleProducts => _products.where((product) {
        final matchesCategory = _selectedCategory == 'Tümü' ||
            product.category == _selectedCategory;
        final matchesSearch = product.name.toLowerCase().contains(_query) ||
            product.category.toLowerCase().contains(_query);
        return matchesCategory && matchesSearch;
      }).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addToCart(Product product) {
    CartStore.add(product);
    setState(() {});
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('${product.name} sepete eklendi'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildBanner()),
            SliverToBoxAdapter(child: _buildCategoryHeading()),
            SliverToBoxAdapter(child: _buildCategories()),
            SliverToBoxAdapter(child: _buildProductHeading()),
            if (_visibleProducts.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('Bu aramayla eşleşen ürün bulunamadı.')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                sliver: SliverGrid.builder(
                  itemCount: _visibleProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: .70,
                  ),
                  itemBuilder: (context, index) {
                    final product = _visibleProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () => Navigator.pushNamed(
                        context,
                        ProductDetailPage.routeName,
                        arguments: product,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: ValueListenableBuilder<int>(
        valueListenable: CartStore.count,
        builder: (context, count, _) => FloatingActionButton.extended(
          onPressed: () => _showCart(context),
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
          label: const Text('Sepetim'),
        ),
      ),
    );
  }

  Widget _buildHeader() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF3457D5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.grid_view_rounded, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MİNİ KATALOG', style: TextStyle(fontSize: 11, letterSpacing: 1.4, color: Color(0xFF777E90), fontWeight: FontWeight.w700)),
                  SizedBox(height: 3),
                  Text('Seç Beğen Al', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            ValueListenableBuilder<int>(
              valueListenable: CartStore.count,
              builder: (context, count, _) => IconButton(
                onPressed: () => _showCart(context),
                icon: Badge(
                  isLabelVisible: count > 0,
                  label: Text('$count'),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildSearch() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value.trim().toLowerCase()),
          decoration: InputDecoration(
            hintText: 'Ürün veya kategori ara',
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _query.isEmpty
                ? null
                : IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _query = '');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );

  Widget _buildBanner() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 158,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF203EAD), Color(0xFF5279F3)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('GÜNÜN SEÇKİSİ', style: TextStyle(color: Color(0xFFCFD9FF), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.4)),
                    SizedBox(height: 8),
                    Text('Teknolojiyle\ngününü yenile.', style: TextStyle(color: Colors.white, fontSize: 22, height: 1.12, fontWeight: FontWeight.w800)),
                    SizedBox(height: 8),
                    Text('Sana uygun ürünleri keşfet', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.auto_awesome_rounded, size: 70, color: Color(0xFFFFD166)),
            ],
          ),
        ),
      );

  Widget _buildCategoryHeading() => const Padding(
        padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
        child: Text('Kategoriler', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
      );

  Widget _buildCategories() => SizedBox(
        height: 42,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = _categories[index];
            final selected = category == _selectedCategory;
            return ChoiceChip(
              label: Text(category),
              selected: selected,
              onSelected: (_) => setState(() => _selectedCategory = category),
              showCheckmark: false,
              labelStyle: TextStyle(color: selected ? Colors.white : const Color(0xFF596174), fontWeight: FontWeight.w600),
              selectedColor: const Color(0xFF3457D5),
              backgroundColor: Colors.white,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            );
          },
        ),
      );

  Widget _buildProductHeading() => Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
        child: Row(
          children: [
            const Expanded(child: Text('Öne çıkan ürünler', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
            Text('${_visibleProducts.length} ürün', style: const TextStyle(color: Color(0xFF777E90), fontSize: 12)),
          ],
        ),
      );

  void _showCart(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) => ValueListenableBuilder<List<Product>>(
      valueListenable: CartStore.items,
      builder: (context, items, _) => SizedBox(
        height: 420,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                items.isEmpty
                    ? Icons.shopping_cart_outlined
                    : Icons.shopping_bag_rounded,
                size: 36,
              ),
              const SizedBox(height: 12),
              Text(
                items.isEmpty
                    ? 'Sepetin şimdilik boş'
                    : 'Sepetinde ${items.length} ürün var',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Text('Alışverişe dönüp ürün ekleyebilirsin.'),
                      )
                    : ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final product = items[index];
                          return ListTile(
                            leading: Icon(product.icon),
                            title: Text(product.name),
                            subtitle: Text(product.category),
                          );
                        },
                      ),
              ),
              const Text('Alışveriş Her Zaman Mutlu Eder.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Alışverişe dön'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}


Widget _productArtwork(Product product, {required double iconSize}) {
  final imageAsset = product.imageAsset;
  if (imageAsset == null) {
    return Icon(
      product.icon,
      size: iconSize,
      color: const Color(0xFF25325A),
    );
  }

  return Image.asset(
    imageAsset,
    fit: BoxFit.contain,
    width: double.infinity,
    height: double.infinity,
    errorBuilder: (context, error, stackTrace) => Icon(
      product.icon,
      size: iconSize,
      color: const Color(0xFF25325A),
    ),
  );
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                 child: Stack(
  fit: StackFit.expand,
  children: [
    Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: product.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: _productArtwork(product, iconSize: 68),
      ),
    ),
    Positioned(
      left: 8,
      top: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          product.tag,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w800,
            color: Color(0xFF3457D5),
          ),
        ),
      ),
    ),
  ],
),
                ),
                const SizedBox(height: 10),
                Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                const SizedBox(height: 3),
                Text(product.category, style: const TextStyle(fontSize: 10, color: Color(0xFF777E90))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text(_formatPrice(product.price), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF3457D5)))),
                    const Icon(Icons.arrow_forward_rounded, size: 16, color: Color(0xFF3457D5)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  static const routeName = '/product';
  final Product product;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Ürün detayı'), backgroundColor: const Color(0xFFF7F8FC)),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(color: product.color, borderRadius: BorderRadius.circular(28)),
              child: _productArtwork(product, iconSize: 130),
            ),
            const SizedBox(height: 22),
            Text(product.category.toUpperCase(), style: const TextStyle(color: Color(0xFF3457D5), fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(product.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            Text(product.description, style: const TextStyle(color: Color(0xFF687084), fontSize: 15, height: 1.55)),
            const SizedBox(height: 22),
            const Text('Ürün bilgileri', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            _InfoRow(label: 'Kategori', value: product.category),
            _InfoRow(label: 'Ürün kodu', value: 'MK-${product.id.toString().padLeft(4, '0')}'),
            _InfoRow(label: 'Stok durumu', value: 'Stokta'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text(_formatPrice(product.price), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF3457D5)))),
                FilledButton.icon(
                  onPressed: () {
                    CartStore.add(product);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ürün sepete eklendi')));
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded),
                  label: const Text('Sepete ekle'),
                ),
              ],
            ),
          ],
        ),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          children: [
            Expanded(child: Text(label, style: const TextStyle(color: Color(0xFF777E90)))),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

String _formatPrice(double price) =>
    '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')} ₺';



