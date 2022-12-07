function tle_data = import_tle(filename, dataLines)
% example: 
% tle_data = importfile("E:\OneDrive\TLEs\tle2004_1of8.txt\10000_2004_P1.csv", [2, Inf]);

if nargin < 2
    dataLines = [2, Inf];
end

opts = delimitedTextImportOptions("NumVariables", 6);

opts.DataLines = dataLines;
opts.Delimiter = ",";

opts.VariableNames = ["time", "inclination", "eccentricity", "AoP", "mean_anomaly", "mean_motion"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

tle_data = readtable(filename, opts);
end