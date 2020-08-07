        jump.i  #lab0                   ;jump.i  lab0
lab0:
        add.r   0,0,132                 ;add.r   a,a,$t0
        write.r 132                     ;write.r $t0
        inttoreal.i 8,140               ;inttoreal.i b,$t1
        add.r   0,140,148               ;add.r   a,$t1,$t2
        write.r 148                     ;write.r $t2
        add.i   12,12,156               ;add.i   x,x,$t3
        write.i 156                     ;write.i $t3
        add.r   52,52,160               ;add.r   y,y,$t4
        write.r 160                     ;write.r $t4
        inttoreal.i 12,168              ;inttoreal.i x,$t5
        add.r   168,52,176              ;add.r   $t5,y,$t6
        write.r 176                     ;write.r $t6
        inttoreal.i 12,184              ;inttoreal.i x,$t7
        add.r   0,184,192               ;add.r   a,$t7,$t8
        write.r 192                     ;write.r $t8
        inttoreal.i 8,200               ;inttoreal.i b,$t9
        add.r   200,52,208              ;add.r   $t9,y,$t10
        write.r 208                     ;write.r $t10
        add.i   8,12,216                ;add.i   b,x,$t11
        write.i 216                     ;write.i $t11
        inttoreal.i 8,220               ;inttoreal.i b,$t12
        add.r   220,52,228              ;add.r   $t12,y,$t13
        write.r 228                     ;write.r $t13
        div.r   0,0,236                 ;div.r   a,a,$t14
        write.r 236                     ;write.r $t14
        inttoreal.i 8,244               ;inttoreal.i b,$t15
        div.r   244,0,252               ;div.r   $t15,a,$t16
        write.r 252                     ;write.r $t16
        inttoreal.i 12,260              ;inttoreal.i x,$t17
        div.r   260,0,268               ;div.r   $t17,a,$t18
        write.r 268                     ;write.r $t18
        div.i   12,8,276                ;div.i   x,b,$t19
        write.i 276                     ;write.i $t19
        div.r   52,0,280                ;div.r   y,a,$t20
        write.r 280                     ;write.r $t20
        inttoreal.i 8,288               ;inttoreal.i b,$t21
        div.r   52,288,296              ;div.r   y,$t21,$t22
        write.r 296                     ;write.r $t22
        and.r   0,0,304                 ;and.r   a,a,$t23
        write.r 304                     ;write.r $t23
        inttoreal.i 8,312               ;inttoreal.i b,$t24
        and.r   312,0,320               ;and.r   $t24,a,$t25
        write.r 320                     ;write.r $t25
        inttoreal.i 12,328              ;inttoreal.i x,$t26
        and.r   0,328,336               ;and.r   a,$t26,$t27
        write.r 336                     ;write.r $t27
        and.r   0,52,344                ;and.r   a,y,$t28
        write.r 344                     ;write.r $t28
        and.i   8,12,352                ;and.i   b,x,$t29
        write.i 352                     ;write.i $t29
        inttoreal.i 8,356               ;inttoreal.i b,$t30
        and.r   356,52,364              ;and.r   $t30,y,$t31
        write.r 364                     ;write.r $t31
        inttoreal.i 12,372              ;inttoreal.i x,$t32
        or.r    0,372,380               ;or.r    a,$t32,$t33
        write.r 380                     ;write.r $t33
        or.r    0,52,388                ;or.r    a,y,$t34
        write.r 388                     ;write.r $t34
        or.i    8,12,396                ;or.i    b,x,$t35
        write.i 396                     ;write.i $t35
        inttoreal.i 8,400               ;inttoreal.i b,$t36
        or.r    400,52,408              ;or.r    $t36,y,$t37
        write.r 408                     ;write.r $t37
        inttoreal.i 12,416              ;inttoreal.i x,$t38
        or.r    416,52,424              ;or.r    $t38,y,$t39
        write.r 424                     ;write.r $t39
        inttoreal.i 12,432              ;inttoreal.i x,$t40
        div.r   0,432,440               ;div.r   a,$t40,$t41
        write.r 440                     ;write.r $t41
        div.r   0,52,448                ;div.r   a,y,$t42
        write.r 448                     ;write.r $t42
        div.i   8,12,456                ;div.i   b,x,$t43
        write.i 456                     ;write.i $t43
        inttoreal.i 8,460               ;inttoreal.i b,$t44
        div.r   460,52,468              ;div.r   $t44,y,$t45
        write.r 468                     ;write.r $t45
        inttoreal.i 12,476              ;inttoreal.i x,$t46
        div.r   476,52,484              ;div.r   $t46,y,$t47
        write.r 484                     ;write.r $t47
        inttoreal.i 12,492              ;inttoreal.i x,$t48
        mod.r   0,492,500               ;mod.r   a,$t48,$t49
        write.r 500                     ;write.r $t49
        mod.r   0,52,508                ;mod.r   a,y,$t50
        write.r 508                     ;write.r $t50
        mod.i   8,12,516                ;mod.i   b,x,$t51
        write.i 516                     ;write.i $t51
        inttoreal.i 8,520               ;inttoreal.i b,$t52
        mod.r   520,52,528              ;mod.r   $t52,y,$t53
        write.r 528                     ;write.r $t53
        inttoreal.i 12,536              ;inttoreal.i x,$t54
        mod.r   536,52,544              ;mod.r   $t54,y,$t55
        write.r 544                     ;write.r $t55
        sub.r   #0,0,552                ;sub.r   0,a,$t56
        write.r 552                     ;write.r $t56
        sub.i   #0,8,560                ;sub.i   0,b,$t57
        write.i 560                     ;write.i $t57
        sub.i   #0,12,564               ;sub.i   0,x,$t58
        write.i 564                     ;write.i $t58
        sub.r   #0,52,568               ;sub.r   0,y,$t59
        write.r 568                     ;write.r $t59
        sub.r   #0,0,576                ;sub.r   0,a,$t60
        inttoreal.i 12,584              ;inttoreal.i x,$t61
        add.r   576,584,592             ;add.r   $t60,$t61,$t62
        write.r 592                     ;write.r $t62
        sub.i   #0,8,600                ;sub.i   0,b,$t63
        inttoreal.i 600,604             ;inttoreal.i $t63,$t64
        add.r   604,0,612               ;add.r   $t64,a,$t65
        write.r 612                     ;write.r $t65
        sub.i   #0,12,620               ;sub.i   0,x,$t66
        inttoreal.i 620,624             ;inttoreal.i $t66,$t67
        add.r   624,52,632              ;add.r   $t67,y,$t68
        write.r 632                     ;write.r $t68
        sub.r   #0,52,640               ;sub.r   0,y,$t69
        inttoreal.i #3,648              ;inttoreal.i 3,$t70
        add.r   640,648,656             ;add.r   $t69,$t70,$t71
        write.r 656                     ;write.r $t71
        realtoint.r 0,664               ;realtoint.r a,$t72
        je.i    664,#0,#lab1            ;je.i    $t72,0,lab1
        mov.i   #0,668                  ;mov.i   0,$t73
        jump.i  #lab2                   ;jump.i  lab2
