{smcl}
{* *! version 1.0.0 22oct2026}{...}
{title:Title}

{phang}
{bf:mapex} {hline 2} Create a choropleth map of one variable across the provinces of Iran

{title:Syntax}

{p 8 16 2}
{cmd:mapex}

{title:Description}

{pstd}
{cmd:mapex} is a dialog-based wrapper for producing a choropleth map of a single numeric variable across the provinces of Iran. It uses bundled province geography data and calls community-contributed mapping commands, including {cmd:geoplot}, to draw the map.

{pstd}
The command is intended to make a common province-level mapping task accessible without requiring users to write the underlying {cmd:geoplot} syntax.

{title:Requirements}

{pstd}
Mapex requires Stata 17 or later and the following community-contributed packages:

{p 8 12 2}
{cmd:geoplot}, {cmd:palettes}, {cmd:colrspace}, {cmd:moremata}, {cmd:reclink}, and {cmd:missings}.

{pstd}
If a dependency is missing, Mapex displays an installation hint. These packages can be installed from Stata using:

{p 8 12 2}
{cmd:ssc install geoplot}
{break}
{cmd:ssc install palettes}
{break}
{cmd:ssc install colrspace}
{break}
{cmd:ssc install moremata}
{break}
{cmd:ssc install reclink}
{break}
{cmd:ssc install missings}

{title:Workflow}

{pstd}
Run {cmd:mapex} and follow the dialogs and the Continue links displayed in the Results window.

{phang2}
1. Start {cmd:mapex}. The initial dialog offers to open Stata's Excel-import dialog. Import or prepare the data, then follow the Continue link displayed in the Results window.

{phang2}
2. In the data dialog, select the variable containing province names.

{phang2}
3. Select the option indicating that the data are already aggregated to the province level. The raw-data option is not implemented in this release.

{phang2}
4. In the map settings dialog, select the numeric variable to plot; choose the two colors for the color ramp; select province-name and value-label colors; and choose automatic or manual class breaks.

{phang2}
5. Confirm the dialog to draw the map.

{title:Data requirements}

{pstd}
The current workflow expects province-level data, normally one observation for each of Iran's 31 provinces. The province-name variable must be suitable for matching against Mapex's bundled province reference data, and the variable to be mapped must be numeric.

{pstd}
If the source data contain individual-level records or multiple observations per province, aggregate them to one record per province before using Mapex. Check for duplicate province names, missing provinces, spelling differences, and extra spaces. Mapex uses fuzzy matching to associate the supplied province names with its reference geography; users should verify that the names and matches are correct.


{title:Class breaks}

{pstd}
The map settings dialog provides two approaches:

{phang2}
{bf:Automatic breaks:} select the desired number of classes (2 through 15). Mapex passes the selected number of classes to the underlying plotting workflow.

{phang2}
{bf:Manual breaks:} enter numeric break points separated by spaces, for example {cmd:10 20 30 40}. Choose cut points appropriate for the variable and inspect the resulting legend.

{title:Remarks}

{pstd}
Mapex creates or replaces working geographic frames and a temporary dataset in the Mapex installation directory as part of its plotting workflow. Avoid relying on these internal working objects as permanent analysis data.

{pstd}
The current version is designed for a single-variable province map. It does not currently provide a completed workflow for mapping raw, individual-level observations.

{title:Examples}

{phang}
Open the Mapex workflow:

{p 8 12 2}
{cmd:. mapex}

{pstd}
For a complete example dataset containing observations for all 31 provinces of Iran, see the {browse "https://github.com/alisoltanimirzayi/mapex#example-input-data":Example input data} section in the Mapex GitHub repository.


{title:Installation & Update}

{pstd}
You can install or Update the program from Stata using this

{p 8 12 2}
{cmd:net install mapex, from("https://raw.githubusercontent.com/alisoltanimirzayi/mapex/main/") replace}

{title:Dependencies and acknowledgement}

{pstd}
Mapex is a convenience wrapper around community-contributed Stata tools, especially Ben Jann's {cmd:geoplot}. Consult the help files for those commands for their full documentation and licensing terms.

{title:Author}
{pstd}
Mapex was written by Ali Soltani Mirzayi. For support and bug reports, use the GitHub repository's Issues page.

{pstd}
Email: {browse "mailto:alisoltanimirzayi@gmail.com":alisoltanimirzayi@gmail.com}

{title:Also see}

{psee}
{help geoplot}, {help colorpalette}, {help reclink}, {help missings}
