        jump.i  #lab0                   ;jump.i  lab0
lab0:
        mul.i   4,#2,156                ;mul.i   j,2,$t0
        add.i   156,#4,160              ;add.i   $t0,4,$t1
        jne.i   0,160,#lab1             ;jne.i   i,$t1,lab1
        mov.i   #0,164                  ;mov.i   0,$t2
        jump.i  #lab2                   ;jump.i  lab2
lab1:
        mov.i   #1,164                  ;mov.i   1,$t2
lab2:
        mov.i   164,0                   ;mov.i   $t2,i
        jge.i   0,28,#lab3              ;jge.i   i,z,lab3
        mov.i   #0,168                  ;mov.i   0,$t3
        jump.i  #lab4                   ;jump.i  lab4
lab3:
        mov.i   #1,168                  ;mov.i   1,$t3
lab4:
        inttoreal.i 168,172             ;inttoreal.i $t3,$t4
        mov.r   172,12                  ;mov.r   $t4,x
        jl.i    0,36,#lab5              ;jl.i    i,o,lab5
        mov.i   #0,180                  ;mov.i   0,$t5
        jump.i  #lab6                   ;jump.i  lab6
lab5:
        mov.i   #1,180                  ;mov.i   1,$t5
lab6:
        mov.i   180,36                  ;mov.i   $t5,o
        jle.i   0,76,#lab7              ;jle.i   i,p,lab7
        mov.i   #0,184                  ;mov.i   0,$t6
        jump.i  #lab8                   ;jump.i  lab8
lab7:
        mov.i   #1,184                  ;mov.i   1,$t6
lab8:
        inttoreal.i 184,188             ;inttoreal.i $t6,$t7
        mov.r   188,76                  ;mov.r   $t7,p
        sub.i   #9,#1,196               ;sub.i   9,1,$t8
        mul.i   196,#8,196              ;mul.i   $t8,8,$t8
        add.i   #76,196,200             ;add.i   &p,$t8,$t9
        je.r    *200,36,#lab9           ;je.r    $t9,o,lab9
        mov.i   #0,204                  ;mov.i   0,$t10
        jump.i  #lab10                  ;jump.i  lab10
lab9:
        mov.i   #1,204                  ;mov.i   1,$t10
lab10:
        mov.i   204,36                  ;mov.i   $t10,o
        jne.i   0,36,#lab11             ;jne.i   i,o,lab11
        mov.i   #0,208                  ;mov.i   0,$t11
        jump.i  #lab12                  ;jump.i  lab12
lab11:
        mov.i   #1,208                  ;mov.i   1,$t11
lab12:
        inttoreal.i 208,212             ;inttoreal.i $t11,$t12
        mov.r   212,12                  ;mov.r   $t12,x
        jg.r    12,8,#lab13             ;jg.r    x,k,lab13
        mov.i   #0,220                  ;mov.i   0,$t13
        jump.i  #lab14                  ;jump.i  lab14
lab13:
        mov.i   #1,220                  ;mov.i   1,$t13
lab14:
        mov.i   220,0                   ;mov.i   $t13,i
        sub.i   #3,#1,224               ;sub.i   3,1,$t14
        mul.i   224,#8,224              ;mul.i   $t14,8,$t14
        add.i   #76,224,228             ;add.i   &p,$t14,$t15
        sub.i   #2,#1,232               ;sub.i   2,1,$t16
        mul.i   232,#4,232              ;mul.i   $t16,4,$t16
        add.i   #36,232,236             ;add.i   &o,$t16,$t17
        jg.r    12,*236,#lab15          ;jg.r    x,$t17,lab15
        mov.i   #0,240                  ;mov.i   0,$t18
        jump.i  #lab16                  ;jump.i  lab16
lab15:
        mov.i   #1,240                  ;mov.i   1,$t18
lab16:
        inttoreal.i 240,244             ;inttoreal.i $t18,$t19
        mov.r   244,*228                ;mov.r   $t19,$t15
        jl.r    76,12,#lab17            ;jl.r    p,x,lab17
        mov.i   #0,252                  ;mov.i   0,$t20
        jump.i  #lab18                  ;jump.i  lab18
lab17:
        mov.i   #1,252                  ;mov.i   1,$t20
