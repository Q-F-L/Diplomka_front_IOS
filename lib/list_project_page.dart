import 'package:diplomka/ProjectsConvertJSON.dart';
import 'package:flutter/material.dart';
import 'global.dart' as global;

class ListProjectPage extends StatefulWidget {
  _ListProjectPage createState() => _ListProjectPage();
}

class _ListProjectPage extends State<ListProjectPage> {
  late Future<ProjectsList>? projectList;

  void initState() {
    super.initState();
    projectList = getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/menu_page');
                        },
                        child: Image.asset('assets/arrow_back.png')),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Проекты',
                      style: TextStyle(
                          fontSize: 36,
                          color: Color.fromRGBO(32, 86, 146, 1),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      flex: 1, child: Image.asset('assets/logo_image.png')),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: FutureBuilder<ProjectsList>(
                    future: projectList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.projects.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                      global.id = snapshot.data!.projects[index].id;
                                      global.topic = snapshot.data!.projects[index].topic;
                                      global.title=
                                          snapshot.data!.projects[index].title;
                                      global.now_description= snapshot.data!
                                          .projects[index].now_description;
                                      global.now_video= snapshot
                                          .data!.projects[index].now_video;
                                      global.now_photo= snapshot
                                          .data!.projects[index].now_photo;
                                      global.need_description= snapshot.data!
                                          .projects[index].need_description;
                                      global.need_video= snapshot
                                          .data!.projects[index].need_video;
                                      global.need_photo= snapshot
                                          .data!.projects[index].need_photo;
                                      global.will_description= snapshot.data!
                                          .projects[index].will_description;
                                      global.rating=
                                          snapshot.data!.projects[index].rating;
                                      global.status=
                                          snapshot.data!.projects[index].status;
                                      global.discussion_id= snapshot
                                          .data!.projects[index].discussion_id;
                                      global.project_user_id= snapshot
                                          .data!.projects[index].user_id;
                                      global.created_at= snapshot
                                          .data!.projects[index].created_at;
                                      global.updated_at= snapshot
                                          .data!.projects[index].updated_at;
                                  Navigator.pushNamed(
                                      context, '/detail_project_page');
                                },
                                child: Table(
                                  border: TableBorder.all(),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FixedColumnWidth(100),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(2),
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: <TableRow>[
                                    TableRow(
                                      decoration: const BoxDecoration(),
                                      children: <Widget>[
                                        Image.asset('assets/image_p.png'),
                                        Container(
                                          height: 32,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${snapshot.data?.projects[index].title}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color.fromRGBO(
                                                      32, 86, 146, 1),
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.end,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              '${snapshot.data?.projects[index].rating}/5',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      114, 114, 114, 1.0),
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.end,
                                            ),
                                            Text(
                                              '${snapshot.data?.projects[index].topic}',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromRGBO(
                                                      32, 86, 146, 1),
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text('Error');
                      }
                      return Text('Empty');
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
