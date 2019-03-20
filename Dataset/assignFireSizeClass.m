function classes = assignFireSizeClass(X)

thres = [0.26, 10, 100, 300, 1000, 5000];
threslog = log10(thres);

classes = zeros(size(X, 1), 1);

for i = 1:size(X, 1)
	x = X(i, 1);
	if x < threslog(1)
		classes(i) = 1;
	elseif x < threslog(2)
		classes(i) = 2;
	elseif x < threslog(3)
		classes(i) = 3;
	elseif x < threslog(4)
		classes(i) = 4;
	elseif x < threslog(5)
		classes(i) = 5;
	elseif x < threslog(6)
		classes(i) = 6;
	else
		classes(i) = 7;
	end
end
end