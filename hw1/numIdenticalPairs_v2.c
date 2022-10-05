int numIdenticalPairs(int* nums, int numsSize){
    int space[101]={0}, count=0;
    for(int i=0;i<numsSize;i++){
        if(space[nums[i]]>0)
            count+=space[nums[i]];
        space[nums[i]]++;
    }
    return count;
}
