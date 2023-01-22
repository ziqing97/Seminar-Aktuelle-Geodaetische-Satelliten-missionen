function satellitestatistic = import_satistic_data(filename, dataLines)

if nargin < 2
    dataLines = [2, Inf];
end

opts = delimitedTextImportOptions("NumVariables", 5);

opts.DataLines = dataLines;
opts.Delimiter = ",";

opts.VariableNames = ["Var1", "year", "number", "add_number", "remove_number"];
opts.SelectedVariableNames = ["year", "number", "add_number", "remove_number"];
opts.VariableTypes = ["string", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

opts = setvaropts(opts, "Var1", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var1", "EmptyFieldRule", "auto");

satellitestatistic = readtable(filename, opts);

end