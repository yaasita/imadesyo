" vim: set sw=4 et fdm=marker nowrap:
"
" imadesyo.vim - when do you start? IMADESYO!
"
" Version: 2.0
" Maintainer:	yaasita < https://github.com/yaasita/imadesyo >
function! imadesyo#s:Imadesyo(...) abort "{{{
    w
    " user cmd
    if a:0 != 0
        let l:user_cmd = ""
        for s in a:000
            let l:user_cmd = l:user_cmd . s . " "
        endfor
        let b:imadesyo_command = l:user_cmd
    endif
    if !exists('b:imadesyo_command')
        let b:imadesyo_command = s:ReturnExecCommand()
    endif
    execute b:imadesyo_command
endfunction "}}}
function! s:ReturnExecCommand() "{{{
    " command
	if has('win32')
		let l:cmd = "!"
	else
		let l:cmd = "!clear && "
	endif
    " conf detect
    let l:name = expand("%:p")
    if     (&ft  == 'vim')                               | return 'source %'
    elseif (l:name =~ '\v\.mailfilter$')                 | return l:cmd.'maildrop -V 9 < /dev/null'
    elseif (l:name =~ '\v\.slim$')                       | return l:cmd.'slimrb -p '.expand("%")
    elseif (l:name =~ '\v^/etc/.*grub')                  | return l:cmd.'update-grub'
    elseif (l:name =~ '\v^/etc/aliases$')                | return l:cmd.'newaliases'
    elseif (l:name =~ '\v^/etc/apache2')                 | return l:cmd.'apache2ctl configtest && service apache2 restart'
    elseif (l:name =~ '\v^/etc/apt/sources.list')        | return l:cmd.'apt-get update'
    elseif (l:name =~ '\v^/etc/bind')                    | return l:cmd.'named-checkconf && service bind9 reload'
    elseif (l:name =~ '\v^/etc/default/isc-dhcp-server') | return l:cmd.'dhcpd -t && service isc-dhcp-server restart'
    elseif (l:name =~ '\v^/etc/dhcp/dhcpd.conf')         | return l:cmd.'dhcpd -t && service isc-dhcp-server restart'
    elseif (l:name =~ '\v^/etc/fstab')                   | return l:cmd.'mount -a'
    elseif (l:name =~ '\v^/etc/lighttpd')                | return l:cmd.'lighttpd -t -f '.l:name.' && service lighttpd restart'
    elseif (l:name =~ '\v^/etc/logrotate')               | return l:cmd.'logrotate -vf '.l:name
    elseif (l:name =~ '\v^/etc/munin')                   | return l:cmd.'service munin-node restart'
    elseif (l:name =~ '\v^/etc/mysql')                   | return l:cmd.'mysqld --help && service mysql restart'
    elseif (l:name =~ '\v^/etc/nagios/')                 | return l:cmd.'service nagios-nrpe-server restart'
    elseif (l:name =~ '\v^/etc/nagios3')                 | return l:cmd.'nagios3 -v /etc/nagios3/nagios.cfg && service nagios3 restart'
    elseif (l:name =~ '\v^/etc/nginx')                   | return l:cmd.'service nginx configtest && service nginx restart'
    elseif (l:name =~ '\v^/etc/ntp.conf')                | return l:cmd.'service ntp restart'
    elseif (l:name =~ '\v^/etc/postfix')                 | return l:cmd.'postfix check && service postfix restart'
    elseif (l:name =~ '\v^/etc/rsyslog')                 | return l:cmd.'rsyslogd -N1 && service rsyslog restart'
    elseif (l:name =~ '\v^/etc/samba')                   | return l:cmd.'testparm -s && service samba restart'
    elseif (l:name =~ '\v^/etc/smartd.conf')             | return l:cmd.'service smartd restart'
    elseif (l:name =~ '\v^/etc/squid3')                  | return l:cmd.'squid3 -k check && service squid3 reload'
    elseif (l:name =~ '\v^/etc/ssh')                     | return l:cmd.'sshd -t && service ssh reload'
    elseif (l:name =~ '\v^/etc/unbound')                 | return l:cmd.'unbound-checkconf && service unbound restart'
    elseif (l:name =~ '\v^/etc/varnish')                 | return l:cmd.'varnishd -C -f '.l:name.' && service varnish reload'
    elseif (l:name =~ '\v^/etc/vsftpd')                  | return l:cmd.'service vsftpd restart'
    elseif (l:name =~ '\v_spec\.rb$')                    | return l:cmd.'rspec -c '.expand("%")
    endif
    " file type detect
    let l:first_line=getline(1)
    if l:first_line =~ '\v^#!'
        return l:cmd.matchstr(l:first_line,'\v^#!\zs.+').' '.expand("%")
    elseif (&ft == 'make')
        return l:cmd."make -f".' '.expand("%")
    else
        return l:cmd.&ft.' '.expand("%")
    endif
endfunction "}}}