lab1:
        mov.i   #1,668                  ;mov.i   1,$t73
lab2:
        write.r 668                     ;write.r $t73
        je.i    8,#0,#lab3              ;je.i    b,0,lab3
        mov.i   #0,676                  ;mov.i   0,$t74
        jump.i  #lab4                   ;jump.i  lab4
lab3:
        mov.i   #1,676                  ;mov.i   1,$t74
lab4:
        write.i 676                     ;write.i $t74
        je.i    12,#0,#lab5             ;je.i    x,0,lab5
        mov.i   #0,680                  ;mov.i   0,$t75
        jump.i  #lab6                   ;jump.i  lab6
lab5:
        mov.i   #1,680                  ;mov.i   1,$t75
lab6:
        write.i 680                     ;write.i $t75
        realtoint.r 52,684              ;realtoint.r y,$t76
        je.i    684,#0,#lab7            ;je.i    $t76,0,lab7
        mov.i   #0,688                  ;mov.i   0,$t77
        jump.i  #lab8                   ;jump.i  lab8
lab7:
        mov.i   #1,688                  ;mov.i   1,$t77
lab8:
        write.r 688                     ;write.r $t77
        je.i    12,#0,#lab9             ;je.i    x,0,lab9
        mov.i   #0,696                  ;mov.i   0,$t78
        jump.i  #lab10                  ;jump.i  lab10
lab9:
        mov.i   #1,696                  ;mov.i   1,$t78
lab10:
        je.i    696,#0,#lab11           ;je.i    $t78,0,lab11
        mov.i   #0,700                  ;mov.i   0,$t79
        jump.i  #lab12                  ;jump.i  lab12
lab11:
        mov.i   #1,700                  ;mov.i   1,$t79
lab12:
        je.i    700,#0,#lab13           ;je.i    $t79,0,lab13
        mov.i   #0,704                  ;mov.i   0,$t80
        jump.i  #lab14                  ;jump.i  lab14
lab13:
        mov.i   #1,704                  ;mov.i   1,$t80
lab14:
        je.i    704,#0,#lab15           ;je.i    $t80,0,lab15
        mov.i   #0,708                  ;mov.i   0,$t81
        jump.i  #lab16                  ;jump.i  lab16
lab15:
        mov.i   #1,708                  ;mov.i   1,$t81
lab16:
        write.i 708                     ;write.i $t81
        exit                            ;exit    
