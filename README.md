<img src="media/logo.png" alt="zest logo" width="125" align="right">

# `zest` - config bootstrapper
### `zest` is a command-line tool for managing config files.

## Getting Started
### Creating the config directory
Start using `zest` by creating a directory:
```sh
$ mkdir ~/.cfg
$ cd ~/.cfg
```

Then create a `.zest.yml` file in that directory:
```sh
$ touch .zest.yml
```

The `.zest.yml` file signifies a `zest` config directory, along with containing configuration.

### Adding config files
Let's add the config files for [Vim][vim].
The core Vim config is stored in `~/.vimrc` and `~/.gvimrc` (for graphical Vim).

First create a `vim` directory in the config directory:
```sh
$ mkdir vim
```

Then add the config files:
```sh
$ cp ~/.vimrc vim/vimrc
$ cp ~/.gvimrc vim/gvimrc
```

[vim]: https://wikipedia.org/wiki/Vim_(text_editor)

### Creating a bootstrap.yml file
To turn the `vim` directory into a `zest` config, we need to add a `bootstrap.yml` file.

First create a `bootstrap.yml` file in the `vim` directory:
```sh
$ touch vim/bootstrap.yml
```

Then write this YAML to the `bootstrap.yml` file in your preferred editor:
```yaml
config:
  link:
    - ~/.vimrc: vimrc
    - ~/.gvimrc: gvimrc
```

This `bootstrap.yml` file specifies that `~/.vimrc` and `~/.gvimrc` will be symlinked to their respective files.
If you use MacOS, this is the equivalent of aliasing a file to a given location in Finder.

`bootstrap.yml` is written in [YAML][yaml], hence the syntax.
The equivalent to the above YAML in JSON would look like:
```json
{
  "config": {
    "link": [
      { "~/.vimrc": "vimrc" },
      { "~/.gvimrc": "gvimrc" }
    ]
  }
}
```

[yaml]: https://wikipedia.org/wiki/YAML

### Running the config
Let's try running our completed Vim config!

First backup the current `.vimrc` and `.gvimrc`:
```sh
$ mv ~/.vimrc ~/.vimrc.bk
$ mv ~/.gvimrc ~/.gvimrc.bk
```

Then run the config using `zest`:
```sh
$ zest config run vim
```

If you look at `~/.vimrc` and `~/.gvimrc`, they will be symlinked to the files in the config directory!

## More Information
The `example` directory in this repository contains example config files for `zest`.
The files have all the settings you can use for configuring `zest`!
