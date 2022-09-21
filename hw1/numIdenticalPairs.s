.data
nums: .word 1,2,3,1,3,3
len: .word 6

.text


main:
    la     s1, nums        # s1 = nums[];  // array
    lw     s2, len         # s2 = len;     // length of the array
    li     s3, 0
    slli   s4, s2 ,2       # s4 = len * 4
    add    s4, s1 ,s4      # s4 = nums+len * 4  //end address of the array  
for1:    
    addi   s5, s1 ,4
    lw     t1, 0(s1)
    addi   s1, s1, 4
    beq    s1, s4, print
for2:   
    beq    s5, s4 ,for1
    lw     t2, 0(s5)
    addi   s5, s5 ,4
    bne    t1, t2, for2
    addi   s3, s3, 1
    j      for2

    
# --- print ---
print:
    mv a0, s3
    li a7, 1
    ecall
