function [varargout] = tex_getreporttitle(varargin)
  # -- Function: [title] = tex_getreporttitle(Analysis)

  Analysis = '';
	if (1 > nargin)
      error('need the analysis I.D.');
    else
	  v = 1;
	  Analysis = [varargin{v}];  v++;
	end

	if (1)
		model_years = { '2014'; '2015'; '2016'; '2017' };
		menu_string = [];
		for (f = 1:length(model_years) - 1)
			menu_string = [ menu_string '"' [model_years{f}] '", ' ];
		end
		menu_string = [ menu_string '"' [model_years{length(model_years)}] '"' ];
		eval([ "opt = menu('select a model year: '," menu_string ");"]);
		model_year = [model_years{opt}];

		models = { 'KL'; 'UF'; 'BU'; 'VM'; 'K4'; 'RU'; 'JD'; 'KR'; 'MP'; 'PK'; 'RA'; 'RT'; 'TR'; 'FC'; 'JF' };
		menu_string = [];
		for (f = 1:length(models) - 1)
			menu_string = [ menu_string '"' [models{f}] '", ' ];
		end
		menu_string = [ menu_string '"' [models{length(models)}] '"' ];
		eval([ "opt = menu('select a model: '," menu_string ");"]);
		model = [models{opt}];

		if (1 == opt)  # KL
			engines = [ 2.4 3.2 2.0 2.2 ];
		elseif (2 == opt)  # UF
			engines = [ 2.4 3.6 ];
		else  # BU VM K4 RU JD KR MP PK RA RT TR FC JF
			engines = [ 1.4 2.4 3.2 3.6 2.0 ];
		end
		menu_string = [];
		for (f = 1:length(engines) - 1)
			menu_string = [ menu_string '"' num2str(engines(f)) '", ' ];
		end
		menu_string = [ menu_string '"' num2str(engines(length(engines))) '"' ];
		eval([ "opt = menu('select an engine: '," menu_string ");"]);
		engine = engines(opt);

		title = [ model_year ' ' model ' ' num2str(engine) 'L ' strrep(Analysis, '_', ' ') ' Analysis' ];
	end

	if (nargout >= 1)
		varargout{1} = title;
		if (nargout >= 2)
			varargout{2} = engine;
		end
	end  
end
