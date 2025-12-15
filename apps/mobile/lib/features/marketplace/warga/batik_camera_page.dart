import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class BatikCameraPage extends StatefulWidget {
  const BatikCameraPage({super.key});

  @override
  State<BatikCameraPage> createState() => _BatikCameraPageState();
}

class _BatikCameraPageState extends State<BatikCameraPage> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isDetecting = false;
  Timer? _autoDetectTimer;

  // Detection state
  String? _detectedMotif;
  double? _confidence;
  bool _isAutoMode = false;
  DateTime? _lastDetectionTime;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        throw Exception('No cameras available');
      }

      _cameraController = CameraController(
        _cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(FlashMode.off);

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal membuka kamera: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleAutoMode() {
    setState(() {
      _isAutoMode = !_isAutoMode;
    });

    if (_isAutoMode) {
      // Start auto detection every 3 seconds
      _autoDetectTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (!_isDetecting) {
          _captureAndDetect();
        }
      });
    } else {
      // Stop auto detection
      _autoDetectTimer?.cancel();
      _autoDetectTimer = null;
    }
  }

  Future<void> _captureAndDetect() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (_isDetecting) return;

    setState(() {
      _isDetecting = true;
    });

    try {
      // Capture image
      final XFile image = await _cameraController!.takePicture();

      // Resize for better quality (800x800 instead of 200x200)
      final File processedImage = await _resizeImage(File(image.path));

      // Process and detect
      await _detectBatik(processedImage);

      setState(() {
        _lastDetectionTime = DateTime.now();
      });
    } catch (e) {
      print('Error capturing/detecting: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDetecting = false;
        });
      }
    }
  }

  Future<void> _detectBatik(File imageFile) async {
    try {
      final sessionHash = DateTime.now().millisecondsSinceEpoch.toString();

      // Step 1: Upload file
      final uploadUrl = 'https://rimsj-batik-classifier.hf.space/upload';
      var uploadRequest = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      uploadRequest.files.add(
        await http.MultipartFile.fromPath('files', imageFile.path),
      );

      final uploadResponse = await uploadRequest.send().timeout(
        const Duration(seconds: 10),
      );
      final uploadResult = await http.Response.fromStream(uploadResponse);

      if (uploadResult.statusCode != 200) {
        throw Exception('Upload failed');
      }

      final uploadData = jsonDecode(uploadResult.body);
      Map<String, dynamic>? fileData;

      if (uploadData is List && uploadData.isNotEmpty) {
        if (uploadData[0] is Map) {
          fileData = uploadData[0] as Map<String, dynamic>;
        } else if (uploadData[0] is String) {
          fileData = {'path': uploadData[0]};
        }
      }

      if (fileData == null) throw Exception('Upload failed');

      // Step 2: Join queue
      final queueUrl = 'https://rimsj-batik-classifier.hf.space/queue/join';
      final callResponse = await http
          .post(
            Uri.parse(queueUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'data': [fileData],
              'fn_index': 0,
              'session_hash': sessionHash,
            }),
          )
          .timeout(const Duration(seconds: 5));

      final callResult = jsonDecode(callResponse.body);
      final eventId = callResult['event_id'];

      // Step 3: Get result
      final resultUrl =
          'https://rimsj-batik-classifier.hf.space/queue/data?session_hash=$sessionHash';
      final resultResponse = await http
          .get(Uri.parse(resultUrl))
          .timeout(const Duration(seconds: 30));

      if (resultResponse.statusCode == 200) {
        final lines = resultResponse.body.split('\n');
        Map<String, dynamic>? successResult;

        for (var line in lines) {
          if (line.startsWith('data: ')) {
            final dataLine = line.substring(6);
            if (dataLine.trim().isEmpty) continue;

            try {
              final event = jsonDecode(dataLine);
              if (event['msg'] == 'process_completed' &&
                  event['success'] == true) {
                successResult = event;
                break;
              }
            } catch (e) {
              continue;
            }
          }
        }

        if (successResult != null) {
          final output = successResult['output'];
          if (output != null && output['data'] != null) {
            final data = output['data'];
            if (data is List && data.isNotEmpty && data[0] is Map) {
              final result = data[0] as Map<String, dynamic>;

              if (result.containsKey('label')) {
                String topLabel = result['label'] as String;
                double topConfidence = 0.0;

                if (result['confidences'] is List) {
                  final confidencesList = result['confidences'] as List;
                  for (var item in confidencesList) {
                    if (item is Map &&
                        item['label'] == topLabel &&
                        item['confidence'] is num) {
                      topConfidence = (item['confidence'] as num).toDouble();
                      break;
                    }
                  }
                }

                // Clean nama motif
                String cleanMotif = topLabel;
                if (topLabel.contains('_')) {
                  cleanMotif = topLabel.split('_').last;
                }

                setState(() {
                  _detectedMotif = cleanMotif;
                  _confidence = topConfidence;
                });

                return;
              }
            }
          }
        }
      }

      throw Exception('Detection failed');
    } catch (e) {
      print('Detection error: $e');
      rethrow;
    }
  }

  Future<File> _resizeImage(File imageFile) async {
    try {
      // Read image
      final bytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);

      if (image == null) return imageFile;

      // Resize to 800x800 maintaining aspect ratio with high quality
      img.Image resized = img.copyResize(
        image,
        width: 800,
        height: 800,
        interpolation: img.Interpolation.cubic,
      );

      // Encode with high quality (95%)
      final resizedBytes = img.encodeJpg(resized, quality: 95);

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(
        tempDir.path,
        'batik_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      final tempFile = File(tempPath);
      await tempFile.writeAsBytes(resizedBytes);

      return tempFile;
    } catch (e) {
      print('Resize error: $e');
      return imageFile; // Return original if resize fails
    }
  }

  @override
  void dispose() {
    _autoDetectTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          if (_isInitialized && _cameraController != null)
            Positioned.fill(child: CameraPreview(_cameraController!))
          else
            const Center(child: CircularProgressIndicator(color: Colors.white)),

          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Deteksi Batik',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
          ),

          // Detection Result Overlay (Top Center)
          if (_detectedMotif != null)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF6366F1), width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _detectedMotif!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Confidence: ${(_confidence! * 100).toStringAsFixed(1)}%',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 14,
                          ),
                        ),
                        if (_lastDetectionTime != null)
                          Text(
                            '${DateTime.now().difference(_lastDetectionTime!).inSeconds}s ago',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 20,
                top: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Auto Mode Toggle
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: _isAutoMode
                          ? const Color(0xFF6366F1).withOpacity(0.3)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isAutoMode
                            ? const Color(0xFF6366F1)
                            : Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isAutoMode ? Icons.auto_mode : Icons.touch_app,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _isAutoMode
                              ? 'Mode Auto (Setiap 3 detik)'
                              : 'Mode Manual',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Capture/Detect Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Toggle Auto Mode
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _toggleAutoMode,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _isAutoMode
                                    ? const Color(0xFF6366F1)
                                    : Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                _isAutoMode ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isAutoMode ? 'Stop' : 'Auto',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Manual Capture
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _isDetecting ? null : _captureAndDetect,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: _isDetecting
                                    ? Colors.grey
                                    : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF6366F1),
                                  width: 4,
                                ),
                              ),
                              child: _isDetecting
                                  ? const Padding(
                                      padding: EdgeInsets.all(20),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFF6366F1),
                                            ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.camera,
                                      color: Color(0xFF6366F1),
                                      size: 40,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Deteksi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // View Result Detail
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _detectedMotif != null
                                ? () {
                                    Navigator.pop(context, _detectedMotif);
                                  }
                                : null,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _detectedMotif != null
                                    ? Colors.green
                                    : Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Selesai',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Processing Indicator
          if (_isDetecting && !_isAutoMode)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Mendeteksi motif batik...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