lab18:
        mov.i   252,36                  ;mov.i   $t20,o
        sub.i   #1,#1,256               ;sub.i   1,1,$t21
        mul.i   256,#8,256              ;mul.i   $t21,8,$t21
        add.i   #76,256,260             ;add.i   &p,$t21,$t22
        jle.r   *260,0,#lab19           ;jle.r   $t22,i,lab19
        mov.i   #0,264                  ;mov.i   0,$t23
        jump.i  #lab20                  ;jump.i  lab20
lab19:
        mov.i   #1,264                  ;mov.i   1,$t23
lab20:
        inttoreal.i 264,268             ;inttoreal.i $t23,$t24
        mov.r   268,12                  ;mov.r   $t24,x
        jle.r   76,0,#lab21             ;jle.r   p,i,lab21
        mov.i   #0,276                  ;mov.i   0,$t25
        jump.i  #lab22                  ;jump.i  lab22
lab21:
        mov.i   #1,276                  ;mov.i   1,$t25
lab22:
        jl.i    8,28,#lab23             ;jl.i    k,z,lab23
        mov.i   #0,280                  ;mov.i   0,$t26
        jump.i  #lab24                  ;jump.i  lab24
lab23:
        mov.i   #1,280                  ;mov.i   1,$t26
lab24:
        and.i   276,280,284             ;and.i   $t25,$t26,$t27
        jl.i    36,12,#lab25            ;jl.i    o,x,lab25
        mov.i   #0,288                  ;mov.i   0,$t28
        jump.i  #lab26                  ;jump.i  lab26
lab25:
        mov.i   #1,288                  ;mov.i   1,$t28
lab26:
        or.i    284,288,292             ;or.i    $t27,$t28,$t29
        sub.i   #1,#1,296               ;sub.i   1,1,$t30
        mul.i   296,#4,296              ;mul.i   $t30,4,$t30
        add.i   #36,296,300             ;add.i   &o,$t30,$t31
        and.i   292,*300,304            ;and.i   $t29,$t31,$t32
        sub.i   #2,#1,308               ;sub.i   2,1,$t33
        mul.i   308,#8,308              ;mul.i   $t33,8,$t33
        add.i   #76,308,312             ;add.i   &p,$t33,$t34
        jne.i   304,*312,#lab27         ;jne.i   $t32,$t34,lab27
        mov.i   #0,316                  ;mov.i   0,$t35
        jump.i  #lab28                  ;jump.i  lab28
lab27:
        mov.i   #1,316                  ;mov.i   1,$t35
lab28:
        inttoreal.i 316,320             ;inttoreal.i $t35,$t36
        mov.r   320,76                  ;mov.r   $t36,p
        realtoint.r 20,328              ;realtoint.r y,$t37
        je.i    328,#0,#lab29           ;je.i    $t37,0,lab29
        mov.i   #0,332                  ;mov.i   0,$t38
        jump.i  #lab30                  ;jump.i  lab30
lab29:
        mov.i   #1,332                  ;mov.i   1,$t38
lab30:
        mov.r   332,12                  ;mov.r   $t38,x
        je.i    0,#0,#lab31             ;je.i    i,0,lab31
        mov.i   #0,340                  ;mov.i   0,$t39
        jump.i  #lab32                  ;jump.i  lab32
lab31:
        mov.i   #1,340                  ;mov.i   1,$t39
lab32:
        add.i   340,#25,344             ;add.i   $t39,25,$t40
        inttoreal.i 344,348             ;inttoreal.i $t40,$t41
        mov.r   348,20                  ;mov.r   $t41,y
        realtoint.r 20,356              ;realtoint.r y,$t42
        je.i    356,#0,#lab33           ;je.i    $t42,0,lab33
        mov.i   #0,360                  ;mov.i   0,$t43
        jump.i  #lab34                  ;jump.i  lab34
lab33:
        mov.i   #1,360                  ;mov.i   1,$t43
lab34:
        inttoreal.i #5,368              ;inttoreal.i 5,$t44
        mul.r   360,368,376             ;mul.r   $t43,$t44,$t45
        realtoint.r 376,384             ;realtoint.r $t45,$t46
        mov.i   384,0                   ;mov.i   $t46,i
        je.i    0,#0,#lab35             ;je.i    i,0,lab35
        mov.i   #0,388                  ;mov.i   0,$t47
        jump.i  #lab36                  ;jump.i  lab36
