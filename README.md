## WHAT'S THAT?

This is my `mfld` Gentoo overlay.

It contains currently a custom version of the `cnijfilter` packages (Canon Pixma inkjet printers drivers for CUPS), targetting my personal ip7250 printer, that I archived here after being reviewed by the Gentoo developers (but not accepted at the end, see the [pull request](https://github.com/gentoo/gentoo/pull/5595)).

Thanks to the [@Sabayon](https://github.com/sabayon) project where I initially sourced the packages, to [@tokiclover](https://github.com/tokiclover) (maintainer of the Bar overlay) who has been supporting the Canon printer topic for several years now, and to [@willnewton](https://github.com/willnewton/cnijfilter) for one source patch.

## WHAT'S NOW & NEXT ?

* Current release is `r3.80-1`, that is based on the original 3.80-1 sources from Canon, plus some patches sourced from several other projects (see above), plus some fixes in an effort to reduce the number of the compilation warnings.

* **BUG**: after moving to Gentoo profile 17.1, the configuration files should be installed not anymore in `/usr/lib64`, but in `/usr/lib`, especially the `cnijlib` folder and `bilib` symbolic link.

* The next release `r3.80-2` would download the patched sources from GitHub, rather than from some obscure Canon server, and would allow to remove completely the patch file.
