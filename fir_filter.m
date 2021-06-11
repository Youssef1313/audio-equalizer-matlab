function [ filters ] = fir_filter( order, fs, bands)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for band = bands
filters = [filters fir1(order + 1, fs / 2, bands / 2)]; 
end

