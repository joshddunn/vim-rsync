if !exists("g:vim_rsync")
  let g:vim_rsync = {}
endif

function! RsyncExclude(project)
    let exclude = ""
    if has_key(a:project, "exclude")
      for item in a:project["exclude"]
        let exclude = exclude . " --exclude='" . item . "' "
      endfor
    endif

    return exclude
endfunction

function! RsyncPush(args)
  if has_key(g:vim_rsync, a:args)
    let project = g:vim_rsync[a:args]
    let exclude = call RsyncExclude(project)
    exe "!rsync -r --delete " .  . project["local_directory"] . " " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"]
  else
    echo "The project is not defined in vim_rsync"
  endif
endfunction

function! RsyncPull(args)
  if has_key(g:vim_rsync, a:args)
    let project = g:vim_rsync[a:args]
    let exclude = call RsyncExclude(project)
    exe "!rsync -r --delete " . exclude . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"] . " " . project["local_directory"]
  else
    echo "The project is not defined in vim_rsync"
  endif
endfunction

command! -nargs=1 RsyncPush call RsyncPush (<q-args>)
command! -nargs=1 RsyncPull call RsyncPull (<q-args>)
