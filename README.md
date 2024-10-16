# svsal-tei

TEI XML files of the project [The School of Salamanca](https://salamanca.school/). Works, Dictionary Articles and more.

## What's this?

The project [The School of Salamanca](https://salamanca.school/) of the Academy of Sciences and Literature | Mainz, in
collaboration with the
[Institute for Philosophy of the Goethe University Frankfurt](http://www.philosophie.uni-frankfurt.de/) and the
[Max Planck Institute for Legal History and Legal Theory](https://www.lhlt.mpg.de/), establishes a digital collection of sources
and a dictionary of the juridical-political language of the eponymous school. If you want to learn more about the
School of Salamanca and its role in the history of political and juridical thought, you can find more information on
the project's [website](https://salamanca.school/), but of course you may also prefer to start with scholarly reference
works, such as the respective entries in the
[Stanford Encyclopedia of Philosophy](https://plato.stanford.edu/entries/school-salamanca/) or the
[Encyclopedia of Renaissance Philosophy](https://doi.org/10.1007/978-3-319-02848-4_692-1).
Of course, [Wikipedia](https://en.wikipedia.org/wiki/School_of_Salamanca) has entries in several languages, too.

These files represent historical works of authors of the school or modern dictionary articles about salient topics
of the (Western) juridical-political language as it has been shaped by the school. They have passed several stages
of editorial work and quality assurance. They have been evolving in a private repository and are available for reading
on the website of the project. Once they have arrived in this repository, they are ready to be shared
and forwarded to a long-time archival site and research data repository at [zenodo.org](https://zenodo.org/). This
forwarding happens automatically with every TEI file checked in here, and is done with the
[tei2zenodo service](https://gitlab.gwdg.de/mpilhlt/tei2zenodo) developed at the MPI for Legal History and Legal Theory.

## Technical preparation of the files

Unlike in this repository, the XML files in our working contexts are organized in a modularized way: Redundant metadata
about the project and about the handling of special characters is described in stand-alone files
(<https://files.salamanca.school/works-general.xml> and <https://files.salamanca.school/specialchars.xml>) and included
in the respective processing via the [XML XInclude](https://www.w3.org/TR/xinclude-11/) mechanism.

For submission to the research data repository, we have to resolve these XInclude constructs so that the files can in
fact stand alone, and to adjust some bits of our vocabulary: the repository expects information about contributor roles
and licenses to be expressed differently from what we use in the project. This preparation is done with the
[prepare.cmd](./prepare.cmd) script, which calls [GNU sed](https://www.gnu.org/software/sed/sed.html),
[XMLlint](https://gitlab.gnome.org/GNOME/libxml2/-/wikis/home), and some processing of XSLT via
[Saxon Home Edition](https://www.saxonica.com/products/products.xml).

(Xmllint seems to be among the VERY few tools able to resolve our XIncludes (since it can make use of
the xpointer scheme in the xpointer attribute) besides [eXist-db](https://exist-db.org/) and our online web application.
See <https://www.zlatkovic.com/projects/libxml/index.html> for download links and more information about xmllint on
windows.)

We include all the necessary files here for convenience (see the [prepare](./prepare/) subdirectory).

## Licence

All the files are available under open access terms: They are licensed under
the terms of the
[Creative Commons Attribution licence (CC-BY 4.0)](https://creativecommons.org/licenses/by/4.0) except where stated
differently in the files themselves (in the `/TEI/teiHeader/fileDesc/publicationStmt/availability/licence` element
or thereabouts).
