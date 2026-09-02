%%
%% IEEEtran.bst
%% BibTeX Bibliography Style file for IEEE Journals and Conferences (unsorted)
%% Version 1.14 (2015/08/26)
%% 
%% Copyright (c) 2003-2015 Michael Shell
%% 
%% 
%% Original starting code base and algorithms obtained from the output of
%% Patrick W. Daly's makebst package as well as from prior versions of
%% IEEE BibTeX styles:
%% 
%% 1. Howard Trickey and Oren Patashnik's ieeetr.bst  (1985/1988)
%% 2. Silvano Balemi and Richard H. Roy's IEEEbib.bst (1993)
%% 
%% Support sites:
%% http://www.michaelshell.org/tex/ieeetran/
%% http://www.ctan.org/pkg/ieeetran
%% and/or
%% http://www.ieee.org/
%% 
%% For use with BibTeX version 0.99a or later
%%
%% This is a numerical citation style.
%% 
%%*************************************************************************
%% Legal Notice:
%% This code is offered as-is without any warranty either expressed or
%% implied; without even the implied warranty of MERCHANTABILITY or
%% FITNESS FOR A PARTICULAR PURPOSE! 
%% User assumes all risk.
%% In no event shall the IEEE or any contributor to this code be liable for
%% any damages or losses, including, but not limited to, incidental,
%% consequential, or any other damages, resulting from the use or misuse
%% of any information contained here.
%%
%% All comments are the opinions of their respective authors and are not
%% necessarily endorsed by the IEEE.
%%
%% This work is distributed under the LaTeX Project Public License (LPPL)
%% ( http://www.latex-project.org/ ) version 1.3, and may be freely used,
%% distributed and modified. A copy of the LPPL, version 1.3, is included
%% in the base LaTeX documentation of all distributions of LaTeX released
%% 2003/12/01 or later.
%% Retain all contribution notices and credits.
%% ** Modified files should be clearly indicated as such, including  **
%% ** renaming them and changing author support contact information. **
%%*************************************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DEFAULTS FOR THE CONTROLS OF THE BST STYLE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These are the defaults for the user adjustable controls. The values used
% here can be overridden by the user via IEEEtranBSTCTL entry type.

% NOTE: The recommended LaTeX command to invoke a control entry type is:
% 
%\makeatletter
%\def\bstctlcite{\@ifnextchar[{\@bstctlcite}{\@bstctlcite[@auxout]}}
%\def\@bstctlcite[#1]#2{\@bsphack
%  \@for\@citeb:=#2\do{%
%    \edef\@citeb{\expandafter\@firstofone\@citeb}%
%    \if@filesw\immediate\write\csname #1\endcsname{\string\citation{\@citeb}}\fi}%
%  \@esphack}
%\makeatother
%
% It is called at the start of the document, before the first \cite, like:
% \bstctlcite{IEEEexample:BSTcontrol}
%
% IEEEtran.cls V1.6 and later does provide this command.



% #0 turns off the display of the number for articles.
% #1 enables
FUNCTION {default.is.use.number.for.article} { #1 }


% #0 turns off the display of the paper and type fields in @inproceedings.
% #1 enables
FUNCTION {default.is.use.paper} { #1 }


% #0 turns off the display of urls
% #1 enables
FUNCTION {default.is.use.url} { #1 }


% #0 turns off the forced use of "et al."
% #1 enables
% When there are more than 6 authors, force et al. usage.
FUNCTION {default.is.forced.et.al} { #1 }


% The maximum number of names that can be present beyond which an "et al."
% usage is forced. Be sure that num.names.shown.with.forced.et.al (below)
% is not greater than this value!
% List up to 6 authors; if more, use the primary author + et al.
FUNCTION {default.max.num.names.before.forced.et.al} { #6 }


% The number of names that will be shown with a forced "et al.".
% Must be less than or equal to max.num.names.before.forced.et.al
% Show only the first author followed by "et al."
FUNCTION {default.num.names.shown.with.forced.et.al} { #1 }


% The maximum number of editor names that can appear before "et al." is forced.
% IEEE style allows up to 3 editors; if more, the first editor + et al. is used.
FUNCTION {default.max.num.editors.before.forced.et.al} { #3 }


% #0 turns off the alternate interword spacing for entries with URLs.
% #1 enables
% Disabled by default: the legacy x4 inter-word stretch produced visibly
% loose lines in entries that carry long URLs (blog/news/social-media
% references in particular). Long URLs are still broken safely by the
% \url{} command from the url/hyperref package.
FUNCTION {default.is.use.alt.interword.spacing} { #0 }


% If alternate interword spacing for entries with URLs is enabled, this is
% the interword spacing stretch factor that will be used. For example, the
% default "4" here means that the interword spacing in entries with URLs can
% stretch to four times normal. Does not have to be an integer. Note that
% the value specified here can be overridden by the user in their LaTeX
% code via a command such as:
% "\providecommand\BIBentryALTinterwordstretchfactor{1.5}" in addition to
% that via the IEEEtranBSTCTL entry type.
FUNCTION {default.ALTinterwordstretchfactor} { "1.5" }


% #0 turns off the "dashification" of repeated (i.e., identical to those
% of the previous entry) names. The IEEE normally does this.
% #1 enables
FUNCTION {default.is.dash.repeated.names} { #0 }


% The default name format control string.
FUNCTION {default.name.format.string}{ "{f.~}{vv~}{ll}{, jj}" }


% The default LaTeX font command for the names.
FUNCTION {default.name.latex.cmd}{ "" }


% The default URL prefix.
% NOTE: The leading "[Online]." (or "[Online Video].", etc.) is emitted by
% the format.online.marker function so that the medium can vary per entry
% type (videos, datasets, etc.). The prefix here therefore contains only
% the "Available:" portion that follows the medium marker.
FUNCTION {default.name.url.prefix}{ "Available:" }


% Other controls that cannot be accessed via IEEEtranBSTCTL entry type.

% #0 turns off the terminal startup banner/completed message so as to
% operate more quietly.
% #1 enables
FUNCTION {is.print.banners.to.terminal} { #1 }




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILE VERSION AND BANNER %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION{bst.file.version} { "1.14" }
FUNCTION{bst.file.date} { "2015/08/26" }
FUNCTION{bst.file.website} { "http://www.michaelshell.org/tex/ieeetran/bibtex/" }

FUNCTION {banner.message}
{ is.print.banners.to.terminal
     { "-- IEEEtran.bst version" " " * bst.file.version *
       " (" * bst.file.date * ") " * "by Michael Shell." *
       top$
       "-- " bst.file.website *
       top$
       "-- See the " quote$ * "IEEEtran_bst_HOWTO.pdf" * quote$ * " manual for usage information." *
       top$
     }
     { skip$ }
   if$
}

FUNCTION {completed.message}
{ is.print.banners.to.terminal
     { ""
       top$
       "Done."
       top$
     }
     { skip$ }
   if$
}




%%%%%%%%%%%%%%%%%%%%%%
%% STRING CONSTANTS %%
%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {bbl.and}{ "and" }
FUNCTION {bbl.etal}{ "et~al." }
FUNCTION {bbl.editors}{ "Eds." }
FUNCTION {bbl.editor}{ "Ed." }
FUNCTION {bbl.edition}{ "ed." }
FUNCTION {bbl.volume}{ "vol." }
FUNCTION {bbl.of}{ "of" }
FUNCTION {bbl.number}{ "no." }
FUNCTION {bbl.in}{ "in" }
FUNCTION {bbl.pages}{ "pp." }
FUNCTION {bbl.page}{ "p." }
FUNCTION {bbl.chapter}{ "ch." }
FUNCTION {bbl.paper}{ "paper" }
FUNCTION {bbl.part}{ "pt." }
FUNCTION {bbl.patent}{ "Patent" }
FUNCTION {bbl.patentUS}{ "U.S." }
FUNCTION {bbl.revision}{ "Rev." }
FUNCTION {bbl.series}{ "ser." }
FUNCTION {bbl.standard}{ "Standard" }
FUNCTION {bbl.techrep}{ "Tech. Rep." }
FUNCTION {bbl.mthesis}{ "M.S. thesis" }
FUNCTION {bbl.phdthesis}{ "Ph.D. dissertation" }
FUNCTION {bbl.translator}{ "trans." }
FUNCTION {bbl.accessed}{ "Accessed:" }
FUNCTION {bbl.online}{ "[Online]." }
FUNCTION {bbl.onlinevideo}{ "[Online Video]." }
FUNCTION {bbl.available}{ "Available:" }
FUNCTION {bbl.article.no}{ "Art. no." }
FUNCTION {bbl.presented}{ "presented at" }
FUNCTION {bbl.arxiv}{ "arXiv:" }
FUNCTION {bbl.section}{ "sect." }
FUNCTION {bbl.st}{ "st" }
FUNCTION {bbl.nd}{ "nd" }
FUNCTION {bbl.rd}{ "rd" }
FUNCTION {bbl.th}{ "th" }


% This is the LaTeX spacer that is used when a larger than normal space
% is called for (such as just before the address:publisher).
FUNCTION {large.space} { "\hskip 1em plus 0.5em minus 0.4em\relax " }

% The LaTeX code for dashes that are used to represent repeated names.
% Note: Some older IEEE journals used something like
% "\rule{0.275in}{0.5pt}\," which is fairly thick and runs right along
% the baseline. However, the IEEE now uses a thinner, above baseline,
% six dash long sequence.
FUNCTION {repeated.name.dashes} { "------" }



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PREDEFINED STRING MACROS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MACRO {jan} {"Jan."}
MACRO {feb} {"Feb."}
MACRO {mar} {"Mar."}
MACRO {apr} {"Apr."}
MACRO {may} {"May"}
MACRO {jun} {"Jun."}
MACRO {jul} {"Jul."}
MACRO {aug} {"Aug."}
MACRO {sep} {"Sep."}
MACRO {oct} {"Oct."}
MACRO {nov} {"Nov."}
MACRO {dec} {"Dec."}



%%%%%%%%%%%%%%%%%%
%% ENTRY FIELDS %%
%%%%%%%%%%%%%%%%%%

ENTRY
  { address
    assignee
    author
    articleno
    booktitle
    chapter
    day
    dayfiled
    edition
    editor
    eprint
    eprinttype
    howpublished
    inlanguage
    institution
    intype
    journal
    key
    language
    medium
    month
    monthfiled
    nationality
    note
    number
    organization
    pages
    paper
    publisher
    repository
    school
    section
    series
    revision
    title
    titleraw
    translator
    type
    url
    urldate
    doi
    version
    volume
    year
    yearfiled
    CTLuse_article_number
    CTLuse_paper
    CTLuse_url
    CTLuse_forced_etal
    CTLmax_names_forced_etal
    CTLnames_show_etal
    CTLuse_alt_spacing
    CTLalt_stretch_factor
    CTLdash_repeated_names
    CTLname_format_string
    CTLname_latex_cmd
    CTLname_url_prefix
  }
  {}
  { label }




%%%%%%%%%%%%%%%%%%%%%%%
%% INTEGER VARIABLES %%
%%%%%%%%%%%%%%%%%%%%%%%

INTEGERS { prev.status.punct this.status.punct punct.std
           punct.no punct.comma punct.period 
           prev.status.space this.status.space space.std
           space.no space.normal space.large
           prev.status.quote this.status.quote quote.std
           quote.no quote.close
           prev.status.nline this.status.nline nline.std
           nline.no nline.newblock 
           status.cap cap.std
           cap.no cap.yes}

INTEGERS { longest.label.width multiresult nameptr namesleft number.label numnames }

INTEGERS { is.use.number.for.article
           is.use.paper
           is.use.url
           is.forced.et.al
           max.num.names.before.forced.et.al
           max.num.editors.before.forced.et.al
           num.names.shown.with.forced.et.al
           is.use.alt.interword.spacing
           is.dash.repeated.names}


%%%%%%%%%%%%%%%%%%%%%%
%% STRING VARIABLES %%
%%%%%%%%%%%%%%%%%%%%%%

STRINGS { bibinfo
          longest.label
          oldname
          s
          t
          ALTinterwordstretchfactor
          name.format.string
          name.latex.cmd
          name.url.prefix}

% String / integer scratch space for parsing the urldate field into
% (year, month-numeric, day) components. See parse.urldate below.
STRINGS { ud.y ud.m ud.d ud.tmp ud.parsed }
INTEGERS { ud.idx ud.len ud.space.pos }




%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOW LEVEL FUNCTIONS %%
%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {initialize.controls}
{ default.is.use.number.for.article 'is.use.number.for.article :=
  default.is.use.paper 'is.use.paper :=
  default.is.use.url 'is.use.url :=
  default.is.forced.et.al 'is.forced.et.al :=
  default.max.num.names.before.forced.et.al 'max.num.names.before.forced.et.al :=
  default.max.num.editors.before.forced.et.al 'max.num.editors.before.forced.et.al :=
  default.num.names.shown.with.forced.et.al 'num.names.shown.with.forced.et.al :=
  default.is.use.alt.interword.spacing 'is.use.alt.interword.spacing :=
  default.is.dash.repeated.names 'is.dash.repeated.names :=
  default.ALTinterwordstretchfactor 'ALTinterwordstretchfactor :=
  default.name.format.string 'name.format.string :=
  default.name.latex.cmd 'name.latex.cmd :=
  default.name.url.prefix 'name.url.prefix :=
}


% This IEEEtran.bst features a very powerful and flexible mechanism for
% controlling the capitalization, punctuation, spacing, quotation, and
% newlines of the formatted entry fields. (Note: IEEEtran.bst does not need
% or use the newline/newblock feature, but it has been implemented for
% possible future use.) The output states of IEEEtran.bst consist of
% multiple independent attributes and, as such, can be thought of as being
% vectors, rather than the simple scalar values ("before.all", 
% "mid.sentence", etc.) used in most other .bst files.
% 
% The more flexible and complex design used here was motivated in part by
% the IEEE's rather unusual bibliography style. For example, the IEEE ends the
% previous field item with a period and large space prior to the publisher
% address; the @electronic entry types use periods as inter-item punctuation
% rather than the commas used by the other entry types; and URLs are never
% followed by periods even though they are the last item in the entry.
% Although it is possible to accommodate these features with the conventional
% output state system, the seemingly endless exceptions make for convoluted,
% unreliable and difficult to maintain code.
%
% IEEEtran.bst's output state system can be easily understood via a simple
% illustration of two most recently formatted entry fields (on the stack):
%
%               CURRENT_ITEM
%               "PREVIOUS_ITEM"
%
% which, in this example, is to eventually appear in the bibliography as:
% 
%               "PREVIOUS_ITEM," CURRENT_ITEM
%
% It is the job of the output routine to take the previous item off of the
% stack (while leaving the current item at the top of the stack), apply its
% trailing punctuation (including closing quote marks) and spacing, and then
% to write the result to BibTeX's output buffer:
% 
%               "PREVIOUS_ITEM," 
% 
% Punctuation (and spacing) between items is often determined by both of the
% items rather than just the first one. The presence of quotation marks
% further complicates the situation because, in standard English, trailing
% punctuation marks are supposed to be contained within the quotes.
% 
% IEEEtran.bst maintains two output state (aka "status") vectors which
% correspond to the previous and current (aka "this") items. Each vector
% consists of several independent attributes which track punctuation,
% spacing, quotation, and newlines. Capitalization status is handled by a
% separate scalar because the format routines, not the output routine,
% handle capitalization and, therefore, there is no need to maintain the
% capitalization attribute for both the "previous" and "this" items.
% 
% When a format routine adds a new item, it copies the current output status
% vector to the previous output status vector and (usually) resets the
% current (this) output status vector to a "standard status" vector. Using a
% "standard status" vector in this way allows us to redefine what we mean by
% "standard status" at the start of each entry handler and reuse the same
% format routines under the various inter-item separation schemes. For
% example, the standard status vector for the @book entry type may use
% commas for item separators, while the @electronic type may use periods,
% yet both entry handlers exploit many of the exact same format routines.
% 
% Because format routines have write access to the output status vector of
% the previous item, they can override the punctuation choices of the
% previous format routine! Therefore, it becomes trivial to implement rules
% such as "Always use a period and a large space before the publisher." By
% pushing the generation of the closing quote mark to the output routine, we
% avoid all the problems caused by having to close a quote before having all
% the information required to determine what the punctuation should be.
%
% The IEEEtran.bst output state system can easily be expanded if needed.
% For instance, it is easy to add a "space.tie" attribute value if the
% bibliography rules mandate that two items have to be joined with an
% unbreakable space. 

FUNCTION {initialize.status.constants}
{ #0 'punct.no :=
  #1 'punct.comma :=
  #2 'punct.period :=
  #0 'space.no := 
  #1 'space.normal :=
  #2 'space.large :=
  #0 'quote.no :=
  #1 'quote.close :=
  #0 'cap.no :=
  #1 'cap.yes :=
  #0 'nline.no :=
  #1 'nline.newblock :=
}

FUNCTION {std.status.using.comma}
{ punct.comma 'punct.std :=
  space.normal 'space.std :=
  quote.no 'quote.std :=
  nline.no 'nline.std :=
  cap.no 'cap.std :=
}

FUNCTION {std.status.using.period}
{ punct.period 'punct.std :=
  space.normal 'space.std :=
  quote.no 'quote.std :=
  nline.no 'nline.std :=
  cap.yes 'cap.std :=
}

FUNCTION {initialize.prev.this.status}
{ punct.no 'prev.status.punct :=
  space.no 'prev.status.space :=
  quote.no 'prev.status.quote :=
  nline.no 'prev.status.nline :=
  punct.no 'this.status.punct :=
  space.no 'this.status.space :=
  quote.no 'this.status.quote :=
  nline.no 'this.status.nline :=
  cap.yes 'status.cap :=
}

FUNCTION {this.status.std}
{ punct.std 'this.status.punct :=
  space.std 'this.status.space :=
  quote.std 'this.status.quote :=
  nline.std 'this.status.nline :=
}

FUNCTION {cap.status.std}{ cap.std 'status.cap := }

FUNCTION {this.to.prev.status}
{ this.status.punct 'prev.status.punct :=
  this.status.space 'prev.status.space :=
  this.status.quote 'prev.status.quote :=
  this.status.nline 'prev.status.nline :=
}


FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   { skip$ }
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    { skip$ }
  if$
}


% convert the strings "yes" or "no" to #1 or #0 respectively
FUNCTION {yes.no.to.int}
{ "l" change.case$ duplicate$
    "yes" =
    { pop$  #1 }
    { duplicate$ "no" =
        { pop$ #0 }
        { "unknown boolean " quote$ * swap$ * quote$ *
          " in " * cite$ * warning$
          #0
        }
      if$
    }
  if$
}


% pushes true if the single char string on the stack is in the
% range of "0" to "9"
FUNCTION {is.num}
{ chr.to.int$
  duplicate$ "0" chr.to.int$ < not
  swap$ "9" chr.to.int$ > not and
}

% multiplies the integer on the stack by a factor of 10
FUNCTION {bump.int.mag}
{ #0 'multiresult :=
    { duplicate$ #0 > }
    { #1 -
      multiresult #10 +
      'multiresult :=
    }
  while$
pop$
multiresult
}

% converts a single character string on the stack to an integer
FUNCTION {char.to.integer}
{ duplicate$ 
  is.num
    { chr.to.int$ "0" chr.to.int$ - }
    {"noninteger character " quote$ * swap$ * quote$ *
          " in integer field of " * cite$ * warning$
    #0
    }
  if$
}

% converts a string on the stack to an integer
FUNCTION {string.to.integer}
{ duplicate$ text.length$ 'namesleft :=
  #1 'nameptr :=
  #0 'numnames :=
    { nameptr namesleft > not }
    { duplicate$ nameptr #1 substring$
      char.to.integer numnames bump.int.mag +
      'numnames :=
      nameptr #1 +
      'nameptr :=
    }
  while$
pop$
numnames
}




% The output routines write out the *next* to the top (previous) item on the
% stack, adding punctuation and such as needed. Since IEEEtran.bst maintains
% the output status for the top two items on the stack, these output
% routines have to consider the previous output status (which corresponds to
% the item that is being output). Full independent control of punctuation,
% closing quote marks, spacing, and newblock is provided.
% 
% "output.nonnull" does not check for the presence of a previous empty
% item.
% 
% "output" does check for the presence of a previous empty item and will
% remove an empty item rather than outputing it.
% 
% "output.warn" is like "output", but will issue a warning if it detects
% an empty item.

FUNCTION {output.nonnull}
{ swap$
  prev.status.punct punct.comma =
     { "," * }
     { skip$ }
   if$
  prev.status.punct punct.period =
     { add.period$ }
     { skip$ }
   if$ 
  prev.status.quote quote.close =
     { "''" * }
     { skip$ }
   if$
  prev.status.space space.normal =
     { " " * }
     { skip$ }
   if$
  prev.status.space space.large =
     { large.space * }
     { skip$ }
   if$
  write$
  prev.status.nline nline.newblock =
     { newline$ "\newblock " write$ }
     { skip$ }
   if$
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.warn}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

% "fin.entry" is the output routine that handles the last item of the entry
% (which will be on the top of the stack when "fin.entry" is called).

FUNCTION {fin.entry}
{ this.status.punct punct.no =
     { skip$ }
     { add.period$ }
   if$
   this.status.quote quote.close =
     { "''" * }
     { skip$ }
   if$
write$
newline$
}


FUNCTION {is.last.char.not.punct}
{ duplicate$
   "}" * add.period$
   #-1 #1 substring$ "." =
}

FUNCTION {is.multiple.pages}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {capitalize}{ "u" change.case$ "t" change.case$ }

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\emph{" swap$ * "}" * }
  if$
}

FUNCTION {do.name.latex.cmd}
{ name.latex.cmd
  empty$
    { skip$ }
    { name.latex.cmd "{" * swap$ * "}" * }
  if$
}

% IEEEtran.bst uses its own \BIBforeignlanguage command which directly
% invokes the TeX hyphenation patterns without the need of the Babel
% package. Babel does a lot more than switch hyphenation patterns and
% its loading can cause unintended effects in many class files (such as
% IEEEtran.cls).
FUNCTION {select.language}
{ duplicate$ empty$ 'pop$
    { language empty$ 'skip$
        { "\BIBforeignlanguage{" language * "}{" * swap$ * "}" * }
      if$
    }
  if$
}

FUNCTION {tie.or.space.prefix}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$
}

FUNCTION {get.bbl.editor}
{ editor num.names$ #1 > 'bbl.editors 'bbl.editor if$ }

FUNCTION {space.word}{ " " swap$ * " " * }


% Field Conditioners, Converters, Checkers and External Interfaces

FUNCTION {empty.field.to.null.string}
{ duplicate$ empty$
    { pop$ "" }
    { skip$ }
  if$
}

FUNCTION {either.or.check}
{ empty$
    { pop$ }
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {empty.entry.warn}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$ url empty$
  and and and and and and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}


% The bibinfo system provides a way for the electronic parsing/acquisition
% of a bibliography's contents as is done by ReVTeX. For example, a field
% could be entered into the bibliography as:
% \bibinfo{volume}{2}
% Only the "2" would show up in the document, but the LaTeX \bibinfo command
% could do additional things with the information. IEEEtran.bst does provide
% a \bibinfo command via "\providecommand{\bibinfo}[2]{#2}". However, it is
% currently not used as the bogus bibinfo functions defined here output the
% entry values directly without the \bibinfo wrapper. The bibinfo functions
% themselves (and the calls to them) are retained for possible future use.
% 
% bibinfo.check avoids acting on missing fields while bibinfo.warn will
% issue a warning message if a missing field is detected. Prior to calling
% the bibinfo functions, the user should push the field value and then its
% name string, in that order.

FUNCTION {bibinfo.check}
{ swap$ duplicate$ missing$
    { pop$ pop$ "" }
    { duplicate$ empty$
        { swap$ pop$ }
        { swap$ pop$ }
      if$
    }
  if$
}

FUNCTION {bibinfo.warn}
{ swap$ duplicate$ missing$
    { swap$ "missing " swap$ * " in " * cite$ * warning$ pop$ "" }
    { duplicate$ empty$
        { swap$ "empty " swap$ * " in " * cite$ * warning$ }
        { swap$ pop$ }
      if$
    }
  if$
}


% The IEEE separates large numbers with more than 4 digits into groups of
% three. The IEEE uses a small space to separate these number groups. 
% Typical applications include patent and page numbers.

% number of consecutive digits required to trigger the group separation.
FUNCTION {large.number.trigger}{ #5 }

% For numbers longer than the trigger, this is the blocksize of the groups.
% The blocksize must be less than the trigger threshold, and 2 * blocksize
% must be greater than the trigger threshold (can't do more than one
% separation on the initial trigger).
FUNCTION {large.number.blocksize}{ #3 }

% What is actually inserted between the number groups.
FUNCTION {large.number.separator}{ "\," }

% So as to save on integer variables by reusing existing ones, numnames
% holds the current number of consecutive digits read and nameptr holds
% the number that will trigger an inserted space.
FUNCTION {large.number.separate}
{ 't :=
  ""
  #0 'numnames :=
  large.number.trigger 'nameptr :=
  { t empty$ not }
  { t #-1 #1 substring$ is.num
      { numnames #1 + 'numnames := }
      { #0 'numnames := 
        large.number.trigger 'nameptr :=
      }
    if$
    t #-1 #1 substring$ swap$ *
    t #-2 global.max$ substring$ 't :=
    numnames nameptr =
      { duplicate$ #1 nameptr large.number.blocksize - substring$ swap$
        nameptr large.number.blocksize - #1 + global.max$ substring$
        large.number.separator swap$ * *
        nameptr large.number.blocksize - 'numnames :=
        large.number.blocksize #1 + 'nameptr :=
      }
      { skip$ }
    if$
  }
  while$
}

% Converts all single dashes "-" to double dashes "--".
FUNCTION {n.dashify}
{ large.number.separate
  't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}


% This function detects entries with names that are identical to that of
% the previous entry and replaces the repeated names with dashes (if the
% "is.dash.repeated.names" user control is nonzero).
FUNCTION {name.or.dash}
{ 's :=
   oldname empty$
     { s 'oldname := s }
     { s oldname =
         { is.dash.repeated.names
              { repeated.name.dashes }
              { s 'oldname := s }
            if$
         }
         { s 'oldname := s }
       if$
     }
   if$
}

% Converts the number string on the top of the stack to
% "numerical ordinal form" (e.g., "7" to "7th"). There is
% no artificial limit to the upper bound of the numbers as the
% two least significant digits determine the ordinal form.
FUNCTION {num.to.ordinal}
{ duplicate$ #-2 #1 substring$ "1" =
      { bbl.th * }
      { duplicate$ #-1 #1 substring$ "1" =
          { bbl.st * }
          { duplicate$ #-1 #1 substring$ "2" =
              { bbl.nd * }
              { duplicate$ #-1 #1 substring$ "3" =
                  { bbl.rd * }
                  { bbl.th * }
                if$
              }
            if$
          }
        if$
      }
    if$
}

% If the string on the top of the stack begins with a number,
% (e.g., 11th) then replace the string with the leading number
% it contains. Otherwise retain the string as-is. s holds the
% extracted number, t holds the part of the string that remains
% to be scanned.
FUNCTION {extract.num}
{ duplicate$ 't :=
  "" 's :=
  { t empty$ not }
  { t #1 #1 substring$
    t #2 global.max$ substring$ 't :=
    duplicate$ is.num
      { s swap$ * 's := }
      { pop$ "" 't := }
    if$
  }
  while$
  s empty$
    'skip$
    { pop$ s }
  if$
}

% Converts the word number string on the top of the stack to
% Arabic string form. Will be successful up to "tenth".
FUNCTION {word.to.num}
{ duplicate$ "l" change.case$ 's :=
  s "first" =
    { pop$ "1" }
    { skip$ }
  if$
  s "second" =
    { pop$ "2" }
    { skip$ }
  if$
  s "third" =
    { pop$ "3" }
    { skip$ }
  if$
  s "fourth" =
    { pop$ "4" }
    { skip$ }
  if$
  s "fifth" =
    { pop$ "5" }
    { skip$ }
  if$
  s "sixth" =
    { pop$ "6" }
    { skip$ }
  if$
  s "seventh" =
    { pop$ "7" }
    { skip$ }
  if$
  s "eighth" =
    { pop$ "8" }
    { skip$ }
  if$
  s "ninth" =
    { pop$ "9" }
    { skip$ }
  if$
  s "tenth" =
    { pop$ "10" }
    { skip$ }
  if$
}


% Converts the string on the top of the stack to numerical
% ordinal (e.g., "11th") form.
FUNCTION {convert.edition}
{ duplicate$ empty$ 'skip$
    { duplicate$ #1 #1 substring$ is.num
        { extract.num
          num.to.ordinal
        }
        { word.to.num
          duplicate$ #1 #1 substring$ is.num
            { num.to.ordinal }
            { "edition ordinal word " quote$ * edition * quote$ *
              " may be too high (or improper) for conversion" * " in " * cite$ * warning$
            }
          if$
        }
      if$
    }
  if$
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LATEX BIBLIOGRAPHY CODE %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {start.entry}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  initialize.prev.this.status
}

% Here we write out all the LaTeX code that we will need. The most involved
% code sequences are those that control the alternate interword spacing and
% foreign language hyphenation patterns. The heavy use of \providecommand
% gives users a way to override the defaults. Special thanks to Javier Bezos,
% Johannes Braams, Robin Fairbairns, Heiko Oberdiek, Donald Arseneau and all
% the other gurus on comp.text.tex for their help and advice on the topic of
% \selectlanguage, Babel and BibTeX.
FUNCTION {begin.bib}
{ "% Generated by IEEEtran.bst, version: " bst.file.version * " (" * bst.file.date * ")" *
  write$ newline$
  preamble$ empty$ 'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" *
  write$ newline$
  "\providecommand{\url}[1]{#1}"
  write$ newline$
  "\csname url@samestyle\endcsname"
  write$ newline$
  "\providecommand{\newblock}{\relax}"
  write$ newline$
  "\providecommand{\bibinfo}[2]{#2}"
  write$ newline$
  % User-configurable appearance hooks. Defaults match the historic
  % IEEE.bst look (\small font, single line spacing, -5pt itemsep).
  % Override from the document preamble, e.g.:
  %   \renewcommand{\bibfontsize}{\footnotesize}
  %   \renewcommand{\biblinespread}{1.1}
  %   \renewcommand{\bibitemsep}{0pt}
  "\providecommand{\bibfontsize}{\small}"
  write$ newline$
  "\providecommand{\biblinespread}{1.0}"
  write$ newline$
  "\providecommand{\bibitemsep}{-5pt}"
  write$ newline$
  "\bibfontsize\linespread{\biblinespread}\selectfont"
  write$ newline$
  "\setlength{\itemsep}{\bibitemsep}"
  write$ newline$
  "\providecommand{\BIBentrySTDinterwordspacing}{\spaceskip=0pt\relax}"
  write$ newline$
  "\providecommand{\BIBentryALTinterwordstretchfactor}{"
  ALTinterwordstretchfactor * "}" *
  write$ newline$
  "\providecommand{\BIBentryALTinterwordspacing}{\spaceskip=\fontdimen2\font plus "
  write$ newline$
  "\BIBentryALTinterwordstretchfactor\fontdimen3\font minus \fontdimen4\font\relax}"
  write$ newline$
  "\providecommand{\BIBforeignlanguage}[2]{{%"
  write$ newline$
  "\expandafter\ifx\csname l@#1\endcsname\relax"
  write$ newline$
  "\typeout{** WARNING: IEEEtran.bst: No hyphenation pattern has been}%"
  write$ newline$
  "\typeout{** loaded for the language `#1'. Using the pattern for}%"
  write$ newline$
  "\typeout{** the default language instead.}%"
  write$ newline$
  "\else"
  write$ newline$
  "\language=\csname l@#1\endcsname"
  write$ newline$
  "\fi"
  write$ newline$
  "#2}}"
  write$ newline$
  "\providecommand{\BIBdecl}{\relax}"
  write$ newline$
  "\BIBdecl"
  write$ newline$
}

FUNCTION {end.bib}
{ newline$ "\end{thebibliography}" write$ newline$ }

FUNCTION {if.url.alt.interword.spacing}
{ is.use.alt.interword.spacing
    { is.use.url
        { url empty$ 'skip$ {"\BIBentryALTinterwordspacing" write$ newline$} if$ }
        { skip$ }
      if$
    }
    { skip$ }
  if$
}

FUNCTION {if.url.std.interword.spacing}
{ is.use.alt.interword.spacing
    { is.use.url
        { url empty$ 'skip$ {"\BIBentrySTDinterwordspacing" write$ newline$} if$ }
        { skip$ }
      if$
    }
    { skip$ }
  if$
}




%%%%%%%%%%%%%%%%%%%%%%%%
%% LONGEST LABEL PASS %%
%%%%%%%%%%%%%%%%%%%%%%%%

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ type$ "ieeetranbstctl" =
    { skip$ }
    { number.label int.to.str$ 'label :=
      number.label #1 + 'number.label :=
      label width$ longest.label.width >
        { label 'longest.label :=
          label width$ 'longest.label.width :=
        }
        { skip$ }
      if$
    }
  if$
}




%%%%%%%%%%%%%%%%%%%%%
%% FORMAT HANDLERS %%
%%%%%%%%%%%%%%%%%%%%%

%% Lower Level Formats (used by higher level formats)

FUNCTION {format.address.org.or.pub.date}
{ 't :=
  ""
  year empty$
    { "empty year in " cite$ * warning$ }
    { skip$ }
  if$
  address empty$ t empty$ and
  year empty$ and month empty$ and
    { skip$ }
    { this.to.prev.status
      this.status.std
      cap.status.std
      address "address" bibinfo.check *
      t empty$
        { skip$ }
        { punct.period 'prev.status.punct :=
          space.normal 'prev.status.space :=
          address empty$
            { skip$ }
            { ": " * }
          if$
          t *
        }
      if$
      % For foreign-language books / proceedings, the
      % marker "(in Language)" is inserted between the publisher and the
      % year, e.g. "Tokyo: Nihon Keizai Hyoronsha (in Japanese), 2000.".
      inlanguage empty$
        { skip$ }
        { " (in " * inlanguage "inlanguage" bibinfo.check * ")" * }
      if$
      year empty$ month empty$ and
        { skip$ }
        { t empty$ address empty$ and
            { skip$ }
            { ", " * }
          if$
          month empty$
            { year empty$
                { skip$ }
                { year "year" bibinfo.check * }
              if$
            }
            { month "month" bibinfo.check *
              % when both month and day are present (typical for
              % conference proceedings), the date reads "Month Day, Year",
              % e.g. "Jun. 2--6, 2003". Without a day it stays "Month Year".
              day empty$
                { skip$ }
                { " " * day "day" bibinfo.check * }
              if$
              year empty$
                 { skip$ }
                 { day empty$
                     { " " * year "year" bibinfo.check * }
                     { ", " * year "year" bibinfo.check * }
                   if$
                 }
              if$
            }
          if$
        }
      if$
    }
  if$
}


FUNCTION {format.names}
{ 'bibinfo :=
  duplicate$ empty$ 'skip$ {
  this.to.prev.status
  this.status.std
  's :=
  "" 't :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr
      name.format.string
      format.name$
      bibinfo bibinfo.check
      't :=
      nameptr #1 >
        { nameptr num.names.shown.with.forced.et.al #1 + =
          bibinfo "editor" =
            { numnames max.num.editors.before.forced.et.al > }
            { numnames max.num.names.before.forced.et.al > }
          if$
          is.forced.et.al and and
            { "others" 't :=
              #1 'namesleft :=
            }
            { skip$ }
          if$
          namesleft #1 >
            { ", " * t do.name.latex.cmd * }
            { s nameptr "{ll}" format.name$ duplicate$ "others" =
                { 't := }
                { pop$ }
              if$
              t "others" =
                { " " * bbl.etal emphasize * }
                { numnames #2 >
                    { "," * }
                    { skip$ }
                  if$
                  bbl.and
                  space.word * t do.name.latex.cmd *
                }
              if$
            }
          if$
        }
        { t do.name.latex.cmd }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  cap.status.std
  } if$
}




%% Higher Level Formats

%% addresses/locations

FUNCTION {format.address}
{ address duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
    }
  if$
}


FUNCTION {format.doi}
{ doi empty$
  { "" }
  { this.to.prev.status
    this.status.std
    "doi:\mylinkurl{" doi * "}" *
    cap.status.std
  }
  if$
}


%% author/editor names

FUNCTION {format.authors}
{ author "author" format.names
  author empty$ editor empty$ or
    'skip$
    { author editor =
        { ", " *
          editor num.names$ #1 >
            'bbl.editors
            'bbl.editor
          if$
          *
        }
        'skip$
      if$
    }
  if$
}

FUNCTION {format.editors}
{ editor "editor" format.names duplicate$ empty$ 'skip$
    { ", " *
      get.bbl.editor
      capitalize
      *
    }
  if$
}



%% date

FUNCTION {format.date}
{
  month "month" bibinfo.check duplicate$ empty$
  year  "year" bibinfo.check duplicate$ empty$
    { swap$ 'skip$
        { this.to.prev.status
          this.status.std
          cap.status.std
         "there's a month but no year in " cite$ * warning$ }
      if$
      *
    }
    { this.to.prev.status
      this.status.std
      cap.status.std
      swap$ 'skip$
        {
          % If day is supplied, format as "Month Day, Year"; otherwise "Month Year".
          day empty$
            { swap$
              " " * swap$
            }
            { swap$
              " " * day * ", " * swap$
            }
          if$
        }
      if$
      *
    }
  if$
}

FUNCTION {format.date.electronic}
{ month "month" bibinfo.check duplicate$ empty$
  year  "year" bibinfo.check duplicate$ empty$
    { swap$
        { pop$ }
        { "there's a month but no year in " cite$ * warning$
        pop$ ")" * "(" swap$ *
        this.to.prev.status
        % The "(Date)" cluster is followed by a sentence
        % separator (period in period-style entries, comma in
        % comma-style entries). Inherit punct.std rather than
        % suppressing it with punct.no.
        punct.std 'this.status.punct :=
        space.normal 'this.status.space :=
        quote.no 'this.status.quote :=
        cap.yes  'status.cap :=
        }
      if$
    }
    { swap$
        { swap$ pop$ ")" * "(" swap$ * }
        { % Render electronic dates as "(Month Day, Year)" when
          % a day is available (e.g., online video, online manual), or as
          % "(Month Year)" otherwise (e.g., online conference paper).
          % Stack on entry: [month_val, year_val] (year on top).
          day empty$
            { swap$ "(" swap$ * " " * swap$ * ")" * }
            { swap$ "(" swap$ * " " * day * ", " * swap$ * ")" * }
          if$
        }
      if$
    this.to.prev.status
    % "(Date)" is followed by a sentence separator inherited
    % from the entry's std punctuation (period for online references,
    % comma elsewhere).
    punct.std 'this.status.punct :=
    space.normal 'this.status.space :=
    quote.no 'this.status.quote :=
    cap.yes  'status.cap :=
    }
  if$
}



%% edition/title

% Note: The IEEE considers the edition to be closely associated with
% the title of a book. So, in IEEEtran.bst the edition is normally handled 
% within the formatting of the title. The format.edition function is 
% retained here for possible future use.
FUNCTION {format.edition}
{ edition duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      convert.edition
      status.cap
        { "t" }
        { "l" }
      if$ change.case$
      "edition" bibinfo.check
      "~" * bbl.edition *
      cap.status.std
    }
  if$
}

% This is used to format the booktitle of a conference proceedings.
% Here we use the "intype" field to provide the user a way to 
% override the word "in" (e.g., with things like "presented at")
% Use of intype stops the emphasis of the booktitle to indicate that
% we no longer mean the written conference proceedings, but the
% conference itself.
FUNCTION {format.in.booktitle}
{ booktitle "booktitle" bibinfo.check duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      select.language
      intype missing$
        { emphasize
          bbl.in " " *
        }
        { intype " " * }
      if$
      swap$ *
      cap.status.std
    }
  if$
}

% This is used to format the booktitle of collection.
% Here the "intype" field is not supported, but "edition" is.
FUNCTION {format.in.booktitle.edition}
{ booktitle "booktitle" bibinfo.check duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      select.language
      emphasize
      edition empty$ 'skip$
        { ", " *
          edition
          convert.edition
          "l" change.case$
          * "~" * bbl.edition *
        }
      if$
      bbl.in " " * swap$ *
      cap.status.std
    }
  if$
}


FUNCTION {format.article.title}
{ title duplicate$ empty$ 'skip$
    { "t" change.case$ }
  if$
  "title" bibinfo.check
  titleraw empty$
    { skip$ }
    { titleraw "t" change.case$ "titleraw" bibinfo.check
      emphasize                     
      swap$ " [" swap$ * "]" * *
    }
  if$
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      quote.close 'this.status.quote :=
      is.last.char.not.punct
        { punct.std 'this.status.punct := }
        { punct.no 'this.status.punct := }
      if$
      select.language
      "``" swap$ *
      cap.status.std
    }
  if$
}


FUNCTION {format.article.title.electronic}
{ title duplicate$ empty$ 'skip$
    { "t" change.case$ }
  if$
  "title" bibinfo.check
  titleraw empty$
    { skip$ }
    { titleraw "t" change.case$ "titleraw" bibinfo.check
      emphasize
      swap$ " [" swap$ * "]" * *
    }
  if$
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      quote.close 'this.status.quote :=
      is.last.char.not.punct
        { punct.std 'this.status.punct := }
        { punct.no 'this.status.punct := }
      if$
      select.language
      "``" swap$ *
      cap.status.std
    }
  if$
}


FUNCTION {format.book.title.edition}
{ title "title" bibinfo.check
  titleraw empty$
    { % No transliteration supplied: italicise the title itself.
      duplicate$ empty$ 'skip$ 'emphasize if$
    }
    { titleraw "titleraw" bibinfo.check
      emphasize
      swap$ " [" swap$ * "]" * *
    }
  if$
  duplicate$ empty$
    { "empty title in " cite$ * warning$ }
    { this.to.prev.status
      this.status.std
      select.language
      edition empty$ 'skip$
        { ", " *
          edition
          convert.edition
          status.cap
            { "t" }
            { "l" }
          if$
          change.case$
          * "~" * bbl.edition *
        }
      if$
      cap.status.std
    }
  if$
}


FUNCTION {format.book.title}
{ title "title" bibinfo.check
  titleraw empty$
    { % No transliteration supplied: italicise the title itself.
      duplicate$ empty$ 'skip$ 'emphasize if$
    }
    { titleraw "titleraw" bibinfo.check
      emphasize
      swap$ " [" swap$ * "]" * *
    }
  if$
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
      select.language
    }
  if$
}



%% journal

FUNCTION {format.journal}
{ journal duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
      select.language
      emphasize
    }
  if$
}


%% Plain (un-italicised) variant of format.journal — used for blog
%% references where the blog source title is set in roman type.
FUNCTION {format.journal.plain}
{ journal duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
      select.language
    }
  if$
}



%% how published

FUNCTION {format.howpublished}
{ howpublished duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
    }
  if$
}



%% institutions/organization/publishers/school

FUNCTION {format.institution}
{ institution duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
    }
  if$
}

FUNCTION {format.organization}
{ organization duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
    }
  if$
}

FUNCTION {format.address.publisher.date}
{ publisher "publisher" bibinfo.warn format.address.org.or.pub.date }

FUNCTION {format.address.publisher.date.nowarn}
{ publisher "publisher" bibinfo.check format.address.org.or.pub.date }

FUNCTION {format.address.organization.date}
{ organization "organization" bibinfo.check format.address.org.or.pub.date }

FUNCTION {format.school}
{ school duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
    }
  if$
}



%% volume/number/series/chapter/pages

FUNCTION {format.volume}
{ volume empty.field.to.null.string
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      bbl.volume 
      status.cap
        { capitalize }
        { skip$ }
      if$
      swap$ tie.or.space.prefix
      "volume" bibinfo.check
      * *
      cap.status.std
    }
  if$
}

FUNCTION {format.number}
{ number empty.field.to.null.string
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      status.cap
         { bbl.number capitalize }
         { bbl.number }
       if$
      swap$ tie.or.space.prefix
      "number" bibinfo.check
      * *
      cap.status.std
    }
  if$
}

FUNCTION {format.number.if.use.for.article}
{ is.use.number.for.article 
     { format.number }
     { "" }
   if$
}

% The series title (and any series volume number) is treated
% as an extension of the book/proceedings title and is enclosed in
% parentheses immediately after it, e.g. "Title (Series Title, 67)".
% We deliberately bind the parenthesised series to the previous item
% (the title) with a space rather than a comma so the parenthesis sits
% flush against the title in the rendered bibliography.
% This is the BOOK style. See format.series.in for the conference style.
FUNCTION {format.series}
{ series empty$
   { "" }
   { this.to.prev.status
     this.status.std
     punct.no 'prev.status.punct :=
     space.normal 'prev.status.space :=
     "(" series "series" bibinfo.check * ")" *
     cap.status.std
   }
 if$
}


%% Series formatter for CONFERENCE PROCEEDINGS.
%% Conference Proceedings With Series Title:
%%   "in Abbreviated Name of Conf., in Series Title, vol. X, X ed., ..."
%% The series here is rendered in roman type (no italics) and prefixed
%% with "in ", not wrapped in parentheses as it is for books.
FUNCTION {format.series.in}
{ series empty$
   { "" }
   { this.to.prev.status
     this.status.std
     bbl.in " " *
     series "series" bibinfo.check *
     cap.status.std
   }
 if$
}


FUNCTION {format.chapter}
{ chapter empty$
    { "" }
    { this.to.prev.status
      this.status.std
      type empty$
        { bbl.chapter }
        { type "l" change.case$
          "type" bibinfo.check
        }
      if$
      chapter tie.or.space.prefix
      "chapter" bibinfo.check
      * *
      cap.status.std
    }
  if$
}


% The intended use of format.paper is for paper numbers of inproceedings.
% The paper type can be overridden via the type field.
% We allow the type to be displayed even if the paper number is absent
% for things like "postdeadline paper"
FUNCTION {format.paper}
{ is.use.paper
     { paper empty$
        { type empty$
            { "" }
            { this.to.prev.status
              this.status.std
              type "type" bibinfo.check
              cap.status.std
            }
          if$
        }
        { this.to.prev.status
          this.status.std
          type empty$
            { bbl.paper }
            { type "type" bibinfo.check }
          if$
          " " * paper
          "paper" bibinfo.check
          *
          cap.status.std
        }
      if$
     }
     { "" } 
   if$
}


FUNCTION {format.pages}
{ pages duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      duplicate$ is.multiple.pages
        {
          bbl.pages swap$
          n.dashify
        }
        {
          bbl.page swap$
        }
      if$
      tie.or.space.prefix
      "pages" bibinfo.check
      * *
      cap.status.std
    }
  if$
}



%% technical report number

FUNCTION {format.tech.report.number}
{ number "number" bibinfo.check
  this.to.prev.status
  this.status.std
  cap.status.std
  type duplicate$ empty$
    { pop$ 
      bbl.techrep
    }
    { skip$ }
  if$
  "type" bibinfo.check 
  swap$ duplicate$ empty$
    { pop$ }
    { tie.or.space.prefix * * }
  if$
}



%% note

FUNCTION {format.note}
{ note empty$
    { "" }
    { this.to.prev.status
      this.status.std
      punct.period 'this.status.punct :=
      note #1 #1 substring$
      duplicate$ "{" =
        { skip$ }
        { status.cap
          { "u" }
          { "l" }
        if$
        change.case$
        }
      if$
      note #2 global.max$ substring$ *
      "(" swap$ * ")" *      % <-- ADDED: wraps note in parentheses
      "note" bibinfo.check
      cap.yes  'status.cap :=
    }
  if$
}



%% patent

FUNCTION {format.patent.date}
{ this.to.prev.status
  this.status.std
  year empty$
    { monthfiled duplicate$ empty$
        { "monthfiled" bibinfo.check pop$ "" }
        { "monthfiled" bibinfo.check }
      if$
      dayfiled duplicate$ empty$
        { "dayfiled" bibinfo.check pop$ " " * }
        { "dayfiled" bibinfo.check 
          monthfiled empty$ 
             { "dayfiled without a monthfiled in " cite$ * warning$
               * 
             }
             { " " swap$ * * }
           if$
        }
      if$
      yearfiled empty$
        { "no year or yearfiled in " cite$ * warning$ }
        { yearfiled "yearfiled" bibinfo.check 
          swap$
          duplicate$ empty$
             { pop$ }
             { ", " * swap$ * }
           if$
        }
      if$
    }
    { month duplicate$ empty$
        { "month" bibinfo.check pop$ "" }
        { "month" bibinfo.check }
      if$
      day duplicate$ empty$
        { "day" bibinfo.check pop$ "" * }
        { "day" bibinfo.check 
          month empty$ 
             { "day without a month in " cite$ * warning$
               * 
             }
             { " " swap$ * * }
           if$
        }
      if$
      year "year" bibinfo.check 
      swap$
      duplicate$ empty$
        { pop$ }
        { ", " * swap$ * }
      if$
    }
  if$
  cap.status.std
}

FUNCTION {format.patent.nationality.type.number}
{ this.to.prev.status
  this.status.std
  nationality duplicate$ empty$
    { "nationality" bibinfo.warn pop$ "" }
    { "nationality" bibinfo.check
      duplicate$ "l" change.case$ "united states" =
        { pop$ bbl.patentUS }
        { skip$ }
      if$
      " " *
    }
  if$
  type empty$
    { bbl.patent "type" bibinfo.check }
    { type "type" bibinfo.check }
  if$  
  *
  number duplicate$ empty$
    { "number" bibinfo.warn pop$ }
    { "number" bibinfo.check
      large.number.separate
      swap$ " " * swap$ *
    }
  if$ 
  cap.status.std
}



%% standard

FUNCTION {format.organization.institution.standard.type.number}
{ this.to.prev.status
  this.status.std
  organization duplicate$ empty$
    { pop$ 
      institution duplicate$ empty$
        { "institution" bibinfo.warn }
        { "institution" bibinfo.warn " " * }
      if$
    }
    { "organization" bibinfo.warn " " * }
  if$
  type empty$
    { bbl.standard "type" bibinfo.check }
    { type "type" bibinfo.check }
  if$  
  *
  number duplicate$ empty$
    { "number" bibinfo.check pop$ }
    { "number" bibinfo.check
      large.number.separate
      swap$ " " * swap$ *
    }
  if$ 
  cap.status.std
}

FUNCTION {format.revision}
{ revision empty$
    { "" }
    { this.to.prev.status
      this.status.std
      bbl.revision
      revision tie.or.space.prefix
      "revision" bibinfo.check
      * *
      cap.status.std
    }
  if$
}


%% thesis

FUNCTION {format.master.thesis.type}
{ this.to.prev.status
  this.status.std
  type empty$
    {
      bbl.mthesis
    }
    { 
      type "type" bibinfo.check
    }
  if$
cap.status.std
}

FUNCTION {format.phd.thesis.type}
{ this.to.prev.status
  this.status.std
  type empty$
    {
      bbl.phdthesis
    }
    { 
      type "type" bibinfo.check
    }
  if$
cap.status.std
}



%% URL
%% A reference may carry both a DOI and a URL; in that
%% case the DOI is rendered first, terminated by a period, and the URL
%% follows. Earlier versions of IEEEtran.bst suppressed the URL whenever
%% a DOI was present — we drop that suppression so both fields render.
FUNCTION {format.url}
{ is.use.url
    { url empty$
      { "" }
      { this.to.prev.status
        this.status.std
        cap.yes 'status.cap :=
        name.url.prefix " " *
        "\url{" * url * "}" *
        punct.no 'this.status.punct :=
        punct.period 'prev.status.punct :=
        space.normal 'this.status.space :=
        space.normal 'prev.status.space :=
        quote.no 'this.status.quote :=
      }
    if$
    }
    { "" }
  if$
}


%% "(in Language)" marker — placed immediately after the article/paper
%% title for non-English publications ("Periodical
%% in Other Language" and "Manual" online).  Output form:
%% "(in German)", "(in Russian)" etc.  Reads from the `inlanguage`
%% field (kept distinct from `language`, which is consumed by
%% \BIBforeignlanguage for hyphenation only).
%%
%% IEEE convention: the marker is ALWAYS followed by a comma, but the
%% punctuation BEFORE it depends on the entry type:
%%   - period before "(in Lang)"  --> Video, Lecture
%%       e.g. "Title of Video. (in Language), (Release date)."
%%   - comma before  "(in Lang)"  --> Article, Manual, Book
%%       e.g. "Title, (in Language), x ed. (Year)."
%%
%% format.in.language therefore leaves prev.status.punct alone (so it
%% inherits whatever the previous format function set, typically the
%% entry-level std punctuation) and forces this.status.punct to comma
%% so the following item is joined with a comma.
%% Handlers that want a comma BEFORE "(in Lang)" in a period-style
%% entry (e.g. @manual online) override this.status.punct := comma on
%% the title BEFORE calling format.in.language.
FUNCTION {format.in.language}
{ inlanguage duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      punct.comma 'this.status.punct :=
      space.normal 'this.status.space :=
      "inlanguage" bibinfo.check
      "(in " swap$ * ")" *
      cap.status.std
    }
  if$
}


%% translator (used for translated books, conference proceedings, etc.)
%% Output form: "trans. J. K. Translator"
FUNCTION {format.translator}
{ translator duplicate$ empty$ 'skip$
    { pop$
      translator "translator" format.names
      duplicate$ empty$ 'skip$
        { bbl.translator " " * swap$ * }
      if$
    }
  if$
}

% The `urldate` field in the .bib can be written in any of the three
% popular formats; this section parses it and reformats to IEEE
% "Mon. DD, YYYY" before it ever reaches the output. Inputs:
%   * ISO  "YYYY-MM-DD"   e.g. 2026-04-06
%   * GOST "DD.MM.YYYY"   e.g. 06.04.2026
%   * IEEE "Mon. DD, YYYY" (also accepts "Month DD, YYYY") e.g. Apr. 6, 2026
FUNCTION {ud.unpad}
{ duplicate$ text.length$ #2 =
    { duplicate$ #1 #1 substring$ "0" =
        { #2 #1 substring$ }
        { skip$ }
      if$
    }
    { skip$ }
  if$
}

FUNCTION {ud.month.num.to.abbrev}
{ duplicate$ "01" = { pop$ "Jan." } {
  duplicate$ "02" = { pop$ "Feb." } {
  duplicate$ "03" = { pop$ "Mar." } {
  duplicate$ "04" = { pop$ "Apr." } {
  duplicate$ "05" = { pop$ "May"  } {
  duplicate$ "06" = { pop$ "Jun." } {
  duplicate$ "07" = { pop$ "Jul." } {
  duplicate$ "08" = { pop$ "Aug." } {
  duplicate$ "09" = { pop$ "Sep." } {
  duplicate$ "10" = { pop$ "Oct." } {
  duplicate$ "11" = { pop$ "Nov." } {
  duplicate$ "12" = { pop$ "Dec." } {
    skip$
  } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$ } if$
}

FUNCTION {ud.month.name.to.num}
{ duplicate$ #1 #3 substring$ "l" change.case$ 'ud.tmp :=
  ud.tmp "jan" =
    { pop$ "01" }
    { ud.tmp "feb" =
        { pop$ "02" }
        { ud.tmp "mar" =
            { pop$ "03" }
            { ud.tmp "apr" =
                { pop$ "04" }
                { ud.tmp "may" =
                    { pop$ "05" }
                    { ud.tmp "jun" =
                        { pop$ "06" }
                        { ud.tmp "jul" =
                            { pop$ "07" }
                            { ud.tmp "aug" =
                                { pop$ "08" }
                                { ud.tmp "sep" =
                                    { pop$ "09" }
                                    { ud.tmp "oct" =
                                        { pop$ "10" }
                                        { ud.tmp "nov" =
                                            { pop$ "11" }
                                            { ud.tmp "dec" =
                                                { pop$ "12" }
                                                { skip$ }
                                              if$
                                            }
                                          if$
                                        }
                                      if$
                                    }
                                  if$
                                }
                              if$
                            }
                          if$
                        }
                      if$
                    }
                  if$
                }
              if$
            }
          if$
        }
      if$
    }
  if$
}

FUNCTION {parse.urldate}
{ "no" 'ud.parsed :=
  "" 'ud.y :=  "" 'ud.m :=  "" 'ud.d :=
  urldate empty$ 'skip$
    { urldate text.length$ 'ud.len :=
      ud.len #10 =
        { % ISO YYYY-MM-DD?
          urldate #5 #1 substring$ "-" =
          urldate #8 #1 substring$ "-" = and
            { urldate #1 #4 substring$ 'ud.y :=
              urldate #6 #2 substring$ 'ud.m :=
              urldate #9 #2 substring$ 'ud.d :=
              "yes" 'ud.parsed :=
            }
            { % GOST DD.MM.YYYY?
              urldate #3 #1 substring$ "." =
              urldate #6 #1 substring$ "." = and
                { urldate #1 #2 substring$ 'ud.d :=
                  urldate #4 #2 substring$ 'ud.m :=
                  urldate #7 #4 substring$ 'ud.y :=
                  "yes" 'ud.parsed :=
                }
                { skip$ }
              if$
            }
          if$
        }
        { skip$ }
      if$
      ud.parsed "no" =
        { ud.len #7 >
            { urldate ud.len #3 - #4 substring$ 'ud.y :=
              urldate ud.len #4 - #1 substring$ " " =
              urldate ud.len #5 - #1 substring$ "," = and
                { % Pre-year (positions 1..len-6) = "Mon[.] DD".
                  % Find first space to separate month from day.
                  #1 'ud.idx :=
                  #0 'ud.space.pos :=
                    { ud.idx ud.len #5 - <
                      ud.space.pos #0 = and
                    }
                    { urldate ud.idx #1 substring$ " " =
                        { ud.idx 'ud.space.pos := }
                        { skip$ }
                      if$
                      ud.idx #1 + 'ud.idx :=
                    }
                  while$
                  ud.space.pos #0 >
                    { urldate #1 ud.space.pos #1 - substring$
                      ud.month.name.to.num 'ud.m :=
                      urldate ud.space.pos #1 +
                      ud.len #6 - ud.space.pos -
                      substring$ 'ud.d :=
                      "yes" 'ud.parsed :=
                    }
                    { skip$ }
                  if$
                }
                { skip$ }
              if$
            }
            { skip$ }
          if$
        }
        { skip$ }
      if$
    }
  if$
}

FUNCTION {urldate.in.ieee.style}
{ parse.urldate
  ud.parsed "yes" =
    { ud.m ud.month.num.to.abbrev " " * ud.d ud.unpad * ", " * ud.y * }
    { urldate }
  if$
}


%% accessed date (used for online references)
%% Output form: "Accessed: Month Day, Year"
%% IEEE: the accessed-date phrase is preceded by a period (not a comma),
%% even inside comma-style entries.
FUNCTION {format.urldate}
{ urldate duplicate$ empty$ 'skip$
    { pop$
      this.to.prev.status
      this.status.std
      punct.period 'prev.status.punct :=
      space.normal 'prev.status.space :=
      urldate.in.ieee.style
      "urldate" bibinfo.check
      bbl.accessed " " * swap$ *
      cap.yes 'status.cap :=
    }
  if$
}


%% Social-media variant of format.urldate — omits the colon after
%% "Accessed" to match the social-media layout
%% ("Accessed Apr. 19, 2021" instead of "Accessed: Apr. 19, 2021").
FUNCTION {format.urldate.social}
{ urldate duplicate$ empty$ 'skip$
    { pop$
      this.to.prev.status
      this.status.std
      punct.period 'prev.status.punct :=
      space.normal 'prev.status.space :=
      urldate.in.ieee.style
      "urldate" bibinfo.check
      "Accessed " swap$ *
      cap.yes 'status.cap :=
    }
  if$
}


%% [Online]. / [Online Video]. marker
%% IEEE style: the preceding field is terminated with a period before the
%% medium marker, regardless of whether the entry uses comma- or
%% period-style internal separators. We override prev.status.punct to
%% period but leave prev.status.quote intact so that a quoted title that
%% immediately precedes the marker still gets its closing "''" written.
FUNCTION {format.online.marker}
{ url empty$
    { "" }
    { this.to.prev.status
      this.status.std
      punct.period 'prev.status.punct :=
      space.normal 'prev.status.space :=
      medium empty$
        { bbl.online }
        { "[" medium * "]." * }
      if$
      punct.no 'this.status.punct :=
      space.normal 'this.status.space :=
      cap.yes 'status.cap :=
    }
  if$
}


%% Article ID (Art. no. XXX) for periodicals identified by article number
FUNCTION {format.articleno}
{ articleno duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      "articleno" bibinfo.check
      bbl.article.no " " * swap$ *
      cap.status.std
    }
  if$
}


%% arXiv preprint: "arXiv:XXXX.XXXXX"
FUNCTION {format.eprint}
{ eprint duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      "eprint" bibinfo.check
      eprinttype empty$
        { bbl.arxiv swap$ * emphasize }
        { eprinttype "l" change.case$ "arxiv" =
            { bbl.arxiv swap$ * emphasize }
            { eprinttype ":" * swap$ * emphasize }
          if$
        }
      if$
      cap.status.std
    }
  if$
}


%% Software version (for @software entries)
FUNCTION {format.version}
{ version duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      "version" bibinfo.check
      "(" swap$ * ")" *
      cap.status.std
    }
  if$
}


%% Repository / archive name (for @software entries)
FUNCTION {format.repository}
{ repository duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      "repository" bibinfo.check
      cap.status.std
    }
  if$
}


%% Section (sect. x) used in books/chapters
FUNCTION {format.section}
{ section duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      "section" bibinfo.check
      bbl.section swap$ tie.or.space.prefix * *
      cap.status.std
    }
  if$
}




%%%%%%%%%%%%%%%%%%%%
%% ENTRY HANDLERS %%
%%%%%%%%%%%%%%%%%%%%


% Note: In many journals, the IEEE (or the authors) tend not to show the number
% for articles, so the display of the number is controlled here by the
% switch "is.use.number.for.article"
FUNCTION {article}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.in.language output
  format.journal "journal" bibinfo.check "journal" output.warn
  format.volume output
  format.number.if.use.for.article output
  articleno empty$
    { format.pages output }
    { skip$ }
  if$
  format.date "year" output.warn
  format.articleno output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}


FUNCTION {book}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  author empty$
    { format.editors "author and editor" output.warn }
    { format.authors output.nonnull }
  if$
  name.or.dash
  format.book.title.edition output
  format.series output
  author empty$
    { skip$ }
    { format.editors output }
  if$
  format.translator output
  format.address.publisher.date output
  format.volume output
  format.number output
  format.chapter output
  format.section output
  format.pages output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {booklet}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.article.title "title" output.warn
  format.howpublished "howpublished" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.address "address" bibinfo.check output
  format.date output
  format.note output
  format.doi output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

%% @electronic — generic online reference (also the target of the
%% @online / @website / @socialmedia / @webpage / @internet / @www
%% aliases). "Websites" prescribes a roman
%% (non-italicised) website / source title:
%%   J. K. Author. "Page Title." Website Title. Accessed: Date.
%%   [Online]. Available: URL
%% We therefore render the `journal` field through format.journal.plain
%% rather than the italicising format.journal used by periodicals.
FUNCTION {electronic}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.date.electronic output
  format.article.title.electronic output
  format.journal.plain output
  format.howpublished "howpublished" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.address "address" bibinfo.check output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}

FUNCTION {inbook}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  author empty$
    { format.editors "author and editor" output.warn }
    { format.authors output.nonnull }
  if$
  name.or.dash
  format.book.title.edition output
  format.series output
  author empty$
    { skip$ }
    { format.editors output }
  if$
  format.translator output
  format.address.publisher.date output
  format.volume output
  format.number output
  format.chapter output
  format.section output
  format.pages output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {incollection}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  % NOTE: for books/chapters the "(in Language)" marker is placed between
  % the publisher and the year by format.address.publisher.date — NOT
  % after the chapter title. We therefore do NOT call format.in.language
  % here.
  format.in.booktitle "booktitle" output.warn
  format.series output
  format.editors output
  format.translator output
  % the edition is placed AFTER editors and translator,
  % immediately before the address/publisher block, e.g.
  %   "in BookTitle, X. Editor, Ed., trans. T. Translator, 3rd ed. City: ..."
  format.edition output
  format.address.publisher.date.nowarn output
  format.volume output
  format.number output
  format.chapter output
  format.section output
  format.pages output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {inproceedings}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  % "(in Language)" goes right after the closing quote of the
  % paper title, before "in Abbreviated Name of Conf.".
  format.in.language output
  format.in.booktitle "booktitle" output.warn
  % Series for conference proceedings: prefixed with "in ", roman type
  % (NOT parenthesised — that is the book layout).
  format.series.in output
  format.editors output
  format.volume output
  format.number output
  % Edition comes after vol./no., immediately before the date block
  % ("Conference Proceedings With Series Title, Volume Title,
  % and Edition": "... vol. X, X ed., Jul. 2006, pp. 4301-4304.").
  format.edition output
  publisher empty$
    { format.address.organization.date output }
    { format.organization "organization" bibinfo.check output
      format.address.publisher.date output
    }
  if$
  format.paper output
  format.pages output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

%% @manual covers two layouts:
%%
%% Print Handbook / Manual:
%%   Name of Manual/Handbook, (in Language), x ed., Abbrev. Name of Co.,
%%   City of Co., State, Year, pp. xxx--xxx.
%%
%% Manual/Handbook (Online):
%%   J. K. Author (or Abbrev. Name of Co., City, State, Country).
%%   Name of Manual/Handbook, (in Language), x ed. (Year).
%%   Accessed: Month Day, Year. [Online]. Available: URL
%%
%% The presence of a url or urldate field switches the entry to the
%% online layout: period-style separators and a parenthesised "(Year)".
FUNCTION {manual}
{ url empty$ urldate empty$ and
    { std.status.using.comma }
    { std.status.using.period }
  if$
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.book.title "title" output.warn
  % Manual (Online) renders "Title, (in Language), x ed.
  % (Year)." with commas around "(in Lang)" and "x ed." even though
  % the surrounding entry is period-style. Override the title's
  % trailing punctuation here so that "(in Lang)" / "x ed." are
  % comma-joined to the title.
  url empty$ urldate empty$ and
    { skip$ }
    { punct.comma 'this.status.punct :=
      space.normal 'this.status.space :=
    }
  if$
  format.in.language output
  format.edition output
  url empty$ urldate empty$ and
    { % Print manual: organization, address, plain year, pages.
      format.organization "organization" bibinfo.check output
      format.address "address" bibinfo.check output
      format.date output
      format.pages output
    }
    { % Online manual: "(Year)." then "Accessed: ..." then [Online]/URL.
      format.organization "organization" bibinfo.check output
      format.address "address" bibinfo.check output
      format.date.electronic output
      format.pages output
    }
  if$
  format.howpublished "howpublished" bibinfo.check output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

%% Master's thesis (Q. Theses and Dissertations).
%% Basic Format:
%%   J. K. Author, "Title of thesis," (in Language), M.S. thesis,
%%   Abbrev. Dept., Abbrev. Univ., City, Abbrev. State, Year.
%%   [Online]. Available: URL
FUNCTION {mastersthesis}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.in.language output
  format.master.thesis.type output.nonnull
  format.school "school" bibinfo.warn output
  format.address "address" bibinfo.check output
  format.date "year" output.warn
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

%% @misc — generic fallback handler, also used as the target of the
%% @preprint / @arxiv aliases. "Preprint arXiv"
%% prescribes:
%%   J. K. Author, "Title of paper," (in Language), Year, arXiv:number.
%% The "(in Language)" marker is therefore inserted right after the
%% quoted title; the eprint cluster prints "arXiv:NNNN" via
%% format.eprint.
FUNCTION {misc}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.article.title "title" output.warn
  format.in.language output
  format.howpublished "howpublished" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.address "address" bibinfo.check output
  format.pages output
  format.date output
  format.eprint output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}

%% Year-first electronic date — "(Year, Month Day)" or "(Year)".
%% Used by the @government and @patentonline layouts where the IEEE
%% prescribes year-first parenthesised dates (distinct from the
%% month-first format produced by format.date.electronic).
FUNCTION {format.date.year.first.electronic}
{ month "month" bibinfo.check duplicate$ empty$
  year  "year" bibinfo.check duplicate$ empty$
    { swap$
        { pop$ }
        { "there's a month but no year in " cite$ * warning$
        pop$ ")" * "(" swap$ *
        this.to.prev.status
        punct.std 'this.status.punct :=
        space.normal 'this.status.space :=
        quote.no 'this.status.quote :=
        cap.yes  'status.cap :=
        }
      if$
    }
    { swap$
        { swap$ pop$ ")" * "(" swap$ * }
        { % Both month and year present. Render as "(Year, Month Day)"
          % when day is set, or "(Year, Month)" otherwise.
          % Stack on entry: [month_val, year_val] (year on top).
          day empty$
            { "(" swap$ * ", " * swap$ * ")" * }
            { "(" swap$ * ", " * swap$ * " " * day * ")" * }
          if$
        }
      if$
    this.to.prev.status
    punct.std 'this.status.punct :=
    space.normal 'this.status.space :=
    quote.no 'this.status.quote :=
    cap.yes  'status.cap :=
    }
  if$
}


%% Patent inventor formatter — "by Author1 and Author2".
%% Joined to the preceding (title) field with a comma:
%%   "Screwless clip mounted computer drive, by D. Williams."
FUNCTION {format.patent.invented.by}
{ author duplicate$ empty$ 'skip$
    { pop$
      author "author" format.names
      duplicate$ empty$ 'skip$
        { punct.comma 'prev.status.punct :=
          space.normal 'prev.status.space :=
          "by " swap$ *
        }
      if$
    }
  if$
}


%% Patent (L. Patent)
%% Basic Format:
%%   J. K. Author, "Title of patent," (in Language), Country Patent xxx,
%%   Month Day, Year.
%% The "(in Language)" marker (when supplied) is inserted between the
%% quoted patent title and the "Country Patent xxx" cluster.
FUNCTION {patent}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.article.title output
  format.in.language output
  format.patent.nationality.type.number output
  format.patent.date output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}

FUNCTION {periodical}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.editors output
  name.or.dash
  format.book.title "title" output.warn
  format.series output
  format.volume output
  format.number output
  format.organization "organization" bibinfo.check output
  format.date "year" output.warn
  format.note output
  format.doi output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

%% Ph.D. dissertation (Q. Theses and Dissertations).
%% Basic Format:
%%   J. K. Author, "Title of dissertation," (in Language), Ph.D.
%%   dissertation, Abbrev. Dept., Abbrev. Univ., City, Abbrev. State,
%%   Year. [Online]. Available: URL
FUNCTION {phdthesis}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.in.language output
  format.phd.thesis.type output.nonnull
  format.school "school" bibinfo.warn output
  format.address "address" bibinfo.check output
  format.date "year" output.warn
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {proceedings}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.editors output
  name.or.dash
  format.book.title "title" output.warn
  format.series output
  format.volume output
  format.number output
  publisher empty$
    { format.address.organization.date output }
    { format.organization "organization" bibinfo.check output
      format.address.publisher.date output
    }
  if$
  format.note output
  format.doi output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {standard}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.book.title "title" output.warn
  format.howpublished "howpublished" bibinfo.check output
  format.organization.institution.standard.type.number output
  format.address "address" bibinfo.check output
  format.revision output
  format.date output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {techreport}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.howpublished "howpublished" bibinfo.check output
  format.institution "institution" bibinfo.warn output
  format.address "address" bibinfo.check output
  format.tech.report.number output.nonnull
  format.date "year" output.warn
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}

FUNCTION {unpublished}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.date output
  format.eprint output
  format.note "note" output.warn
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}


%% Social media (T. Websites — "For social media
%% websites (Twitter etc.)"):
%% Basic Format:
%%   J. K. Author, "Post Title." Media Title. Accessed Date Accessed.
%%   [Online.] Available: URL
%% Three quirks vs. plain @website/@electronic:
%%   * a COMMA (not a period) follows the author block,
%%   * "Accessed" is NOT followed by a colon,
%%   * the period is INSIDE the bracket: "[Online.]" not "[Online].".
FUNCTION {socialmedia}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  punct.comma 'this.status.punct :=
  space.normal 'this.status.space :=
  name.or.dash
  format.article.title.electronic output
  format.journal.plain output
  format.howpublished "howpublished" bibinfo.check output
  format.note output
  format.urldate.social output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Blog (A. Blogs)
%% Basic Format:
%%   J. K. Author, "Title of the post," Title of the Blog, Month Day,
%%   Year. [Online]. Available: URL
%% Differs from @article only in that the blog source title (journal
%% field) is rendered in roman type, NOT italics.
FUNCTION {blog}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.in.language output
  format.journal.plain "journal" bibinfo.check "journal" output.warn
  format.volume output
  format.number.if.use.for.article output
  articleno empty$
    { format.pages output }
    { skip$ }
  if$
  format.date "year" output.warn
  format.articleno output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}


%% Software (O. Software)
%% Basic Format:
%%   J. K. Author. Title of Software. Date Repository or Archive.
%%   (version or Year). Publisher Name. Accessed: Date.
%%   [Type of Medium]. Global Persistent Identifier. Available: URL
%% Example:
%%   D. W. Arning et al. Mixed Mode--Mixed Level Circuit Simulator.
%%   (2011). Ngspice. Accessed: Jan. 11, 2019. [Online].
%%   doi:10.5281/zenodo.1234567. Available: http://ngspice.sourceforge.net
%% The (Year) cluster precedes the publisher; the DOI / persistent
%% identifier (read from the `doi` field) is rendered AFTER "[Online]."
%% and BEFORE "Available: URL".
FUNCTION {software}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.book.title "title" output.warn
  format.repository output
  format.version output
  format.date.electronic output
  format.organization "organization" bibinfo.check output
  format.howpublished "howpublished" bibinfo.check output
  format.address "address" bibinfo.check output
  format.note output
  format.urldate output
  format.online.marker output
  format.doi output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Dataset (E. Datasets)
%% Basic Format:
%%   Author, Date, "Title of Dataset," Source. [Online]. Available: URL
%%   (or doi: xxx if DOI is used)
FUNCTION {dataset}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.date output
  format.article.title "title" output.warn
  format.howpublished "howpublished" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.address "address" bibinfo.check output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Plain (un-quoted, italicised) title used for electronic references
%% whose title is treated as a book/work title rather than as a short
%% piece (websites, social-media posts).  Output form: "\emph{Title}".
FUNCTION {format.book.title.electronic}
{ title "title" bibinfo.check
  titleraw empty$
    { duplicate$ empty$ 'skip$ 'emphasize if$ }
    { titleraw "titleraw" bibinfo.check
      emphasize
      swap$ " [" swap$ * "]" * *
    }
  if$
  duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
      select.language
    }
  if$
}


%% Plain title formatter — no quotation marks, no italics. Used for the
%% Conference Paper Online layout where the paper title is set in roman
%% type and terminated by a period (e.g. Taylor's "Assessment: ...").
FUNCTION {format.title.plain}
{ title "title" bibinfo.check duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      cap.status.std
      select.language
    }
  if$
}


%% Conference-name formatter with the leading word "Presented" given a
%% capital "P". Used by @confonline entries where the conference name
%% follows a sentence-ending period: "Title. Presented at <Conf>.".
%% The location of the conference (address field) is then joined to
%% the conference name with a COMMA, matching 
%% "Presented at <Conf>., <City>, <Country>." pattern.
FUNCTION {format.presented.booktitle.cap}
{ booktitle "booktitle" bibinfo.check duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      select.language
      "Presented at " swap$ *
      punct.comma 'this.status.punct :=
      space.normal 'this.status.space :=
      cap.status.std
    }
  if$
}


%% Lecture title formatter — plain text (no italics, no quotes), with
%% the lecture medium type appended in square brackets as part of the
%% title cluster, e.g. "Documenting literature [PowerPoint slides]".
FUNCTION {format.lecture.title}
{ title "title" bibinfo.check duplicate$ empty$ 'skip$
    { medium empty$
        { skip$ }
        { " [" * medium * "]" * }
      if$
      this.to.prev.status
      this.status.std
      cap.status.std
      select.language
    }
  if$
}


%% Online video / YouTube (K. Online Video)
%% Basic Format:
%%   Video Owner/Creator, Location. Title of Video. (in Language),
%%   (Release date). Accessed: Date. [Online Video]. Available: URL
%% Notes:
%%   - The video owner/creator is joined to the optional location with
%%     a COMMA ("mtaOnline1, Fazi Mosque, U.K.") even though the rest
%%     of the entry uses period separators prescribes this
%%     mixed style.
%%   - The "(in Language)" marker, when supplied, sits between the
%%     italicised title and the parenthesised release date.
FUNCTION {video}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  % Force a comma between Owner/Creator and Location (rather than the
  % default period set by std.status.using.period).
  punct.comma 'this.status.punct :=
  space.normal 'this.status.space :=
  name.or.dash
  format.address "address" bibinfo.check output
  format.book.title.electronic output
  format.in.language output
  format.date.electronic output
  format.note output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Patent Online (L. Patent — "Patent Online")
%% Basic Format:
%%   Name of the invention, by inventor's name. (Year, Month Day).
%%   Patent Number. [Online]. Available: URL
%% Example:
%%   Screwless clip mounted computer drive, by D. Williams.
%%   (2005, Apr. 26). U.S. Patent 6,885,550. [Online].
%%   Available: http://patft.uspto.gov/netacgi/6,885,550
%% This is a period-style layout: the invention name (plain roman type,
%% no quotes / no italics) leads the entry, followed by the inventor
%% prefixed with "by", a year-first parenthesised date, the patent
%% nationality+number cluster, and finally the [Online]/URL block.
FUNCTION {patentonline}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.title.plain output
  format.patent.invented.by output
  name.or.dash
  format.date.year.first.electronic output
  format.patent.nationality.type.number output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Conference Paper Online (C. Conference Paper Online)
%% Basic Format:
%%   J. K. Author. (Date). Title. (in Language). Presented at Abbreviated
%%   Conf. Title. [Online]. Available: URL
%% Period-style separators; the paper title is set in plain roman type
%% (NOT quoted, NOT italicised), and the conference name is preceded by
%% the capitalised phrase "Presented at" rather than the lowercase
%% "presented at the" used by the in-person @presentation type.
FUNCTION {confonline}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.date.electronic output
  format.title.plain output
  format.in.language output
  format.presented.booktitle.cap output
  format.address "address" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Lecture notes / Lecture online (G. Lectures)
%% Basic Format:
%%   J. K. Author. (Year). Title of lecture [Type of Medium]. (in Language),
%%   Available: URL
%% Note: IEEE prints the medium marker INSIDE the title cluster (e.g.,
%% "[PowerPoint slides]") and omits the leading "[Online]." entirely.
%% We therefore deliberately skip format.online.marker here. The
%% "(in Language)" marker, when supplied, is inserted between the
%% title+medium cluster and "Available: URL", and is always set off by
%% commas (handled inside format.in.language).
FUNCTION {lecture}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.date.electronic output
  format.lecture.title output
  format.in.language output
  format.organization "organization" bibinfo.check output
  format.note output
  format.urldate output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% U.S. Government documents (R. U.S. Government Documents)
%% Basic Format:
%%   Legislative body. Number of Congress, Session. (Year, Month Day).
%%   Title. [Online]. Available: URL
%% The title is italicised (treated as a publication title). The date
%% block uses the YEAR-FIRST parenthesised form "(Year, Month Day)" as
%% prescribed. Distinct from the month-first form used by
%% other electronic types.
FUNCTION {government}
{ std.status.using.period
  start.entry
  if.url.alt.interword.spacing
  format.authors output
  name.or.dash
  format.howpublished "howpublished" bibinfo.check output
  format.date.year.first.electronic output
  format.book.title.electronic "title" output.warn
  format.note output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  empty.entry.warn
  if.url.std.interword.spacing
}


%% Booktitle formatter for "presented at" conference references.
%% Note: when a paper is *presented* (rather than appearing in proceedings),
%% the conference name is set in roman (not italic). The lead-in word is
%% taken from the user-supplied intype field if present, otherwise from
%% bbl.presented ("presented at").
FUNCTION {format.presented.booktitle}
{ booktitle "booktitle" bibinfo.check duplicate$ empty$ 'skip$
    { this.to.prev.status
      this.status.std
      select.language
      intype missing$
        { bbl.presented " " * }
        { intype " " * }
      if$
      swap$ *
      cap.status.std
    }
  if$
}


%% Conference paper PRESENTED at a conference (
%%  Conferences and Conference Proceedings — Conference Paper).
%% Basic Format:
%%   J. K. Author, "Title of paper," presented at the Abbreviated Name of
%%   Conf., City of Conf., State, Country, Month d--d, Year, Paper number.
FUNCTION {presentation}
{ std.status.using.comma
  start.entry
  if.url.alt.interword.spacing
  format.authors "author" output.warn
  name.or.dash
  format.article.title "title" output.warn
  format.presented.booktitle output
  format.series output
  format.editors output
  format.volume output
  format.number output
  format.address "address" bibinfo.check output
  format.organization "organization" bibinfo.check output
  format.date "year" output.warn
  format.paper output
  format.pages output
  format.note output
  format.doi output
  format.urldate output
  format.online.marker output
  format.url output
  fin.entry
  if.url.std.interword.spacing
}


% The special entry type which provides the user interface to the
% BST controls
FUNCTION {IEEEtranBSTCTL}
{ is.print.banners.to.terminal
    { "** IEEEtran BST control entry " quote$ * cite$ * quote$ * " detected." *
      top$
    }
    { skip$ }
  if$
  CTLuse_article_number
  empty$
    { skip$ }
    { CTLuse_article_number
      yes.no.to.int
      'is.use.number.for.article :=
    }
  if$
  CTLuse_paper
  empty$
    { skip$ }
    { CTLuse_paper
      yes.no.to.int
      'is.use.paper :=
    }
  if$
  CTLuse_url
  empty$
    { skip$ }
    { CTLuse_url
      yes.no.to.int
      'is.use.url :=
    }
  if$
  CTLuse_forced_etal
  empty$
    { skip$ }
    { CTLuse_forced_etal
      yes.no.to.int
      'is.forced.et.al :=
    }
  if$
  CTLmax_names_forced_etal
  empty$
    { skip$ }
    { CTLmax_names_forced_etal
      string.to.integer
      'max.num.names.before.forced.et.al :=
    }
  if$
  CTLnames_show_etal
  empty$
    { skip$ }
    { CTLnames_show_etal
      string.to.integer
      'num.names.shown.with.forced.et.al :=
    }
  if$
  CTLuse_alt_spacing
  empty$
    { skip$ }
    { CTLuse_alt_spacing
      yes.no.to.int
      'is.use.alt.interword.spacing :=
    }
  if$
  CTLalt_stretch_factor
  empty$
    { skip$ }
    { CTLalt_stretch_factor
      'ALTinterwordstretchfactor :=
      "\renewcommand{\BIBentryALTinterwordstretchfactor}{"
      ALTinterwordstretchfactor * "}" *
      write$ newline$
    }
  if$
  CTLdash_repeated_names
  empty$
    { skip$ }
    { CTLdash_repeated_names
      yes.no.to.int
      'is.dash.repeated.names :=
    }
  if$
  CTLname_format_string
  empty$
    { skip$ }
    { CTLname_format_string
      'name.format.string :=
    }
  if$
  CTLname_latex_cmd
  empty$
    { skip$ }
    { CTLname_latex_cmd
      'name.latex.cmd :=
    }
  if$
  CTLname_url_prefix
  missing$
    { skip$ }
    { CTLname_url_prefix
      'name.url.prefix :=
    }
  if$


  num.names.shown.with.forced.et.al max.num.names.before.forced.et.al >
    { "CTLnames_show_etal cannot be greater than CTLmax_names_forced_etal in " cite$ * warning$ 
      max.num.names.before.forced.et.al 'num.names.shown.with.forced.et.al :=
    }
    { skip$ }
  if$
}


%%%%%%%%%%%%%%%%%%%
%% ENTRY ALIASES %%
%%%%%%%%%%%%%%%%%%%
FUNCTION {conference}{inproceedings}
% A conference paper available only online — period-style layout with
% "Presented at <Conf>." (capital P). Distinct from @presentation, which
% is the in-person comma-style "presented at the <Conf>, City, Date" form.
FUNCTION {confpaperonline}{confonline}
FUNCTION {conferenceonline}{confonline}
FUNCTION {online}{electronic}
FUNCTION {internet}{electronic}
FUNCTION {webpage}{electronic}
FUNCTION {website}{electronic}
% NOTE: @socialmedia has its own dedicated handler (defined above) — do
% NOT alias it to @electronic here.
FUNCTION {www}{electronic}
% News articles share the periodical-style layout of @article
% (author, title, source title, date, [Online]. Available: URL).
FUNCTION {news}{article}
FUNCTION {newsarticle}{article}
% A preprint (e.g., arXiv) is rendered through @misc using the
% eprint / eprinttype fields handled by format.eprint.
FUNCTION {preprint}{misc}
FUNCTION {arxiv}{misc}
% Theses with non-IEEE @thesis tag fall back to the doctoral handler;
% users may also use @mastersthesis or @phdthesis directly.
FUNCTION {thesis}{phdthesis}
FUNCTION {dissertation}{phdthesis}
FUNCTION {default.type}{misc}



%%%%%%%%%%%%%%%%%%
%% MAIN PROGRAM %%
%%%%%%%%%%%%%%%%%%

READ

EXECUTE {initialize.controls}
EXECUTE {initialize.status.constants}
EXECUTE {banner.message}

EXECUTE {initialize.longest.label}
ITERATE {longest.label.pass}

EXECUTE {begin.bib}
ITERATE {call.type$}
EXECUTE {end.bib}

EXECUTE{completed.message}


%% That's all folks, mds.