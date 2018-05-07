if !exists("g:vim_rsync")
  let g:vim_rsync = {}
endif

function! RsyncExclude(project)
    if has_key(a:project, "exclude")
      return join(map(a:project["exclude"], "\"--exclude=\'\" . v:val . \"'\""), ' ')
    endif
    return ""
endfunction

function! RsyncValidate(project, project_name)
  if !has_key(a:project, "user")
    echoerr "The field 'user' in g:vim_rsync['" . a:project_name . "'] cannot be empty"
    return 0
  endif

  if !has_key(a:project, "ip_address")
    echoerr "The field 'ip_address' in g:vim_rsync['" . a:project_name . "'] cannot be empty"
    return 0
  endif

  if !has_key(a:project, "local_directory")
    echoerr "The field 'local_directory' in g:vim_rsync['" . a:project_name . "'] cannot be empty"
    return 0
  endif

  if !has_key(a:project, "remote_directory")
    echoerr "The field 'remote_directory' in g:vim_rsync['" . a:project_name . "'] cannot be empty"
    return 0
  endif

  return 1
endfunction

function! RsyncPush(args)
  if has_key(g:vim_rsync, a:args)
    let project = g:vim_rsync[a:args]
    if RsyncValidate(project, a:args)
      exe "!rsync -r --delete " . RsyncExclude(project) . " " . project["local_directory"] . " " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"]
    endif
  else
    echoerr "The project '" . a:args . "' is not defined in g:vim_rsync"
  endif
endfunction

function! RsyncPull(args)
  if has_key(g:vim_rsync, a:args)
    let project = g:vim_rsync[a:args]
    if RsyncValidate(project)
      exe "!rsync -r --delete " . RsyncExclude(project) . " " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"] . " " . project["local_directory"]
    endif
  else
    echoerr "The project '" . a:args . "' is not defined in g:vim_rsync"
  endif
endfunction

command! -nargs=1 RsyncPush call RsyncPush (<q-args>)
command! -nargs=1 RsyncPull call RsyncPull (<q-args>)
