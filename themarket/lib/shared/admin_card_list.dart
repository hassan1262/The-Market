import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:super_market_application/models/product.dart';
import 'package:super_market_application/providers/product_provider.dart';
import 'package:super_market_application/shared/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class CardList extends StatefulWidget {
  Product data;
  int index;
  CardList(this.data, this.index);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
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

  void fn(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: ListView(
            children: [
              Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      widget.data.picture,
                      width: 100,
                      height: 100,
                    ),
                    IconButton(
                      onPressed: () {
                        showChoiceDialog(context);
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                      ),
                    ),
                    TextFormField(
                      initialValue: '${widget.data.name}',
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Name',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter the product name' : null,
                      onChanged: (val) {
                        widget.data.name = val;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: '${widget.data.price}',
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Price',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter the product price' : null,
                      onChanged: (val) {
                        widget.data.price = val;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      initialValue: '${widget.data.category}',
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Category',
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter the product category' : null,
                      onChanged: (val) {
                        widget.data.price = val;
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        this.storageReference = FirebaseStorage.instance
                            .ref()
                            .child("Products Images/$name");
                        this.uploadTask = this
                            .storageReference!
                            .putFile(File(this.imagePath));
                        this.downloadUrl = (await uploadTask);
                        url = await this.downloadUrl!.ref.getDownloadURL();
                        Provider.of<ProductProviders>(context, listen: false)
                            .editProducts(widget.index, url, widget.data.name,
                                widget.data.price, widget.data.category);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Update',
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: green,
                        minimumSize: Size.fromHeight(40),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.data.picture,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                "${widget.data.name}",
              ),
              Text(
                "${widget.data.price}",
              ),
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: green,
                ),
                onPressed: () {
                  widget.data.picture =
                      Provider.of<ProductProviders>(context, listen: false)
                          .picture(widget.index);
                  widget.data.name =
                      Provider.of<ProductProviders>(context, listen: false)
                          .name(widget.index);
                  widget.data.price =
                      Provider.of<ProductProviders>(context, listen: false)
                          .price(widget.index);
                  widget.data.category =
                      Provider.of<ProductProviders>(context, listen: false)
                          .category(widget.index);
                  fn(context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: red[900],
                ),
                onPressed: () {
                  Provider.of<ProductProviders>(context, listen: false)
                      .removeProducts(widget.index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
