# ⚠️ WARNING ⚠️
If you somehow stumbled upon this repo by chance, PLEASE do not use Kon OS just yet. I haven't tested it yet, it's probably very unstable.
...Like seriously, I'm not even done the readme.md file yet. I just put this here just in case.

# Kon OS - An automated PC optimization tool
Kon OS is a customizable, easy to use, open-source optimization tool for Windows 11. It prioritizes high performance, privacy, and customizability.

## Usage:
- First, the PowerShell execution policy needs to be set to `Bypass`.
```ps1
# Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine
```
- Then, you can install Kon OS by running this one liner:
```ps1
# irm "https://raw.githubusercontent.com/ki8y/KonOS/main/Bootstrapper.ps1" | iex
```
<sub>Unfinished readme :P</sub>

Todo:
- [ ] Finish general tweaks scrpt
- [x] Finish service control script
- [ ] Backport to Windows 10
- [ ] Make Kon OS at least functional (LMFAO)
- [ ] Create an easy post setup configuration wizard (CLI or GUI but I'll prob do CLI since thats easier and idk how to use c# yet...)
- [x] Stop using batch
- [ ] Finish documentation
