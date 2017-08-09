# Thesis

The repository contains a PhD thesis in computer science.

## Requirements

The thesis can be compiled using the [MacTeX][mactex] distribution. Apart from
the typefaces provided by MacTeX, the following typefaces have to be installed:

* [Input Mono][input] (Narrow),
* [Korolev LiU][korolev] (Medium), and
* [Miller Text][miller] (Roman, Roman Small Caps, and Italic).

In case any of the aforementioned typefaces are not available, they can be
changed in `thesis.cls`, which, however, is likely to ruin the layout of the
thesis.

## Compilation

```bash
latexmk -xelatex thesis.tex
```

## Copyright

© 2017 Ivan Ukhov

[input]: http://input.fontbureau.com/
[korolev]: https://liu.se/en/
[mactex]: https://www.tug.org/mactex/
[miller]: https://store.typenetwork.com/foundry/cartercone/series/miller?family=miller-text
