# vim-rsync

Built with neovim in mind.

## Installation

Make sure `rsync` is installed.

Then add the following line to your config.

    Plug 'joshddunn/vim-rsync'

## Usage

```vim
let g:vim_rsync = {
\  "project_name": {
\    "user": "root",
\    "ip_address": "xx.xx.xx",
\    "local_directory": "/local/dir/",
\    "remote_directory": "/remote/dir/",
\    "exclude": [
\      "dir/to/ignore"
\    ]
\  }
\}
```

If your vim setup is public, it's recommended you store `g:vim_rsync` in a file that is ignored by git.

Only exclude is optional.

To pull files from server use

    :RsyncPull project_name

To push files to server use

    :RsyncPush project_name

## Help

The documentation can be read using `:help vim-rsync`.
