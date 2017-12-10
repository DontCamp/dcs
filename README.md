# DCS Stuff

## Branches

master is intended to hold scripts and other junk needed for easily distributing stuff in here.

Missions live in orphaned branches in their unzipped form. Create an orphaned branch with
`git checkout --orphan <branchname>`.

## Making a .miz file

DCS requires the missions file to be zipped and have the **.miz** extension. It's easy enough to
create a zip folder natively in Windows, but be sure to create the zip folder from the files in
the root of the branch and not from a directory containing those files (an easy mistake to make
with the Windows UI). There should be a **mission** file at the root of the zip file.

Your **.miz** (zip) file should look like this:
```
mission-budahas.miz
├── l10n
│   └── DEFAULT
│       ├── dictionary
│       ├── mapResource
│       └── mist_4_3_74.lua
├── mission
├── options
└── warehouses
```

## Skins (Liveries) Curation

There are a lot of ways to install DCS liveries, many of them undesirable, such as mod managers, or stuffing junk into your DCS installation directory.  [There is a better way](https://forums.eagle.ru/showthread.php?t=190778), by using the **C:\Users\myusername\Saved Games\DCS directory**, which is a search path/overlay thing that is neat.  

The tricky part is adapting the existing skin distribution stuff out there to this process.  In the end, a server owner could distribute a ZIP file that could populate this path for all clients so that skins could be seen by everyone in multiplayer:

**C:\Users\myusername\Saved Games\DCS\Liveries**

Given this, it's suggested that ace pilots who want a sweet skin proceed to contribute to a community ZIP file by figuring out the proper overlay/search path for their aircraft, dumping the files in to the **Saved Games/Liveries** dir, and then testing those changes locally before adding to the community ZIP file.  

Based on the author's experience, it seems that modules produced by Eagle Dynamics may have installation paths looking a bit like this:

**C:\Program Files (x86)\Steam\steamapps\common\DCSWorld\Bazar\Liveries\su-27**

Which, for the **Saved Games/Liveries** overlay/search path becomes:

**C:\Users\myusername\Saved Games\DCS\Liveries\su-27**

Modules produced by third-party developers, such as the Mirage 2000, may some something like this:

**C:\Program Files (x86)\Steam\steamapps\common\DCSWorld\CoreMods\aircraft\M-2000C\Liveries\M-2000C**

Which, for the **Saved Games/Liveries** overlay/search path becomes:

**C:\Users\yourusername\Saved Games\DCS\Liveries\M-2000C**

After all is said and done, you should wind up with a tree that looks a bit like this:

```
Saved Games/DCS/Liveries
└── M-2000C
    └── Delta Dagger 317
        ├── description.lua
        ├── empty.dds
        ├── M2KC_1T_DD.dds
        ├── M2KC_2T_DD.dds
        ├── M2KC_7T_DD.dds
        └── Thumbs.db
```
