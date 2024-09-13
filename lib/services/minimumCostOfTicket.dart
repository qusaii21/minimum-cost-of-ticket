import 'package:intl/intl.dart';

// lib imports
import 'package:ads_course_project_minimum_cost_of_ticket/services/globalVariables.dart' as global;
import 'package:ads_course_project_minimum_cost_of_ticket/services/node.dart';

class MinimumCost {
  Node createNode(int dayOfTravel, int amount, String path) {
    Node newNode = Node();
    newNode.dayOfTravel = dayOfTravel;
    newNode.amount = amount;
    newNode.path = path;
    return newNode;
  }

  List<Node> endNodes = [];

  Node addOneDayPassNode(List<int> days, List<int> costs, int currentDayIndex, Node root) {
    int currentOneDayIndex = indexOnOneDayTravel(days, currentDayIndex);

    if (currentOneDayIndex == -1) {
      Node temp = createNode(367, root.amount + costs[0],
          "${root.path}\nOne Day pass at day ${DateFormat("dd-MMM-yy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}");
      endNodes.add(temp);
      return temp;
    }

    root.dayPassNode = createNode(days[currentOneDayIndex], 0, "");
    root.dayPassNode!.amount = root.amount + costs[0];
    root.dayPassNode!.path =
        "${root.path}\nOne Day pass at day ${DateFormat("dd-MMM-yyyy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}";
    Node newNode = root.dayPassNode!;
    newNode.dayPassNode = addOneDayPassNode(days, costs, currentOneDayIndex, newNode);
    newNode.sevenDayPassNode = addSevenDayPassNode(days, costs, currentOneDayIndex, newNode);
    newNode.thirtyDayPassNode = addThirtyDayPassNode(days, costs, currentOneDayIndex, newNode);
    return newNode;
  }

  Node addSevenDayPassNode(List<int> days, List<int> costs, int currentDayIndex, Node root) {
    int currentSevenDayIndex = indexOnSevenDayTravel(days, currentDayIndex);

    if (currentSevenDayIndex == -1) {
      Node temp = createNode(367, root.amount + costs[1],
          "${root.path}\nSeven Day pass at day ${DateFormat("dd-MMM-yyyy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}");
      endNodes.add(temp);
      return temp;
    }

    root.sevenDayPassNode = createNode(days[currentSevenDayIndex], 0, "");
    root.sevenDayPassNode!.amount = root.amount + costs[1];
    root.sevenDayPassNode!.path =
        "${root.path}\nSeven Day pass at day ${DateFormat("dd-MMM-yyyy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}";
    Node newNode = root.sevenDayPassNode!;
    newNode.dayPassNode = addOneDayPassNode(days, costs, currentSevenDayIndex, newNode);
    newNode.sevenDayPassNode = addSevenDayPassNode(days, costs, currentSevenDayIndex, newNode);
    newNode.thirtyDayPassNode = addThirtyDayPassNode(days, costs, currentSevenDayIndex, newNode);
    return newNode;
  }

  Node addThirtyDayPassNode(List<int> days, List<int> costs, int currentDayIndex, Node root) {
    int currentThirtyDayIndex = indexOnThirtyDayTravel(days, currentDayIndex);

    if (currentThirtyDayIndex == -1) {
      Node temp = createNode(367, root.amount + costs[2],
          "${root.path}\nThirty Day pass at day ${DateFormat("dd-MMM-yyyy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}");
      endNodes.add(temp);
      return temp;
    }

    root.thirtyDayPassNode = createNode(days[currentThirtyDayIndex], 0, "");
    root.thirtyDayPassNode!.amount = root.amount + costs[2];
    root.thirtyDayPassNode!.path =
        "${root.path}\nThirty Day pass at day ${DateFormat("dd-MMM-yyyy").format(DateTime(DateTime.now().year, 1, days[currentDayIndex]))}";
    Node newNode = root.thirtyDayPassNode!;
    newNode.dayPassNode = addOneDayPassNode(days, costs, currentThirtyDayIndex, newNode);
    newNode.sevenDayPassNode = addSevenDayPassNode(days, costs, currentThirtyDayIndex, newNode);
    newNode.thirtyDayPassNode = addThirtyDayPassNode(days, costs, currentThirtyDayIndex, newNode);
    return newNode;
  }

// Get next day of travel we need to buy ticket on
  int indexOnOneDayTravel(List<int> days, int currentDayIndex) {
    int lastDay = days.last;
    int newDay = days[currentDayIndex] + 1;
    if (newDay >= lastDay) return -1;
    while (true) {
      if (days[currentDayIndex++] >= newDay) return currentDayIndex - 1;
    }
  }

  int indexOnSevenDayTravel(List<int> days, int currentDayIndex) {
    int lastDay = days.last;
    int newDay = days[currentDayIndex] + 7;
    if (newDay >= lastDay) return -1;
    while (true) {
      if (days[currentDayIndex++] >= newDay) return currentDayIndex - 1;
    }
  }

  int indexOnThirtyDayTravel(List<int> days, int currentDayIndex) {
    int lastDay = days.last;
    int newDay = days[currentDayIndex] + 30;
    if (newDay >= lastDay) return -1;
    while (true) {
      if (days[currentDayIndex++] >= newDay) return currentDayIndex - 1;
    }
  }

  void minCostTickets(List<int> days, List<int> costs) {
    Node root = createNode(days[0], 0, "");
    root.dayPassNode = addOneDayPassNode(days, costs, 0, root);
    root.sevenDayPassNode = addSevenDayPassNode(days, costs, 0, root);
    root.thirtyDayPassNode = addThirtyDayPassNode(days, costs, 0, root);

    int minCost = 9223372036854775807;
    endNodes.forEach((node) {
      if (node.amount < minCost) {
        minCost = node.amount;
        global.minNode.clear();
        global.minNode.add(node);
      } else if (node.amount == minCost) {
        global.minNode.add(node);
      }
    });
  }
}
