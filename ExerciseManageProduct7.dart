import 'dart:io';

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);
}

void main() {
  List<Product> products = [];

  while (true) {
    print("\n=== QUẢN LÝ SẢN PHẨM ===");
    print("1. Thêm sản phẩm");
    print("2. Hiển thị danh sách sản phẩm");
    print("3. Tìm kiếm sản phẩm theo tên");
    print("4. Bán sản phẩm");
    print("5. Thoát");
    stdout.write("Chọn chức năng (1-5): ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addProduct(products);
        break;
      case '2':
        showProducts(products);
        break;
      case '3':
        searchProduct(products);
        break;
      case '4':
        sellProduct(products);
        break;
      case '5':
        print("Đã thoát chương trình.");
        return;
      default:
        print("❌ Lựa chọn không hợp lệ.");
    }
  }
}

void addProduct(List<Product> list) {
  stdout.write("Nhập tên sản phẩm: ");
  String name = stdin.readLineSync() ?? "";

  double price;
  while (true) {
    stdout.write("Nhập giá sản phẩm: ");
    try {
      price = double.parse(stdin.readLineSync()!);
      if (price < 0) throw FormatException();
      break;
    } catch (_) {
      print("❌ Giá không hợp lệ. Nhập số dương.");
    }
  }

  int quantity;
  while (true) {
    stdout.write("Nhập số lượng trong kho: ");
    try {
      quantity = int.parse(stdin.readLineSync()!);
      if (quantity < 0) throw FormatException();
      break;
    } catch (_) {
      print("❌ Số lượng không hợp lệ.");
    }
  }

  list.add(Product(name, price, quantity));
  print("✅ Đã thêm sản phẩm $name.");
}

void showProducts(List<Product> list) {
  if (list.isEmpty) {
    print("📭 Danh sách sản phẩm trống.");
    return;
  }

  print("\n📦 DANH SÁCH SẢN PHẨM:");
  print("| Tên sản phẩm         | Giá      | Số lượng |");
  print("-----------------------------------------------");

  for (var p in list) {
    print(
      "| ${p.name.padRight(20)} | ${p.price.toStringAsFixed(2).padLeft(8)} | ${p.quantity.toString().padLeft(9)} |",
    );
  }
}

void searchProduct(List<Product> list) {
  stdout.write("🔍 Nhập tên sản phẩm cần tìm: ");
  String keyword = stdin.readLineSync()!.toLowerCase();

  var found = list
      .where((p) => p.name.toLowerCase().contains(keyword))
      .toList();

  if (found.isEmpty) {
    print("❌ Không tìm thấy sản phẩm.");
    return;
  }

  print("\n📍 Kết quả tìm kiếm:");
  for (var p in found) {
    print(
      "- ${p.name} | Giá: ${p.price.toStringAsFixed(2)} | Kho: ${p.quantity}",
    );
  }
}

void sellProduct(List<Product> list) {
  stdout.write("🛒 Nhập tên sản phẩm cần bán: ");
  String name = stdin.readLineSync() ?? "";
  Product? product;
  try {
    product = list.firstWhere(
      (p) => p.name.toLowerCase() == name.toLowerCase(),
    );
  } catch (e) {
    product = null;
  }

  if (product == null) {
    print("❌ Không tìm thấy sản phẩm.");
    return;
  }

  int amount;
  while (true) {
    stdout.write("Nhập số lượng cần bán: ");
    try {
      amount = int.parse(stdin.readLineSync()!);
      if (amount <= 0) throw FormatException();
      break;
    } catch (_) {
      print("❌ Số lượng không hợp lệ.");
    }
  }

  if (amount > product.quantity) {
    print("⚠️ Không đủ hàng trong kho. Hiện có ${product.quantity} sản phẩm.");
  } else {
    product.quantity -= amount;
    print("✅ Bán thành công $amount sản phẩm ${product.name}.");
    print("📦 Số lượng còn lại: ${product.quantity}");
  }
}
