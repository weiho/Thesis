% This is IEEETR.BST in text format, as of May 13, 1986.
% IEEE Transactions bibliography style
%    numeric labels, order-of-reference, IEEE abbreviations,
%    quotes around article titles, commas separate all fields
%    except after book titles and before "notes".  Otherwise,
%    much like the "plain" family, from which this is adapted.
%
%   History
%   9/30/85 (HWT) Original version, by Howard Trickey.
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  {label}
 
 
 
INTEGERS { output.state before.all mid.sentence mid.sentenceb
           after.sentence after.block }
 
FUNCTION {init.state.consts}
{ 'before.all #0 :=
  'mid.sentence #1 :=
  'mid.sentenceb #2 :=
  'after.sentence #3 :=
  'after.block #4 :=
}
 
 
STRINGS { s t }
 
FUNCTION {output.nonnull}
{ 's swap$ :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state mid.sentenceb =
        { " " * write$ }
        { output.state after.block =
       { add.period$ write$
         newline$
         "\newblock " write$
       }
       { output.state before.all =
           'write$
           { add.period$ " " * write$ }
         if$
       }
          if$
        }
      if$
    }
  if$
  'output.state mid.sentence :=
  s
}
 
FUNCTION {output}
{ 's swap$ :=
  s "" =
    'skip$
    { s output.nonnull }
  if$
}
 
FUNCTION {output.check}
{ 's swap$ :=
  't swap$ :=
  s "" =
    { "Warning: the " t * " shouldn't be empty in " * cite$ * top$ }
    { s output.nonnull }
  if$
}
 
FUNCTION {output.bibitem}
{ newline$
 
  "\bibitem{" write$
 
  cite$ write$
  "}" write$
  newline$
  ""
  'output.state before.all :=
}
 
FUNCTION {blank.sep}
{ 'output.state mid.sentenceb :=
}
 
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}
 
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { 'output.state after.block := }
  if$
}
 
 
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
   'skip$
   { 'output.state after.sentence := }
      if$
    }
  if$
}
 
 
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
 
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
 
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
 
 
FUNCTION {field.or.null}
{ duplicate$
  missing$
    { pop$ "" }
    'skip$
  if$
}
 
FUNCTION {italicize}
{ 's swap$ :=
  s "" =
    { "" }
    { "{\it " s * "}" * }
  if$
}
 
INTEGERS { nameptr namesleft numnames }
 
STRINGS {nameresult}
 
