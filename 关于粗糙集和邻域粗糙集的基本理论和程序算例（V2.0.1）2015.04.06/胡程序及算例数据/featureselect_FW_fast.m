%程序描述：featureselect_FW_fast.m,按分类效率对属性进行选择，前向方法,快速算法---------优化算法,
%邻域依赖性指标计算复杂度。
%efficiency：the significance of the selected features。
%data_array：Input data with decision ranked in the last column
%delta：the size of neighborhood. generally speaking, delta=[0.1,0.2]
%efc_ctrl：The threshold to stop the search. The search is stoped if the increment introduced with every new feature is less than efc_ctrl.  
%fun_dpd：This parameter selects the strategies of computing attribute
%significance. 用于计算属性重要度的函数，在此程序中已经指定了，不需要再选择。
% fun_dpd should be cited with single quotation marks，for example, 'clsf_dpd_fast'.
function [feature_slct,efficiency]=featureselect_FW_fast(data_array,delta,efc_ctrl)%,fun_dpd)
[m,n]=size(data_array);
feature_slct=[];
efficiency=0;
feature_lft=(1:n-1);
sample_lft=(1:m);
sample_all=(1:m);
smp_csst_all=[];
array_cur=[];
num_cur=0;
while num_cur<n-1 
    if num_cur==0
        array_cur=[];
    else
        array_cur(:,num_cur)=data_array(:,feature_slct(num_cur));%将新选中的属性对应数据列加到原有表中
    end
    %开始进行组合
    dpd_tmp=[];
    smp_csst_tmp=[];
    for i=1:length(feature_lft)
        array_tmp=array_cur;%是指 将新选中的属性对应数据列加到原有表中，后赋给array_tmp的，然后进入属性依赖度的计算子程序
        array_tmp(:,[num_cur+1,num_cur+2])=data_array(:,[feature_lft(i),n]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%不同的策略，速度有差别
        %switch fun_dpd
        %    case 'clsf_dpd_fast'      %优化算法,距离计算完了,2范数----较快
        %        [w,e]=clsf_dpd_fast(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd_fast2'     %优化算法,距离没计算完,2范数----最快
        %        [w,e]=clsf_dpd_fast2(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd'           %优化算法,速度慢，用于对比,2范数----最慢
        %        [w,e]=clsf_dpd(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd_fast_3'    %优化算法,无穷范数
        %        [w,e]=clsf_dpd_fast_3(array_tmp,delta,sample_lft);
            %case 'Copy_of_clsf_dpd_fast_3'                              %自己补充的算法 用于修正data_array没有被定义的错误
                [w,e]=Copy_of_clsf_dpd_fast_3(array_tmp,delta,sample_lft);%%%  输出的w是dependency，输出的e是smp_csst？？？？
        %end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%继续        
        dpd_tmp(i)=w;
        if length(e)~=0
            smp_csst_tmp(i,(1:length(e)))=e;
        end
    end
 %%%%%%%%%%%%%%%输出单个属性的重要度%%%%%%%%%%%%%%%%%%%%%%%%  
% dpd_tmp
%    bar(dpd_tmp);
% pause
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    [max_dpd,max_sequence1]=max(dpd_tmp);
    if num_cur>0 & dpd_tmp<efc_ctrl
        num_cur=n-1;
    else
        if max_dpd>0 | num_cur>0
            if num_cur==0
                efficiency(1)=max_dpd;
            else
                efficiency(num_cur+1)=efficiency(num_cur)+max_dpd;
            end
            feature_slct(num_cur+1)=feature_lft(max_sequence1);    
            if length(smp_csst_tmp)~=0
                smp_csst_all=[smp_csst_all,smp_csst_tmp(max_sequence1,:)];
            end
            sample_lft=sample_all;
            sample_lft(smp_csst_all)=[];
            feature_lft(max_sequence1)=[];
            num_cur=num_cur+1; 
        else
            num_cur=n-1;
        end
    end
end

