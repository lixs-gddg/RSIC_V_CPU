.text
j main_function

#关卡1地图生成#
grade_1:
bne t2, zero, mode1_closed

li s8 0x40001
sw s8, 0(zero)
   
li s8, 0x40040
sw s8, 4(zero)

li s8, 0x3fe4ffff
sw s8, 8(zero)
     
li s8, 0x240004
sw s8, 12(zero)
  
li s8, 0x240004
sw s8, 16(zero)

li s8, 0x3aa7f924
sw s8, 20(zero)
 
li s8, 0xaa00124
sw s8, 24(zero)
   
li s8, 0xaa00124
sw s8, 28(zero)

li s8, 0xfabfff24
sw s8, 32(zero)

li s8, 0x2820024
sw s8, 36(zero)

li s8, 0x3aa60024
sw s8, 40(zero)

li s8, 0x2efa7fe4
sw s8, 44(zero)

li s8, 0x20120020
sw s8, 48(zero)

li s8, 0x2ff20020
sw s8, 52(zero)
  
li s8, 0x2443ff3f
sw s8, 56(zero)

li s8, 0x21120020
sw s8, 60(zero)

li s8, 0x27f20020
sw s8, 64(zero)

li s8, 0x24127f24
sw s8, 68(zero)
 
li s8, 0x20120124
sw s8, 72(zero)

li s8, 0x20f20124
sw s8, 76(zero)

li s8, 0x3c83ff24
sw s8, 80(zero)

li s8, 0x4820004
sw s8, 84(zero)
 
li s8, 0x4920004
sw s8, 88(zero)

li s8, 0xe4927ffc
sw s8, 92(zero)

li s8, 0x24904000
sw s8, 96(zero)

li s8, 0x24904000
sw s8, 100(zero)

li s8, 0x249fcfff
sw s8, 104(zero)

li s8, 0x4800000
sw s8, 108(zero)

li s8, 0x4800000
sw s8, 112(zero)

li s8, 0xfcffffcf
sw s8, 116(zero)

li s8, 0x800000
sw s8, 120(zero)

li s8, 0x800000
sw s8, 124(zero)

addi   a7,zero,34
ecall

addi t2, zero, 1

mode1_closed:
uret


#关卡2地图生成#
grade_2:
bne t2, zero, mode2_closed

li s8, 0x1
sw s8, 0(zero)

li s8, 0x6efd7ffc
sw s8, 4(zero)

li s8, 0x11008002
sw s8, 8(zero)

li s8, 0xd35f1fda
sw s8, 12(zero)
 
li s8, 0x14802022
sw s8, 16(zero)
 
li s8, 0x527fc72a
sw s8, 20(zero)
 
li s8, 0x488008aa
sw s8, 24(zero)
 
li s8, 0x447df28c
sw s8, 28(zero)

li s8, 0x52800252
sw s8, 32(zero)

li s8, 0x249fdc2a
sw s8, 36(zero)

li s8, 0x50a022a2
sw s8, 40(zero)

li s8, 0x3c992aac
sw s8, 44(zero)
 
li s8, 0x4282aaa0
sw s8, 48(zero)

li s8, 0x527aa91a
sw s8, 52(zero)
 
li s8, 0xa8840822
sw s8, 56(zero)
 
li s8, 0x72d04a4
sw s8, 60(zero)
 
li s8, 0x4022224a
sw s8, 64(zero)
 
li s8, 0x535a498a
sw s8, 68(zero)
 
li s8, 0x54849022
sw s8, 72(zero)

li s8, 0x5562abdc
sw s8, 76(zero)

li s8, 0x55480402
sw s8, 80(zero)

li s8, 0x5152a972
sw s8, 84(zero)
 
li s8, 0x2e251484
sw s8, 88(zero)
  
li s8, 0x409222b8
sw s8, 92(zero)

li s8, 0x39294484
sw s8, 96(zero)

li s8, 0x4a25112
sw s8, 100(zero)

li s8, 0xd69892aa
sw s8, 104(zero)

li s8, 0x12831442
sw s8, 108(zero)

li s8, 0x727c695c
sw s8, 112(zero)

li s8, 0xa008110
sw s8, 116(zero)

li s8, 0xe9ff1ee4
sw s8, 120(zero)

li s8, 0x8006002
sw s8, 124(zero)

addi   a7,zero,34
ecall

addi t2, zero, 1

mode2_closed:
uret



#上下左右中断程序#
#使用寄存器：s1-s7，坐标：t0-t1
# t0 X   t1 Y
#ecall a7=100,报警

#中断程序左：
interrupt_left:

#在生成地图时移动无效
beq t2, zero, step1_closed

#边界判断
addi s8, zero, 31
beq t0, s8, border  

