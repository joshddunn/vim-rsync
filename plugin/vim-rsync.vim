if !exists("g:vim_rsync")
  let g:vim_rsync = { "remote": {} }
endif

function! RsyncPush(args)
  let project = g:vim_rsync_data["remote"]
  if has_key(project, a:args)
    let project = project[a:args]
    let exclude = ""
    for item in project["ignore"]
      let exclude = exclude . " --exclude='" . item . "' "
    endfor
    exe "!rsync -r --delete " . exclude . project["local_directory"] . " " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"]
  else
    echo "The project is not defined in vim_rsync_data"
  endif
endfunction
command! -nargs=* RsyncPush call RsyncPush ('<args>')

function! RsyncPull(args)
  let project = g:vim_rsync_data["remote"]
  if has_key(project, a:args)
    let project = project[a:args]
    let exclude = ""
    for item in project["ignore"]
      let exclude = exclude . " --exclude='" . item . "' "
    endfor
    exe "!rsync -r --delete " . exclude . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"] . " " . project["local_directory"]
  else
    echo "The project is not defined in vim_rsync_data"
  endif
endfunction
command! -nargs=* RsyncPull call RsyncPull ('<args>')
