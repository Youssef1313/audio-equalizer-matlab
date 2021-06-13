classdef Filter

    properties
        Numerator
        Denominator
    end

    methods
        function obj = Filter(numerator, denominator)
           obj.Numerator = numerator;
           obj.Denominator = denominator;
        end
    end
end
