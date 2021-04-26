%����������featureselect_FW_fast.m,������Ч�ʶ����Խ���ѡ��ǰ�򷽷�,�����㷨---------�Ż��㷨,
%����������ָ����㸴�Ӷȡ�
%efficiency��the significance of the selected features��
%data_array��Input data with decision ranked in the last column
%delta��the size of neighborhood. generally speaking, delta=[0.1,0.2]
%efc_ctrl��The threshold to stop the search. The search is stoped if the increment introduced with every new feature is less than efc_ctrl.  
%fun_dpd��This parameter selects the strategies of computing attribute
%significance. ���ڼ���������Ҫ�ȵĺ������ڴ˳������Ѿ�ָ���ˣ�����Ҫ��ѡ��
% fun_dpd should be cited with single quotation marks��for example, 'clsf_dpd_fast'.
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
        array_cur(:,num_cur)=data_array(:,feature_slct(num_cur));%����ѡ�е����Զ�Ӧ�����мӵ�ԭ�б���
    end
    %��ʼ�������
    dpd_tmp=[];
    smp_csst_tmp=[];
    for i=1:length(feature_lft)
        array_tmp=array_cur;%��ָ ����ѡ�е����Զ�Ӧ�����мӵ�ԭ�б��У��󸳸�array_tmp�ģ�Ȼ��������������ȵļ����ӳ���
        array_tmp(:,[num_cur+1,num_cur+2])=data_array(:,[feature_lft(i),n]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ͬ�Ĳ��ԣ��ٶ��в��
        %switch fun_dpd
        %    case 'clsf_dpd_fast'      %�Ż��㷨,�����������,2����----�Ͽ�
        %        [w,e]=clsf_dpd_fast(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd_fast2'     %�Ż��㷨,����û������,2����----���
        %        [w,e]=clsf_dpd_fast2(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd'           %�Ż��㷨,�ٶ��������ڶԱ�,2����----����
        %        [w,e]=clsf_dpd(array_tmp,delta,sample_lft);
        %    case 'clsf_dpd_fast_3'    %�Ż��㷨,�����
        %        [w,e]=clsf_dpd_fast_3(array_tmp,delta,sample_lft);
            %case 'Copy_of_clsf_dpd_fast_3'                              %�Լ�������㷨 ��������data_arrayû�б�����Ĵ���
                [w,e]=Copy_of_clsf_dpd_fast_3(array_tmp,delta,sample_lft);%%%  �����w��dependency�������e��smp_csst��������
        %end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����        
        dpd_tmp(i)=w;
        if length(e)~=0
            smp_csst_tmp(i,(1:length(e)))=e;
        end
    end
 %%%%%%%%%%%%%%%����������Ե���Ҫ��%%%%%%%%%%%%%%%%%%%%%%%%  
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

