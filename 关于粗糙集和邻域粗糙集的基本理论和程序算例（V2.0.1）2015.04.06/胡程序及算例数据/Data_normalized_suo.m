%%% 对多维数组中的每一列单独进行归一化处理
%%% 索子 2012.12.19   qq:379786867
function Normaldata = Data_normalized_suo(Normaldata)
[m,n] = size(Normaldata);
for j=1:n
    amin=min(Normaldata(:,j));
    amax=max(Normaldata(:,j));
    for i=1:m
        Normaldata(i,j)=(Normaldata(i,j)-amin)./(amax-amin);
    end
end