#!/usr/bin/env python3
# example from
# https://www.educba.com/tkinter-treeview/

from tkinter import *
from tkinter import ttk

appln = Tk()
appln.title("Application for GUI to represent the University ")
ttk.Label(appln, text ="Treeview(hierarchical)").pack()

treeview = ttk.Treeview(appln)
treeview.pack()

treeview.insert(''  , '0'  , 'i1'            , text ='University')
treeview.insert(''  , '1'  , 'i2'            , text ='Computer Science')
treeview.insert(''  , '2'  , 'i3'            , text ='Mechanical_Engg')
treeview.insert(''  , 'end', 'i4'            , text ='Civil_Engg')
treeview.insert('i2', 'end', 'Analysis_Of_DS', text ='Analysis_Of_DS')
treeview.insert('i2', 'end', 'OOPS'          , text ='OOPS')
treeview.insert('i3', 'end', 'Mech_Exam'     , text ='Mech_Exam')
treeview.insert('i3', 'end', 'CAD'           , text ='CAD')
treeview.insert('i4', 'end', 'Civil_Exam'    , text ='Civil_Exam')
treeview.insert('i4', 'end', 'Drawing'       , text ='Drawing')

treeview.move('i2'  , 'i1', 'end')
treeview.move('i3'  , 'i1', 'end')
treeview.move('i4'  , 'i1', 'end')
appln.mainloop()

