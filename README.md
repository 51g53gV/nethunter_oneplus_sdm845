
 ## OnePlus 6 / 6T - NetHunter kernel
 
 ### Supports
 * Android 10
 * A bunch of external WiFi adapters
 * A bunch of Bluetooth adapters
 * CAN network support
 * Latest linux-firmware integrated in kernel
 * Frame injection patches added
 * HID gadget
 * USB gadget
 * USB OTG-Y (charge while using external adapter)
 
 ### TODO
 * Add wireguard support
 * Merge more/newer linux stable kernel patches

### HowTo build kernel source
First you will require a functionally toolchain, create toolchain folder and setup ..
```
$ cd
$ mkdir toolchains && cd toolchains/
$ git clone https://gitlab.com/HDTC/gclang.git
$ git clone https://bitbucket.org/xanaxdroid/aarch64-8.0.git
$ cd ..
$ git clone https://github.com/kimocoder/nethunter_kernel_oneplus_sdm845 -b nethunter-10.0
```
Then you will need to edit the "run.sh" and "build.sh" to point to correct setup/kernel tree.


 ### Wi-Fi chipsets tested
 * rt2800usb: supports monitor mode and frame injection.
 * carl9170: support monitor mode and frame injection.
 * rt73usb: support monitor mode, not frame injection.
 * r8188eu: does not support monitor mode or frame injection at this point.

