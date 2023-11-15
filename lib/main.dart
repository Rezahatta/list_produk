import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login page',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _icon(),
          const SizedBox(height: 50),
          _inputField("Username", usernameController),
          const SizedBox(height: 20),
          _inputField("Password", passwordController, isPassword: true),
          const SizedBox(height: 50),
          _loginBtn(),
          const SizedBox(height: 20),
          _extraText(),
        ]),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white));

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: () {

        debugPrint("Username :" + usernameController.text);
        debugPrint("Password :" + passwordController.text);
         Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProductListPage()),
  );
        
      },
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Sign in ",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          )),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Color.fromARGB(255, 228, 226, 226),
        foregroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

Widget _extraText(){
    return const Text(
      "Can't access to your account?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white
      ),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(id: 1, name: '1 Minyak Sayur', price: 14000),
    Product(id: 2, name: '2 Mousepad', price: 20000),
    Product(id: 3, name: '3 Mouse', price: 20000),
    Product(id: 4, name: '4 Sapu', price: 15000),
    Product(id: 5, name: '5 Beras', price: 100000),
    Product(id: 6, name: '6 Baju', price: 60000),
    Product(id: 7, name: '7 sabun', price: 7000),
    Product(id: 8, name: '8 Lap tangan', price: 8000),
    Product(id: 9, name: '9 shampoo', price: 13000),
    Product(id: 10, name: '10 Bantal', price: 30000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Daftar Produk'),
      ),
              backgroundColor: const Color.fromARGB(255, 255, 218, 163),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('Harga: Rp ${products[index].price}'),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red, 
              ),
              onPressed: () {
                
                _showDeleteDialog(context, index);
              },
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          _showAddProductDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Penghapusan'),
          content: Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                
                _deleteProduct(index);
                Navigator.pop(context);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Produk Baru'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
               
                _addProduct(nameController.text, priceController.text);
                Navigator.pop(context);
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _addProduct(String name, String price) {
    double newPrice = double.tryParse(price) ?? 0.0;

    setState(() {
      products.add(Product(
        id: products.length + 1,
        name: name,
        price: newPrice,
      ));
    });
  }
}

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
