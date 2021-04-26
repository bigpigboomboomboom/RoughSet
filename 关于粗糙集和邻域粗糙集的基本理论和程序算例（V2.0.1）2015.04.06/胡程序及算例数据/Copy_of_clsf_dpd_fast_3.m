%程序描述：clsf_dpd_fast2,计算新加入的一个属性的依赖度,相比1，减少了邻域计算次数，但增加了前面的判断次数(no,no,no))---
%--------新思想+我的改进1+我的改进2
%5种情况：（每次是否检查全部样本、邻域样本是否全部检查、距离是否计算完）=>(yes，yes,yes)+(no，yes,yes)+(no，yes,n
%o)+(no,no,yes)+(no,no,no)
%data_array：标准化之后的数据,数组，列表示一个属性(包括决策属性)在不同样本上的取值，行表示一个样本在不同属性上的取值
%delta：邻域大小,固定值
%smp_chk:需判断类别的样本编号，新加入的属性只对这些样本有作用，因此计算的是新加入属性的依赖度
%%%suo 这里所说的标准化之后的数据实际上就是对数据进行归一化处理，归一化后的数据落入[0,1]之间。
%%%    需要强调的是：归一化处理，是需要对每个属性的数据进行单独的归一化处理。
%%%    否则，如果进行全局的归一化处理，结果还是会导致大数吞小数的后果。   索 2012.12.18
function [dependency,smp_csst]=Copy_of_clsf_dpd_fast_3(array_tmp,delta,smp_chk)
[m,n]=size(array_tmp);
num_rightclassified=0;
smp_csst=[];%%%     ？？？？
for i=1:length(smp_chk)
    %对于第i个样本,找到它的邻域
    sign=1;
    j=0;
    while j~=m
        j=j+1;
        in=1;
            k=0;    
            while k<n-1
                k=k+1;
                dist=abs(array_tmp(smp_chk(i),k)-array_tmp(j,k));
                if dist>delta(:,k)%这里需要对每个属性的delta邻域半径进行单独判断
                    k=n-1;
                    in=0;
                end
            end
            if in==1
                if array_tmp(j,n)~=array_tmp(smp_chk(i),n)
                    j=m;
                    sign=0;
                end
            end
    end
    if sign==1
        num_rightclassified=num_rightclassified+1;%%下近似的样本个数加1
        smp_csst=[smp_csst,smp_chk(i)];%smp_chk:需判断类别的样本编号，新加入的属性只对这些样本有作用，因此计算的是新加入属性的依赖度
    end
end
dependency=num_rightclassified/m;%输出依赖度，num_rightclassified是下近似（积极域）的样本个数 
            
            