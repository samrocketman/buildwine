# Build WINE on Ubuntu 16.04

This document is designed to build wine and install it in a user writeable
prefix at `$HOME/usr`.  This was done to play No Man's Sky on WINE but the
pre-built Ubuntu packages didn't seem to work at all.

I have registered my experience with the [No Man's Sky GOG page on the
AppDB][appdb_nms].

Other references:

* [Ubuntu wiki page on WINE][wine_ubuntu]
* [Building Biarch WINE][wine_biarch]

# Install prerequisites for building Biarch WINE

Install prerequisites for both 64-bit and 32-bit software building.

    ./dependencies.sh

# Building Biarch WINE

Configurable environment variables:

* `PREFIX` - You can choose your prefix to specify a new custom prefix (defaults
  to `$HOME/usr`).
* `WINE_VERSION` - Choose the git tag or branch in which to build WINE (defaults
  to git tag `wine-1.9.16`).

I created [a script](makewine.sh) which helps automate the building on Ubuntu.

    ./makewine.sh

Alternatively, specify a custom `PREFIX` as an example.

    PREFIX="$HOME/usr" ./makewine.sh

Once building is complete don't forget to add `$PREFIX` to your `$PATH`
environment variable.  For example, add to your `~/.bashrc` file:

```bash
export PATH="${HOME}/usr/bin:${PATH}"
```

> Note: the script builds WINE from master but I have built WINE 1.9.16 for No
> Man's Sky.  You can do that in the following way.

>     WINE_VERSION=wine-1.9.16 ./makewine.sh

# Setting up WINE for No Man's Sky

This is for setting up WINE for No Man's Sky GOG edition.

```bash
#create $HOME/.wine
wineboot
#Configure WINE for Windows XP and alternatively change DPI for Hi DPI monitor
winecfg
#Install No Man's Sky prereqs
winetricks -q msxml3
winetricks -q vcrun2010
winetricks -q vcrun2013
#optionally set the Video memory size
winetricks videomemorysize=2048
#Install No Man's Sky
wine setup_no_mans_sky_2.3.0.5.exe
```

> Note: WINE on Ubuntu does not work with WINE configured as Windows 7; however
> Windows XP worked for me.

Then you may start No Man's Sky.

```bash
wine "C:\\GOG Games\\No Man's Sky\\Binaries\\NMS.exe"
```

[appdb_nms]: https://appdb.winehq.org/objectManager.php?sClass=version&iId=34056
[wine_biarch]: https://wiki.winehq.org/Building_Biarch_Wine_On_Ubuntu
[wine_ubuntu]: https://wiki.winehq.org/Ubuntu
