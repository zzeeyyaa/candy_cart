import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var isLoading = false.obs;
  var currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // Set initial user if exists
    currentUser.value = supabase.auth.currentUser;

    // Listen to changes in Auth State
    supabase.auth.onAuthStateChange.listen((data) {
      currentUser.value = data.session?.user;
    });
  }

  // Register method
  Future<bool> signUp(BuildContext context, String email, String password) async {
    try {
      isLoading(true);
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      
      // Show success dialog
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        title: 'Registrasi Berhasil',
        desc: 'Silakan cek email Anda untuk verifikasi atau silakan masuk jika sudah aktif.',
        btnOkOnPress: () {},
      ).show();
      return true;
    } on AuthException catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Registrasi Gagal',
        desc: e.message,
        btnOkColor: Colors.redAccent,
        btnOkOnPress: () {},
      ).show();
      return false;
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Terjadi kesalahan tidak terduga: $e',
        btnOkColor: Colors.redAccent,
        btnOkOnPress: () {},
      ).show();
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Login method
  Future<bool> signIn(BuildContext context, String email, String password) async {
    try {
      isLoading(true);
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return true;
    } on AuthException catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Login Gagal',
        desc: e.message,
        btnOkColor: Colors.redAccent,
        btnOkOnPress: () {},
      ).show();
      return false;
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        title: 'Error',
        desc: 'Terjadi kesalahan tidak terduga: $e',
        btnOkColor: Colors.redAccent,
        btnOkOnPress: () {},
      ).show();
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Logout method
  Future<void> signOut() async {
    try {
      isLoading(true);
      await supabase.auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Gagal logout: $e');
    } finally {
      isLoading(false);
    }
  }
}
