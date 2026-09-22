import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:data/get_involved/models/picked_document.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ui/src/core/extensions/context_theme_ext.dart';
import 'package:ui/src/core/extensions/sizedbox_ext.dart';
import 'package:flutter/material.dart';

/// A single "pick this document" row used in the Get Involved forms'
/// document-upload sections.
class DocumentUploadField extends StatelessWidget {
  const DocumentUploadField({
    super.key,
    required this.label,
    required this.hint,
    required this.isRequired,
    required this.allowedExtensions,
    required this.pickedFile,
    required this.isUploading,
    required this.isUploaded,
    required this.onFilePicked,
  });

  final String label;
  final String hint;
  final bool isRequired;
  final List<String> allowedExtensions;
  final PickedDocument? pickedFile;
  final bool isUploading;
  final bool isUploaded;
  final ValueChanged<PickedDocument> onFilePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withOpacity(.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                isRequired ? 'Required' : 'Optional',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isRequired
                      ? context.colorScheme.error
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          4.sH,
          Text(
            hint,
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          10.sH,
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: isUploading ? null : () => _pickFile(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    isUploaded
                        ? Icons.check_circle
                        : BootstrapIcons.cloud_arrow_up,
                    size: 18,
                    color: isUploaded
                        ? Colors.green
                        : context.colorScheme.primary,
                  ),
                  8.sW,
                  Expanded(
                    child: Text(
                      pickedFile != null ? pickedFile!.fileName : 'Choose file',
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        color: pickedFile != null
                            ? Colors.black87
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  if (isUploading)
                    const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      withData: true,
    );
    final picked = result?.files.single;
    final bytes = picked?.bytes;
    if (picked != null && bytes != null) {
      onFilePicked(PickedDocument(fileName: picked.name, bytes: bytes));
    }
  }
}
