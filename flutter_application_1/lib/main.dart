import 'package:flutter/material.dart';
import '/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, String>> informationList = [];
   File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  bool _isDrawerOpen = false;

  bool isNumeric(String? value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
   Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

Widget _buildInfoRow(String label, String value, Color color) {
  return Container(
    color: color,
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Text('$label:', style: const TextStyle(color: Colors.white)),
       if (label == '') // Conditionally show the image
            _selectedImage != null
                ? Image.file(_selectedImage!, width: 50, height: 50)
                : const Text('', style: TextStyle(color: Colors.white)),
          if (label != '') // Other labels
            Text(value, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: _isDrawerOpen
                  ? const Icon(Icons.close)
                  : const Icon(Icons.menu),
              onPressed: () {
                if (_isDrawerOpen) {
                  _scaffoldKey.currentState!.openEndDrawer();
                } else {
                  _scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
            backgroundColor: Colors.blue[400],
            iconTheme: const IconThemeData(
              color: Color.fromRGBO(235, 255, 0, 2.5),
            ),
            title: const Text('Page title'),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  // Add your action when heart icon is pressed
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Add your action when search icon is pressed
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Add your action when three dots icon is pressed
                },
              ),
            ],
          ),
         body: ListView.builder(
  itemCount: informationList.length,
  itemBuilder: (context, index) {
    Map<String, String> information = informationList[index];
    return ListTile(
      //title: Text('Name: ${information['Name']}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', information['Name']!, Colors.yellow),
          _buildInfoRow('Phone', information['Phone']!, Colors.blue),
          _buildInfoRow('Email', information['Email']!, Colors.green),
          _buildInfoRow('Address', information['Address']!, Colors.orange),
          _buildInfoRow('Website', information['Website']!, Colors.purple),
          // Thêm các thông tin khác nếu có
        ],
      ),
    );
  },
),


          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton(
                onPressed: () => _dialogBuilder(context),
                // ignore: sort_child_properties_last
                child: const Icon(Icons.add),
                backgroundColor: Colors.green,
              );
            },
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 10, 130, 228),
                  ),
                  child: Text('Drawer Header'),
                ),
                ListTile(
                  leading: const Icon(Icons.music_note),
                  title: const Text('Music'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Account'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.shape_line),
                label: 'Tròn vuông',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cabin),
                label: 'Nhà máy',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.tab),
                label: 'Tệp tin',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController websiteController = TextEditingController();

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text(
          //   'Title',
          //   style: TextStyle(
          //     fontSize: 40.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.blue,
          //   ),
          // ),
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                ElevatedButton(
             onPressed: _pickImage,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                   
                    padding: const EdgeInsets.all(8.0),
                    decoration: const  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black, 
                       //border:  Border.all(color: Colors.green, width: 2.0), // Adjust the color as needed
                    ),
                    child: const Icon(Icons.photo_camera, color: Color.fromARGB(255, 254, 254, 254)),  // Adjust the icon color as needed
                  ),
                  const SizedBox(width: 8),  // Add some spacing between icon and text
                  //const Text('Upload Image'),
                ],
              ),
            ),

            // Show the image preview
            _buildInfoRow('Image', '', Colors.transparent),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    suffixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    suffixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid phone number';
                    } else if (!isNumeric(value)) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    suffixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    // Các điều kiện validation khác nếu cần thiết
                    return null;
                  },
                ),
                TextFormField(
                  controller: websiteController,
                  decoration: const InputDecoration(
                    labelText: 'Website',
                    suffixIcon: Icon(Icons.web),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your website';
                    }
                    // Các điều kiện validation khác nếu cần thiết
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Handle saving the information
                  String name = nameController.text;
                  String phone = phoneController.text;
                  String email = emailController.text;
                  String address = addressController.text;
                  String website = websiteController.text;

                  // Do something with the information (e.g., save to the home screen)
                  _saveInformation(name, phone, email, address, website);
                   // Clear the text fields
                      nameController.clear();
                      phoneController.clear();
                      emailController.clear();
                      addressController.clear();
                      websiteController.clear();


                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _saveInformation(
      String name, String phone, String email, String address, String website) {
    // Tạo một đối tượng FormData để lưu thông tin từ form
    FormData formData = FormData(
      name: name,
      phone: phone,
      email: email,
      address: address,
      website: website,
    );

    // Thực hiện việc thêm thông tin vào body (hoặc làm gì đó với formData)
    // Điều này chỉ là một ví dụ và bạn cần điều chỉnh nó tùy thuộc vào yêu cầu của bạn.
    // Ví dụ: informationList.add(formData.toMap());
    informationList.add(formData.toMap());

    // Tái tạo UI
    _reloadUI();
  }

  void _reloadUI() {
    // Gọi setState để tái tạo UI khi danh sách thay đổi
    setState(() {});
  }
}

class FormData {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String website;

  FormData({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.website,
  });

  // Chuyển đổi thông tin thành một Map để lưu vào body hoặc thực hiện các xử lý khác
  Map<String, String> toMap() {
    return {
      'Name': name,
      'Phone': phone,
      'Email': email,
      'Address': address,
      'Website': website,
    };
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.reloadUI}): super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final VoidCallback reloadUI;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