addi s1, zero, 1
add s2, t0, s1
sll s3, s1, s2 
slli s4, t1, 2     
lw  s5, 0(s4)     
and s6 , s5, s3
bne s6, zero, wall  #判断是否会撞墙


add t0, t0, s1   #不会撞墙就移动光点，下面的程序都类似
or s5, s5, s3    
srli s3, s3, 1
xor s5, s5, s3   
sw s5, 0(s4)      
addi a7, zero, 34    
ecall

addi s7, zero, 31
beq t0, s7, next_judge1
uret
next_judge1:
beq t1, s7, game_success
step1_closed:
uret



interrupt_right:

beq t2, zero, step2_closed


beq t0, zero, border

addi s1, zero, 1   
sub s2, t0, s1
sll s3, s1, s2  
slli s4, t1, 2     
lw  s5, 0(s4)     
and s6 , s5, s3
bne s6, zero, wall   


sub t0, t0, s1   
or s5, s5, s3    
slli s3, s3, 1
xor s5, s5, s3   
sw s5, 0(s4)      
addi a7, zero, 34    
ecall

addi s7, zero, 31
beq t0, s7, next_judge2
uret
next_judge2:
beq t1, s7, game_success
step2_closed:
uret




interrupt_down:


beq t2, zero, step3_closed


addi s8, zero, 31
beq t1, s8, border  

addi s1, zero, 1     
add s2, t0, zero
sll s3, s1, s2 
add s7, t1, s1 
slli s4, s7, 2    
lw  s5, 0(s4)    
and s6 , s5, s3
bne s6, zero, wall  


add t1, t1, s1   
or s5, s5, s3    
sw s5, 0(s4)      
#srl s3, s3, 1
addi s4, s4, -4     
lw s5, 0(s4)
xor s5, s5, s3  
sw s5, 0(s4)      
addi a7, zero, 34    
ecall

addi s7, zero, 31
beq t0, s7, next_judge3
uret
next_judge3:
beq t1, s7, game_success
step3_closed:
uret


interrupt_up:

beq t2, zero, step4_closed

beq t1, zero, border 
addi s1, zero, 1     
add s2, t0, zero
sll s3, s1, s2  
sub s7, t1, s1   
slli s4, s7, 2     
lw  s5, 0(s4)     
and s6 , s5, s3
bne s6, zero, wall  

sub t1, t1, s1   
or s5, s5, s3    
sw s5, 0(s4)      
#srl s3, s3, 1
addi s4, s4, 4     
lw s5, 0(s4)
xor s5, s5, s3  
sw s5, 0(s4)      
addi a7, zero, 34    
ecall


addi s7, zero, 31
beq t0, s7, next_judge4
uret
next_judge4:
beq t1, s7, game_success
step4_closed:
uret


border: 
wall:    
#ecall a7=100，报警
addi a7, zero, 100    
ecall
uret




main_function:

addi t0, zero, 0  #X
addi t1, zero, 0  #Y
#加载开始游戏时的提示
li s8, 0x557700
sw s8, 0(zero)

li s8, 0x554200
sw s8, 4(zero)

li s8, 0x757200
sw s8, 8(zero)

li s8, 0x551200
sw s8, 12(zero)

li s8, 0x577200
sw s8, 16(zero)

li s8, 0x11087cf8
sw s8, 28(zero)

li s8, 0x1b140880
sw s8, 32(zero)

li s8, 0x153e10f8
sw s8, 36(zero)
  
li s8, 0x11222080
sw s8, 40(zero)

li s8, 0x11227cf8
sw s8, 44(zero)
  
li s8, 0x60e4ea0
sw s8, 56(zero)

li s8, 0x208a8a0
sw s8, 60(zero)

li s8, 0x20eee40
sw s8, 64(zero)

li s8, 0x208a240
sw s8, 68(zero)

li s8, 0x74eae40
sw s8, 72(zero)

li s8, 0x70a4ec0
sw s8, 84(zero)

li s8, 0x10aaaa0
sw s8, 88(zero)
  
li s8, 0x70eeea0
sw s8, 92(zero)

li s8, 0x40aaca0
sw s8, 96(zero)

li s8, 0x74aaac0
sw s8, 100(zero)

addi   a7,zero,34
ecall
addi   t2,zero,0
nop_cycle:#空循环，等待中断按键
nop
nop
nop
nop
nop
j nop_cycle



#SUCCESS#

game_success:

addi t3, zero, 1  

li s8, 0x75777772
sw s8, 52(zero)
  
li s8, 0x45445442
sw s8, 56(zero)

li s8, 0x75447772
sw s8, 60(zero)

li s8, 0x15444110
sw s8, 64(zero)

li s8, 0x77777772
sw s8, 68(zero)

addi   a7,zero,34
ecall

j nop_cycle