lab35:
        mov.i   #1,388                  ;mov.i   1,$t47
lab36:
        mov.i   388,0                   ;mov.i   $t47,i
        sub.i   #2,#1,392               ;sub.i   2,1,$t48
        mul.i   392,#8,392              ;mul.i   $t48,8,$t48
        add.i   #76,392,396             ;add.i   &p,$t48,$t49
        realtoint.r 12,400              ;realtoint.r x,$t50
        je.i    400,#0,#lab37           ;je.i    $t50,0,lab37
        mov.i   #0,404                  ;mov.i   0,$t51
        jump.i  #lab38                  ;jump.i  lab38
lab37:
        mov.i   #1,404                  ;mov.i   1,$t51
lab38:
        mov.r   404,*396                ;mov.r   $t51,$t49
        sub.i   #2,#1,412               ;sub.i   2,1,$t52
        mul.i   412,#8,412              ;mul.i   $t52,8,$t52
        add.i   #76,412,416             ;add.i   &p,$t52,$t53
        sub.i   #1,#1,420               ;sub.i   1,1,$t54
        mul.i   420,#4,420              ;mul.i   $t54,4,$t54
        add.i   #36,420,424             ;add.i   &o,$t54,$t55
        je.i    *424,#0,#lab39          ;je.i    $t55,0,lab39
        mov.i   #0,428                  ;mov.i   0,$t56
        jump.i  #lab40                  ;jump.i  lab40
lab39:
        mov.i   #1,428                  ;mov.i   1,$t56
lab40:
        inttoreal.i 428,432             ;inttoreal.i $t56,$t57
        mov.r   432,*416                ;mov.r   $t57,$t53
        sub.i   #10,#1,440              ;sub.i   10,1,$t58
        mul.i   440,#8,440              ;mul.i   $t58,8,$t58
        add.i   #76,440,444             ;add.i   &p,$t58,$t59
        realtoint.r *444,448            ;realtoint.r $t59,$t60
        je.i    448,#0,#lab41           ;je.i    $t60,0,lab41
        mov.i   #0,452                  ;mov.i   0,$t61
        jump.i  #lab42                  ;jump.i  lab42
lab41:
        mov.i   #1,452                  ;mov.i   1,$t61
lab42:
        realtoint.r 452,460             ;realtoint.r $t61,$t62
        mov.i   460,0                   ;mov.i   $t62,i
        sub.i   #0,#10,464              ;sub.i   0,10,$t63
        mov.i   464,0                   ;mov.i   $t63,i
        sub.r   #0,#1.205,468           ;sub.r   0,1.205,$t64
        realtoint.r 468,476             ;realtoint.r $t64,$t65
        mov.i   476,0                   ;mov.i   $t65,i
        sub.i   #0,8,480                ;sub.i   0,k,$t66
        inttoreal.i 480,484             ;inttoreal.i $t66,$t67
        mov.r   484,12                  ;mov.r   $t67,x
        sub.r   #0,20,492               ;sub.r   0,y,$t68
        realtoint.r 492,500             ;realtoint.r $t68,$t69
        mov.i   500,8                   ;mov.i   $t69,k
        sub.i   #1,#1,504               ;sub.i   1,1,$t70
        mul.i   504,#8,504              ;mul.i   $t70,8,$t70
        add.i   #76,504,508             ;add.i   &p,$t70,$t71
        sub.i   #0,#1,512               ;sub.i   0,1,$t72
        inttoreal.i 512,516             ;inttoreal.i $t72,$t73
        mov.r   516,*508                ;mov.r   $t73,$t71
        sub.i   #2,#1,524               ;sub.i   2,1,$t74
        mul.i   524,#8,524              ;mul.i   $t74,8,$t74
        add.i   #76,524,528             ;add.i   &p,$t74,$t75
        sub.r   #0,#2.5,532             ;sub.r   0,2.5,$t76
        mov.r   532,*528                ;mov.r   $t76,$t75
        exit                            ;exit    
