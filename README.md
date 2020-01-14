# rcvr
Recievor

This package was designed to mechanize the reproducible
  tabulation of Maine Ranked Choce/Instant Runoff elections.
  
## Contest database
Metadata to reconstruct elections are stored in the textfile `contest_keys.txt`,
including filenames and URLs for downloading original
cast vote record files from
the Maine Office of the Secretary of State, Division
of Elections [(here)](https://www.maine.gov/sos/cec/elec/results/index.html "Election Results").
.
Thus far, three data sets are available, including:

- June 12, 2018 - Primary Election
  - Governor - Democrat (132250 CVRs)
  - Representative to Congress District 2 - Democrat (50845 CVRs)
  
- November 6, 2018 - General Election
  - Representative to Congress District 2 (296077 CVRs)
  
## Contest instances
Use `rrcv::contest()` to construct a `contest` instance,
which will store metadata as `attributes`
and edited ballot data in an underlying
dataframe.

1. If `original == TRUE` the `contest_str` must be set to an `object`
found in the contest database,
as well as valid values for `source`, `CVR_file`,
and `alternative` fields
matching `object`.

2. If `original == FALSE` parameters for a folder (`source =`)
and a list of cast vote records (`CVR_files =`)
must be supplied when invoking `rcvr::contest()`.

## Tabulation options
Tabulation of `contest` instances is accomplished by `rcvr::conduct_runoff()`,
which provides options for processing
overvotes and undervotes.

For example under Maine rules,
an overvote at a particular rank
invalidates that choice and all subsequent choices.
Other jurisdictions may ignore
any or all overvotes.
Under Maine rules, single
undervotes are ignored but **two consecutive**
undervotes invalidate all subsequent choice [(download here)](https://www.maine.gov/sos/cec/rules/29/250/250c535.docx "29-250 Code of Maine Rules Chapter 535: Rules Governing The Administration of Election Determined By Ranked-Choice Voting").
Maine law is more restrictive,
with **two sequential** undervotes
invalidating subsequent choices
[(here)](http://www.mainelegislature.org/legis/statutes/21-A/title21-Asec723-A.html "Title 21-A M.R.S. S 723-A Determination of winner in election for an office elected by ranked-choice voting").
The default for `rcvr::conduct_runoff()`

- `sequentialU == FALSE`
- `max_U = 2`
- `sequentialO == FALSE`
- `max_O  = 1`

## Retabulating Maine Elections
[Yo](https://drive.google.com/open?id=1aJqReiWc3CzjtriG2pSgGasNcLDK61Ol "Hete")
