#include <nV/Interface.h>
#include <nV/Parser.h>
#include <nV/utils.h>
#include <nV/Config.h>
#include <cstring>

namespace nV {
	bool backend_mode = false;
	int timeout_mode = 0;
	inline void prompt() {
		if(backend_mode)
			return;
    wcerr <<
#ifdef _WIN32
#ifdef _MSC_VER
			(wchar)956 <<
#else
			_W("nV") <<
#endif
#else
			_W("nv") <<
#endif
			_W("> ");
	}
	inline void newline() {
    wcout << _W("  > ");
	}
	inline void open(Parser& p, wifstream& f, const char* s) {
    f.open(s);
    if (!f)
			return;
    try {
			p.start(f);
			p.eval();
    } catch (std::exception& e) {
			wcerr << _W("Error occurred while eval ") << s << _W(", ")
						<< e.what() << _W("...") << endl;
    }
    f.close();
	}
	bool readline(wistream& i, wstring& r) {
		if(timeout_mode == 0){
			return (bool)std::getline(i, r);
		}
		else {
			bool flag = true;
#ifndef _WIN32
			int     sockfd = 0;
			fd_set  fdR;
			struct  timeval timeout = {timeout_mode, 0};
			FD_ZERO(&fdR);
			FD_SET(sockfd, &fdR);
			switch (select(sockfd + 1, &fdR, NULL, NULL, &timeout)){
			case -1:
			case 0:
				flag = false;
				break;
			default:
				flag = (bool)std::getline(i, r);
			}
#else
			flag = (bool)std::getline(i, r);
#endif
			return flag;
		}
	}
	void read_mode() {
		backend_mode = getenv("NV_BACKEND") != 0;
		char *p = getenv("NV_TIMEOUT");
		timeout_mode = 0;
		if(p)
			timeout_mode = atoi(getenv("NV_TIMEOUT"));
	}
}

using namespace nV;

CAPI Kernel* nV_init(Kernel* kernel = 0) { 
	try {
		setlocale(LC_ALL, "");
		wcin.imbue(std::locale(""));
		wcout.imbue(std::locale(""));
	} catch (std::exception& e) {
		wcerr << _W("Error occurred while set locale, ") << e.what() << _W("...") << endl;
	}
	//wcerr.rdbuf(0);
	Kernel* pKernel = kernel;
	if (!kernel) {
		pKernel = new Kernel;
		pKernel->parser = new Parser(*pKernel);
	}
	return pKernel;
}
CAPI const char*  nV_eval(Kernel* kernel, const char* str) { 
	static string s;
	Kernel& k = *kernel;
	Parser& p = *(k.parser);
	wstring w = to_wstring(str,strlen(str));
    	wistringstream in(w);
	var r;
    	try {
          p.start(in);
          r = p.eval();
    	} catch (std::exception& e) {
        	k.logging(__FUNCTIONW__) << _W("Error occurred while eval ") << w << _W(", ")
                                 << e.what() << _W("...") << endl;
    	}
	wostringstream out;
	for (int i = 1; i < r.tuple().size; ++i) {
	    grammar.print(k, out, k.value(tuple(SYS(Pretty), r.tuple()[i])));
	    out << endl;
	}
	w = out.str();
	s = to_string(w.c_str(), w.size());
	return s.c_str();
} 
#if 1//!__EMSCRIPTEN__
CAPI int nV_main(int argc, char *argv[], Kernel* kernel = 0) {
	Kernel* pKernel = nV_init(kernel);
	Kernel& k = *pKernel;
	Parser& p = *(k.parser);

	read_mode();
	wifstream f;
#ifdef _WIN32
	open(p, f, (Kernel::nv_home() + "/conf/nV.ini").c_str());
#else
	open(p, f, (Kernel::nv_home() + "/etc/nV.ini").c_str());
#endif
	//open(p, f, "nV.ini");
	if (argc > 1) {
		for (int i = 1; i < argc; ++i)
			open(p, f, argv[i]);
		return 0;
	}
	if(!backend_mode){
		wcerr <<
			std::setw(45) << _W("*         *    \n") <<
			std::setw(45) << _W("*         *    \n") <<
			std::setw(45) << _W("*         *    \n") <<
			std::setw(45) << _W("*         *    \n") <<
			std::setw(45) << _W("*         *    \n") <<
			std::setw(45) << _W("*         *   *\n") <<
			std::setw(45) << _W("* *     *  * * \n") <<
			std::setw(45) << _W("*   * *        \n") <<
			std::setw(45) << _W("*              \n");
	}
	if(backend_mode)
		wcout<<" "<<endl;
	prompt();
	var r;
	wstring buf, line;
	while (readline(wcin, line)) {
		if (!backend_mode) {
			if (line.empty()) {
				buf.clear();
				prompt();
				continue;
			}
		}
	line_already_read:
		if (line == _W("Exit"))
			break;
		buf += line;
		try {
			wistringstream stream(buf);
			p.start(stream);
			r = p.gen(p.parse());
		} catch (std::exception& e) {
			if (!strcmp(e.what(), "more")) {
				if (backend_mode) {
					if (std::getline(wcin, line))
					{
						buf += _W('\n');
						goto line_already_read;
					}
					else
					{
						wcout << _W("SyntaxError::more : incomplete input.\n");
					}
				} else {
					newline();
					buf += _W('\n');
					continue;
				}
			} else if (!strcmp(e.what(), "error")) {
				if (backend_mode) {
					wcout << _W("SyntaxError::error : at line: ") << p.parsing->lineno
								<< _W(", column: ") << p.parsing->column << _W("\n");
					break;
				} else {
					wcout << std::setw(p.parsing->column + 4) << _W("^\n");
				}
			}
			buf.clear();
			prompt();
			continue;
		}
		try {
			r = k.eval(r);
			if (r != 0) {
				k.print(r);
				r = null;
			}
		} catch (std::exception& e) {
			wcerr << _W("Error occurred while eval ") << buf << _W(", ")
						<< e.what() << _W("...") << endl;
			k.start();
		}
		buf.clear();
		prompt();
	}
	if (!kernel) {
		delete pKernel->parser;
		delete pKernel;
	}
	return 0;
}
#endif
