        jump.i  #lab0                   ;jump.i  lab0
lab0:
        sub.i   #0,#1,0                 ;sub.i   0,1,$t0
        write.i 0                       ;write.i $t0
        exit                            ;exit    
