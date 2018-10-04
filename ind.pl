student('������','����','��������','�',1997,'Yes',[marklist('Math',5),marklist('Chemistry',2)]).
student('�������','������','��������','�',1998,'No',[marklist('Math',4),marklist('Chemistry',3)]).
student('��������','�����','��������','�',1996,'No',[marklist('Math',4),marklist('Chemistry',3)]).
student('���������','�������','��������','�',1996,'Yes',[marklist('Math',4),marklist('Chemistry',1)]).
student('�������','����','����������','�',1997,'No',[marklist('Math',4),marklist('Chemistry',1)]).

student('����������','���������','����������','�',1998,'No',[marklist('Math',4),marklist('English',2)]).
student('������','���������','��������','�',1998,'Yes',[marklist('Math',2),marklist('English',4)]).
student('����������','����','����������','�',1998,'No',[marklist('Math',3),marklist('English',1)]).

student_group('ILP',090302,7,[
        student('������','����','��������','�',1997,'Yes',[marklist('Math',5),marklist('Chemistry',2),marklist('Russian',4)]),
        student('�������','������','��������','�',1998,'No',[marklist('Math',4),marklist('Chemistry',3),marklist('Russian',4)]),
        student('��������','�����','��������','�',1996,'No',[marklist('Math',4),marklist('Chemistry',3),marklist('Russian',4)])
]).
student_group('ILP',090302,8,[
        student('���������','�������','��������','�',1996,'Yes',[marklist('Math',4),marklist('Chemistry',1)]),
        student('�������','����','����������','�',1997,'No',[marklist('Math',4),marklist('Chemistry',2)])
]).

student_group('ILS',090305,8,[
        student('����������','���������','����������','�',1998,'No',[marklist('Math',4),marklist('English',2)]),
        student('������','���������','��������','�',1998,'Yes',[marklist('Math',2),marklist('English',4)]),
        student('����������','����','����������','�',1998,'No',[marklist('Math',3),marklist('English',2)])
]).

student_female(Surname,F):-
student_group(_,F,_,Students),
member(student(Surname,_,_,'�',_,_,_),Students).

all_females(F,List):-
findall(Surname,student_female(Surname,F),List).

countMarks(F,G,N):-student_group(F,_,G,Students),member(student(_,_,_,_,_,_,Marks),Students),
length(Marks,N).
getBiggest(N):-countMarks(_,_,M), M>N.
getBigCount(F,G):-countMarks(F,G,N),not(getBiggest(N)).

bad_mark(Surname):-student_group(_,_,_,Students),member(student(Surname,_,_,_,_,_,Marks),Students),member(marklist(_,2),Marks).
tails(List):-findall(Surname,bad_mark(Surname),List).

getWarStudents(Surname):-student_group(_,_,_,Students),member(student(Surname,_,_,_,_,'Yes',_),Students).
warcaf(List):-findall(Surname,getWarStudents(Surname),List).

task1(F,N):-
findall(Number,student_group(F,_,Number,_),List),
length(List,N),
write('����� ����� �� ���������� - '),
write(N).

task2(F,List):-
findall(Surname,student_female(Surname,F),List),
write('�������(��) �� �������������: '),nl,
write(List).

task3(N):-
getBigCount(_,N),!,
write(N).

task4(L):-
tails(L),
write(L).

task5(L):-
warcaf(L),
write(L).
