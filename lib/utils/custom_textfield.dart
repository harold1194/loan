import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final FormFieldValidator<String>? validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardtype;
  final bool obscure;
  final bool readonly;
  final bool showicon;
  final int? maxLength; // Correct spelling
  final int? maxline;
  final Function()? ontap;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatter;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.icon,
    this.validator,
    this.keyboardtype = TextInputType.text,
    this.obscure = false,
    this.readonly = false,
    this.showicon = true,
    this.maxLength,
    this.maxline,
    this.ontap,
    this.inputFormatter,
    this.onChanged,
    this.textAlign = TextAlign.end,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxline,
        readOnly: readonly,
        controller: textEditingController,
        obscureText: obscure,
        keyboardType: keyboardtype,
        inputFormatters: inputFormatter,
        textAlign: textAlign,
        onTap: readonly ? ontap : null,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hint,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
          prefixIcon:
              showicon ? Icon(icon, size: 22, color: Colors.grey) : null,
          suffixIcon:
              readonly ? Icon(icon, size: 22, color: Colors.grey) : null,
          // This hides the character counter
          counterText: '',
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLength: maxLength, // Correct spelling
      ),
    );
  }
}
