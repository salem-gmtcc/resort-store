import 'package:resort_store/presentation/resources/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/checkBox_model/checkBox_model.dart';
import '../resources/textStyle_manger.dart';
import 'custom_padding.dart';

class CustomCheckBoxTree extends StatefulWidget {
  const CustomCheckBoxTree({Key? key}) : super(key: key);

  @override
  State<CustomCheckBoxTree> createState() => _CustomCheckBoxTreeState();
}

class _CustomCheckBoxTreeState extends State<CustomCheckBoxTree> {
  final allChecked = CheckBoxModel(title: "All");
  List<CheckBoxModel> checkBoxList = [
    CheckBoxModel(title: "****1"),
    CheckBoxModel(title: "****2"),
    CheckBoxModel(title: "****3"),
  ];

   List<MyNode> roots = <MyNode>[
    MyNode(
      title: "General Option",
      children: <MyNode>[
        MyNode(
          title: 'Task Scheduling Management',
          children: <MyNode>[
            MyNode(title: 'task 1'),
            MyNode(title: 'task 2'),
          ],
        ),
        MyNode(title: 'Users Work Records'),
      ],
    ),
    MyNode(
      title: 'Report and Document Printer Design',
      children: <MyNode>[
        MyNode(
          title: 'Report 1',
          children: <MyNode>[
            MyNode(title: 'Report 1.1'),
          ],
        ),
        MyNode(title: 'Report 2')
      ],
    ),
  ];

  TreeController<MyNode>? treeController;

  @override
  void initState() {
    super.initState();
    treeController = TreeController<MyNode>(
      roots: roots,
      childrenProvider: (MyNode node) => node.children,
    );
  }

  @override
  void dispose() {
    treeController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.w,
        height: 250.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: AppColor.white.withOpacity(0.3)),
        child: TreeView<MyNode>(
          treeController: treeController!,
          nodeBuilder: (BuildContext context, TreeEntry<MyNode> entry) {
            return MyTreeTile(
              // Add a key to your tiles to avoid syncing descendant animations.
              key: ValueKey(entry.node),
              entry: entry,
              onTap: () => treeController!.toggleExpansion(entry.node),
            );
          },
        ),
      ),
    );
  }

  onAllClicked(CheckBoxModel checkBoxModel) {
    final selectAll = !checkBoxModel.value;
    setState(() {
      checkBoxModel.value = selectAll;
      checkBoxList.forEach((element) {
        element.value = selectAll;
      });
    });
  }

  onItemClicked(CheckBoxModel checkBoxModel) {
    setState(() {
      checkBoxModel.value = !checkBoxModel.value;
    });
  }
}

class MyTreeTile extends StatelessWidget {
   MyTreeTile({
    super.key,
    required this.entry,
    required this.onTap,
  });

   TreeEntry<MyNode>? entry;
   VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: TreeIndentation(
        entry: entry!,
        guide: const IndentGuide.connectingLines(indent: 48),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
          child: Row(
            children: [
              // Checkbox(value: entry!.hasChildren ? entry!.isExpanded : null, onChanged: (value){
              //   print("value   $value");
              //  value != value;
              // }),
              FolderButton(
                isOpen: entry!.hasChildren ? entry!.isExpanded : null,
                onPressed: entry!.hasChildren ? onTap : null,
              ),
              Text(entry!.node.title!,style: mediumTextStyle(fontSize:13.sp, color: AppColor.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class FancyTreeCheckboxNode extends StatelessWidget {
  final FancyTreeNode node;
  final Function(bool?)? onChecked;

  const FancyTreeCheckboxNode({
    required this.node,
    this.onChecked,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(node.title.toString()),
      value: node.isSelected,
      onChanged: onChecked != null
          ? (value) {
              onChecked!(value);
              node.isSelected = value!;
            }
          : null,
      secondary: Icon(node.icon),
    );
  }
}
