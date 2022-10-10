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
    addi   sp, sp, -100    # 
    mv     s0, sp          # save the address of the array
    li     t0, 0           # t0 use for count byte address in initialize_array
    jal    initialize_array # jump and link to the function
    li     s4, 0           # s4 is the i in c code, use for count iteration
    
for: 
    bge    s4, s2, print   # when first pointer move to the last of the array, end the loop
    slli   s5, s4, 2       # S5 = S4 * 4   
    add    s5, s5, s1      # find address of num[i]
    lw     s5, 0(s5)       # load word in num[i]
    addi   s5, s5, -1      # mapping num from range 1~100 to 0~99 in case to perfactly fit in memory
    add    s5, s5, s0      # add space array address to find the byte address
    lbu    s6, 0(s5)       # load unsigned byte from address
    ble    s6, x0, ifn     # if s6 bigger than 0 do next instruction if not skip next line
    add    s3, s3, s6      # same instruction as "count+=space[nums[i]]"
ifn:
    addi   s6, s6, 1       # mapping num from range 0~99 back to 1~100
    sb     s6, 0(s5)       # save byte back in memory
    addi   s4, s4, 1       # interation count
    j      for             # for1 loop
    
initialize_array:
    add    t1, t0, s0      # find address
    sw     x0,  0(t1)      # save 4 bytes as 0
    addi   t0, t0, 4       # move address to next word(4 bytes)
    slti   t2, t0, 100     # set t2=1 if t0<100 else t2 =0
    bnez   t2, initialize_array #use t2 to find if initialization end.
    jr     ra              # return caller
# --- print ---
print:
    mv a0, s3
    li a7, 1               #print the value of a0 as a signed integer
    ecall
