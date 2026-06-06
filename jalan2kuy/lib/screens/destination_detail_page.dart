import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';

class DestinationDetailPage extends StatelessWidget {
  final String destinationId;
  final String destinationName;
  final String destinationImage;
  final String destinationThumbnail;

  const DestinationDetailPage({
    Key? key,
    required this.destinationId,
    required this.destinationName,
    required this.destinationImage,
    required this.destinationThumbnail,
  }) : super(key: key);

  // Data dummy destinasi lengkap (sesuai database)
  Map<String, dynamic> _getDestinationData() {
    switch (destinationId) {
      case 'dst001': // Danau Weekuri
        return {
          'id': 'dst001',
          'name': 'Danau Weekuri',
          'location': 'Kabupaten Sumba Barat Daya, Nusa Tenggara Timur',
          'openingHours': '08:00',
          'closingHours': '17:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 10000,
          'description': 'Danau Weekuri adalah sebuah danau unik yang terletak di Desa Kelapa Lima, Kecamatan Kodi Utara, Kabupaten Sumba Barat Daya, Nusa Tenggara Timur (NTT). Dikenal juga dengan sebutan Danau Air Asin Weekuri, tempat ini merupakan salah satu keajaiban alam paling menakjubkan di Pulau Sumba. Berbeda dengan danau pada umumnya yang berisi air tawar, air di Danau Weekuri berasal dari air laut yang masuk melalui celah-celah batu karang, menjadikannya sebagai laguna alami dengan perpaduan warna biru muda, hijau toska, dan jernih transparan yang memanjakan mata.\n\nPemandangan di sekitar danau sangat mempesona — airnya begitu tenang, dikelilingi batu karang tinggi dan vegetasi hijau yang menambah kesan alami serta menenangkan. Dengan kedalaman yang bervariasi, mulai dari sekitar satu meter di tepi hingga lebih dari lima meter di bagian tengah, Danau Weekuri menjadi tempat ideal untuk berenang, bersantai, atau sekadar menikmati keindahan alam. Nama "Weekuri" sendiri berasal dari bahasa daerah Sumba yang berarti "air yang memercik", menggambarkan proses alami masuknya air laut ke dalam danau melalui celah-celah batu karang di tepi pantai.',
          'imagePath': 'destinations/image/GxXfM0rt0mQeK9pdjsHN86t3JPNqwT4vbVFN5FKe.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/OkEpL8NHoapcX1k2tO80pouSNsSrpmTatzFoEUGG.jpg',
        };
      case 'dst002': // Gunung Rinjani
        return {
          'id': 'dst002',
          'name': 'Gunung Rinjani',
          'location': 'Pulau Lombok, Nusa Tenggara Barat',
          'openingHours': '07:00',
          'closingHours': '17:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 150000,
          'description': 'Gunung Rinjani adalah salah satu gunung berapi tertinggi di Indonesia yang terletak di Pulau Lombok, Nusa Tenggara Barat, dengan ketinggian mencapai 3.726 meter di atas permukaan laut. Gunung ini merupakan bagian dari Taman Nasional Gunung Rinjani yang memiliki luas sekitar 41.330 hektare dan menjadi salah satu destinasi wisata alam paling populer di Indonesia maupun dunia.\n\nDi kawasan gunung ini, wisatawan dapat menemukan beragam keajaiban alam seperti Danau Segara Anak, sebuah danau kawah berwarna biru kehijauan yang terbentuk akibat letusan besar pada masa lalu. Di tengah danau tersebut berdiri sebuah gunung kecil bernama Gunung Barujari, yang sering disebut "anak Rinjani". Selain danau yang menakjubkan, panorama Rinjani juga dihiasi dengan hamparan padang rumput, hutan tropis yang lebat, air terjun yang mempesona, hingga jalur pendakian menantang dengan pemandangan matahari terbit dan terbenam yang spektakuler.',
          'imagePath': 'destinations/image/9G19cn2KNqscnTcfKmeMfUDPPhNJh3jS8yUfVyRE.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/Jru103JQPunexa2hZ07NjXkf38grIJbhEqiB1Skj.jpg',
        };
      case 'dst003': // Bukit Merese
        return {
          'id': 'dst003',
          'name': 'Bukit Merese',
          'location': 'Kabupaten Lombok Tengah, Nusa Tenggara Barat',
          'openingHours': '05:00',
          'closingHours': '19:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 10000,
          'description': 'Bukit Merese adalah salah satu destinasi wisata alam paling terkenal di Pulau Lombok, Nusa Tenggara Barat. Terletak di kawasan Pantai Tanjung Aan, Kecamatan Pujut, Kabupaten Lombok Tengah, Bukit Merese menjadi tempat favorit bagi wisatawan lokal maupun mancanegara untuk menikmati keindahan panorama alam dari ketinggian.\n\nBukit ini menawarkan pemandangan yang luar biasa indah, berupa hamparan laut biru yang berpadu dengan perbukitan hijau serta garis pantai yang memanjang di sepanjang pesisir selatan Lombok. Dari puncak bukit, pengunjung dapat menyaksikan pemandangan 360 derajat yang mencakup Pantai Tanjung Aan di sebelah timur dan Pantai Seger di sebelah barat. Bukit Merese terkenal sebagai spot terbaik untuk menikmati matahari terbit (sunrise) maupun matahari terbenam (sunset).',
          'imagePath': 'destinations/image/FWQjn3D35MjH1HNRbMH7zUNuaFs5DyqgaKeYmAQG.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/x9mHJgSmPAkPzq2g0xz21k9M2ra2SAyK2xO7deId.jpg',
        };
      case 'dst004': // Candi Borobudur
        return {
          'id': 'dst004',
          'name': 'Candi Borobudur',
          'location': 'Magelang, Jawa Tengah',
          'openingHours': '06:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 50000,
          'description': 'Candi Borobudur adalah salah satu warisan budaya dan sejarah paling megah di dunia yang terletak di Magelang, Jawa Tengah, Indonesia. Candi ini merupakan candi Buddha terbesar di dunia dan menjadi salah satu simbol kejayaan peradaban Nusantara pada masa lampau. Dibangun pada masa Dinasti Syailendra sekitar abad ke-8 hingga ke-9 Masehi, Borobudur menggambarkan kebesaran arsitektur dan spiritualitas umat Buddha di masa itu.\n\nStruktur candi ini berbentuk piramida berundak yang terdiri dari sembilan tingkat, yakni enam teras berbentuk bujur sangkar di bagian bawah dan tiga teras melingkar di bagian atas. Di puncaknya terdapat satu stupa besar yang menjadi pusat dari keseluruhan bangunan. Secara keseluruhan, Borobudur memiliki 2.672 panel relief dan 504 arca Buddha, yang semuanya dipahat dengan detail luar biasa menggunakan batu andesit.',
          'imagePath': 'destinations/image/wKVMGKiZSh4eAo7NRgKYbNNELSImoYhDIu8IWLLr.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/Z6NOINhNtQgb0N3sWAGYSyNypnjBI3RAvw2DmbBD.jpg',
        };
      case 'dst005': // Candi Prambanan
        return {
          'id': 'dst005',
          'name': 'Candi Prambanan',
          'location': 'Sleman, Yogyakarta',
          'openingHours': '06:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 150000,
          'description': 'Candi Prambanan adalah kompleks candi Hindu terbesar dan termegah di Indonesia yang terletak di perbatasan antara Kabupaten Sleman, Daerah Istimewa Yogyakarta, dan Kabupaten Klaten, Jawa Tengah. Candi ini dibangun sekitar abad ke-9 Masehi oleh Rakai Pikatan dari Wangsa Sanjaya sebagai persembahan untuk Trimurti, yaitu tiga dewa utama dalam agama Hindu: Brahma (Sang Pencipta), Wisnu (Sang Pemelihara), dan Siwa (Sang Pelebur).\n\nKompleks Candi Prambanan terdiri dari lebih dari 240 candi, meskipun kini sebagian besar hanya tersisa reruntuhannya akibat gempa dan waktu. Bangunan utamanya terdapat tiga candi besar di bagian tengah, yaitu Candi Siwa setinggi 47 meter sebagai candi utama, diapit oleh Candi Brahma dan Candi Wisnu di sisi kiri dan kanan. Pada tahun 1991, Candi Prambanan resmi ditetapkan sebagai Situs Warisan Dunia oleh UNESCO.',
          'imagePath': 'destinations/image/sBBVjGZmm7rcwaMEUfYQsIqz2h3Cw4M1Awz1im11.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/gTAnjdweyCpBtco74SYQCwrRBL8lDFm1A59fHIg8.jpg',
        };
      case 'dst006': // Monumen Nasional
        return {
          'id': 'dst006',
          'name': 'Monumen Nasional (Monas)',
          'location': 'Jakarta Pusat, DKI Jakarta',
          'openingHours': '08:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 30000,
          'description': 'Monumen Nasional (Monas) adalah ikon kebanggaan bangsa Indonesia yang terletak di pusat Kota Jakarta, tepatnya di Lapangan Medan Merdeka. Monas dibangun sebagai simbol perjuangan rakyat Indonesia dalam merebut kemerdekaan dari penjajahan, sekaligus menjadi pengingat semangat nasionalisme dan cinta tanah air. Pembangunan monumen ini dimulai pada 17 Agustus 1961 atas prakarsa Presiden Soekarno, dan diresmikan untuk umum pada 12 Juli 1975.\n\nMonas memiliki tinggi sekitar 132 meter dan dirancang oleh arsitek Friedrich Silaban serta R.M. Soedarsono. Di puncaknya terdapat lidah api yang terbuat dari perunggu seberat 14,5 ton, dilapisi emas murni seberat 50 kilogram. Api tersebut disebut "Api Abadi Kemerdekaan", yang menyimbolkan semangat perjuangan bangsa Indonesia yang tidak pernah padam.',
          'imagePath': 'destinations/image/xVCHrIeT3XCUXnwJGXGu2CqOENFKa3NtilsMJChU.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/HDGNRxBmmj7ZBTEblAcFJD1FBqfgD7TQTSJEb6wA.jpg',
        };
      case 'dst007': // Taman Nasional Komodo
        return {
          'id': 'dst007',
          'name': 'Taman Nasional Komodo',
          'location': 'Manggarai Barat, Nusa Tenggara Timur',
          'openingHours': '06:00',
          'closingHours': '18:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 50000,
          'description': 'Taman Nasional Komodo adalah salah satu destinasi wisata paling terkenal di Indonesia dan dunia, terletak di Kepulauan Nusa Tenggara, tepatnya di antara Pulau Sumbawa dan Pulau Flores. Kawasan ini terdiri dari tiga pulau besar — Pulau Komodo, Pulau Rinca, dan Pulau Padar — serta beberapa pulau kecil lainnya yang semuanya memiliki keindahan alam yang luar biasa.\n\nDidirikan pada tahun 1980 dan diakui sebagai Warisan Dunia UNESCO pada tahun 1991, Taman Nasional Komodo awalnya dibentuk untuk melindungi hewan purba langka Komodo (Varanus komodoensis), spesies kadal terbesar di dunia yang hanya hidup secara alami di kawasan ini. Komodo dapat tumbuh hingga lebih dari tiga meter dan memiliki gigitan beracun yang mematikan bagi mangsanya.',
          'imagePath': 'destinations/image/Qk6YfPAJv0Rm9Zfxd9xt7H6FKnCjQwnii06oPs32.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/PT03feKTeO3vsJJvalQtoGwRmdrUZaiFvEZuVPom.jpg',
        };
      case 'dst008': // Taman Nasional Way Kambas
        return {
          'id': 'dst008',
          'name': 'Taman Nasional Way Kambas',
          'location': 'Lampung Timur, Lampung',
          'openingHours': '07:00',
          'closingHours': '18:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 25000,
          'description': 'Taman Nasional Way Kambas adalah salah satu taman nasional tertua di Indonesia yang terletak di Provinsi Lampung, tepatnya di bagian timur Pulau Sumatra. Kawasan ini memiliki luas sekitar 125.000 hektare dan dikenal sebagai pusat konservasi gajah Sumatra (Elephas maximus sumatranus), salah satu spesies gajah endemik Indonesia yang kini terancam punah.\n\nDidirikan pada tahun 1985, taman nasional ini menjadi simbol upaya pelestarian satwa langka dan ekosistem hutan dataran rendah Sumatra. Daya tarik utama Way Kambas adalah Pusat Konservasi Gajah (Elephant Training Centre) yang berfungsi sebagai tempat pelatihan, rehabilitasi, dan pengembangbiakan gajah-gajah liar agar dapat hidup berdampingan dengan manusia secara harmonis.',
          'imagePath': 'destinations/image/5Dt7dJtSib8icUfgrPUeBxQ3EyaggRuR5FP6e2XQ.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/DFkBTafMCmWiosOjBNMK1ho8Gwtz6BJCbq8jrLnZ.jpg',
        };
      case 'dst009': // Taman Nasional Gunung Leuser
        return {
          'id': 'dst009',
          'name': 'Taman Nasional Gunung Leuser',
          'location': 'Aceh, Sumatra Utara',
          'openingHours': '07:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 20000,
          'description': 'Taman Nasional Gunung Leuser adalah salah satu kawasan konservasi paling penting dan megah di Indonesia yang terletak di Provinsi Aceh dan Sumatera Utara. Kawasan ini memiliki luas lebih dari 1,09 juta hektare dan merupakan bagian dari Warisan Hutan Hujan Tropis Sumatera (Tropical Rainforest Heritage of Sumatra) yang diakui sebagai Warisan Dunia UNESCO sejak tahun 2004.\n\nTaman Nasional Gunung Leuser dikenal sebagai rumah bagi keanekaragaman hayati tertinggi di Asia Tenggara, dengan ribuan spesies flora dan fauna yang hidup di dalamnya. Salah satu daya tarik utamanya adalah keberadaan empat satwa besar yang terancam punah, yaitu orangutan Sumatra, gajah Sumatra, harimau Sumatra, dan badak Sumatra.',
          'imagePath': 'destinations/image/bhbPy3iv8bk87U0HhkBfqT2xjalK3FVq4aV0DQbo.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/j3QrCUrG63dmcnZiPc6F2fjROSJKnhJiKwZkiHlq.jpg',
        };
      case 'dst010': // Pantai Ora
        return {
          'id': 'dst010',
          'name': 'Pantai Ora',
          'location': 'Pulau Seram, Maluku Tengah',
          'openingHours': '00:01',
          'closingHours': '23:59',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 25000,
          'description': 'Pantai Ora adalah salah satu surga tersembunyi di Indonesia yang terletak di Desa Saleman, Kecamatan Seram Utara, Kabupaten Maluku Tengah, Provinsi Maluku. Pantai ini dikenal luas karena keindahannya yang sering disebut sebanding bahkan menyaingi destinasi tropis dunia seperti Maladewa atau Bora-Bora.\n\nPantai Ora memiliki pesona luar biasa dengan air laut yang jernih sebening kaca, pasir putih halus, serta latar belakang perbukitan hijau yang menyejukkan mata. Air lautnya yang tenang memantulkan gradasi warna biru dan toska yang menawan, menciptakan panorama yang sangat fotogenik. Salah satu daya tarik utama Pantai Ora adalah kehidupan bawah lautnya yang mempesona, di mana wisatawan dapat langsung melihat terumbu karang dan ikan-ikan tropis berwarna-warni hanya dengan snorkeling di tepi pantai.',
          'imagePath': 'destinations/image/DpA9IBCR3YWQyBAg73nFP0lHAZQ4UfKXk2x2X3di.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/bIHGbHujlZUTuX4rWldrGCp3fZiyrYT77SHlPGLT.jpg',
        };
      case 'dst011': // Pantai Gatra
        return {
          'id': 'dst011',
          'name': 'Pantai Gatra',
          'location': 'Malang, Jawa Timur',
          'openingHours': '07:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 10000,
          'description': 'Pantai Gatra adalah salah satu destinasi wisata alam yang menawan di Kabupaten Malang, Provinsi Jawa Timur, tepatnya berada di kawasan Desa Sendang Biru, Kecamatan Sitiarjo. Pantai ini merupakan bagian dari Kawasan Konservasi Mangrove dan Pesisir Clungup Mangrove Conservation (CMC Tiga Warna), yang dikelola oleh masyarakat setempat dengan konsep ekowisata berkelanjutan.\n\nPantai Gatra terkenal karena keindahannya yang masih sangat alami dan bersih, jauh dari hiruk pikuk keramaian kota. Berbeda dengan pantai-pantai wisata pada umumnya, jumlah pengunjung di sini dibatasi setiap harinya agar kelestarian alam tetap terjaga. Garis pantainya dihiasi pasir putih lembut dengan air laut berwarna biru kehijauan yang tenang karena terlindung oleh gugusan pulau-pulau kecil di depannya.',
          'imagePath': 'destinations/image/4RtZb1cYOMCbCaOyXoAf3PvWvZp8IhT8DyLvpaIi.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/MSm9GPXifxGZERHqt2CnKIoZPjlw1fURYMPskF9c.jpg',
        };
      case 'dst012': // Pantai Tanjung Aan
        return {
          'id': 'dst012',
          'name': 'Pantai Tanjung Aan',
          'location': 'Lombok Tengah, Nusa Tenggara Barat',
          'openingHours': '06:00',
          'closingHours': '18:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 10000,
          'description': 'Pantai Tanjung Aan adalah salah satu pantai terindah di Pulau Lombok, Nusa Tenggara Barat, yang terletak di Desa Sengkol, Kecamatan Pujut, Kabupaten Lombok Tengah, tidak jauh dari kawasan wisata Mandalika. Pantai ini terkenal karena keunikan pasirnya yang memiliki dua tekstur berbeda — di satu sisi butirannya halus seperti tepung, sementara di sisi lainnya berbentuk bulat-bulat kecil menyerupai biji merica, sehingga sering disebut juga sebagai "Pantai Merica".\n\nGaris pantainya yang panjang membentuk lengkungan indah seperti teluk, dengan air laut berwarna biru toska yang jernih dan ombak yang lembut, menciptakan suasana tenang dan menenangkan. Dikelilingi oleh perbukitan hijau seperti Bukit Merese di sebelah barat dan Bukit Batu Payung di sisi timur, Pantai Tanjung Aan menawarkan pemandangan alam yang menakjubkan dari berbagai sudut.',
          'imagePath': 'destinations/image/QG9zj5k4xv3rv6aecwwWHmjvfk40Jt4LVh0LBoW0.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/rMyHmuAOtczUFlqBYJ9ifXtSfxFRxccrtCIefZ15.jpg',
        };
      case 'dst013': // Floating Market Lembang
        return {
          'id': 'dst013',
          'name': 'Floating Market Lembang',
          'location': 'Lembang, Kabupaten Bandung Barat',
          'openingHours': '09:00',
          'closingHours': '18:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 35000,
          'description': 'Floating Market Lembang adalah salah satu destinasi wisata unik dan populer di Lembang, Kabupaten Bandung Barat, Provinsi Jawa Barat, yang menawarkan pengalaman berbelanja dan bersantap di atas air dengan suasana sejuk khas pegunungan. Berlokasi di kawasan dataran tinggi yang dikelilingi perbukitan hijau dan udara segar, Floating Market Lembang menghadirkan konsep wisata kuliner dan rekreasi keluarga yang berpadu dengan keindahan alam.\n\nSeperti namanya, tempat ini mengusung konsep pasar terapung, di mana para pedagang menjajakan makanan dan minuman khas Nusantara menggunakan perahu kayu yang mengapung di atas danau alami. Pengunjung dapat membeli aneka kuliner seperti batagor, sate kelinci, nasi liwet, jagung bakar, hingga minuman tradisional dengan menggunakan koin khusus yang ditukar di loket utama.',
          'imagePath': 'destinations/image/EpqU8kp68a7ClpZ9Iyki9GB6eJXdzm4oxwUbpdnP.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/w422Ql7Bz1AOt0LA5RIgOjDeLd5RI6rfSjUu7C6.jpg',
        };
      case 'dst014': // Pura Tanah Lot
        return {
          'id': 'dst014',
          'name': 'Pura Tanah Lot',
          'location': 'Tabanan, Bali',
          'openingHours': '06:00',
          'closingHours': '19:00',
          'timezone': 'WITA',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 30000,
          'description': 'Pura Tanah Lot adalah salah satu ikon wisata paling terkenal di Pulau Bali dan menjadi simbol keindahan serta kekayaan budaya spiritual masyarakat Hindu Bali. Terletak di Desa Beraban, Kecamatan Kediri, Kabupaten Tabanan, sekitar 20 kilometer dari Kota Denpasar, Pura Tanah Lot berdiri megah di atas batu karang besar di tengah laut yang hanya dapat diakses ketika air laut surut.\n\nNama "Tanah Lot" berasal dari kata "tanah" yang berarti daratan dan "lot" atau "lod" yang berarti laut, yang secara harfiah menggambarkan lokasinya sebagai "daratan di tengah laut." Pura ini dibangun pada abad ke-16 oleh Dang Hyang Nirartha, seorang pendeta suci dari Majapahit yang menyebarkan ajaran Hindu di Bali.',
          'imagePath': 'destinations/image/rz8lBEboJwppwDyvQ3mEsopp6WEaJZGgIWXXZB0B.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/NgU9JGjROBpJ6RURuDBLfiE3wcAmYpsjj0Pio8D4.jpg',
        };
      case 'dst015': // Kampung Cina Jakarta
        return {
          'id': 'dst015',
          'name': 'Kampung Cina Jakarta',
          'location': 'Cibubur, Jakarta Timur, DKI Jakarta',
          'openingHours': '09:00',
          'closingHours': '18:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 25000,
          'description': 'Kampung Cina Jakarta adalah salah satu kawasan wisata tematik yang menghadirkan suasana khas negeri Tiongkok di tengah hiruk-pikuk ibu kota Indonesia. Terletak di perumahan Kota Wisata, Cibubur, Jakarta Timur, kawasan ini dikenal sebagai destinasi wisata budaya dan kuliner yang menampilkan arsitektur oriental yang memukau serta suasana yang kental dengan nuansa tradisional Tionghoa.\n\nDidirikan pada awal tahun 2000-an, Kampung Cina dibangun dengan konsep miniatur kota bergaya oriental yang memadukan keindahan arsitektur klasik Tiongkok, ornamen merah keemasan, lampion gantung, hingga jembatan melengkung di atas danau buatan yang indah. Saat memasuki area ini, pengunjung seolah dibawa ke suasana kota-kota tua di China seperti Beijing atau Shanghai versi klasik.',
          'imagePath': 'destinations/image/XsvCTjWGMvS5CPrT6QMOZBmKZMIOgkO1KpV8Ga7C.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/J5kk3yPWr4THwVkGWftebT7nMKgbSRbwVDEzDPD8.jpg',
        };
      case 'dst016': // Taman Ismail Marzuki
        return {
          'id': 'dst016',
          'name': 'Taman Ismail Marzuki',
          'location': 'Cikini, Jakarta Pusat, DKI Jakarta',
          'openingHours': '09:00',
          'closingHours': '21:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 0,
          'description': 'Taman Ismail Marzuki (TIM) adalah pusat seni dan kebudayaan ternama yang terletak di Jalan Cikini Raya No. 73, Jakarta Pusat, dan menjadi salah satu ikon penting dalam perkembangan dunia seni Indonesia. Diresmikan pada 10 November 1968, taman budaya ini dinamai untuk mengenang Ismail Marzuki, komponis besar Indonesia yang telah menciptakan ratusan lagu perjuangan dan nasional yang melegenda.\n\nSejak berdirinya, TIM telah menjadi wadah ekspresi dan kreativitas seniman dari berbagai bidang — mulai dari seni pertunjukan, musik, tari, teater, film, hingga seni rupa. Kini, setelah proses revitalisasi besar-besaran yang rampung pada tahun 2022, Taman Ismail Marzuki tampil dengan wajah baru yang lebih modern namun tetap mempertahankan ruh kebudayaan yang kuat.',
          'imagePath': 'destinations/image/n9e7PuYSxMelsAEIKTAZtnbY6lBZhk79EIAhYaUh.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/WBYNzgEkEzKPGnowwduq3rU8AoCccA3RENUAzY7t.jpg',
        };
      case 'dst017': // Taman Mini Indonesia Indah
        return {
          'id': 'dst017',
          'name': 'Taman Mini Indonesia Indah',
          'location': 'Jakarta Timur, DKI Jakarta',
          'openingHours': '07:00',
          'closingHours': '17:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 25000,
          'description': 'Taman Mini Indonesia Indah (TMII) adalah salah satu destinasi wisata budaya dan edukasi paling ikonik di Indonesia, terletak di Jakarta Timur, di atas lahan seluas sekitar 150 hektare. Diresmikan pada tahun 1975 oleh Ibu Tien Soeharto, TMII dibangun dengan tujuan memperkenalkan dan melestarikan keberagaman budaya, adat, serta kekayaan alam Indonesia dalam satu kawasan miniatur yang indah.\n\nKonsep utama Taman Mini Indonesia Indah adalah menghadirkan gambaran lengkap tentang Indonesia dari Sabang hingga Merauke, melalui replika rumah adat, pakaian tradisional, seni pertunjukan, hingga keragaman bahasa dan tradisi dari 38 provinsi di Tanah Air. Di kawasan ini terdapat Anjungan Daerah yang menampilkan arsitektur khas masing-masing provinsi lengkap dengan artefak, kerajinan tangan, dan pertunjukan seni tradisionalnya.',
          'imagePath': 'destinations/image/3QYI1OL5f7PODfNGs0RPxjVMjr6oPydlI1XA9Tua.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/CBRkIdizkkgWiw8aU0o9hU8onrHjiLRM7jI8IYa3.jpg',
        };
      case 'dst018': // Museum Pengkhianatan PKI
        return {
          'id': 'dst018',
          'name': 'Museum Pengkhianatan PKI',
          'location': 'Lubang Buaya, Jakarta Timur, DKI Jakarta',
          'openingHours': '08:00',
          'closingHours': '16:00',
          'timezone': 'WIB',
          'openingDay': 'Senin',
          'closingDay': 'Minggu',
          'entranceFee': 10000,
          'description': 'Museum Pengkhianatan PKI atau dikenal juga sebagai Museum Pengkhianatan Partai Komunis Indonesia (PKI) adalah salah satu museum bersejarah yang terletak di Kompleks Monumen Pancasila Sakti, Lubang Buaya, Jakarta Timur. Museum ini dibangun untuk mengenang peristiwa kelam Gerakan 30 September 1965 (G30S/PKI), yaitu usaha kudeta yang dilakukan oleh Partai Komunis Indonesia terhadap pemerintahan Republik Indonesia.\n\nDiresmikan pada tahun 1992, museum ini menjadi saksi sejarah sekaligus sarana edukasi bagi masyarakat tentang pentingnya menjaga keutuhan bangsa dan ideologi Pancasila. Di dalamnya terdapat ruang diorama, galeri foto, artefak, dan dokumentasi sejarah yang menggambarkan secara kronologis perkembangan ideologi komunisme di Indonesia, aksi-aksi pemberontakan PKI sejak 1948 di Madiun hingga peristiwa G30S 1965.',
          'imagePath': 'destinations/image/fJn0FmdfucsZlZtjg17yJQZ3Ija2INERmSeohNDB.jpg',
          'thumbnailImagePath': 'destinations/thumbnailImage/LBGwYG2UoN27KMCTkwuXR0F6k7ER0Z2cfnCgS7Zg.jpg',
        };
      default:
        return {};
    }
  }

