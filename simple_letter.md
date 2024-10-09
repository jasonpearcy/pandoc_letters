---
documentclass: letter
author:
- Jason Pearcy
return-address: 
- Jason Pearcy
- Bozeman, MT
to-address:
- John MacFarlane
- Berkeley, CA
date: \today
opening: Dear John,
closing: Cheers,
colorlinks: true
...

Thanks for your [recent changes](https://github.com/jgm/pandoc/commit/2a6268de67b883cd814358111d764d330f100d9b)
that involve splitting out the `default.latex` template using partials.  I'm currently working on adding a new
`letter.latex` template that will offer support for creating letters in Pandoc.  This new template is significantly
simplified by using the updated default template.

In the future, we could consider adding letter-writing support directly into the default.latex template.
This would involve incorporating three partials with minimal other code changes. The main benefit
would be consolidating the LaTeX templates, reducing the need to maintain separate default and letter templates.
