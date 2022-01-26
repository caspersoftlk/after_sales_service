import 'package:after_sales_service_module/app/constants/style.dart';
import 'package:after_sales_service_module/app/pages/job/widgets/job_info_card.dart';
import 'package:after_sales_service_module/app/widgets/pageTitileCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RunningJobList extends StatelessWidget {
  const RunningJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        PageTitleCard(title: "Active Jobs", icon: Icons.assignment_outlined),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {

                  },
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                  },
                  backgroundColor: blue,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Edit',
                ),
              ],
            ),
            child: JobInfoCard(),
          ),
        ),
      ]
    );
  }
}
