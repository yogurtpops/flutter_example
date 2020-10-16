/***
 * Class singleton, hanya di inisiasi satu kali saat pertama kali constructor digunakan, hanya ada 1 copy objek selama aplikasi berjalan
 * Constructor CreateProduct() tidak melakukan inisiasi ulang atau membuat objek baru, digunakan untuk mengakses objek dan method class CreateProduct
 */
class UploadItem {
  bool inProgress;
  String message;

  static final UploadItem _singleton = UploadItem._internal();

  factory UploadItem() {
    return _singleton;
  }

  UploadItem._internal(){
    print('inits upload service singleton');
    inProgress = false;
  }

  interruptProcess(){

  }
}