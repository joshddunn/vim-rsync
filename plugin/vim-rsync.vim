let g:vim_rsync_data = {
\ "remote": {
\   "": {
\     "user": "",
\     "ip_address": "",
\     "local_directory": "",
\     "remote_directory": "",
\     "ignore": [
\     ]
\   },
\ }
\}

function! RsyncPush(args)
  let project = g:vim_rsync_data["remote"]
  if has_key(project, a:args)
    let project = project[a:args]
    exe "!rsync -r --delete " . project["local_directory"] . " " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"]
  else
    echo "The project is not defined in vim_rsync_data"
  endif
endfunction
command! -nargs=* RsyncPush call RsyncPush ('<args>')

function! RsyncPull(args)
  let project = g:vim_rsync_data["remote"]
  if has_key(project, a:args)
    let project = project[a:args]
    exe "!rsync -r --delete " . project["user"] . "@" . project["ip_address"] . ":" . project["remote_directory"] . " " . project["local_directory"]
  else
    echo "The project is not defined in vim_rsync_data"
  endif
endfunction
command! -nargs=* RsyncPull call RsyncPull ('<args>')
