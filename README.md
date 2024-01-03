# CMake Template
My personal lightweight CMake template for C++. Focused on Linux.

## Required packages
Make sure to install the required packages per your system.
GLFW is required to run the OpenGL example that comes with this template. 

#### Fedora
    sudo dnf install gcc make cmake clang clang-tools-extra glfw glfw-devel

#### Ubuntu 
    sudo apt install build-essential cmake clang clang-tools-extra libglfw3 libglfw3-dev


## Building & Features
Simply run build.sh to compile and run the program. CMake is run everytime so any changes you've made to CMakeLists.txt will be applied. 

You can easily change build types or compilers. The script will manage multiple build directories for each different configuration. 
**Note** You only need pass any argument once. The settings are written to a .build-config file and will be remembered next time.

|  Arg | Options  |
| :---: | --- |
| -b | Debug, Release, RelWithDebInfo, MinSizeRel  |
| -c | gcc, clang |

#### Example usage
    ./build.sh -b Release -c clang

## Features
- You can reference the assets folder with the `ASSETS_PATH` macro defined in CMakeLists.txt. By default, it's absolute path on your machine. Consider setting it to relative when distributing. 
- `format.sh` will format the entire src directory using clang-format. It will only process common C/C++ file extensions. You can add more if you wish. 
