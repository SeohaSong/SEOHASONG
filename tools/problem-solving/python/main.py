num_n = int(input())
nums = [int(v) for v in input().split()[:num_n] if v]

sel_n = 0
sels = [0] * num_n
for num in nums:

    bgn_idx = 0
    end_idx = sel_n
    while bgn_idx != end_idx:
        idx = (bgn_idx + end_idx) // 2
        sel = sels[idx]
        if num <= sel:
            end_idx = idx
        else:
            bgn_idx = idx + 1
    
    sels[bgn_idx] = num
    if bgn_idx == sel_n:
        sel_n += 1

print(sel_n)
