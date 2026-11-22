# PortMidi plugin

Live MIDI input for Synth Lab. The plugin in `Assets/Plugins/PortMidi` has three parts:

| File | Built from |
| --- | --- |
| `PortMidi.nslib` | `MidiIn.ns` in this folder |
| `Native/x86_64/portmidi.dll` | [PortMidi](https://github.com/PortMidi/portmidi) v2.0.8 |
| `Native/x86_64/libportmidi.so` | the same source |

The engine only finds native libraries in a `Native` folder next to a compiled `.nslib`, which
is why the bindings are a plugin and not a script in `Assets`.

## Rebuilding the bindings

```
build.cmd "path\to\Nio-Editor.exe"
```

## Rebuilding PortMidi

PortMidi is unmodified. Both libraries are plain CMake builds of the `v2.0.8` tag.

Windows, with MinGW-w64 gcc and Ninja:

```
cmake -S portmidi -B build -G Ninja -DCMAKE_C_COMPILER=gcc -DCMAKE_BUILD_TYPE=Release -DCMAKE_SHARED_LINKER_FLAGS="-static-libgcc -s"
cmake --build build
```

Copy `build/libportmidi.dll` to `Native/x86_64/portmidi.dll`.

Linux, with gcc and the ALSA headers (`libasound2-dev`):

```
cmake -S portmidi -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
strip --strip-unneeded build/libportmidi.so.2.0.8
```

Copy `build/libportmidi.so.2.0.8` to `Native/x86_64/libportmidi.so`. It needs `libasound.so.2`
at run time.
