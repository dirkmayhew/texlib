function [X] = pdfdate()
	# -- Function file: [YYYYMMDDhhmmss] = pdfdate()
	#    no inputs
	#    returns a date stamp in pdfdate format

	#  4MAY2013 swapped datesplit to datevec

	[Y,M,D,h,m,s] = datevec(datestr(now));

	M = num2str(M);
	if (length(M) < 2)
		M = ["0" M];
	end
	
	D = num2str(D);
	if (length(D) < 2)
		D = ["0" D];
	end

	h = num2str(h);
	if (length(h) < 2)
		h = ["0" h];
	end

	m = num2str(m);
	if (length(m) < 2)
		m = ["0" m];
	end

	s = num2str(s);
	if (length(s) < 2)
		s = ["0" s];
	end

	datenum = [num2str(Y) M D h m s ];

  X = datenum;
end # [YYYYMMDDhhmmss] = pdfdate()
