import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:week3/sport-event/pages/home_page.dart';
import '../models/event.dart';
import '../models/sport_category.dart';

class CreateEventPage extends StatefulWidget {
  final Event? initialItem;
  final Mode mode;

  const CreateEventPage({super.key, this.initialItem, required this.mode});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  final uuid = const Uuid();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _timeController;
  late TextEditingController _locationController;
  DateTime _selectDate = DateTime.now();
  SportsCategory _selectedCategory = SportsCategory.frisbee;
  File? _image;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _timeController = TextEditingController();
    _locationController = TextEditingController();

    if (widget.mode == Mode.edit && widget.initialItem != null) {
      final item = widget.initialItem!;
      _nameController.text = item.name;
      _descriptionController.text = item.description;
      _selectDate = item.date;
      _timeController.text = item.time;
      _locationController.text = item.location;
      _selectedCategory = item.category;
      if (kIsWeb) {
        _imageBytes = item.imageBytes;
      } else {
        if (item.imagePath.isNotEmpty &&
            !item.imagePath.startsWith('/images')) {
          try {
            _image = File(item.imagePath);
          } catch (e) {
            debugPrint('Error loading image file: $e');
          }
        }
        if (item.imageBytes != null) {
          _imageBytes = item.imageBytes;
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDated() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectDate) {
      setState(() {
        _selectDate = pickedDate;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _image = null;
          _imageBytes = bytes;
        });
      } else {
        setState(() {
          _image = File(pickedFile.path);
          _imageBytes = null;
        });
      }
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
      _imageBytes = null;
      if (widget.initialItem != null) {
        widget.initialItem!.imagePath = ''; // Clear the asset path if it exists
      }
    });
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      if (_image == null && _imageBytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload an image for the event')),
        );
        return;
      }

      final newEvent = Event(
        id: widget.initialItem?.id ?? uuid.v1(),
        name: _nameController.text,
        description: _descriptionController.text,
        date: _selectDate,
        category: _selectedCategory,
        time: _timeController.text,
        location: _locationController.text,
        imagePath: _image?.path ?? '',
        imageBytes: _imageBytes,
      );
      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == Mode.create ? 'Create Event' : 'Edit Event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Event Name
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Event Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Event name is required' : null,
                    ),
                    const SizedBox(height: 12),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      maxLines: 3,
                      validator: (value) =>
                          value!.isEmpty ? 'Description is required' : null,
                    ),
                    const SizedBox(height: 12),

                    // Date Picker
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Date: ${_selectDate.toLocal()}'.split(' ')[0],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _selectDated,
                          icon: const Icon(Icons.date_range),
                          label: const Text('Pick Date'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Time
                    TextFormField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Time is required' : null,
                    ),
                    const SizedBox(height: 12),

                    // Location
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Location is required' : null,
                    ),
                    const SizedBox(height: 12),

                    // Category Dropdown
                    DropdownButtonFormField<SportsCategory>(
                      value: _selectedCategory,
                      onChanged: (value) =>
                          setState(() => _selectedCategory = value!),
                      items: SportsCategory.values
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.label),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Image Picker with Cancel Option
                    // Image Picker with Cancel Option
                    _image != null ||
                            _imageBytes != null ||
                            (widget.initialItem?.imagePath
                                    .startsWith('/images') ??
                                false)
                        ? Column(
                            children: [
                              if (_image != null)
                                Image.file(_image!,
                                    fit: BoxFit.cover, height: 200)
                              else if (_imageBytes != null)
                                Image.memory(_imageBytes!,
                                    fit: BoxFit.cover, height: 200)
                              else if (widget.initialItem?.imagePath
                                      .startsWith('/images') ??
                                  false)
                                Image.asset(
                                  widget.initialItem!.imagePath,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              TextButton.icon(
                                onPressed: _removeImage,
                                icon: const Icon(Icons.delete),
                                label: const Text('Remove Image'),
                              ),
                            ],
                          )
                        : TextButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.image),
                            label: const Text('Pick Event Image'),
                          ),
                    const SizedBox(height: 16),

                    // Save Button
                    ElevatedButton(
                      onPressed: _saveEvent,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        widget.mode == Mode.create
                            ? 'Create Event'
                            : 'Save Event',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
