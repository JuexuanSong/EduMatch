import 'package:flutter/material.dart';

class SkillsAutocomplete extends StatefulWidget {
  final String title;
  final List<String> skills;
  final List<String> availableSkills;
  final Function(String) onSkillAdded;
  final Function(String) onSkillRemoved;
  final int? maxSkills;
  final String? placeholder;
  final Color? chipColor;
  final bool allowCustomSkills;

  const SkillsAutocomplete({
    super.key,
    required this.title,
    required this.skills,
    required this.availableSkills,
    required this.onSkillAdded,
    required this.onSkillRemoved,
    this.maxSkills,
    this.placeholder,
    this.chipColor,
    this.allowCustomSkills = false,
  });

  @override
  State<SkillsAutocomplete> createState() => _SkillsAutocompleteState();
}

class _SkillsAutocompleteState extends State<SkillsAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _errorMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addSkill(String skill) {
    setState(() {
      _errorMessage = '';
    });

    // Validation
    if (skill.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a skill';
      });
      return;
    }

    if (widget.skills.contains(skill)) {
      setState(() {
        _errorMessage = 'Skill already added';
      });
      return;
    }

    if (widget.maxSkills != null && widget.skills.length >= widget.maxSkills!) {
      setState(() {
        _errorMessage = 'Maximum ${widget.maxSkills} skills allowed';
      });
      return;
    }

    // Check if skill exists in available skills or if custom skills are allowed
    if (!widget.availableSkills.contains(skill) && !widget.allowCustomSkills) {
      setState(() {
        _errorMessage = 'Please select from available skills';
      });
      return;
    }

    widget.onSkillAdded(skill);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title with count
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00487B),
              ),
            ),
            if (widget.maxSkills != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.skills.length}/${widget.maxSkills}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),

        // Autocomplete field
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }
            return widget.availableSkills.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()) &&
                  !widget.skills.contains(option);
            });
          },
          onSelected: _addSkill,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            _controller.text = controller.text;
            return TextField(
              controller: controller,
              focusNode: focusNode,
              onSubmitted: (value) {
                if (widget.allowCustomSkills) {
                  _addSkill(value);
                } else {
                  onFieldSubmitted();
                }
              },
              decoration: InputDecoration(
                labelText: widget.placeholder ?? 'Add a skill',
                labelStyle: const TextStyle(color: Color(0xFF00487B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF00A1DF), width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _addSkill(controller.text),
                      )
                    : null,
              ),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  width: MediaQuery.of(context).size.width - 32,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);
                      return ListTile(
                        dense: true,
                        leading: const Icon(Icons.lightbulb_outline),
                        title: Text(option),
                        onTap: () => onSelected(option),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),

        // Error message
        if (_errorMessage.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            _errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],

        const SizedBox(height: 12),

        // Skills chips
        _buildSkillsChips(),
      ],
    );
  }

  Widget _buildSkillsChips() {
    if (widget.skills.isEmpty) {
      return _buildEmptyState();
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.skills.map((skill) {
        return Chip(
          label: Text(skill),
          backgroundColor: (widget.chipColor ?? const Color(0xFF00A1DF)).withValues(alpha: 0.1),
          labelStyle: TextStyle(
            color: widget.chipColor ?? const Color(0xFF00A1DF),
            fontWeight: FontWeight.w500,
          ),
          deleteIcon: Icon(
            Icons.close,
            size: 18,
            color: widget.chipColor ?? const Color(0xFF00A1DF),
          ),
          onDeleted: () => widget.onSkillRemoved(skill),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 32,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 8),
          Text(
            widget.title.contains('Offer') || widget.title.contains('teach')
                ? 'None yet / I\'m still learning'
                : 'No skills added yet',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}