import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class BatikDetectionPage extends StatefulWidget {
  final bool autoDetect;
  final File? imageFile;

  const BatikDetectionPage({
    super.key,
    this.autoDetect = false,
    this.imageFile,
  });

  @override
  State<BatikDetectionPage> createState() => _BatikDetectionPageState();
}

class _BatikDetectionPageState extends State<BatikDetectionPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isProcessing = false;
  Map<String, dynamic>? _detectionResult;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.autoDetect && widget.imageFile != null) {
      _image = widget.imageFile;
      Future.delayed(Duration.zero, () => _processImage());
    }
  }

  // Info motif batik untuk ditampilkan setelah deteksi
  final Map<String, Map<String, String>> batikInfo = {
    'Parang': {
      'origin': 'Yogyakarta & Solo',
      'meaning': 'Simbol kekuatan, keteguhan, dan keberanian',
      'characteristics': 'Motif miring dengan pola parang berjajar diagonal',
    },
    'Kawung': {
      'origin': 'Solo & Yogyakarta',
      'meaning': 'Simbol kesempurnaan, kesucian, dan kebijaksanaan',
      'characteristics':
          'Pola bulat oval yang tersusun simetris seperti buah kawung',
    },
    'Mega Mendung': {
      'origin': 'Cirebon, Jawa Barat',
      'meaning': 'Simbol kesabaran, ketenangan, dan pembawa hujan',
      'characteristics': 'Motif awan dengan gradasi warna biru yang khas',
    },
    'Truntum': {
      'origin': 'Solo, Jawa Tengah',
      'meaning': 'Simbol cinta yang tumbuh kembali dan kesetiaan',
      'characteristics': 'Motif bunga kecil yang rapat menyebar',
    },
    'Sido Mukti': {
      'origin': 'Yogyakarta & Solo',
      'meaning': 'Simbol kemakmuran dan kebahagiaan hidup',
      'characteristics': 'Motif simetris dengan pola sayap dan bunga',
    },
    'Sekar Jagad': {
      'origin': 'Yogyakarta',
      'meaning': 'Simbol keindahan dan keberagaman dunia',
      'characteristics': 'Gabungan berbagai motif batik dalam satu kain',
    },
    'Ceplok': {
      'origin': 'Jawa Tengah',
      'meaning': 'Simbol keseimbangan dan harmoni',
      'characteristics':
          'Motif geometris berbentuk lingkaran atau kotak berulang',
    },
    'Tambal': {
      'origin': 'Yogyakarta',
      'meaning': 'Simbol penyembuhan dan harapan',
      'characteristics': 'Gabungan potongan-potongan berbagai motif batik',
    },
  };

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 95,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _detectionResult = null;
          _errorMessage = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengambil gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _processImage() async {
    if (_image == null) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
      _detectionResult = null;
    });

    try {
      print('Starting image processing...');

      final sessionHash = DateTime.now().millisecondsSinceEpoch.toString();

      // Step 1: Upload file ke Gradio
      final uploadUrl = 'https://rimsj-batik-classifier.hf.space/upload';
      print('Step 1: Uploading file to: $uploadUrl');

      var uploadRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      uploadRequest.files.add(
        await http.MultipartFile.fromPath(
          'files',
          _image!.path,
          filename: 'batik.jpg',
        ),
      );

      final uploadResponse = await uploadRequest.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Upload timeout');
        },
      );

      final uploadResult = await http.Response.fromStream(uploadResponse);
      print('Upload status: ${uploadResult.statusCode}');
      print('Upload response: ${uploadResult.body}');

      if (uploadResult.statusCode != 200) {
        throw Exception('Upload failed: ${uploadResult.statusCode}');
      }

      // Parse upload response untuk dapat file path
      final uploadData = jsonDecode(uploadResult.body);
      print('Upload data: $uploadData');

      // Gradio upload response format: [{"path": "...", "size": ..., "orig_name": "..."}]
      Map<String, dynamic>? fileData;

      if (uploadData is List && uploadData.isNotEmpty) {
        if (uploadData[0] is Map) {
          fileData = uploadData[0] as Map<String, dynamic>;
        } else if (uploadData[0] is String) {
          // Jika cuma string path, buat FileData object
          fileData = {'path': uploadData[0]};
        }
      }

      if (fileData == null || !fileData.containsKey('path')) {
        throw Exception('Failed to get uploaded file data');
      }

      print('Uploaded file data: $fileData');

      // Step 2: Join queue dengan FileData object
      final queueUrl = 'https://rimsj-batik-classifier.hf.space/queue/join';
      print('Step 2: Joining queue at: $queueUrl');

      final callResponse = await http
          .post(
            Uri.parse(queueUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'data': [fileData], // Kirim sebagai FileData object, bukan string
              'fn_index': 0,
              'session_hash': sessionHash,
            }),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception('Call timeout');
            },
          );

      print('Call response status: ${callResponse.statusCode}');
      print('Call response body: ${callResponse.body}');

      if (callResponse.statusCode != 200) {
        throw Exception('Call failed: ${callResponse.statusCode}');
      }

      final callResult = jsonDecode(callResponse.body);
      final eventId = callResult['event_id'];

      if (eventId == null) {
        throw Exception('No event_id in response');
      }

      print('Got event_id: $eventId');

      // Step 2: Poll result dari /queue/data dengan SSE
      final resultUrl =
          'https://rimsj-batik-classifier.hf.space/queue/data?session_hash=$sessionHash';
      print('Step 2: Fetching result from: $resultUrl');

      final resultResponse = await http
          .get(Uri.parse(resultUrl))
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw Exception('Result timeout');
            },
          );

      print('Result response status: ${resultResponse.statusCode}');
      print('Result response body: ${resultResponse.body}');

      if (resultResponse.statusCode == 200) {
        // Parse SSE response - cari event process_completed yang success
        final lines = resultResponse.body.split('\n');
        Map<String, dynamic>? successResult;

        for (var line in lines) {
          if (line.startsWith('data: ')) {
            final dataLine = line.substring(6); // Remove 'data: ' prefix
            if (dataLine.trim().isEmpty) continue;

            try {
              final event = jsonDecode(dataLine);
              print('Event: ${event['msg']}');

              // Cari event process_completed yang success
              if (event['msg'] == 'process_completed' &&
                  event['success'] == true) {
                successResult = event;
                print('Found success event: $successResult');
                break;
              }
            } catch (e) {
              continue;
            }
          }
        }

        if (successResult == null) {
          // Coba print semua events untuk debugging
          print('All SSE lines:');
          for (var line in lines) {
            if (line.startsWith('data: ')) {
              print(line);
            }
          }
          throw Exception(
            'Model gagal memproses gambar. Coba gambar yang lebih kecil.',
          );
        }

        // Extract data dari output
        final output = successResult['output'];
        if (output == null || output['data'] == null) {
          throw Exception('No data in output');
        }

        final data = output['data'];
        print('Output data: $data');

        // Gradio response format: data: [results_dict, markdown_text]
        if (data is List && data.isNotEmpty) {
          if (data[0] is Map) {
            final result = data[0] as Map<String, dynamic>;

            print('Result map: $result');

            // Gradio Label component format: {label: "xxx", confidences: [{label: "xxx", confidence: 0.xx}, ...]}
            String? topLabel;
            double topConfidence = 0.0;
            List<Map<String, dynamic>> allConfidences = [];

            if (result.containsKey('label') &&
                result.containsKey('confidences')) {
              topLabel = result['label'] as String?;

              if (result['confidences'] is List) {
                final confidencesList = result['confidences'] as List;

                for (var item in confidencesList) {
                  if (item is Map) {
                    final label = item['label']?.toString() ?? '';
                    final conf = (item['confidence'] is num)
                        ? (item['confidence'] as num).toDouble()
                        : 0.0;

                    // Clean nama (hapus prefix wilayah)
                    String cleanLabel = label;
                    if (label.contains('_')) {
                      cleanLabel = label.split('_').last;
                    }

                    allConfidences.add({
                      'label': cleanLabel,
                      'confidence': conf,
                    });

                    // Get top confidence
                    if (label == topLabel) {
                      topConfidence = conf;
                    }
                  }
                }
              }
            }

            if (topLabel == null || topLabel.isEmpty) {
              throw Exception('Tidak ada label prediksi');
            }

            // Clean nama motif (hapus prefix wilayah)
            String detectedMotif = topLabel;
            if (topLabel.contains('_')) {
              detectedMotif = topLabel.split('_').last;
            }

            // Cari info motif
            final info = _findBatikInfo(detectedMotif);

            setState(() {
              _detectionResult = {
                'name': detectedMotif,
                'confidence': topConfidence,
                'origin': info['origin'],
                'meaning': info['meaning'],
                'characteristics': info['characteristics'],
                'allConfidences': allConfidences,
              };
              _isProcessing = false;
            });

            print(
              'Success! Detected: $detectedMotif with confidence: ${topConfidence * 100}%',
            );
          } else {
            throw Exception('Format response tidak sesuai');
          }
        } else {
          throw Exception('Response tidak mengandung data valid');
        }
      } else if (resultResponse.statusCode == 500) {
        throw Exception(
          'Server error (500) - Coba refresh halaman web Hugging Face dulu',
        );
      } else if (resultResponse.statusCode == 503) {
        throw Exception(
          'Service unavailable (503) - Server cold start, tunggu 1 menit',
        );
      } else {
        throw Exception(
          'HTTP ${resultResponse.statusCode}: ${resultResponse.body}',
        );
      }
    } catch (e) {
      print('Error details: $e');
      setState(() {
        _isProcessing = false;
        _errorMessage = 'Gagal mendeteksi: $e';
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Map<String, String> _findBatikInfo(String motifName) {
    // Cari info yang cocok dengan nama motif
    for (var key in batikInfo.keys) {
      if (motifName.toLowerCase().contains(key.toLowerCase())) {
        return batikInfo[key]!;
      }
    }
    // Default info jika tidak ditemukan
    return {
      'origin': 'Indonesia',
      'meaning': 'Motif batik tradisional Indonesia',
      'characteristics': 'Motif batik dengan keunikan tersendiri',
    };
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Sumber Gambar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildImageSourceButton(
                    icon: Icons.camera_alt,
                    label: 'Kamera',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildImageSourceButton(
                    icon: Icons.photo_library,
                    label: 'Galeri',
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF6366F1)),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Deteksi Motif Batik',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.info_outline, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Cara Menggunakan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Ambil foto atau pilih gambar batik\n'
                      '2. Klik tombol "Deteksi Motif"\n'
                      '3. Lihat hasil deteksi dan informasi motif\n'
                      '4. Cari produk dengan motif yang sama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // AI Model Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.smart_toy, color: Colors.green[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'VGG16 Model • 111 Motif Batik Indonesia',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Image Preview Area
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!, width: 2),
                ),
                child: _image == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada gambar',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap tombol di bawah untuk mengambil foto',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.file(_image!, fit: BoxFit.cover),
                            ),
                          ),
                          if (_isProcessing)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Menganalisis motif batik...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),

              // Error Message
              if (_errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_errorMessage!.contains('500') ||
                          _errorMessage!.contains('503'))
                        Padding(
                          padding: const EdgeInsets.only(top: 8, left: 28),
                          child: Text(
                            'Tips: Server Hugging Face mungkin cold start. Tunggu 1-2 menit dan coba lagi.',
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 11,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

              // Action Buttons
              if (_image == null)
                ElevatedButton.icon(
                  onPressed: _showImageSourceDialog,
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Ambil/Pilih Gambar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                )
              else
                Column(
                  children: [
                    // Detect Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isProcessing ? null : _processImage,
                        icon: _isProcessing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(
                          _isProcessing ? 'Mendeteksi...' : 'Deteksi Motif',
                          style: const TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Change Image Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isProcessing
                            ? null
                            : () {
                                setState(() {
                                  _image = null;
                                  _detectionResult = null;
                                  _errorMessage = null;
                                });
                              },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Ganti Gambar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6366F1),
                          side: const BorderSide(color: Color(0xFF6366F1)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              // Detection Result
              if (_detectionResult != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green[600],
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Hasil Deteksi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Detected Motif Name
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF6366F1).withOpacity(0.1),
                              const Color(0xFF8B5CF6).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              _detectionResult!['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6366F1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getConfidenceColor(
                                  _detectionResult!['confidence'],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Akurasi: ${(_detectionResult!['confidence'] * 100).toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildResultRow(
                        'Asal Daerah',
                        _detectionResult!['origin'],
                      ),
                      _buildResultRow('Makna', _detectionResult!['meaning']),
                      _buildResultRow(
                        'Karakteristik',
                        _detectionResult!['characteristics'],
                      ),

                      // Top Predictions (if available)
                      if (_detectionResult!['allConfidences'] != null &&
                          (_detectionResult!['allConfidences'] as List).length >
                              1) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Prediksi Lainnya:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...(_detectionResult!['allConfidences'] as List)
                            .skip(1)
                            .take(4)
                            .map(
                              (conf) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      conf['label'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      '${(conf['confidence'] * 100).toStringAsFixed(1)}%',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      ],

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context, _detectionResult!['name']);
                          },
                          icon: const Icon(Icons.shopping_bag),
                          label: const Text('Cari Produk dengan Motif Ini'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) {
      return Colors.green;
    } else if (confidence >= 0.6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
