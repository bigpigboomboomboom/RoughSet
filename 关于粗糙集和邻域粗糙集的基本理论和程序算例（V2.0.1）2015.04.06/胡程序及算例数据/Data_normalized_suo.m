%%% �Զ�ά�����е�ÿһ�е������й�һ������
%%% ���� 2012.12.19   qq:379786867
function Normaldata = Data_normalized_suo(Normaldata)
[m,n] = size(Normaldata);
for j=1:n
    amin=min(Normaldata(:,j));
    amax=max(Normaldata(:,j));
    for i=1:m
        Normaldata(i,j)=(Normaldata(i,j)-amin)./(amax-amin);
    end
end