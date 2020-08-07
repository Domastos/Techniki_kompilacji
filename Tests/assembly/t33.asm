        jump.i  #lab0                   ;jump.i  lab0
lab0:
        je.i    0,#0,#lab1              ;je.i    a,0,lab1
        write.r 52                      ;write.r d
        jump.i  #lab2                   ;jump.i  lab2
lab1:
        write.i 12                      ;write.i c
lab2:
        je.r    4,#0,#lab3              ;je.r    b,0,lab3
        write.i 0                       ;write.i a
        jump.i  #lab4                   ;jump.i  lab4
lab3:
        write.r 52                      ;write.r d
lab4:
        je.i    12,#0,#lab5             ;je.i    c,0,lab5
        write.r 4                       ;write.r b
        jump.i  #lab6                   ;jump.i  lab6
lab5:
        write.i 0                       ;write.i a
lab6:
        je.r    52,#0,#lab7             ;je.r    d,0,lab7
        write.i 12                      ;write.i c
        jump.i  #lab8                   ;jump.i  lab8
lab7:
        write.r 4                       ;write.r b
lab8:
        je.i    0,#0,#lab9              ;je.i    a,0,lab9
        write.r 52                      ;write.r d
        jump.i  #lab10                  ;jump.i  lab10
lab9:
        write.i 12                      ;write.i c
lab10:
        je.r    4,#0,#lab11             ;je.r    b,0,lab11
        write.i 0                       ;write.i a
        jump.i  #lab12                  ;jump.i  lab12
lab11:
        write.r 52                      ;write.r d
lab12:
        je.i    12,#0,#lab13            ;je.i    c,0,lab13
        write.r 4                       ;write.r b
        jump.i  #lab14                  ;jump.i  lab14
lab13:
        write.i 0                       ;write.i a
lab14:
        je.i    #0,#0,#lab15            ;je.i    0,0,lab15
        write.r 52                      ;write.r d
        jump.i  #lab16                  ;jump.i  lab16
lab15:
        write.i #1                      ;write.i 1
lab16:
        je.i    #4,#0,#lab17            ;je.i    4,0,lab17
        write.r #2.2                    ;write.r 2.2
        jump.i  #lab18                  ;jump.i  lab18
lab17:
        write.r 52                      ;write.r d
lab18:
        je.i    12,#0,#lab19            ;je.i    c,0,lab19
        write.i #1                      ;write.i 1
        jump.i  #lab20                  ;jump.i  lab20
lab19:
        write.r #4.3                    ;write.r 4.3
lab20:
        exit                            ;exit    
