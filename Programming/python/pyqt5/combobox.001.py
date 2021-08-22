#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Combobox example from:
#   https://pythonbasics.org/pyqt-combobox/

import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel, QComboBox, QPushButton

class Example(QMainWindow):
    
    def __init__(self):
        super().__init__()
                
        combo = QComboBox(self)
        combo.addItem("Apple")
        combo.addItem("Pear")
        combo.addItem("Lemon")
        combo.move(50, 50)

        combo1 = QComboBox(self)
        combo1.addItem("Apple xxxxxxxxxxxxxxx")
        combo1.addItem("Pear")
        combo1.addItem("Lemon")
        combo1.setEditable(True)
        combo1.setInsertPolicy(QComboBox.InsertAtTop)
        combo1.move(50, 90)

        self.qlabel = QLabel(self)
        self.qlabel.move(50,16)

        combo.activated[str].connect(self.onChanged)      

        self.setGeometry(50,50,320,200)
        self.setWindowTitle("QLineEdit Example")
        self.show()

    def onChanged(self, text):
        self.qlabel.setText(text)
        self.qlabel.adjustSize()
        
if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = Example()
    sys.exit(app.exec_())
