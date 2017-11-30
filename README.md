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
