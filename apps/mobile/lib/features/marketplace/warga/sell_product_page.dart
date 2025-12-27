import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;

class SellProductPage extends StatefulWidget {
  const SellProductPage({super.key});

  @override
  State<SellProductPage> createState() => _SellProductPageState();
}

class _SellProductPageState extends State<SellProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? detectedMotif;
  String? detectedRegion;
  File? _productImage;
  bool _isSubmitting = false;
  bool _isDetecting = false;
  double _detectionProgress = 0.0;
  bool _isGeneratingAI = false;
  double _aiProgress = 0.0;
  final ImagePicker _picker = ImagePicker();

  static const String _openRouterApiKey =
      'API_KEY_YANG_HARUS_DIGANTI_DENGAN_MILIK_ANDA';
  static const String _openRouterModel =
      'meta-llama/llama-3.2-3b-instruct:free';

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 95,
      );

      if (pickedFile != null && mounted) {
        setState(() {
          _productImage = File(pickedFile.path);
          detectedMotif = null;
          _nameController.clear();
          _descriptionController.clear();
        });

        // Auto-detect setelah upload
        await _detectMotifInline();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal memilih gambar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00AFC1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.camera_alt, color: Color(0xFF00AFC1)),
              ),
              title: const Text('Kamera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00AFC1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.photo_library,
                  color: Color(0xFF00AFC1),
                ),
              ),
              title: const Text('Galeri'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _generateDescriptionWithAI() async {
    if (detectedRegion == null || detectedMotif == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Deteksi motif batik terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isGeneratingAI = true;
      _aiProgress = 0.0;
    });

    try {
      final prompt =
          '''Buatkan deskripsi produk batik untuk marketplace dalam bahasa Indonesia:

Daerah: $detectedRegion
Motif: $detectedMotif

Format (tanpa nomor):
- Penjelasan singkat motif (2-3 kalimat)
- Filosofi atau makna (1-2 kalimat)
- Keunikan dari daerah $detectedRegion (1 kalimat)
- Cocok untuk acara apa (1 kalimat)

Langsung berikan deskripsinya saja, maksimal 150 kata, persuasif untuk pembeli.''';

      setState(() => _aiProgress = 0.3);

      final response = await http.post(
        Uri.parse('https://openrouter.ai/api/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_openRouterApiKey',
          'HTTP-Referer': 'https://batik-marketplace.app',
          'X-Title': 'Batik Marketplace',
        },
        body: json.encode({
          'model': _openRouterModel,
          'messages': [
            {
              'role': 'system',
              'content':
                  'Kamu adalah asisten yang membuat deskripsi produk batik. Langsung berikan deskripsi tanpa penjelasan atau pemikiran tambahan.',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
          'max_tokens': 300,
          'stop': ['Hmm,', 'Aku ', 'User meminta'],
        }),
      );

      setState(() => _aiProgress = 0.7);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('🔍 DEBUG - OpenRouter Full Response: $data');

        // Extract description dengan error handling
        String description = '';
        try {
          if (data['choices'] != null && data['choices'].isNotEmpty) {
            final choice = data['choices'][0];
            print('🔍 DEBUG - Choice data: $choice');
            print('🔍 DEBUG - Finish reason: ${choice['finish_reason']}');

            final content = choice['message']?['content'];
            if (content != null) {
              description = content.toString().trim();
              print('✅ DEBUG - Raw content length: ${description.length}');
              print('✅ DEBUG - Content: "$description"');
            } else {
              print(
                '⚠️ DEBUG - Content is null, checking message: ${choice['message']}',
              );
            }
          } else if (data['error'] != null) {
            throw Exception('API Error: ${data['error']}');
          } else {
            throw Exception('Unexpected response format');
          }
        } catch (e) {
          print('❌ DEBUG - Parse Error: $e');
          print('❌ DEBUG - Data keys: ${data.keys}');
          if (data['choices'] != null && data['choices'].isNotEmpty) {
            print('❌ DEBUG - First choice: ${data['choices'][0]}');
          }
          throw Exception('Failed to parse AI response: $e');
        }

        // Jangan reject kalau text pendek - bisa jadi valid response
        if (description.isEmpty) {
          print('⚠️ DEBUG - Empty description, using fallback');
          throw Exception('Empty description received from API');
        }

        print(
          '✅ DEBUG - Setting description to field (${description.length} chars)',
        );

        // Set text dengan force update
        _descriptionController.text = description;
        _descriptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _descriptionController.text.length),
        );

        print(
          '✅ DEBUG - Controller text now: "${_descriptionController.text}"',
        );

        setState(() {
          _aiProgress = 1.0;
        });

        await Future.delayed(const Duration(milliseconds: 300));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '✅ Deskripsi berhasil dibuat (${description.length} karakter)',
              ),
              backgroundColor: const Color(0xFF00AFC1),
            ),
          );
        }
      } else {
        final errorBody = response.body;
        print('❌ DEBUG - API Error ${response.statusCode}: $errorBody');
        throw Exception('API Error: ${response.statusCode} - $errorBody');
      }
    } catch (e) {
      // Fallback jika API gagal
      print('⚠️ DEBUG - Error caught: $e');

      final fallbackDescription =
          'Batik $detectedMotif dari $detectedRegion merupakan karya seni tradisional Indonesia yang kaya akan makna. Motif ini menggambarkan keindahan budaya dan filosofi yang mendalam. Cocok untuk berbagai acara formal maupun kasual, batik ini akan membuat penampilan Anda lebih elegan dan berkesan.';

      // Set text dengan force update
      _descriptionController.text = fallbackDescription;
      _descriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: _descriptionController.text.length),
      );

      setState(() {
        _aiProgress = 1.0;
      });

      print(
        '📝 DEBUG - Fallback description set: ${_descriptionController.text}',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '⚠️ Menggunakan deskripsi default\n${e.toString().substring(0, e.toString().length > 50 ? 50 : e.toString().length)}...',
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      print(
        '🏁 DEBUG - AI Generation finished. isGenerating: $_isGeneratingAI',
      );
      setState(() => _isGeneratingAI = false);
    }
  }

  Future<void> _detectMotifInline() async {
    if (_productImage == null) return;

    setState(() {
      _isDetecting = true;
      _detectionProgress = 0.0;
    });

    try {
      // Step 1: Resize image (20%)
      setState(() => _detectionProgress = 0.2);
      final bytes = await _productImage!.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) throw Exception('Failed to decode image');

      final resized = img.copyResize(
        image,
        width: 800,
        height: 800,
        interpolation: img.Interpolation.cubic,
      );
      final jpegBytes = img.encodeJpg(resized, quality: 95);

      // Step 2: Upload file (40%)
      setState(() => _detectionProgress = 0.4);
      final uploadUrl = 'https://rimsj-batik-classifier.hf.space/upload';
      var uploadRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      uploadRequest.files.add(
        http.MultipartFile.fromBytes(
          'files',
          jpegBytes,
          filename: 'batik.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final uploadResponse = await uploadRequest.send();
      final uploadBody = await uploadResponse.stream.bytesToString();
      final uploadData = json.decode(uploadBody) as List;
      final filePath = uploadData[0] as String;

      // Step 3: Join queue (60%)
      setState(() => _detectionProgress = 0.6);
      final queueUrl = 'https://rimsj-batik-classifier.hf.space/queue/join';
      final sessionHash = DateTime.now().millisecondsSinceEpoch.toString();

      final queueResponse = await http.post(
        Uri.parse(queueUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'data': [
            {'path': filePath},
          ],
          'event_data': null,
          'fn_index': 0,
          'trigger_id': 6,
          'session_hash': sessionHash,
        }),
      );

      final queueData = json.decode(queueResponse.body);
      final eventId = queueData['event_id'];

      // Step 4: Poll for result (80%)
      setState(() => _detectionProgress = 0.8);
      final resultUrl =
          'https://rimsj-batik-classifier.hf.space/queue/data?session_hash=$sessionHash';
      final resultResponse = await http.get(Uri.parse(resultUrl));

      final lines = resultResponse.body.split('\n');
      for (var line in lines) {
        if (line.startsWith('data: ') && line.contains('process_completed')) {
          final jsonStr = line.substring(6);
          final resultData = json.decode(jsonStr);

          if (resultData['event_id'] == eventId) {
            final output = resultData['output']['data'][0];
            final label = output['label'] as String;

            // Parse region dan motif
            final parts = label.split('_');
            final region = parts[0]; // Contoh: "Yogyakarta"
            final motif = parts.sublist(1).join(' '); // Contoh: "Parang Barong"

            // Step 5: Auto-fill form (100%)
            setState(() {
              _detectionProgress = 1.0;
              detectedMotif = motif;
              detectedRegion = region;
              _nameController.text = 'Kain Batik $motif';
              _isDetecting = false;
            });

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ Motif terdeteksi: $motif dari $region'),
                  backgroundColor: const Color(0xFF00AFC1),
                ),
              );
            }
            return;
          }
        }
      }

      throw Exception('Detection failed');
    } catch (e) {
      setState(() {
        _isDetecting = false;
        _detectionProgress = 0.0;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mendeteksi motif: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_productImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih gambar produk terlebih dahulu'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (detectedMotif == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan deteksi motif batik terlebih dahulu'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00AFC1)),
                ),
                SizedBox(height: 16),
                Text('Menyimpan produk...'),
              ],
            ),
          ),
        ),
      ),
    );

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context); // Close loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Produk berhasil ditambahkan!'),
          backgroundColor: Color(0xFF00AFC1),
        ),
      );

      // Return to marketplace
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Jual Produk Batik',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Upload Section
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Foto Produk',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: _productImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _productImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap untuk upload foto',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  // Progress bar saat deteksi
                  if (_isDetecting) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00AFC1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xFF00AFC1),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Mendeteksi motif batik...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                              Text(
                                '${(_detectionProgress * 100).toInt()}%',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF00AFC1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: _detectionProgress,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF00AFC1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Detected Motif Badge
                  if (detectedMotif != null && !_isDetecting) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00AFC1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF00AFC1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF00AFC1),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Motif Terdeteksi:',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  detectedMotif!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00AFC1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Product Form
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detail Produk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Product Name
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Produk',
                        hintText: 'Misal: Kain Batik Megamendung',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF00AFC1),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama produk harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Price
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Harga (Rp)',
                        hintText: 'Misal: 150000',
                        prefixText: 'Rp ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF00AFC1),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga harus diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Harga harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Stock
                    TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Stok',
                        hintText: 'Jumlah stok tersedia',
                        suffixText: 'pcs',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Color(0xFF00AFC1),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stok harus diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Stok harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description with AI Button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Deskripsi',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: _isGeneratingAI
                                  ? null
                                  : _generateDescriptionWithAI,
                              icon: _isGeneratingAI
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFF00AFC1),
                                            ),
                                      ),
                                    )
                                  : const Icon(Icons.auto_awesome, size: 18),
                              label: Text(
                                _isGeneratingAI
                                    ? 'Generating...'
                                    : 'Generate AI',
                                style: const TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF00AFC1),
                                side: const BorderSide(
                                  color: Color(0xFF00AFC1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_isGeneratingAI) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00AFC1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                LinearProgressIndicator(
                                  value: _aiProgress,
                                  backgroundColor: Colors.grey[300],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color(0xFF00AFC1),
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${(_aiProgress * 100).toInt()}% - Membuat deskripsi dengan AI...',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        TextFormField(
                          key: ValueKey(_descriptionController.text),
                          controller: _descriptionController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                                'Jelaskan detail produk atau klik "Generate AI"',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFF00AFC1),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Deskripsi harus diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80), // Space for fixed button
          ],
        ),
      ),

      // Submit Button (Fixed at bottom)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _isSubmitting ? null : _submitProduct,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00AFC1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBackgroundColor: Colors.grey,
            ),
            child: const Text(
              'Tambahkan Produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