FUNCTION {format.names}
{ 's swap$ :=
  'nameptr #1 :=
  'nameresult "" :=
  'numnames s num.names$ :=
  'namesleft numnames :=
    { namesleft #0 > }
    {
 
      't s nameptr "{f.~}{vv~}{ll}{, jj}" format.name$ :=
 
      nameptr #1 >
   { namesleft #1 >
       { 'nameresult nameresult ", " * t * := }
       { numnames #2 >
      { 'nameresult nameresult "," * := }
      'skip$
         if$
         t "others" =
      { 'nameresult nameresult " {\it et al.}" * := }
      { 'nameresult nameresult " and " * t * := }
         if$
       }
     if$
   }
   { 'nameresult nameresult t * := }
      if$
      'nameptr nameptr #1 + :=
      'namesleft namesleft #1 - :=
    }
  while$
  nameresult
}
 
FUNCTION {format.authors}
{ author missing$
    { "" }
    { author format.names }
  if$
}
 
FUNCTION {format.editors}
{ editor missing$
    { "" }
    { editor num.names$ #1 >
   { editor format.names ", eds." * }
   { editor format.names ", ed." * }
      if$
    }
  if$
}
 
 
FUNCTION {format.title}
 
{ title missing$
    { "" }
    { "``" title "ul" change.case$ * ",''" * }
  if$
 
}
 
 
FUNCTION {entry.string.max} { #100 }
 
FUNCTION {global.string.max} { #300 }
 
 
STRINGS {pageresult}
 
FUNCTION {n.dashify}
{ 't swap$ :=
  'pageresult "" :=
    { t "" = not }
    { t #1 #1 substring$ "-" =
   { t #1 #2 substring$ "--" = not
       { 'pageresult pageresult "--" * :=
         't t #2 global.string.max substring$ :=
       }
       {   { t #1 #1 substring$ "-" = }
      { 'pageresult pageresult "-" * :=
        't t #2 global.string.max substring$ :=
      }
         while$
       }
     if$
   }
   { 'pageresult pageresult t #1 #1 substring$ * :=
     't t #2 global.string.max substring$ :=
   }
      if$
    }
  while$
  pageresult
}
 
 
FUNCTION {format.date}
{ year missing$
    { month missing$
   { "" }
   { "Warning: there's a month but no year in " cite$ * top$
     month
   }
      if$
    }
    { month missing$
   { year }
   { month " " * year * }
      if$
    }
  if$
}
 
 
FUNCTION {format.btitle}
{ title field.or.null
  italicize
}
 
 
FUNCTION {format.bvolume}
{ volume missing$
    { series missing$
   { "" }
   { series italicize }
      if$
    }
    { "Vol.~" volume *
      series missing$
   'skip$
   { " of " * series italicize * }
      if$
    }
  if$
}
 
 
FUNCTION {format.edition}
{ edition missing$
    { "" }
    { edition "ll" change.case$ " ed." * }
  if$
}
 
 
INTEGERS {multiresult}
 
FUNCTION {multi.page.check}
{ 't swap$ :=
  'multiresult #0 :=
    { multiresult not
      t "" = not
      and
    }
    { t #1 #1 substring$ "-" =
      t #1 #1 substring$ "," =
      or
   { 'multiresult #1 := }
   { 't t #2 global.string.max substring$ := }
      if$
    }
  while$
  multiresult
}
 
 
FUNCTION {format.pages}
{ pages missing$
    { "" }
    { pages multi.page.check
   { "pp.~" pages n.dashify * }
   { "p.~" pages n.dashify * }
      if$
    }
  if$
}
 
 
FUNCTION {format.volume}
{ volume missing$
    { "" }
    { "vol.~" volume * }
  if$
}
 
FUNCTION {format.number}
{ number missing$
    { "" }
    { "no.~" number * }
  if$
}
 
FUNCTION {format.chapter.pages}
{ chapter missing$
    'format.pages
    { "ch.~" chapter *
      pages missing$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}
 
FUNCTION {format.in.ed.booktitle}
{ booktitle missing$
    { "" }
    { 't format.editors :=
      t "" =
   { "in " booktitle italicize * }
   { "in " booktitle italicize * ", (" * t * ")" * }
      if$
    }
  if$
}
 
 
FUNCTION {format.tr.number}
{ type missing$
    { "Tech. Rep." }
    { type }
  if$
  number missing$
    'skip$
    { "~" * number * }
  if$
}
 
FUNCTION {format.addr.pub}
{ publisher missing$
    { "" }
    { address missing$
        { "" }
        { address ": " * }
      if$
      publisher *
    }
  if$
}
 
FUNCTION {format.paddress}
{ address missing$
    { "" }
    { "(" address * ")" * }
  if$
}
 
FUNCTION {article}
{ output.bibitem
  "author" format.authors output.check
  "title" format.title output.check
  blank.sep
  "journal" journal field.or.null italicize output.check
  format.volume output
  month missing$
    { format.number output }
    'skip$
  if$
  "pages" format.pages output.check
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {book}
{ output.bibitem
  author missing$
    { "author and editor" format.editors output.check }
    { "author" format.authors output.check }
  if$
  "title" format.btitle output.check
  new.block
  format.bvolume output
  "publisher" format.addr.pub output.check
  format.edition output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  "title" format.btitle output.check
  new.block
  howpublished field.or.null output
  address field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {inbook}
{ output.bibitem
  author missing$
    { "author and editor" format.editors output.check }
    { "author" format.authors output.check }
  if$
  "title" format.btitle output.check
  "chapter and pages" format.chapter.pages output.check
  new.block
  format.bvolume output
  "publisher" format.addr.pub output.check
  format.edition output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {incollection}
{ output.bibitem
  "authors" format.authors output.check
  "title" format.title output.check
  blank.sep
  "booktitle" format.in.ed.booktitle output.check
  format.chapter.pages output
  "publisher" format.addr.pub output.check
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {inproceedings}
{ output.bibitem
  "author" format.authors output.check
  "title" format.title output.check
  blank.sep
  "booktitle" format.in.ed.booktitle output.check
  format.paddress output
  format.pages output
  organization field.or.null output
  publisher field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {conference} { inproceedings }
 
FUNCTION {manual}
{ output.bibitem
  format.authors output
  "title" format.btitle output.check
  new.block
  organization field.or.null output
  address field.or.null output
  format.edition output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {mastersthesis}
{ output.bibitem
  "author" format.authors output.check
  "title" format.btitle output.check
  new.block
  "Master's thesis" output
  "school" school field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
 
FUNCTION {misc}
{ output.bibitem
  format.authors output
  format.title output
  blank.sep
  howpublished field.or.null output
  format.date output
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {phdthesis}
{ output.bibitem
  "author" format.authors output.check
  "title" format.btitle output.check
  new.block
  "PhD thesis" output
  "school" school field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {proceedings}
{ output.bibitem
  editor missing$
    { organization missing$
   'skip$
   { organization field.or.null output }
      if$
    }
    { format.editors output }
  if$
  "title" format.btitle output.check
  format.paddress output
  editor missing$
    'skip$
    { organization field.or.null output }
  if$
  publisher field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {techreport}
{ output.bibitem
  "author" format.authors output.check
  "title" format.title output.check
  blank.sep
  format.tr.number output
  "institution" institution field.or.null output.check
  address field.or.null output
  "year" format.date output.check
  new.block
  note field.or.null output
  fin.entry
}
 
FUNCTION {unpublished}
{ output.bibitem
  "author" format.authors output.check
  "title" format.title output.check
  blank.sep
  format.date output
  new.block
  "note" note field.or.null output.check
  fin.entry
}
 
FUNCTION {default.type} { book }
 
MACRO {jan} {"Jan."}
 
MACRO {feb} {"Feb."}
 
MACRO {mar} {"March"}
 
MACRO {apr} {"Apr."}
 
MACRO {may} {"May"}
 
MACRO {jun} {"June"}
 
MACRO {jul} {"July"}
 
MACRO {aug} {"Aug."}
 
MACRO {sep} {"Sep."}
 
MACRO {oct} {"Oct."}
 
MACRO {nov} {"Nov."}
 
MACRO {dec} {"Dec."}
 
MACRO {acmcs} {"ACM Computing Surveys"}
 
MACRO {acta} {"Acta Informatica"}
 
MACRO {cacm} {"Communications ACM"}
 
MACRO {ibmjrd} {"IBM J. Research and Development"}
 
MACRO {ibmsj} {"IBM Systems J."}
 
MACRO {ieeese} {"IEEE Trans. Software Engineering"}
 
MACRO {ieeetc} {"IEEE Trans. Computers"}
 
MACRO {ieeetcad}
 {"IEEE Trans. Computer-Aided Design"}
 
MACRO {ipl} {"Information Processing Letters"}
 
MACRO {jacm} {"J. ACM"}
 
MACRO {jcss} {"J. Computer and System Sciences"}
 
MACRO {scp} {"Science of Computer Programming"}
 
MACRO {sicomp} {"SIAM J. Computing"}
 
MACRO {tocs} {"ACM Trans. Computer Systems"}
 
MACRO {tods} {"ACM Trans. Database Systems"}
 
MACRO {tog} {"ACM Trans. Graphics"}
 
MACRO {toms} {"ACM Trans. Mathematical Software"}
 
MACRO {toois} {"ACM Trans. Office Information Systems"}
 
MACRO {toplas} {"ACM Trans. Programming Languages and Systems"}
 
MACRO {tcs} {"Theoretical Computer Science"}
 
READ
 
STRINGS {longest.label}
 
INTEGERS { number.label longest.label.width }
 
FUNCTION {initialize.longest.label}
{ 'longest.label "" :=
  'number.label #1  :=
  'longest.label.width #0 :=
}
 
FUNCTION {longest.label.pass}
{ 'label number.label int.to.str$ :=
  'number.label number.label #1 + :=
  label width$ longest.label.width >
    { 'longest.label label :=
      'longest.label.width label width$ :=
    }
    'skip$
  if$
}
 
EXECUTE {initialize.longest.label}
 
ITERATE {longest.label.pass}
 
FUNCTION {preamble}
{ "\begin{thebibliography}{"  longest.label  * "}" * write$
  newline$
}
 
EXECUTE {preamble}
 
EXECUTE {init.state.consts}
 
ITERATE {call.type$}
 
FUNCTION {finish.up} { newline$ "\end{thebibliography}" write$ newline$ }
 
EXECUTE {finish.up}
