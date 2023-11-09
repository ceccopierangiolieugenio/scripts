#! /bin/env python3
# Example from:
# https://stackoverflow.com/questions/31190384/pyside-qmenu-examples

import sys
from PySide6 import QtGui


class MyLabel(QtGui.QLabel):
    def __init__(self,action):
        super(MyLabel,self).__init__()
        self.action = action

    def mouseReleaseEvent(self,e):
        self.action.trigger()

class Example(QtGui.QMainWindow):

    def __init__(self):
        super(Example, self).__init__()

        wAction = QtGui.QWidgetAction(self)
        ql = MyLabel(wAction)
        ql.setText("<b>Hello</b> <i>Qt!</i>")
        wAction.setDefaultWidget(ql)
        wAction.triggered.connect(self.close)

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(wAction)

        self.setGeometry(300, 300, 250, 150)
        self.setWindowTitle('Menubar')    
        self.show()

app = QtGui.QApplication(sys.argv)
ex = Example()
sys.exit(app.exec_())
