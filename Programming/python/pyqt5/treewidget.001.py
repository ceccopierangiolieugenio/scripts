#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# example from:
# https://stackoverflow.com/questions/41204234/python-pyqt5-qtreewidget-sub-item

import sys
from PyQt5.QtWidgets import QTreeWidget, QTreeWidgetItem, QApplication, QWidget

if __name__ == '__main__':
    app = 0
    if QApplication.instance():
        app = QApplication.instance()
    else:
        app = QApplication(sys.argv)

    l1 = QTreeWidgetItem(["String A", "String B", "String C"])
    l2 = QTreeWidgetItem(["String AA", "String BB", "String CC"])
    l3 = QTreeWidgetItem(["String AAA", "String BBB", "String CCC"])
    l2.addChild(l3)

    for i in range(3):
        l1_child = QTreeWidgetItem(["Child A" + str(i), "Child B" + str(i), "Child C" + str(i)])
        l1.addChild(l1_child)

    for j in range(2):
        l2_child = QTreeWidgetItem(["Child AA" + str(j), "Child BB" + str(j), "Child CC" + str(j)])
        l2.addChild(l2_child)

    for j in range(2):
        l3_child = QTreeWidgetItem(["Child AAA" + str(j), "Child BBB" + str(j), "Child CCC" + str(j)])
        l3.addChild(l3_child)

    w = QWidget()
    w.resize(510, 210)

    tw = QTreeWidget(w)
    tw.resize(500, 200)
    tw.setColumnCount(3)
    tw.setHeaderLabels(["Column 1", "Column 2", "Column 3"])
    tw.addTopLevelItem(l1)
    tw.addTopLevelItem(l2)

    w.show()
    sys.exit(app.exec_())

