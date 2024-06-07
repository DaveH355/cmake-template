# CMake Template

My personal lightweight CMake template for C++. Focused on Linux.

## Required packages

Make sure to install the required packages per your system.
GLFW is required to run the OpenGL example that comes with this template.

#### Fedora

    sudo dnf upgrade
    sudo dnf install gcc make cmake clang clang-tools-extra glfw glfw-devel

#### Ubuntu

    sudo apt update && sudo apt upgrade
    sudo apt install build-essential cmake clang clang-tools-extra libglfw3 libglfw3-dev

## Building

Simply run `build.sh` to compile and run the program. CMake is run everytime so any changes you've made to CMakeLists.txt will be applied.

You can easily change build types or compilers. The script will manage different build directories for different configurations.

|      Arg       | Options                                    |
| :------------: | ------------------------------------------ |
|  -b, --build   | Debug, Release, RelWithDebInfo, MinSizeRel |
| -c, --compiler | gcc, clang                                 |

#### Example usage

    ./build.sh -b Release -c clang

### Library Management

./external is for libraries that aren't avaliable through the package manager. You can manually add your own and link them in CMake. Or use `fetch.sh`, which can manage header only libraries. Simply edit the file to add more libraries. Then run the script. The headers are stored in ./external/singles which is automatically included into the project.

For larger libraries like imgui, it's better to download manually. Using CMake's FetchContent is clunky as it downloads the same library for every build dir.

### Additional Features

- `format.sh` will format the entire src directory using clang-format. It will only process common C/C++ file extensions. You can add more if you wish.

- You can reference the assets folder with the `ASSETS_PATH` macro defined in CMakeLists.txt. By default, it's absolute path on your machine. Consider setting it to relative when distributing.
