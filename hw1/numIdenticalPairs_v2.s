.data
nums1: .word   1,3,2,1,3,3
len1:  .word   6
nums2: .word   99,2,3,56,0,2,56,99
len2:  .word   8
nums3: .word   2,5,6,100,1,2,1,2,2,6,100,2,5,5
len3:  .word   14

.text
main:
    la     s1, nums3       # s1 = nums[];  // set s1 as first pointer started from nums[0]
    lw     s2, len3        # s2 = len;     // length of the array
    li     s3, 0           # s3 = 0;       // count = 0
    addi   sp, sp, -100
    mv     s0, sp
    li     t0, 0
    jal    initialize_array
    li     s4, 0
    
for: 
    bge    s4, s2, print   # when first pointer move to the last of the array, end the loop
    slli   s5, s4, 2 ####
    add    s5, s5, s1
    lw     s5, 0(s5)
    addi   s5, s5, -1
    add    s5, s5, s0
    lbu    s6, 0(s5)
    ble    s6, x0, ifn
    add    s3, s3, s6  ######t0        
ifn:
    addi   s6, s6, 1
    sb     s6, 0(s5)
    addi   s4, s4, 1 ####
    j      for            # for1 loop
    
initialize_array:
    add    t1, t0, s0
    sw     x0,  0(t1)
    addi   t0, t0, 4
    slti   t2, t0, 100 
    bnez   t2, initialize_array     
    jr     ra
# --- print ---
print:
    mv a0, s3
    li a7, 1
    ecall
