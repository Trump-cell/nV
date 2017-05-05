#include "common.h"
#include <mU/Exceptions.h>
#include <mU/Kernel.h>
#include <mU/Parser.h>
#include <mU/Interface.h>
#include <mU/UnicodeDevice.h>
#include <mU/utils.h>

#if __cplusplus >= 199711L && _MSC_VER != 1500
#include <thread>
using namespace std;
#else
#include <boost/thread.hpp>
#include <boost/thread/thread.hpp>
using namespace boost;
#endif

namespace mU {
bool backend_mode = getenv("MU_BACKEND") != 0;
inline void prompt() { wcout<<L"mU> "; if (backend_mode) wcout << L"\n" << std::flush; }
inline void newline() { wcout<<L"  > "; }
void find_result(parser *p, var *r)
{
	//try
	//{
		(*r) = SafeEval(Optimi(p->result()));
	//}
	/*catch (thread_interrupted &)
	{
		(*r) = mU::Aborted;
	}*/
}
}
using namespace mU;

CAPI void mU_init() { Initialize(); }
CAPI const char*  mU_eval(const char* str) { 
	static string s;
	wostringstream t;
	var r = ParseString(to_wstring(str,strlen(str)));
	if (r == Failed)
		Print(r, t);
        else
	    for (int i = 0; i < Size(r); ++i) {
		Print(Pretty(At(r,i)), t);
		t << endl;
            }
	wstring w = t.str();
	s = to_string(w.c_str(), w.size());
	return s.c_str();
} 
#if 1//!__EMSCRIPTEN__
CAPI int mU_main(int argc,char *argv[]) {
	mU_init();
//	setlocale(LC_ALL,"");
//	std::locale::global(std::locale(""));
	//wcerr.rdbuf(0);
#ifdef _WIN32
	Get(mbs2wcs(mU_Home() + "/conf/mU.ini"));
#else
	Get(mbs2wcs(mU_Home() + "/etc/mU.ini"));
#endif
	//Get(_W("mU.ini"));
	if(argc > 1) {
		for(int i = 1; i < argc; ++i)
			Get(to_wstring(argv[i], strlen(argv[i])));
		return 0;
	}
//    wcin.imbue(std::locale(""));
//    wcout.imbue(std::locale(""));
    if (!backend_mode)
      {
	wcout<<
		std::setw(45)<<L"*         *    \n"<<
		std::setw(45)<<L"*         *    \n"<<
		std::setw(45)<<L"*         *    \n"<<
		std::setw(45)<<L"*         *    \n"<<
		std::setw(45)<<L"*         *    \n"<<
		std::setw(45)<<L"*         *   *\n"<<
		std::setw(45)<<L"* *     *  * * \n"<<
		std::setw(45)<<L"*   * *        \n"<<
		std::setw(45)<<L"*              \n";
      }
	prompt();
	
	wstring buf, line;

	while((bool)getline(wcin,line))
	{
		parser p;
		if(line.empty())
		{
			buf.clear();
			prompt();
			continue;
		}
		buf += line;
		wistringstream stream(buf);
		var r;
		try {
			p.start(stream);
			p.parse();
		}
		catch (UnexpectedTokenException &)
		{
			if (backend_mode)
			{
				wcerr << L"Syntax::etoken : unexpected token encountered\n" << std::flush;
			}
			else
			{
				wcerr << std::setw(p.column + 4) << L"^\n" << std::flush;
			}
			buf.clear();
			prompt();
			continue;
		}
		catch (MoreInputNeededException &)
		{

			if (backend_mode)
			{
				wcerr << L"Syntax::sntxi : Incomplete expression; more input is needed\n" << std::flush;
			}
			else
			{
				newline();
				buf += L'\n';
				continue;
			}
		}
		++InputLineCounter;
		thread worker(find_result, &p, &r);
		worker.join();
		find_result(&p, &r);
		if(r && r != Null) Println(r);
		buf.clear();
		prompt();
	}

	return 0;
}
#endif
