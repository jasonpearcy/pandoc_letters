# pandoc_letters

Below is documentation that has been added to the Pandoc manual regarding letter support.
This repository contains the examples used in the manual as separate files
with any supporting letterhead or signature files.  You can easily convert the Markdown
letters into TeX or PDF by using the Makefile (type `make`).

# Creating Letters with Pandoc

Until now, creating letters with Pandoc has relied mostly on external templates.
Notable examples include:

 - [pandoc-letter] by Aaron Wolen and Andrew Dunning
 - [pandoc-scrlttr2] by Jens Erat

You can now use Pandoc to create a letter producing a PDF or a TeX file using the
included `letter.latex` template.  To create a letter, set `documentclass` to [`letter`],
[`scrlttr2`], or use one of the [KOMA-Script] classes with

    scrletter: true

included in the YAML metadata block.

Here's the Markdown source for a simple letter, `simple_letter.md`:

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

To produce a PDF of the letter, simply type

    pandoc -t latex --template=letter.latex -o simple_letter.pdf simple_letter.md

While most letter related features are supported, there is currently no support for:

 - Envelope creation
 - Multiple letters from one input file
 - Form letters

## [`letter`] Class Support

Here's the Markdown source for a more full featured letter, `full_featured_letter.md`:

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
    ps: P.S. I didn't add support for all letter features, but you can use `header-includes` for obscure ones.
    signature-before: -3\baselineskip
    signature-after: 2\baselineskip
    signature-file: my-signature.png
    letterhead-file: my-letterhead.png
    colorlinks: true
    ...

    Thanks for the recent discussion on [LaTeX letter support](https://github.com/jgm/pandoc/discussions/10203).
    I've created a `letter.latex` template to support letter writing with Pandoc, and I'd appreciate any feedback
    or suggestions you might have.

    They say no one writes letters anymore, and if that’s true, then this change may not be necessary.
    However, I believe the real reason no one writes letters anymore is that it’s not yet easy to do with Pandoc.

To produce a PDF of the letter, simply type

    pandoc -t latex --template=letter.latex -o full_featured_letter.pdf full_featured_letter.md

Compared to the simple letter, the full featured letter includes additional standard letter options:

 - Enclosures
 - Carbon Copy List
 - Post Script

The full featured letter includes a letterhead image and a signature image, with options discussed below.
As an example of how to change additional letter features, the enclosure name is 
changed from `encl` to `Reference files(s)` using `header-includes`.  

## Letterhead Image

To add a letterhead image to your letter, specify the `letterhead-file` in the YAML metadata block.
This option is supported for both the [`letter`] class and [KOMA-Script].

For the [`letter`] class, the [`wallpaper`] package is used to include a letterhead image, similar to
[pandoc-letter].  The alternatives of using graphicx and/or fancyhdr are not easily supported by the [`letter`] class.

## Signature

By default, the printed name of the author(s) will be included in the signature.  You can include
an image of a signature if the `signature-file` is specified in the YAML metadata block.  Including
an image of a signature is supported for both the [`letter`] class and [KOMA-Script].

For the [`letter`] class, you will often want to add negative vertical space between the closing and the signature.
Otherwise, you may want to add positive vertical space.
This is done by setting a negative length for the `signature-before` variable.  You can adjust
the vertical spacing after the printed signature by setting `signature-after`.  The `closing-indentation` variable
adjusts the horizontal spacing of the closing and signature.

## [KOMA-Script] Support

Letters in [KOMA-Script] are produced using the [`scrlttr2`] document class or by using
a standard [KOMA-Script] document class and including the [`scrletter`] package.  Both
approaches are equivalent, but using
a standard [KOMA-Script] document class and including the [`scrletter`] package is
the preferred option.


### [`scrlttr2`] Example

Here's the Markdown source for a letter using the [`scrlttr2`] document class, `scrlttr2_letter.md`:

    ---
    documentclass: scrlttr2
    classoption:
    - subject=titled
    scrletter-options:
    - \setkomavar{subject}{Pandoc Letters}
    author:
    - Jason Pearcy
    return-address: 
    - Jason Pearcy
    - Bozeman, MT
    to-address:
    - John MacFarlane
    - Berkeley, CA
    date: \today
    opening: "Dear John,"
    closing: "Cheers,"
    closing-indentation: "20em"
    cc:
    - jpcirrus
    - twsh
    ps: P.S. I didn't add support for all letter features, but you can use `header-includes` for obscure ones.
    signature-before: \baselineskip
    signature-after: 2\baselineskip
    signature-file: my-signature.png
    letterhead-file: my-letterhead.png
    colorlinks: true
    ...

    Thanks for the recent discussion on [LaTeX letter support](https://github.com/jgm/pandoc/discussions/10203).
    I've created a `letter.latex` template to support letter writing with Pandoc, and I'd appreciate any feedback
    or suggestions you might have.

    They say no one writes letters anymore, and if that’s true, then this change may not be necessary.
    However, I believe the real reason no one writes letters anymore is that it’s not yet easy to do with Pandoc.

To produce a PDF of the letter, type

    pandoc -t latex --template=letter.latex -o scrlttr2_letter.pdf scrlttr2_letter.md

This example is similar to the full featured letter above with the addition of a subject.  In general, letters
with [KOMA-Script] allow for more customization than letters with the [`letter`] class.

### [`scrletter`] Example

Here's the Markdown source for a letter using the [`scrartcl`] document class with the
[`scrletter`] package, `scrletter_letter.md`:

    ---
    documentclass: scrartcl
    scrletter: true
    scrletter-options:
    - \KOMAoption{subject}{titled}
    - \KOMAoption{backaddress}{false}
    - \setkomavar{subject}{Pandoc Letters}
    letteroption:
    - SN          # typeset following SN norm for Swiss letters
    author:
    - Jason Pearcy
    return-address: 
    - Jason Pearcy
    - Bozeman, MT
    to-address:
    - John MacFarlane
    - Berkeley, CA
    date: "9 October 2024"
    opening: "Dear John,"
    closing: "Cheers,"
    cc:
    - jpcirrus
    - twsh
    ps: P.S. I didn't add support for all letter features, but you can use `header-includes` for obscure ones.
    signature-file: my-signature.png
    colorlinks: true
    ...

    Thanks for the recent discussion on [LaTeX letter support](https://github.com/jgm/pandoc/discussions/10203).
    I've created a `letter.latex` template to support letter writing with Pandoc, and I'd appreciate any feedback
    or suggestions you might have.

    They say no one writes letters anymore, and if that’s true, then this change may not be necessary.
    However, I believe the real reason no one writes letters anymore is that it’s not yet easy to do with Pandoc.

To produce a PDF of the letter, type

    pandoc -t latex --template=letter.latex -o scrletter_letter.pdf scrletter_letter.md

A formatting difference with this letter is that the SN letteroption is used.  The SN letteroption
will typeset the letter using the norm for Swiss letters.  [KOMA-Script] supports
letter class option (lco) files with some lco files included by default.

## Example Differences

In the [`scrlttr2`] Example:

 - You cannot set the `scrletter` variable in the YAML metadata block.  Not even `scrletter: false`.
 - [KOMA-Script] options, variables and plengths can be set in either the `header-includes` or the `scrletter-options`.

In the [`scrletter`] Example:

 - You must set the `scrletter` variable in the YAML metadata block to produce a letter.  You can even set `scrletter: false`.
 - [KOMA-Script] options, variables and plengths can ONLY be set in the `scrletter-options`.

If you're using [KOMA-Script] and not using the [`scrlttr2`] document class, you must load the [`scrletter`] package
prior to setting any KOMA options, variables, or plengths.  If these options are included in the `header-includes`
they will be set prior to the package being loaded and create an error.

If you're using the [`scrlttr2`] document class, loading the [`scrletter`] package will create an error.
If you need to set any KOMA options, variables, or plengths, this can be done in either the `header-includes` or
the `scrletter-options`.


# Templates

## Variables

### Variables for LaTeX

#### LaTeX Letters

Pandoc uses these optional varibles when creating a letter.

`cc`
:   a list of carbon copy recipients

`closing`
:   the closing of the letter, such as `Sincerely,`

`closing-indentation`
:   a length value used to indent the closing and the signature

`encl`
:   a list of enclosures

`letterhead-file`
:   the filename of the letterhead image

`letteroption`
:   a list of lco files to use for formatting when using one of the [KOMA-Script] classes

`opening`
:   the opening of the letter, such as `Dear John,`

`ps`
:   the post script text to include

`return-address`
:   the address of the letter writer

`signature-after`
:   the amount of vertical space to add after the printed signature

`signature-before`
:   the amount of vertical space to add before the signature image

`signature-file`
:   the filename of the signature image

`scrletter`
:   a variable that when defined will load the scrletter package   

`scrletter-options`
:   a list of [KOMA-Script] options, variables, or plengths to set

`to-address`
:   the name and address of the letter recipient

[`letter`]: https://ctan.org/pkg/letter
[KOMA-Script]: https://ctan.org/pkg/koma-script
[pandoc-letter]: https://github.com/aaronwolen/pandoc-letter
[pandoc-scrlttr2]: https://github.com/JensErat/pandoc-scrlttr2
[`scrletter`]: https://ctan.org/pkg/scrletter
[`scrlttr2`]: https://ctan.org/pkg/scrlttr2
[`wallpaper`]: https://ctan.org/pkg/wallpaper