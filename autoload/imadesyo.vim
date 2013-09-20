" vim: set sw=4 et fdm=marker nowrap:
"
" imadesyo.vim - when do you start? IMADESYO!
"
" Version: 1.0
" Maintainer:	yaasita < https://github.com/yaasita/imadesyo >
function! imadesyo#s:Imadesyo() abort "{{{
    w
    " command
	if has('win32')
		let l:cmd = "!"
	else
		let l:cmd = "!clear && "
	endif
    " conf detect
    let l:name = expand("%:p")
    if     (&ft  == 'vim')                               | source %
    elseif (l:name =~ '\v\.mailfilter$')                 | execute l:cmd.'maildrop -V 9 < /dev/null'
    elseif (l:name =~ '\v\.slim$')                       | execute l:cmd.'slimrb -p '.expand("%")
    elseif (l:name =~ '\v^/etc/.*grub')                  | execute l:cmd.'update-grub'
    elseif (l:name =~ '\v^/etc/aliases$')                | execute l:cmd.'newaliases'
    elseif (l:name =~ '\v^/etc/apache2')                 | execute l:cmd.'apache2ctl configtest && service apache2 restart'
    elseif (l:name =~ '\v^/etc/apt/sources.list')        | execute l:cmd.'apt-get update'
    elseif (l:name =~ '\v^/etc/bind')                    | execute l:cmd.'named-checkconf && service bind9 reload'
    elseif (l:name =~ '\v^/etc/default/isc-dhcp-server') | execute l:cmd.'dhcpd -t && service isc-dhcp-server restart'
    elseif (l:name =~ '\v^/etc/dhcp/dhcpd.conf')         | execute l:cmd.'dhcpd -t && service isc-dhcp-server restart'
    elseif (l:name =~ '\v^/etc/fstab')                   | execute l:cmd.'mount -a'
    elseif (l:name =~ '\v^/etc/lighttpd')                | execute l:cmd.'lighttpd -t -f '.l:name.' && service lighttpd restart'
    elseif (l:name =~ '\v^/etc/logrotate')               | execute l:cmd.'logrotate -vf '.l:name
    elseif (l:name =~ '\v^/etc/munin')                   | execute l:cmd.'service munin-node restart'
    elseif (l:name =~ '\v^/etc/mysql')                   | execute l:cmd.'mysqld --help && service mysql restart'
    elseif (l:name =~ '\v^/etc/nagios/')                 | execute l:cmd.'service nagios-nrpe-server restart'
    elseif (l:name =~ '\v^/etc/nagios3')                 | execute l:cmd.'nagios3 -v /etc/nagios3/nagios.cfg && service nagios3 restart'
    elseif (l:name =~ '\v^/etc/nginx')                   | execute l:cmd.'service nginx configtest && service nginx restart'
    elseif (l:name =~ '\v^/etc/ntp.conf')                | execute l:cmd.'service ntp restart'
    elseif (l:name =~ '\v^/etc/postfix')                 | execute l:cmd.'postfix check && service postfix restart'
    elseif (l:name =~ '\v^/etc/rsyslog')                 | execute l:cmd.'rsyslogd -N1 && service rsyslog restart'
    elseif (l:name =~ '\v^/etc/samba')                   | execute l:cmd.'testparm -s && service samba restart'
    elseif (l:name =~ '\v^/etc/smartd.conf')             | execute l:cmd.'service smartd restart'
    elseif (l:name =~ '\v^/etc/squid3')                  | execute l:cmd.'squid3 -k check && service squid3 reload'
    elseif (l:name =~ '\v^/etc/ssh')                     | execute l:cmd.'sshd -t && service ssh reload'
    elseif (l:name =~ '\v^/etc/unbound')                 | execute l:cmd.'unbound-checkconf && service unbound restart'
    elseif (l:name =~ '\v^/etc/varnish')                 | execute l:cmd.'varnishd -C -f '.l:name.' && service varnish reload'
    elseif (l:name =~ '\v^/etc/vsftpd')                  | execute l:cmd.'service vsftpd restart'
    elseif (l:name =~ '\v_spec\.rb$')                    | execute l:cmd.'rspec -c '.expand("%")
    else                                                 | execute l:cmd.s:ExecFileCommand().' '.expand("%")
    endif
endfunction "}}}
function! s:ExecFileCommand() "{{{
    let l:first_line=getline(1)
    if l:first_line =~ '\v^#!'
        return matchstr(l:first_line,'\v^#!\zs.+')
    elseif (&ft == 'make')
        return "make -f"
    else
        return &ft
    endif
endfunction "}}}
