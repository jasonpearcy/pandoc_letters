---
documentclass: letter
header-includes:
- |
  ```{=latex}
  \renewcommand{\enclname}{Reference file(s)}
  ```
author:
- Jason Pearcy
return-address: 
- Jason Pearcy
- Bozeman, MT
to-address:
- John MacFarlane
- Berkeley, CA
date: "October 9, 2024"
opening: "Dear John,"
closing: "Cheers,"
closing-indentation: "0pt"
encl:
- letter.latex
cc:
- jpcirrus
- twsh
ps: "P.S. I didn't add support for all letter features, but you can
use `header-includes` for obscure ones."
signature-before: -3\baselineskip
signature-after: 2\baselineskip
signature-file: my-signature.png
letterhead-file: my-letterhead.png
colorlinks: true
...

Thanks for the recent discussion on
[LaTeX letter support](https://github.com/jgm/pandoc/discussions/10203).
I've created a `letter.latex` template to support letter writing with Pandoc,
and I'd appreciate any feedback or suggestions you might have.

They say no one writes letters anymore, and if that’s true, then this change
may not be necessary.  However, I believe the real reason no one writes letters
anymore is that it’s not yet easy to do with Pandoc.
