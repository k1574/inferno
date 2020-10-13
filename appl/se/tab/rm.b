implement TabAdd;
# Remove tab in front of every input line.

include "sys.m";
	sys: Sys;
include "bufio.m";
	bufio : Bufio;
	Iobuf : import bufio;

include "draw.m";

TabAdd: module
{
	init:	fn(ctxt: ref Draw->Context, argv: list of string);
};

arg0 : string;
n : int;

usage()
{
	sys->fprint(sys->fildes(2), "usage: %s [tabs_num]\n", arg0);
	exit;
}

init(nil: ref Draw->Context, args : list of string)
{
	sys = load Sys Sys->PATH ;
	bufio = load Bufio Bufio->PATH ;

	(arg0, args) = (hd args, tl args) ;

	if( args != nil ){
		(n, args) = (int hd args, tl args) ;
		if(args!=nil) usage() ;
	}else
		n = 1 ;
	if(n<1) usage() ;

	input := bufio->fopen(sys->fildes(0), sys->OREAD) ;
	while(len(s := input.gets('\n')) > 0 ){
		if(len(s) > 1)
			for( i:=0 ; i<n && s[0] == '\t' ; ++i )
				s = s[1:] ;
		sys->print("%s", s);
	}
}