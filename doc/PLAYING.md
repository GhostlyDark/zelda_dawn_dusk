# How to Play

## ROM Version

The ROM version is intended to work on most emulators and flashcarts in the simplest way possible.

**Therefore the instructions are just: Load the ROM on your favorite emulator or flashcart.**

The save data is not compatible with the Disk version.

## Disk Expansion

Playing the Disk Expansion may seem a bit daunting, but it's pretty simple, but to avoid ANY confusion, all details will be mentioned here, and the instructions here will only mention how to play the disk game on emulator.

### Common Warnings / Requirements

An original **The Legend of Zelda - Ocarina of Time NTSC ROM**, regardless of language and version, is required. **This disk works on version 1.0, 1.1 & 1.2 ROMs.**

Regardless of disk region, **the disk will force the game to use English language instead,** so don't be scared of language barrier.

 * **Using the Japanese disk image file _requires_ the following:**
   * **Japanese Retail** 64DD IPL ROM Image File.
   * **Japanese** Legend of Zelda - Ocarina of Time ROM file (any version).
     * If you have an American ROM, use a hex editor, and change the game ID to `CZLJ`. You do not need to update the checksum.
 * **Using the American disk image file _requires_ the following:**
   * **American Retail** 64DD IPL ROM Image File. (It does exist.)
   * **American** Legend of Zelda - Ocarina of Time ROM file (any version).
     * If you have a Japanese ROM, use a hex editor, and change the game ID to `CZLE`. You do not need to update the checksum.

### Project64

#### Fix Recompiler Crash
To play the game on Recompiler mode for maximal performance, the following should be setup for the Ocarina of Time ROM:
 * **Edit the original game ROM settings.** There are two ways to access the game settings:
   * Right click on the game on the Game Browser, then click on "Edit Game Settings" (last option).
   * Or launch the game, then on the menu bar, select Options, then Settings... _(or press Ctrl+T shortcut)_, and then select Config tab on the left side.
 * Select the Recompiler tab for the game settings.
 * **Make sure that Protect Memory is checked.**

#### Play the Disk Expansion
Once it is done, you can now play the disk expansion by doing the following:
 * Right click on the game on the Game Browser, then select **Play Game with Disk**.
 * **Load the Disk Expansion Image file.**
 * **Load the Retail 64DD IPL ROM image file if it was not configured.**
   * The emulator will not ask you for it again unless it cannot find the file anymore.

**The game should launch with "Disk" on the Title Screen.** Make a save file as normal and you can play the game.

### mupen64plus

While mupen64plus does provide official support for 64DD emulation, **due to the use of uncached memory code execution to fix severe initial cache loading issues on real hardware,** the emulator will crash with the regular Disk image.

The easy way to fix it would be changing this line of code on ./asm/EZLJ_DISK_Macros.asm, on line 22:
 * `define KSEG1(0xA0000000)` to `define KSEG1(0x00000000)`

Then rebuild the disk, and then use the following command line:
 * `mupen64plus-ui-console.exe --dd-ipl-rom <Retail 64DD IPL ROM Filepath> --dd-disk <Dawn & Dusk Disk Image Filepath> <Zelda Ocarina of Time NTSC ROM Filepath>`
 
**The title screen should show "Disk" if you have done it right,** and then make your save file, and have fun.