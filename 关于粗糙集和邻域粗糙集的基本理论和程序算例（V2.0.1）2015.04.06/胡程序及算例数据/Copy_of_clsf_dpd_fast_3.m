%����������clsf_dpd_fast2,�����¼����һ�����Ե�������,���1����������������������������ǰ����жϴ���(no,no,no))---
%--------��˼��+�ҵĸĽ�1+�ҵĸĽ�2
%5���������ÿ���Ƿ���ȫ�����������������Ƿ�ȫ����顢�����Ƿ�����꣩=>(yes��yes,yes)+(no��yes,yes)+(no��yes,n
%o)+(no,no,yes)+(no,no,no)
%data_array����׼��֮�������,���飬�б�ʾһ������(������������)�ڲ�ͬ�����ϵ�ȡֵ���б�ʾһ�������ڲ�ͬ�����ϵ�ȡֵ
%delta�������С,�̶�ֵ
%smp_chk:���ж�����������ţ��¼��������ֻ����Щ���������ã���˼�������¼������Ե�������
%%%suo ������˵�ı�׼��֮�������ʵ���Ͼ��Ƕ����ݽ��й�һ��������һ�������������[0,1]֮�䡣
%%%    ��Ҫǿ�����ǣ���һ����������Ҫ��ÿ�����Ե����ݽ��е����Ĺ�һ������
%%%    �����������ȫ�ֵĹ�һ������������ǻᵼ�´�����С���ĺ����   �� 2012.12.18
function [dependency,smp_csst]=Copy_of_clsf_dpd_fast_3(array_tmp,delta,smp_chk)
[m,n]=size(array_tmp);
num_rightclassified=0;
smp_csst=[];%%%     ��������
for i=1:length(smp_chk)
    %���ڵ�i������,�ҵ���������
    sign=1;
    j=0;
    while j~=m
        j=j+1;
        in=1;
            k=0;    
            while k<n-1
                k=k+1;
                dist=abs(array_tmp(smp_chk(i),k)-array_tmp(j,k));
                if dist>delta(:,k)%������Ҫ��ÿ�����Ե�delta����뾶���е����ж�
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
        num_rightclassified=num_rightclassified+1;%%�½��Ƶ�����������1
        smp_csst=[smp_csst,smp_chk(i)];%smp_chk:���ж�����������ţ��¼��������ֻ����Щ���������ã���˼�������¼������Ե�������
    end
end
dependency=num_rightclassified/m;%��������ȣ�num_rightclassified���½��ƣ������򣩵��������� 
            
            