function weight = weightD(dataArray,lammda)
% �������ԵĴ������µ���Ҫ��
% ����Ϊ����ϵͳ���ݣ����һ��Ϊ��������
% ����lammdaΪ��������뾶ʱ�Ĳ�����delta=std��dataArray��/lammda
% lammdaԽС���򻮷ֵõ������򼯺�����Ԫ��Խ�ࡣ
% lammda ע�⣡����������lammda�ͺ��廪�����lammda������
% ����lammdaȡֵ������0.5~1.5֮�䣬���̫���������������������̫С������򱨴�
% ��������ڰ������������Ƚ϶ࣨ��ʮ���ϣ��������lammda=2~4
% ���Ϊÿ�����ԵĴ������µ�Ȩ��
% �˳�������˼��������ĳ���getPosSet
% made by suozi 20140427
% QQ��379786867

[m,n]=size(dataArray); % mΪ������ nΪ���Ը���(���һ��Ϊ��������)
if m<4 || n<4 % С��4����û��������,�����¼���������ʱȥ��һ�����Ժ�ֻ��һ������
    disp('����ľ���ϵͳ���и�������С��4����');
    return
end

%%%%%%%%%%%% ����ȫ���������Ե�������
PosSet_all = getPosSet(dataArray,lammda); %����ȫ��������������ھ������Ե�����
dpd_all=length(PosSet_all)/m; % �õ�ȫ���������Ե�������

%%%%%%%%%%%% ��������ÿ���������Ե������ȡ���Ҫ��
for g=1:n-1 %����ÿ����������
    if g==1
        condiAtt_new=dataArray(:,2:n-1); %�����һ��������������
    elseif g==n-1
        condiAtt_new=dataArray(:,1:n-2); %�������һ��������������
    else
        condiAtt_new=[dataArray(:,1:g-1),dataArray(:,g+1:n-1)];
    end
    dataArray_new=[condiAtt_new,dataArray(:,n)]; %���������Ҫ����ľ���ϵͳ
    % ��ʱ�õ��ľ���ϵͳΪȥ����ָ�����������Ե��µľ���ϵͳ
    PosSet_Att=getPosSet(dataArray_new,lammda); %�õ�ȥ��ĳһ���Ժ���������Ե�����
    dpd_Att_tmp=length(PosSet_Att)/m; % ����ÿ�����Ե�������
    dpd_Att(g,1)=dpd_Att_tmp; % ��ÿ�����Ե������ȴ洢����,��g��
    sig_Att_tmp=dpd_all-dpd_Att_tmp; % ����ÿ�����Ե���Ҫ��
    sig_Att(g,1)=sig_Att_tmp; % ��ÿ�����Ե���Ҫ�ȴ洢��������g��
end

%%%%%%%%%%%%% ����ÿ�����Ե�Ȩ��
for i=1:n-1
    weight_tmp=sig_Att(i,1)/sum(sig_Att);
    weight(i,1)=weight_tmp; %�������ÿ�����Ե�Ȩ�أ��������µ�Ȩֵ��
end

