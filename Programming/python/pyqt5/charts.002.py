#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Example from:
# https://stackoverflow.com/questions/59831326/getting-pyside2-qcharts-to-show-up-when-using-qt-designer

import random
import sys

from PySide2 import QtCore, QtGui, QtUiTools, QtWidgets
from PySide2.QtCharts import QtCharts


def ui_to_window(filename, parent=None):
    file = QtCore.QFile(filename)
    if not file.open(QtCore.QFile.ReadOnly):
        return
    loader = QtUiTools.QUiLoader()
    window = loader.load(file, parent)
    return window


if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    window = ui_to_window("charts.002.design.ui")
    window.widget.setContentsMargins(0, 0, 0, 0)
    lay = QtWidgets.QVBoxLayout(window.widget)
    lay.setContentsMargins(0, 0, 0, 0)

    chartview = QtCharts.QChartView()
    chartview.setContentsMargins(0, 0, 0, 0)
    lay.addWidget(chartview)

    series = QtCharts.QLineSeries()

    for i in range(10):
        series << QtCore.QPointF(i, random.uniform(0, 10))

    # Create Chart and set General Chart setting
    chart = QtCharts.QChart()
    chart.addSeries(series)
    chart.setAnimationOptions(QtCharts.QChart.SeriesAnimations)

    # X Axis Settings
    axisX = QtCharts.QValueAxis()
    chart.addAxis(axisX, QtCore.Qt.AlignBottom)
    series.attachAxis(axisX)

    # Y Axis Settings
    axisY = QtCharts.QValueAxis()
    chart.addAxis(axisY, QtCore.Qt.AlignLeft)
    series.attachAxis(axisY)

    chartview.setChart(chart)

    window.show()
    sys.exit(app.exec_())
