#!/usr/sbin/dtrace -Zs
/*
 * pl_calls.d
 *
 * Example script from Chapter 8 of the book: DTrace: Dynamic Tracing in
 * Oracle Solaris, Mac OS X, and FreeBSD", by Brendan Gregg and Jim Mauro,
 * Prentice Hall, 2011. ISBN-10: 0132091518. http://dtracebook.com.
 * 
 * See the book for the script description and warnings. Many of these are
 * provided as example solutions, and will need changes to work on your OS.
 */

#pragma D option quiet

dtrace:::BEGIN
{
	printf("Tracing Perl... Hit Ctrl-C to end.\n");
}

perl*:::sub-entry
{
	@subs[pid, basename(copyinstr(arg1)), copyinstr(arg0)] = count();
}

dtrace:::END
{
	printf("%-6s %-30s %-30s %8s\n", "PID", "FILE", "SUB", "CALLS");
	printa("%-6d %-30s %-30s %@8d\n", @subs);
}
