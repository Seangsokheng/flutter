import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:week3/sport-event/pages/home_page.dart';
import 'dart:io';
import '../models/event.dart';
import '../models/sport_category.dart';

class EventForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Mode mode;
  final Event? initialItem;
  final Function(Event) saveEvent;
  final DateTime selectDate;
  final File? image;
  final Uint8List? imageBytes;
  final Function(DateTime) onDateChange;
  final Function(File?, Uint8List?) onImagePicked;
  final VoidCallback onRemoveImage;

  const EventForm({
    super.key,
    required this.formKey,
    required this.mode,
    this.initialItem,
    required this.saveEvent,
    required this.selectDate,
    this.image,
    this.imageBytes,
    required this.onDateChange,
    required this.onImagePicked,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final timeController = TextEditingController();
    final locationController = TextEditingController();
    SportsCategory selectedCategory = SportsCategory.frisbee;

    if (mode == Mode.edit && initialItem != null) {
      nameController.text = initialItem!.name;
      descriptionController.text = initialItem!.description;
      timeController.text = initialItem!.time;
      locationController.text = initialItem!.location;
      selectedCategory = initialItem!.category;
    }

    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          onImagePicked(null, bytes);
        } else {
          onImagePicked(File(pickedFile.path), null);
        }
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Event Name
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Event Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            validator: (value) => value!.isEmpty ? 'Event name is required' : null,
          ),
          const SizedBox(height: 12),

          // Description
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            maxLines: 3,
            validator: (value) => value!.isEmpty ? 'Description is required' : null,
          ),
          const SizedBox(height: 12),

          // Date Picker
          Row(
            children: [
              Expanded(
                child: Text(
                  'Date: ${selectDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    onDateChange(pickedDate);
                  }
                },
                icon: const Icon(Icons.date_range),
                label: const Text('Pick Date'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Other Fields (Time, Location, Category Dropdown)
          // Similar structure to your original code...

          // Image Picker
          if (image != null || imageBytes != null)
            Column(
              children: [
                if (image != null)
                  Image.file(image!, fit: BoxFit.cover, height: 200)
                else if (imageBytes != null)
                  Image.memory(imageBytes!, fit: BoxFit.cover, height: 200),
                TextButton.icon(
                  onPressed: onRemoveImage,
                  icon: const Icon(Icons.delete),
                  label: const Text('Remove Image'),
                ),
              ],
            )
          else
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Pick Event Image'),
            ),
          const SizedBox(height: 16),

          // Save Button
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newEvent = Event(
                  id: initialItem?.id ?? const Uuid().v1(),
                  name: nameController.text,
                  description: descriptionController.text,
                  date: selectDate,
                  category: selectedCategory,
                  time: timeController.text,
                  location: locationController.text,
                  imagePath: image?.path ?? '',
                  imageBytes: imageBytes,
                );
                saveEvent(newEvent);
              }
            },
            child: Text(
              mode == Mode.create ? 'Create Event' : 'Save Event',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
