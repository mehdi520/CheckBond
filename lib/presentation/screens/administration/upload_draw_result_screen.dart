import 'dart:io';
import 'package:check_bond/data/models/bonds/data_model/draw_data_model.dart';
import 'package:check_bond/infra/loader/overlay_service.dart';
import 'package:check_bond/infra/utils/toast_utils.dart';
import 'package:check_bond/presentation/common_widgets/app_bars/basic_app_bar.dart';
import 'package:check_bond/presentation/common_widgets/text_ctl/body_medium_text.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';

class UploadDrawResultScreen extends ConsumerStatefulWidget {
  final DrawDataModel data;
  final OverlayService _loadingService = OverlayService();

  UploadDrawResultScreen({super.key, required this.data});

  @override
  ConsumerState<UploadDrawResultScreen> createState() => _UploadDrawResultScreenState();
}

class _UploadDrawResultScreenState extends ConsumerState<UploadDrawResultScreen> {
  File? _selectedFile;
  String? _fileName;
  int? _fileSize;
  String? _fileType;
  bool _isAnalyzing = false;

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        dialogTitle: 'Select a file',
        withData: true,
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        if (await file.exists()) {
          final size = await file.length();
          if (size > 10 * 1024 * 1024) {
            ToastUtils.showError('File size exceeds 10MB limit');
            return;
          }

          setState(() {
            _selectedFile = file;
            _fileName = result.files.single.name;
            _fileSize = size;
            _fileType = result.files.single.extension?.toUpperCase() ?? 'Unknown';
          });
        } else {
          ToastUtils.showError('Selected file does not exist');
        }
      }
    } catch (e) {
      ToastUtils.showError('Error selecting file: ${e.toString()}');
    }
  }

  Future<void> _handleAnalyze() async {
    if (_selectedFile == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    try {
      widget._loadingService.showLoadingOverlay(context);
      
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _selectedFile!.path,
          filename: _fileName,
          contentType: MediaType.parse(
            _fileName!.toLowerCase().endsWith('.csv')
                ? 'text/csv'
                : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
          ),
        ),
      });

      // TODO: Replace with your actual API call
      // final response = await ref.read(uploadProvider.notifier).analyzeFile(formData);
      
      widget._loadingService.hideLoadingOverlay();
      ToastUtils.showSuccess('File analyzed successfully');
    } catch (e) {
      widget._loadingService.hideLoadingOverlay();
      ToastUtils.showError('Failed to analyze file: ${e.toString()}');
    } finally {
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  void _resetFileSelection() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
      _fileSize = null;
      _fileType = null;
    });
  }

  Widget _buildSelectedFileDisplay() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [

          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _fileType == 'CSV' ? Icons.table_chart_outlined : Icons.description_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _fileName ?? 'Selected File',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    if (_fileSize != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${(_fileSize! / 1024).toStringAsFixed(2)} KB',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _fileType ?? 'Unknown',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isAnalyzing ? null : _handleAnalyze,
                  icon: _isAnalyzing 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.analytics),
                  label: Text(_isAnalyzing ? 'Analyzing...' : 'Analyze'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFileSelection,
                  child: const Text('Cancel'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            color: Colors.grey.withOpacity(0.5),
            strokeWidth: 2,
            dashPattern: const [8, 4],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: Colors.grey.withOpacity(0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedFile != null) ...[
                      _buildSelectedFileDisplay(),
                    ] else ...[
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Drag and drop your file here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload a CSV or Excel file. Maximum file size: 10MB',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _pickFile,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Browse Files'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: 'Upload Draw Result'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyMediumText(contentText: "Draw Id : ${ widget.data.drawId}"),
              BodyMediumText(contentText: "Bond type Id : ${ widget.data.bondTypeId}"),

              _buildUploadArea(),
            ],
          ),
        ),
      ),
    );
  }
}
