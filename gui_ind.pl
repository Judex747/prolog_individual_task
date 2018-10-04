:- include('ind.pl').

gui_to_task1 :-
    new(MyWin, dialog('��������� � ������� 1')),
    send_list(MyWin,append,[
                        new(F,text_item('�������� ����������:')),
                        new(MyList, list_browser),
                        button('������',message(@prolog, output1, MyList,F?selection)),
                        button(�����, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task2 :-
    new(MyWin, dialog('��������� � ������� 2')),
    send_list(MyWin,append,[
                        new(F,int_item('����� �������������:')),
                        new(MyList, list_browser),
                        button('������',message(@prolog, output2, MyList,F?selection)),
                        button(�����, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task3 :-
    new(MyWin, dialog('��������� � ������� 3')),
    send_list(MyWin,append,[
                        text('����� ������:'),
                        new(MyList, list_browser),
                        button('������',message(@prolog, output3, MyList)),
                        button(�����, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task4 :-
    new(MyWin, dialog('��������� � ������� 4')),
    send_list(MyWin,append,[
                        text('����� �����������:'),
                        new(MyList, list_browser),
                        button('������',message(@prolog, output4, MyList)),
                        button(�����, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task5 :-
    new(MyWin, dialog('��������� � ������� 5')),
    send_list(MyWin,append,[
                        text('�� ������� �������:'),
                        new(MyList, list_browser),
                        button('������',message(@prolog, output5, MyList)),
                        button(�����, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
output1(FrmList,X) :-
    send(FrmList, clear),
    task1(X,N),
    send(FrmList, append, N),
    fail.
    
output2(FrmList,X) :-
    send(FrmList, clear),
    task2(X,N),
    send_list(FrmList, append, N),
    fail.

output3(FrmList) :-
    send(FrmList, clear),
    task3(N),
    send(FrmList, append, N).
    
output4(FrmList) :-
    send(FrmList, clear),
    task4(N),
    send_list(FrmList, append, N).
    
output5(FrmList) :-
    send(FrmList, clear),
    task5(N),
    send_list(FrmList, append, N).
    
    