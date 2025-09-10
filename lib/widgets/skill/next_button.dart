import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final List<Map<String, dynamic>> skills;
  final Function(List<String>) onPressed;
  final bool isLoading;
  final String buttonText;
  final int minSelection;

  const NextButton({
    super.key,
    required this.skills,
    required this.onPressed,
    this.isLoading = false,
    this.buttonText = 'Next',
    this.minSelection = 1,
  });

  @override
  Widget build(BuildContext context) {
    final selectedSkills = skills.where((skill) => skill['selected']).toList();
    final hasMinSelection = selectedSkills.length >= minSelection;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Selection Summary
        if (selectedSkills.isNotEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF00A1DF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00A1DF).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Skills (${selectedSkills.length}):',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00A1DF),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: selectedSkills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00A1DF).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        skill['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF00A1DF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        
        // Next Button
        Row(
          children: [
            if (!hasMinSelection)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade300),
                  ),
                  child: Text(
                    'Select at least $minSelection skill${minSelection == 1 ? '' : 's'} to continue',
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: hasMinSelection && !isLoading
                  ? () {
                      final selectedSkillNames = selectedSkills
                          .map((skill) => skill['name'] as String)
                          .toList();
                      onPressed(selectedSkillNames);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A1DF),
                disabledBackgroundColor: Colors.grey.shade300,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: hasMinSelection ? 2 : 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ],
    );
  }
}