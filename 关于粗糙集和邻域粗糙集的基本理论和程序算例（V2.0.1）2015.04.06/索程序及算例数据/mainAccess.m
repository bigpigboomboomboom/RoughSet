% 用于计算（邻域粗糙集）代数观下条件属性重要度的主入口程序
% 包含子程序有weigthD（计算权重）、getPosSet（计算正域）reduceSet（约简计算）
%
%   更新说明： 添加了一个数据判断，判断数据中是否存在某列具有相同数据
%             避免了很多网友说到的 flag2 未定义现象
%   更新日期：2015.04.06 （看看上次发布，已经时隔一年了啊！老了啊）
%
% Made by suozi 20140428
% QQ：379786867

clc;
clear all

load('breast.mat') % 加载的test.mat数据为邻域粗糙集使用的数值型决策系统数据
%load('test.txt') % 同学们在加载数据的时候也可以直接加载txt个数数据，或者excel格式的文件
% 最后一列为决策属性
lammda=0.6; %邻域半径计算参数 delta=std（dataArray）/lammda
% 这里lammda取值尽量在0.5~1.5之间，如果太大，则不能输出正常结果，如果太小，则程序报错
% 如果数据内包含的样本数比较多（几十以上），则调大lammda=2~4
sig_ctrl=0.01; %重要度下限的控制参数，取接近0的数
redSet = reduceSet(test,lammda,sig_ctrl) %计算约简集合
weight = weightD(test,lammda) %计算权重
