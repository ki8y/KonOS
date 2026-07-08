# KonOS Rewrite
For about a year now, KonOS has been stuck in development hell. This is mostly because KonOS became a mess of unorganized, messy, old code from back when I was a lot worse at writing powershell scripts. Because of this, I decided it would be better to just rewrite the whole thing. This rewrite is still extremely unfinished, so for now it gets it's own branch. Once it's finished, it'll take over the main branch.

⚠️ Please do not run this on your computer yet, it's extremely unfinished and WILL cause issues.

### What this re-write aims to accomplish:
- Better organization
   - One of the main reasons KonOS became so hard to maintain was because I have terrible organization. I want to make sure I'm better at it this time.
- Performance improvements:
   - Setting up KonOS used to be pretty slow, I want to make it ultra-fast by improving my messy code. I'll use .NET methods more, maybe I'll even write certain parts in C#.
- Improved customization:
   - The old KonOS had a lot of issues with hardcoding and lack of customization, which is concerning since that's one of the main reasons I wanted to make KonOS in the first place. I want to fix that.
- Improved user-friendliness
   - Windows optimization tools are meant to make optimizing your computer easy, and the old KonOS was complicated and messy. I want to fix that in a few ways:
      - Clear documentation that explains things in a non-technical way
      - No cryptic error messages
      - A graphical user interface after installation that makes it easy to customize whatever you want, whether you're an advanced user or a beginner.
      - User friendly logs in the console (keeps verbose logs in a file)
### Some changes I've made so far:
- Performance improvements
   - Registry changes are now done with .NET methods for maximum speed
- Less hardcoding
   - All tweaks are now stored inside JSON files
- Title screen changes
   - The title screen is now centered no matter what window size you're using. If you resize your window, it'll redraw itself to be centered at all times

     <sup>Unfortunately, redrawing causes a flicker effect on lower end hardware. I don't think I'll be fixing this</sup>
- "Kon OS" has been renamed to "KonOS". Less emphasis on the "OS" part.
### Todo list (planned changes):
[ ] Add a user friendly GUI so you can toggle every tweak on/off. Currently experimenting with Python, but I might switch to C#. Avoiding powershell since it's clunky with GUI's.
[ ] Add importing/exporting tweaking profiles (Exporting a tweaking profile creates a json file, which you can import and apply automatically).
[ ] Port all tweaks from the original KonOS back into this rewrite.
[ ] Add unattended setup (You input your settings before the setup even starts. Your settings get saved into a config file, you run the script, and it does the rest).
[ ] Finish Get-Dependencies.ps1

### How to run it:
1. Open PowerShell with admin
2. Copy and paste this code
```ps1
& {
    # Set Execution Policy to "Bypass"
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
    
    # Enforce TLS 1.2 (For secure downloads)
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

    # Run da script
    Invoke-Expression ((Invoke-RestMethod 'https://raw.githubusercontent.com/ki8y/KonOS/KonOS-Rewrite/bootstrapper.ps1').TrimStart([char]0xFEFF))
}
```
3. You're done, from here read the installation wiki.

<sup>Note: The installation wiki does not exist yet. Sorry...</sup>
