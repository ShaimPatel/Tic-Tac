import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  HtmlEditorController editorController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: Get.height * 0.6,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            HtmlEditor(
              controller: editorController, //required
              htmlEditorOptions: const HtmlEditorOptions(
                hint: "Your text here...",
                shouldEnsureVisible: true,
                // disabled: false,
                spellCheck: true,
                inputType: HtmlInputType.text,
              ),
              otherOptions: const OtherOptions(
                height: 400,
              ),
              htmlToolbarOptions: const HtmlToolbarOptions(
                toolbarType: ToolbarType.nativeGrid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
