// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/admin_card_list.dart';
import 'package:super_market_application/shared/app_bar.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
// ignore: must_be_immutable
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int index = 0;
  File? image;
  late String i;
  String url = '';
  String imagePath = '';
  String? name;
  Reference? storageReference;
  UploadTask? uploadTask;
  TaskSnapshot? downloadUrl;
  Future saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    this.name = basename(imagePath);
    this.imagePath = imagePath;
    print(name);
    final image = File('${directory.path}/$name');
    i = image.path;

    return File(imagePath).copy(image.path);
  }

  _openGallery(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imagePermanent = await saveImagePermanently(image.path);
    // final imageTemporary = File(image.path);
    setState(() {
      // this.image = imageTemporary;
      this.image = imagePermanent;
    });
    Navigator.of(context).pop();
  }

  openCamera(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imagePermanent = await saveImagePermanently(image.path);
    // final imageTemporary = File(image.path);
    setState(() {
      // this.image = imageTemporary;
      this.image = imagePermanent;
    });
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Make a choice'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    openCamera(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: TopBar('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProductProviders>(
          builder: (context, ProductProviders data, child) {
            return data.getProduct.length != 0
                ? ListView.builder(
                    itemCount: data.getProduct.length,
                    itemBuilder: (context, index) {
                      return CardList(data.getProduct[index], index);
                    },
                  )
                : GestureDetector(
                    child: Center(
                      child: Text('Add Product'),
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(context);
        },
        backgroundColor: white,
        child: Icon(
          Icons.add,
          color: green,
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _price = TextEditingController();
    TextEditingController _category = TextEditingController();
    // TextEditingController _id = TextEditingController();
    // Create button
    Widget okButton = TextButton(
      child: Text("ADD"),
      onPressed: () async {
        this.image = null;
        DateTime now = DateTime.now();
        String id = now.hour.toString() +
            now.minute.toString() +
            now.second.toString() +
            now.toString();
        this.storageReference =
            FirebaseStorage.instance.ref().child("Products Images/$name");
        this.uploadTask = this.storageReference!.putFile(File(this.imagePath));
        this.downloadUrl = (await uploadTask);
        url = await this.downloadUrl!.ref.getDownloadURL();
        Provider.of<ProductProviders>(context, listen: false)
            .addProducts(url, _name.text, _price.text, _category.text, id);

        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ADD A Product "),
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return ListView(
            children: [
              this.image != null
                  ? ClipOval(
                      child: Image.file(
                        image!,
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/note.jpeg',
                      ),
                      radius: 70.0,
                    ),
              IconButton(
                onPressed: () {
                  showChoiceDialog(context);
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _name,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _price,
                decoration: InputDecoration(hintText: "Enter Price"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _category,
                decoration: InputDecoration(hintText: "Enter category"),
              ),
            ],
          );
        },
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
