#WHAT'S THAT?

This is my `mfld` Gentoo overlay.

It contains currently a custom version of the `cnijfilter` packages (Canon Pixma inkjet printers drivers for CUPS), targetting my personal ip7250 printer, that I archived here after being reviewed by the Gentoo developers (but not accepted at the end, see the [pull request](https://github.com/gentoo/gentoo/pull/5595)).

Thanks to the [@Sabayon](https://github.com/sabayon) project where I sourced initially the packages, and to [@tokiclover](https://github.com/tokiclover) (maintainer of the Bar overlay) who has been supporting the Canon printer topic for several years now.

#WHAT'S NOW & NEXT ?

* **BUG**: after moving to Gentoo profile 17.1, the configuration files should be installed not anymore in `/usr/lib64`, but in `/usr/lib`, especially the `cnijlib` folder and `bilib` symbolic link. Tune the `ebuild` accordingly.

* The branch `patch` unifies the various patch files gathered from different sources into a single `cnijfilter-3.80-r1.patch` file, plus some fixes to compiler warnings. This is a pre-release for `r3.80-1` that should be first tested in `/var/db/repos/mfld`. If successful, the branch should be merged to master, tagged and pushed to GitHub.

* The next release `r3.80-2` would download the patched sources from GitHub, rather than from some obscure Canon server, and would allow to remove completely the patch file.
