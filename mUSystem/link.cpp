#include "common.h"
#include <mU/System.h>
#include <mU/UnicodeDevice.h>

#if __cplusplus >= 199711L
namespace mU {
var Link(const wstring &x, size_t y) { return Null; }
var Server(const wstring &x, size_t y) { return Null; }
var Request(Var x) { return Null; }
#else
#include <boost/asio.hpp>
namespace io = boost::iostreams;
namespace mU {
struct link_t : stream_t
{
	link_t(std::wiostream *x) { rep = x; }
	link_t(const wstring &x, size_t y)
	{
		typedef boost::asio::ip::tcp::iostream socket_t;
		boost::shared_ptr<socket_t> p (new socket_t(
		boost::asio::ip::tcp::endpoint(
		boost::asio::ip::address::from_string(
		string(x.begin(),x.end())),y)));
		rep = new io::stream<UnicodeDevice<socket_t> >(p);
	}
	~link_t() { delete rep; }
	void print(wostream &f) { f << L"Link[" << rep << L']'; }
};
struct server_t : obj_t
{
	server_t(const wstring &x, size_t y) : acceptor(io_service,
		boost::asio::ip::tcp::endpoint(
		boost::asio::ip::address::from_string(
		string(x.begin(),x.end())),y)) {}
	void print(wostream &f) { f << L"Server[" << this << L']'; }
	boost::asio::io_service io_service;
	boost::asio::ip::tcp::acceptor acceptor;
};
var Link(const wstring &x, size_t y) { return new link_t(x,y); }
var Server(const wstring &x, size_t y) { return new server_t(x,y); }
var Request(Var x)
{
	namespace io = boost::iostreams;
	typedef boost::asio::ip::tcp::iostream socket_t;
	boost::shared_ptr<socket_t> stream(new socket_t);
	dynamic_cast<server_t *>(x)->acceptor.accept(*(stream->rdbuf()));
	io::stream<UnicodeDevice<socket_t> > *p
		= new io::stream<UnicodeDevice<socket_t> >(stream);
	return new link_t(p);
}
#endif
}
