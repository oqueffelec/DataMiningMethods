function [ cout ] = moncritere( teta )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
cout=(1-teta(1))^2+100*(teta(2)-teta(1)^2)^2;
end

