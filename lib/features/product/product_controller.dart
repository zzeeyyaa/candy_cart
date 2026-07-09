import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'product_model.dart';

class ProductController extends GetxController {
  // Instance Supabase
  final supabase = Supabase.instance.client;

  // State / Variabel yang bisa dipantau (Observable)
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Langsung ambil data saat controller dipanggil
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      // Query ke tabel 'products' di Supabase
      final response = await supabase
          .from('products')
          .select()
          .isFilter('deleted_at', null); // Sesuai dengan RLS public (soft delete)

      // Mapping data JSON ke List of Product
      products.value = (response as List)
          .map((item) => Product.fromJson(item))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
    } finally {
      isLoading(false);
    }
  }
}