const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const userManagementPageDisplayName = "User";
const userManagementPageRoute = "/user";

const jobPageDisplayName = "Job";
const jobPageRoute = "/job";

const wrPageDisplayName = "INQUIRY";
const wrPageRoute = "/wr";

const fsPageDisplayName = "ticket";
const fsPageRoute = "/fs";

const fs2PageDisplayName = "TICKETS2";
const fs2PageRoute = "/fs2";

const repairNoteDisplayName = "Repair Note";
const repairNotePageRoute = "/repairNote";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
 MenuItem(overviewPageDisplayName, overviewPageRoute),
 MenuItem(jobPageDisplayName, jobPageRoute),
 MenuItem(userManagementPageDisplayName, userManagementPageRoute),
 MenuItem(wrPageDisplayName, wrPageRoute),
 MenuItem(fsPageDisplayName, fsPageRoute),
 MenuItem(authenticationPageDisplayName, authenticationPageRoute),
 MenuItem(fs2PageDisplayName, fs2PageRoute),
];



List<MenuItem> getSideMenuItem(List<dynamic> menu){
  List<MenuItem> sideMenuItemRoutes2 = [];
  for(String s in menu){
    for(MenuItem item in sideMenuItemRoutes){
      if(s == item.route){
        sideMenuItemRoutes2.add(item);
      }
    }
  }
  sideMenuItemRoutes2.add(MenuItem(authenticationPageDisplayName, authenticationPageRoute));
  return sideMenuItemRoutes2;
}