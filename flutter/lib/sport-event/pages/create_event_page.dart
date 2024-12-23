import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:week3/sport-event/widgets/textField.dart';
import '../models/event.dart';
import '../models/sport_category.dart';
import 'home_page.dart';

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
  late TextEditingController _priceController;
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
    _priceController = TextEditingController();

    if (widget.mode == Mode.edit && widget.initialItem != null) {
      final item = widget.initialItem!;
      _nameController.text = item.name;
      _descriptionController.text = item.description;
      _selectDate = item.date;
      _priceController.text = item.price ;
      _timeController.text = item.time;
      _locationController.text = item.location;
      _selectedCategory = item.category;
      if (kIsWeb) {
        _imageBytes = item.imageBytes;
      } else {
        if (item.imagePath.isNotEmpty &&
            item.imagePath.startsWith('/images')) {
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
    _timeController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _selectDated() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.deepOrange,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
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
        widget.initialItem!.imagePath = '';
      }
    });
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      // Check if there's either a new image or an existing image (including asset images)
      bool hasImage = _image != null ||
          _imageBytes != null ||
          (widget.initialItem?.imagePath.startsWith('/images') ?? false) ||
          (widget.initialItem?.imagePath.isNotEmpty ?? false);

      if (!hasImage) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload an image for the event'),
            backgroundColor: Colors.deepOrange,
          ),
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
        price: _priceController.text,
        // Keep the original asset path if it exists and no new image is selected
        imagePath: _image?.path ??
            (widget.initialItem?.imagePath.startsWith('/images') ?? false
                ? widget.initialItem!.imagePath
                : ''),
        imageBytes: _imageBytes ?? widget.initialItem?.imageBytes,
      );
      Navigator.pop(context, newEvent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      widget.mode == Mode.create
                          ? 'Create Event'
                          : 'Edit Event',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildImagePicker(),
                          const SizedBox(height: 20),
                          buildTextField(
                            controller: _nameController,
                            label: 'Event Name',
                            validator: (value) => value!.isEmpty
                                ? 'Event name is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _descriptionController,
                            label: 'Description',
                            maxLines: 3,
                            validator: (value) => value!.isEmpty
                                ? 'Description is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          _buildDatePicker(),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _timeController,
                            label: 'Time',
                            validator: (value) =>
                                value!.isEmpty ? 'Time is required' : null,
                          ),
                          const SizedBox(height: 16,),
                          buildTextField(
                            controller: _priceController,
                            label: 'Price',
                            validator: (value) =>
                                value!.isEmpty ? 'Price is required' : null,
                          ),
                          const SizedBox(height: 16),
                          buildTextField(
                            controller: _locationController,
                            label: 'Location',
                            validator: (value) =>
                                value!.isEmpty ? 'Location is required' : null,
                          ),
                          const SizedBox(height: 16),
                          _buildCategoryDropdown(),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _saveEvent,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              widget.mode == Mode.create
                                  ? 'Create Event'
                                  : 'Save Changes',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDatePicker() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Date: ${DateFormat.yMMMd().format(_selectDate)}',
            style: const TextStyle(fontSize: 16),
          ),
          TextButton.icon(
            onPressed: _selectDated,
            icon: const Icon(Icons.calendar_today, color: Colors.deepOrange),
            label: const Text(
              'Change',
              style: TextStyle(color: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<SportsCategory>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        labelStyle: TextStyle(color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepOrange),
        ),
      ),
      items: SportsCategory.values.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Row(
            children: [
              Icon(category.icon, size: 20, color: Colors.deepOrange),
              const SizedBox(width: 8),
              Text(category.label),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value!),
    );
  }

  Widget _buildImagePicker() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: _image != null ||
              _imageBytes != null ||
              (widget.initialItem?.imagePath.startsWith('/images') ?? false)
          ? Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : _imageBytes != null
                          ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                          : Image.asset(
                              widget.initialItem!.imagePath,
                              fit: BoxFit.cover,
                            ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: _removeImage,
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: _pickImage,
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate,
                      size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 8),
                  Text(
                    'Add Event Image',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
