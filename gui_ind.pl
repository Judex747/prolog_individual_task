:- include('ind.pl').

gui_to_task1 :-
    new(MyWin, dialog('Интерфейс к заданию 1')),
    send_list(MyWin,append,[
                        new(F,text_item('Название факультета:')),
                        new(MyList, list_browser),
                        button('Узнать',message(@prolog, output1, MyList,F?selection)),
                        button(выход, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task2 :-
    new(MyWin, dialog('Интерфейс к заданию 2')),
    send_list(MyWin,append,[
                        new(F,int_item('Номер специальности:')),
                        new(MyList, list_browser),
                        button('Узнать',message(@prolog, output2, MyList,F?selection)),
                        button(выход, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task3 :-
    new(MyWin, dialog('Интерфейс к заданию 3')),
    send_list(MyWin,append,[
                        text('Номер группы:'),
                        new(MyList, list_browser),
                        button('Узнать',message(@prolog, output3, MyList)),
                        button(выход, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task4 :-
    new(MyWin, dialog('Интерфейс к заданию 4')),
    send_list(MyWin,append,[
                        text('Имеют задолжности:'),
                        new(MyList, list_browser),
                        button('Узнать',message(@prolog, output4, MyList)),
                        button(выход, message(MyWin,destroy))
                    ]),
    send(MyWin, open(point(100,400))).
    
gui_to_task5 :-
    new(MyWin, dialog('Интерфейс к заданию 5')),
    send_list(MyWin,append,[
                        text('На военной кафедре:'),
                        new(MyList, list_browser),
                        button('Узнать',message(@prolog, output5, MyList)),
                        button(выход, message(MyWin,destroy))
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
    
    