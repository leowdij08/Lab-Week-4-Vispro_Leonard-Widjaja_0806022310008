// Fungsi untuk menghitung total jarak dari jalur tertentu
int hitungJarak(List<int> jalur, List<List<int>> jarak) {
  int totalJarak = 0;
  for (int i = 0; i < jalur.length - 1; i++) {
    totalJarak += jarak[jalur[i]][jalur[i + 1]];
  }
  return totalJarak;
}

// Fungsi untuk mencari jalur terpendek (TSP)
void tspBacktracking(List<List<int>> jarak) {
  List<int> simpul = [0, 1, 2, 3, 4]; // Semua simpul (A, B, C, D, E)
  List<int> jalurTerbaik = [];
  int jarakTerbaik = 999999; // Nilai besar sebagai batas atas

  // Fungsi rekursif untuk mencoba semua kemungkinan jalur
  void permutasi(List<int> jalur, List<int> sisa) {
    if (sisa.isEmpty) {
      // Tutup jalur dengan kembali ke simpul awal (A)
      jalur.add(0);
      int jarakSekarang = hitungJarak(jalur, jarak);

      // Simpan jalur dan jarak terpendek yang ditemukan
      if (jarakSekarang < jarakTerbaik) {
        jarakTerbaik = jarakSekarang;
        jalurTerbaik = List.from(jalur); // Salin jalur terbaik
      }

      jalur.removeLast(); // Kembali ke jalur sebelum ditutup
    } else {
      // Lanjutkan mencari jalur dengan mencoba semua simpul tersisa
      for (int i = 0; i < sisa.length; i++) {
        int berikutnya = sisa.removeAt(i);
        jalur.add(berikutnya);
        permutasi(jalur, sisa);
        jalur.removeLast(); // Kembali ke kondisi sebelum menambah simpul
        sisa.insert(i, berikutnya); // Kembalikan simpul yang dihapus
      }
    }
  }

  // Mulai dengan simpul A (0) dan cari jalur terbaik
  permutasi([0], simpul.sublist(1)); // Memulai dari A (0), dan sisanya

  // Cetak hasil jalur terbaik dan jarak terpendek
  print('Jalur terpendek: ${jalurTerbaik.map((v) => String.fromCharCode(65 + v)).join(' -> ')}');
  print('Jarak terpendek: $jarakTerbaik');
}

void main() {
  // Matriks jarak berdasarkan graf yang diberikan
  List<List<int>> jarak = [
    [0, 8, 3, 4, 10],  // Jarak dari A
    [8, 0, 5, 2, 7],   // Jarak dari B
    [3, 5, 0, 1, 6],   // Jarak dari C
    [4, 2, 1, 0, 3],   // Jarak dari D
    [10, 7, 6, 3, 0]   // Jarak dari E
  ]; 

  tspBacktracking(jarak);
}
