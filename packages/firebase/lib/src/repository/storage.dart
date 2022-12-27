import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage Uint8List?
  Future<String> uploadImages(String pid, Uint8List xfile) async {
    // creating location to our firebase storage
    // Uint8List file = Uint8List(xfile.);
    Reference ref = _storage.ref().child('products').child(pid);

    String id = const Uuid().v1();
    ref = ref.child(id);

    // putting in uint8list format -> Upload task like a future but not future

    UploadTask uploadTask = ref.putData(xfile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //
  Future<List<String>> uploadFiles(List images, String pid) async {
    var imageUrls =
        await Future.wait(images.map((image) => uploadFile(image, pid)));
    return imageUrls;
  }

//
  Future<String> uploadFile(XFile xfile, String pid) async {
    String id = const Uuid().v1();

    var storageReference =
        _storage.ref().child('products').child(pid).child(id);

    File file = File(xfile.path);
    var uploadTask = storageReference.putFile(file);
    await uploadTask;

    return await storageReference.getDownloadURL();
  }
}
