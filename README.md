# Thesis

The repository contains a PhD thesis in computer science. The latest version can
be found [here][thesis].

## Requirements

The thesis can be compiled using the [MacTeX][mactex] distribution. Apart from
the typefaces provided by MacTeX, the following typefaces have to be installed:

* [Input Mono][input] (Narrow),
* [Korolev LiU][korolev] (Medium), and
* [Miller Text][miller] (Bold, Italic, Roman, and Roman Small Caps).

In case any of the aforementioned typefaces are not available, they can be
replaced in [`thesis.cls`](thesis.cls), which, however, is likely to destroy the
layout of the thesis.

## Compilation

```bash
latexmk -xelatex thesis.tex
```

## License

The content is distributed under the terms of the [MIT license](LICENSE.md).

[thesis]: https://quantum-philosophy.github.io/thesis/thesis.pdf

[input]: http://input.fontbureau.com/
[korolev]: https://liu.se/en/
[mactex]: https://www.tug.org/mactex/
[miller]: https://store.typenetwork.com/foundry/cartercone/series/miller?family=miller-text
