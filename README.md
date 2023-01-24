# vpm

vpm(`0.0.3`) is a package manager for V, written on V.

* The package is now downloaded to the `~/.vmodules` directory.

#### Requirements

* V compiler `>=v0.3.2`.
* Install `git`, because the package is currently downloaded via `git clone`.

#### Building

```bash
$ git clone https://github.com/dvwallin/vpm
$ cd vpm
$ v -prod .
```

#### CLI Usage

| Command        | Params                    | Description                                                  |
| :------------- | :------------------------ | :----------------------------------------------------------- |
| `-v`/`version` |                           | Show `vpm` version                                           |
| `init`         | `<project-name>`          | Initialize project (create the `vpm.json` file)              |
| `get`          | `<git-url>`  `<pkg-name>` | Fetch package from the git repo (add dependency to the `vpm.json`. |
| `install`      |                           | Install the package from the `vpm.json` file.                |
| `-h`/`help`    |                           | Show help information.                                       |
| `clean`        |                           | Delete the `vpm.json` file.                                  |
| `ls`           |                           | Show installed packages list                                 |
| `rm`           | `<package-name>`...       | Remove packages in the `vpm.json` file by name               |

#### Packages

For an overview of all the available and supported packages, you can look at [VPM Repository](http://vpmrepository.com).

#### Example

Here is an example of using the `vargs`  package.

* Make project directory `test`

```bash
$ mkdir test
$ cd test
```

* Init `vpm.json`

```bash
$ vpm init
```

* Write example code

```bash
$ vim main.v
```

```rust
import vargs
import os

fn main() {
    _args := vargs.parse(os.args, 1)
    println(_args.str())
    println(_args.command)
    println(_args.unknown[0])
}
```

* Install `args` package

```bash
$ vpm get https://github.com/nedpals/v-args vargs
```

* Build

```bash
$ v -prod main.v
```

* Run 

```bash
$ ./main hello world
{ command: hello, options: {}, unknown: ["world"] }
hello
world
```

## License
MIT License

Copyright (c) 2023 DVWALLIN

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