  // Data dummy event terkait (sesuai database)
  Map<String, dynamic>? _getRelatedEvent() {
    switch (destinationId) {
      case 'dst004': // Event untuk Candi Borobudur
        return {
          'id': 'evt001',
          'name': 'SAMBUT ENERGI POSITIF DI TENGAH KEAGUNGAN CANDI BOROBUDUR',
          'startDate': '2025-08-22',
          'endDate': '2025-12-28',
          'location': 'Borobudur Cultural Center, Candi Borobudur',
          'description': 'Ruang penyembuhan dan ketenangan yang memanfaatkan suasana spiritual Candi Borobudur yang sakral.',
          'entranceFee': 100,
          'startTime': '09:00',
          'endTime': '15:00',
          'socialMedia': 'borobudurculturalcenter',
          'imagePath': 'events/z2rXQT6K6lTGH70YUI6zwKNnFzR6WWao1LRgv1fU.jpg',
        };
      case 'dst005': // Event untuk Candi Prambanan
        return {
          'id': 'evt002',
          'name': 'SENDRATARI RAMAYANA PRAMBANAN',
          'startDate': '2025-11-01',
          'endDate': '2025-12-31',
          'location': 'Gedung Trimurti, Candi Prambanan',
          'description': 'Persembahan budaya yang megah, Sendratari Ramayana Prambanan adalah sebuah mahakarya yang menawan. Di tengah keagungan Candi Prambanan yang spiritual, epos kuno Ramayana dihidupkan kembali melalui tarian gemulai, drama yang kuat, dan iringan gamelan yang syahdu.',
          'entranceFee': 150000,
          'startTime': '19:30',
          'endTime': '21:00',
          'socialMedia': 'prambananpark',
          'imagePath': 'events/NemigAYqbj0Ie9Sk2ygu8sw6gONsz8ruWLyGodJW.jpg',
        };
      case 'dst017': // Event untuk TMII
        return {
          'id': 'evt003',
          'name': 'SORAK SORAI FEST 2026',
          'startDate': '2025-12-30',
          'endDate': '2026-01-01',
          'location': 'Taman Mini Indonesia Indah',
          'description': 'Sorak Sorai Fest adalah sebuah festival akhir tahun yang menggabungkan konser musik, festival kuliner, dan berbagai kegiatan menarik lainnya. Festival ini biasanya berlangsung di Taman Mini Indonesia Indah (TMII) saat pergantian tahun.',
          'entranceFee': 100000,
          'startTime': '17:00',
          'endTime': '23:00',
          'socialMedia': 'soraksoraifest',
          'imagePath': 'events/PMwiAL85B8JFoBeZmh8FwuriBxkX8JCA5kPLymnR.jpg',
        };
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final destination = _getDestinationData();
    final event = _getRelatedEvent();

    // Jika data tidak ditemukan
    if (destination.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Destinasi Tidak Ditemukan')),
        body: const Center(child: Text('Data destinasi tidak ditemukan')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header dengan Background Gambar Destinasi
          Stack(
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/${destination['imagePath']}'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo & Nama App
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      const SizedBox(height: 30),
                      // Judul Destinasi
                      Text(
                        destination['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari destinasi yang ingin dituju...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Konten Detail
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  _buildInfoCard(destination, event),
                  const SizedBox(height: 20),
                  // Deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    destination['description']!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1, // Explore aktif
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ExplorePage()),
              (route) => false,
            );
          } else if (index == 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Halaman Ticket segera hadir!')),
            );
          } else if (index == 3) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  // Info Card dengan gambar, lokasi, jam, harga, dan event
  Widget _buildInfoCard(Map<String, dynamic> destination, Map<String, dynamic>? event) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Gambar Thumbnail
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/${destination['thumbnailImagePath']}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey.shade400, Colors.grey.shade300],
                    ),
                  ),
                  child: const Icon(Icons.image, size: 60, color: Colors.grey),
                );
              },
            ),
          ),
          // Info Detail
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lokasi
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.black87, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        destination['location']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Jam Operasional
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.black87, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      '${destination['openingDay']} - ${destination['closingDay']}\n(${destination['openingHours']} - ${destination['closingHours']} ${destination['timezone']})',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Harga Tiket
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.black87, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      destination['entranceFee'] == 0
                          ? 'Gratis'
                          : 'Rp ${_formatRupiah(destination['entranceFee'])}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                if (event != null) ...[
                  const SizedBox(height: 16),
                  // Event Terkait
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B5E5E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Event Terkait',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          event['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_formatDate(event['startDate'])} - ${_formatDate(event['endDate'])}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Format Rupiah
  String _formatRupiah(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  // Format Date (YYYY-MM-DD to DD MMM YYYY)
  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}