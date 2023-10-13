import 'package:flutter/material.dart';

class PersonalForm extends StatefulWidget {
  const PersonalForm({Key? key}) : super(key: key);

  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _verifyController = TextEditingController();
  final _personalIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();

  bool _checkBoxValue1 = false;

  List<String> formResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Form',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLabelLeftAligned("Full Name"),
            _buildTextField("Enter FullName", _fullNameController),
            _buildLabelLeftAligned("Email"),
            _buildTextField("Enter your Email", _emailController),
            Row(
              children: [
                Expanded(
                  child: _buildTextFieldLeftAligned(
                      "Enter phone number", _phoneNumberController),
                ),
                Expanded(
                  child:
                      _buildTextFieldLeftAligned("Verify", _verifyController),
                ),
              ],
            ),
            _buildLabelLeftAligned("Personal ID Number"),
            _buildTextField("Value", _personalIdController),
            _buildLabelLeftAligned("Address"),
            _buildTextField("Enter your text here", _addressController),
            _buildLabelLeftAligned("Choose a Date"),
            Row(
              children: [
                Expanded(
                  child: _buildTextField("Select date", _dateController),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ],
            ),
            _buildCheckboxList(),
            ElevatedButton(
              onPressed: () {
                String fullName = _fullNameController.text;
                String email = _emailController.text;
                String address = _addressController.text;
                bool checkBoxValue1 = _checkBoxValue1;

                String result = '''
                  Full Name: $fullName
                  Email: $email
                  Address: $address;
                  Checkbox 1: $checkBoxValue1
                ''';
                formResults.add(result);

                _fullNameController.clear();
                _emailController.clear();
                _phoneNumberController.clear();
                _personalIdController.clear();
                _addressController.clear();
                _dateController.clear();
                setState(() {
                  _checkBoxValue1 = false;
                });
              },
              child: const Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultList(formResults),
                  ),
                );
              },
              child: const Text('View Results'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _dateController.text) {
      setState(() {
        _dateController.text = pickedDate.toLocal().toString();
      });
    }
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildTextFieldLeftAligned(
      String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // Corrected the syntax here
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            alignLabelWithHint: true,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
    );
}


  Widget _buildLabelLeftAligned(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabelLeftAligned("Select Options"),
        CheckboxListTile(
          title: Text(
              "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content."),
          value: _checkBoxValue1,
          onChanged: (value) {
            setState(() {
              _checkBoxValue1 = value ?? false;
            });
          },
          controlAffinity:
              ListTileControlAffinity.leading,
        ),
      ],
    );
  }
}

class ResultList extends StatelessWidget {
  final List<String> formResults;

  ResultList(this.formResults);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Personal Data',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: formResults.asMap().entries.map((entry) {
            int index = entry.key;
            String result = entry.value;

            return Card(
              elevation: 3,
              margin: EdgeInsets.only(bottom: 16.0),
              child: ListTile(
                title: Text('Result ${index + 1}'),
                subtitle: Text(result),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
