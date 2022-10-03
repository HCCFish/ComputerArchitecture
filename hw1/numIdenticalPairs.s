.data
nums1: .word   1,3,2,1,3,3
len1:  .word   6
nums2: .word   99,2,3,56,0,2,56,99
len2:  .word   8
nums3: .word   0,5,6,32,1,0,1,0,0,6,32,0,5,5
len3:  .word   14
.text

main:
    la     s1, nums1       # s1 = nums[];  // set s1 as first pointer started from nums[0]
    lw     s2, len1        # s2 = len;     // length of the array
    li     s3, 0           # s3 = 0;       // count = 0
    slli   s4, s2 ,2       # s4 = len * 4  // find array address length
    add    s4, s1 ,s4      # s4 = nums+len * 4  //end address of the array
    addi   s6, s4 ,-4      # s6 = s4 - 4   //eazy for compare 
for1: 
    beq    s1, s6, print   # when first pointer move to the last of the array, end the loop
    addi   s5, s1 ,4       # set s5 as second pointer started from next of first pointer 
    jal    for2            # call for2 and store current place in $ra
    addi   s1, s1, 4       # move first pointer
    j      for1            # for1 loop
for2:   
    beq    s5, s4 ,return  # when second pointer move outside of the array, return to for1
    addi   sp, sp ,-4      # add a new word for stack
    sw     ra, 0(sp)       # store $ra in stack first before it reuse
    jal    if              # this instrution will reuse $ra and jump to if: 
    lw     ra, 0(sp)       # restore $ra in stack 
    addi   sp, sp ,4       # delete a word of stack 
    addi   s5, s5 ,4       # move second pointer
    j      for2            # for2 loop
if:
    lw     t1, 0(s1)       # t1 = *s1      // data at first pointer
    lw     t2, 0(s5)       # t2 = *s2      // data at second pointer
    bne    t1, t2, return  # if t1≠t2 then skip next instruction and return
    addi   s3, s3, 1       # if t1=t2 then count=count+1
return:
    jr     ra              #return to caller
# --- print ---
print:
    mv a0, s3
    li a7, 1               #print the value of a0 as a signed integer
    ecall
