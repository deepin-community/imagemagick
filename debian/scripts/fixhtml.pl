use strict;
use warnings;
use File::Find;

my $dir = "www";

find(sub {
    return if /^\.\#/;  
    return unless /\.html?$/i;

    local @ARGV = ($_);
    local $^I   = '.bak';

    while (<>) {
        s{<meta\b([^>]*?[^/])>}{"<meta$1 />"}ge;
	s{<input\b([^>]*?[^/])>}{"<input$1 />"}ge;
        s{<link\b([^>]*?[^/])>}{"<link$1 />"}ge;
        s{<br\b([^>]*?[^/])>}{"<br$1 />"}ge;
	s{"nav-link ""}{"nav-link"}g;#"
        s{src="../image/wand.ico">}{src="../image/wand.ico" />}g;
        s{src="../image/wizard.png" width="1104">}{src="../image/wizard.png" width="1104" />}g;
        s{<script async }{<script async="true" }g;
        s{&nbsp;}{ }g;
	s{<a class="nav-link active""}{<a class="nav-link"}g;
	s{<meta name="twitter:description" content="\$this- />description">}{<meta name="twitter:description" content="\$this- />description" />}g;
	
        print;
    }
}, $dir);
