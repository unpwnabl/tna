# TNA

![](https://img.shields.io/badge/Build-passing-brightgreen) [![GitHub Repo stars](https://img.shields.io/github/stars/unpwnabl/tna)](https://github.com/unpwnabl/Game-Engine/stargazers) ![License](https://img.shields.io/github/license/unpwnabl/tna)
</br>
TNA - The Terminal-Nucleic Acide animation, completely in [Bash](https://www.gnu.org/software/bash/). 

![](/img/example.svg)

## Installation

To install, download all of the files from the [github repository](https://www.github.com/unpwnabl/tna) into your local machine at any desired path:
```bash
git pull https://github.com/unpwnabl/tna
cd tna
```
Then, run the [make](https://www.gnu.org/software/make/) command `make install` to install, or `make uninstall` to uninstall the program.
```bash
make install
```

## Run

To run the program, after installing using `make`, just type:
```bash
tna
```

Use `-h` or `--help` to view a list of commands:
```bash
Usage:
	-h, --help				            Display this message
	-s=[option], --speed=[option]		Set refresh speed
	-e=[option], --escape-code=[option]	Set the ANSI escape code
						                default = '\033'
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
This project is licensed under the [GPL-3.0 License](https://www.gnu.org/licenses/gpl-3.0.html).
