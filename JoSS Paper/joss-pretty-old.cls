%%
%% This is file `joss-pretty.cls'.
%% Editing this file is perfectly permitted by the distributing author.
%%
%% BSD License
%%
%% -----------------------------------------------------------------------------
%% IMPORTANT USE GUIDELINES:
%%
%% This document class works like the standard 'article' class except for the
%% way it handles abstracts.  Rather than putting the text of the abstract in an
%% environment, the user now specifies the text of the abstract as the argument
%% of a command.
%%
%% Correct:
%%
%%   \abstract{This is a paper about ...}
%%
%% Incorrect:
%%
%%   \begin{abstract}
%%      This is a paper about ...
%%   \end{abstract}
%%
%% -----------------------------------------------------------------------------
%% This provides a template for JoSS papers.
%%
%% Description: LaTeX package for JoSS papers and related conferences.
%% Keywords: LaTeX, class, JoSS, BibTeX, bibliographic-style
%% Author (aiaa-pretty.cls): Derek Dalle
%% Author (aiaa-tc.cls): Bil Kleb, Bill Wood, Erich Knausenberger
%% Maintainer: Derek Dalle
%% Version: 1.0 <11 April 2012>
%%
%% There are two installation options.
%%
%%   1. Put this file in the same directory as your .tex file, or near it, and 
%%      specify the relative path to this file from the .tex folder in the 
%%      \documentclass line.  For example, if this file is in a directory one
%%      level higher than your .tex file, you should use
%%      \documentclass{../joss-pretty}.
%%
%%   2. Alternately, you could put this file somewhere in your TeX distribution
%%      directory.  If 'texmf' is the path to your main TeX distribution folder,
%%      then a good recommendation is putting this file in 
%%      'texmf/tex/latex/aiaa/'.  This is the same directory that would contain
%%      the aiaa-tc.cls file if it is installed.
%%
%%  'joss-pretty.cls' - A LaTeX class to create JoSS technical papers.
%%
%%  The basic approach is to load the LaTeX article class and various
%%  standard LaTeX packages, and then make modifications and extensions to
%%  conform to JoSS's guidelines.
%%
%%  To use, simply select this class file in your LaTeX document.  For example,
%%
%%    \documentclass{joss-pretty}
%%
%%  Class options:
%%
%%   backrefs   - using this option puts PDF links in the bibliography that
%%                take the reader to the page(s) on which the reference is
%%                used.
%%
%%   conference - used for hand carrying a paper to a 'loose papers'
%%                conference.  It adds the conference name to the
%%                top of the first page, paper number to the bottom
%%                of each page, and a copyright notice on the bottom
%%                of the first.
%%
%%   journal    - produces a style that attempts to replicate a typical
%%                style found in an AIAA journal
%%
%%   submit     - produces output typically required for journal submission,
%%                i.e., 12pt font and 'double spacing'.
%%
%%  Additional options specified in the \documentclass line will be passed
%%  to the article class.
%%
%%  Other general use guidlines:
%%
%%

%% ----- INITIAL DEFINITIONS ---------------------------------------------------
% This prevents the compiler from running on old versions of LaTeX.
\NeedsTeXFormat{LaTeX2e}

% This command gives the name of the class.
\ProvidesClass{joss-pretty}[2010/01/10 v2.0 AIAA paper]


%% ----- OPTIONS ---------------------------------------------------------------
% LaTeX help: logical variables
% Create a new logical variable using
%   \newif\if@something
% This creates a variable \@something with a default of false.

% These variables control the document type.
\newif\if@q@conference
\newif\if@q@submit
\newif\if@q@journal

% These variables control which items to show.
\newif\if@q@abstract
\newif\if@q@author
\newif\if@q@title
\newif\if@q@keyword
\newif\if@q@backref
\newif\if@q@papernumber
\newif\if@q@conference

% These variables relate to the hyperref links.
\newif\if@q@links
\newif\if@links@plain
\newif\if@links@bright

% This option allows the user to compress the entire document.
\newif\if@q@compress

% This sets up any of the above variables that should default to true.
\@q@linkstrue

% Document format options
\DeclareOption{conference}{\@q@conferencetrue}
\DeclareOption{submit}{\@q@submittrue}
\DeclareOption{journal}{\@q@journaltrue}
% Option to compress document
\DeclareOption{compress}{\@q@compresstrue}
% Option to use backward references for references
\DeclareOption{backrefs}{\@q@backreftrue}
% Options to change the colors of the links
\DeclareOption{links=false}{\@q@linksfalse}
\DeclareOption{links=plain}{\@links@plaintrue}
\DeclareOption{links=bright}{\@links@brighttrue}

% This passes any other options on to the article class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}%
 \typeout{Unknown option: passing '\CurrentOption'
  option on to the standard LaTeX article class.}}

% This command appears to tell LaTeX to simply process the class options.
\ProcessOptions


%% ----- DOCUMENT FORMAT -------------------------------------------------------
% This control structure calls the basic LaTeX article.cls class.
\if@q@submit %
 % Submit class: large font and spacing in single column
 \LoadClass[letterpaper,11pt]{article} %
 % Make sure that other formats are supressed.
 \@q@conferencefalse %
 \@q@journalfalse %
\else\if@q@journal %
 % Journal class: mirror the appearance of an AIAA journal article
 \LoadClass[letterpaper,10pt,twoside]{article} %
 % Make sure that the other formats are supressed.
 \@q@conferencefalse %
\else %
 % Conference class: format appropriate for AIAA conference paper
 \LoadClass[letterpaper,10pt]{article} %
\fi\fi

% This class uses the geometry.sty package to set the margins.
\if@q@journal %
 % The margins are very small for the journal version.
 \RequirePackage[margin=2.1cm,bottom=2cm,top=2.5cm,footskip=8pt,headsep=0.4cm,%
  headheight=\baselineskip]{geometry} %
 % This sets the distance between columns.
 \setlength{\columnsep}{1.0cm} %
\else %
 % Larger margins for conference class
 \RequirePackage[margin=2.3cm,top=2.8cm, %
  headheight=0.5\baselineskip]{geometry} %
\fi


%% ----- PACKGAGES -------------------------------------------------------------
% This section tells LaTeX to call a bunch of other packages.
\RequirePackage{graphicx}   % images 
\RequirePackage{array}      % extra row height
\RequirePackage{lastpage}   % to get reference for last page number
\RequirePackage{fancyhdr}   % simple control of headers and footers
\RequirePackage{multicol}   % package for multi-column nomenclature
\RequirePackage{times}      % changes font to Times New Roman
\RequirePackage{verbatim}   % New verbatim format
\RequirePackage{textcomp}   % proper single quotes in verbatim
\RequirePackage{ifthen}     % logical structure
\RequirePackage{subfigure}     % subfigures
\RequirePackage{amsmath}    % AMS packages
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{mathrsfs}
\RequirePackage{gensymb} % (added to make "\degree" work, TRPH 7/14/2014)
\RequirePackage{dblfloatfix} % tables and figures in two-column format
\RequirePackage{flushend}   % balances columns on last page
\RequirePackage{titlecaps}
\Addlcwords{the of into a and for to on with in }

% Need a package to set 1.5-spaced lines for 'submit'
\if@q@submit\RequirePackage{setspace}\fi
% Need a package to fix the author footnotes in two-column format
\if@q@journal\RequirePackage{abstract}\fi


%% ----- IDENTIFIERS AND ABSTRACT ----------------------------------------------
% Variables that hold the value of various identifiers.
\renewcommand{\@author}{}
\newcommand{\@shortauthor}{}
\newcommand{\@abstract}{}
\renewcommand{\@title}{}
\newcommand{\@copyright}{}
\newcommand{\@submitinfo}{}
\newcommand{\@conference}{}
\newcommand{\@journal}{}
\newcommand{\@keyword}{}

% New author command
\renewcommand*{\author}[1]{ %
 % Set the main author field.
 \renewcommand{\@author}{#1} %
 % Set a flag to use it.
 \@q@authortrue}

% New abstract command
\renewcommand{\abstract}[1]{ %
 \renewcommand{\@abstract}{#1} %
 \@q@abstracttrue}

% New title command
\renewcommand{\title}[1]{ %
 \renewcommand{\@title}{#1} %
 \@q@titletrue}

% New command for keyword
\newcommand{\keyword}[1]{ %
 \renewcommand{\@keyword}{#1} %
 \@q@keywordtrue}

% Commands to insert the identifiers
\newcommand{\insertauthor}{\@author}
\newcommand{\insertshortauthor}{\@shortauthor}
\newcommand{\inserttitle}{\@title}
\newcommand{\insertabstract}{\@abstract}
\newcommand{\insertkeyword}{\@keyword}


%% ----- FLOATS ----------------------------------------------------------------
% This eliminates the parentheses around the sublabel in references.
\renewcommand{\thesubfigure}{\alph{subfigure}}
% This formats the actual label area for each subfigure.
\renewcommand{\@thesubfigure}{\alph{subfigure})\hskip\subfiglabelskip}
% This eliminates the parentheses around the sublabel in references.
\renewcommand{\thesubtable}{\alph{subtable}}
% This formats the actual label area for each subtable.
\renewcommand{\@thesubtable}{\alph{subtable})\hskip\subfiglabelskip}

% This sets the distance between a float and the paragraph.
\setlength{\intextsep}{0.7\baselineskip \@plus 2\p@ \@minus 1\p@}

% This sets the priorization for where floats should go.
\renewcommand{\fps@figure}{htbp}
\renewcommand{\fps@table}{htbp}

% Use a package to match the absurd caption formatting guidelines
\RequirePackage[font=small]{caption}

% Formatting specific only to figure captions
\captionsetup[figure]{ %
 font=it,labelfont=bf,position=bottom,singlelinecheck=false}
% Formatting specific only to table captions
\captionsetup[table]{position=top}
% For the journal, tables have a different format
\if@q@journal
 \captionsetup[table]{labelfont=bf} %
\fi

 

%% ----- LENGTHS AND SIZES -----------------------------------------------------
% Vertical spaces for the title area
\newlength{\toptitleskip}
\newlength{\titleauthorskip}
\newlength{\titleabstractskip}
\newlength{\authorabstractskip}
\newlength{\titletextskip}
\newlength{\abstractskip}
\newlength{\keywordskip}

% Set the lengths of the title area skips
\setlength{\toptitleskip}{5ex}
\setlength{\titleauthorskip}{4ex}
\setlength{\titleabstractskip}{5ex}
\setlength{\authorabstractskip}{5ex}
\setlength{\titletextskip}{5ex plus 2pt minus 3pt}
\setlength{\abstractskip}{3ex}
\setlength{\keywordskip}{0pt}

% Change the length of the author-to-abstract skip for submit
\if@q@submit %
 \setlength{\authorabstractskip}{7ex} %
\fi

% Command to make the skips in the title area smaller.
\newcommand{\compresstitle}{ %
 \setlength{\toptitleskip}{-1ex plus 2ex}
 \setlength{\titleauthorskip}{2ex}
 \setlength{\titleabstractskip}{2ex}
 \setlength{\authorabstractskip}{2ex}
 \setlength{\titletextskip}{3ex plus 2pt minus 3pt}
}

% Command to make the section skips smaller.
\newcommand{\compresssections}{ %
 % This gives formatting rules for section headers.
 \renewcommand\section{%
  \@startsection {section}{1}{\z@}%
   {0.1ex \@plus -1ex \@minus -.2ex}%
   {0.7ex \@plus.2ex}%
   {\center\normalfont\large\bfseries}}
 % This gives formatting rules for subsection headers.
 \renewcommand\subsection{%
  \@startsection{subsection}{2}{\z@}%
   {-5.25ex\@plus -1ex \@minus -.2ex}%
   {0.5ex \@plus .2ex}%
   {\normalfont\normalsize\bfseries}}
}

% Command to set the font size to 9 with tight spacing
% It is necessary because there is no 9pt option for article.
\newcommand{\smallfonts}{ %
 % This does the main font resizing work.
 \renewcommand\normalsize{ %
  % The first number is the size of the text.
  % The second number is the size of the line.
  \@setfontsize\normalsize\@ixpt\@ixpt%
  % Set the amount of vertical white space before and after equations.
  \abovedisplayskip 4\p@ \@plus4\p@ \@minus2\p@
  \belowdisplayskip 4\p@ \@plus4\p@ \@minus2\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 3\p@ \@plus3\p@ \@minus2\p@
  % I do not know what this means.
  \let\@listi\@listI
 }
 % The small size needs tweaking, too
 \renewcommand\small{%
  % Decrease the font size to 8pt.
  \@setfontsize\small\@viiipt{9}%
  % Decrease the margins above and below equations.
  \abovedisplayskip 3\p@ \@plus2\p@ \@minus1\p@
  \abovedisplayshortskip \z@ \@plus\p@
  \belowdisplayshortskip 2\p@ \@plus\p@ \@minus\p@
  % I still don't know what this means.
  \def\@listi{\leftmargin\leftmargini
   \topsep 3\p@ \@plus\p@ \@minus\p@
   \parsep 2\p@ \@plus\p@ \@minus\p@
   \itemsep \parsep} %
 }
}


%% ----- TITLE AREA ------------------------------------------------------------

% Amount to skip before inserting title
\newcommand{\tskrp}{5ex}

% Define a new command that does most of the work of making the title.
\renewcommand{\@maketitle}{ %
 % Housekeeping
 \newpage %
 % Change the footnote style to silly marks.
 \renewcommand\thefootnote{\@fnsymbol\c@footnote} %
 % Insert the information in a centered environment
 \begin{center} %
  % Set the footnote command equal to the thanks command.
  \let\footnote\thanks %
  % Check for a title
  \if@q@title %
   {\if@q@journal\Large\else\large\fi %
    \bfseries \inserttitle} %
  \fi %
  % Check for a keyword.
  \if@q@keyword %
   % Do not use for "journal" template.
   \if@q@journal %
   \else %
    % Title-to-author gap
    \if@q@title \vskip\keywordskip \fi %  %(corrected typo "keyworskip" to "keywordskip", TRPH 07/14/14)
    % Insert the keyword
    {\normalsize \bfseries \insertkeyword} %
   \fi %
  \fi %
  % Check for an author field.
  \if@q@author %
   % Title-to-author gap
   \if@q@title \vskip\titleauthorskip \fi %
   % Insert the author.
   { %
    % Be sloppy.
    \sloppy %
    % Insert author in a tabular environment.
    \hfill\begin{tabular}[t]{c}\insertauthor\end{tabular}\hfill %
   } %
  \fi %
  % Switch to 1.5-spacing if the submit version is checked.
  \if@q@submit %
   % 1.5-spaced lines
   \doublespacing%
  \fi %
  % Check for an abstract.
  \if@q@abstract %
   % Check which gap to insert above.
   \if@q@author %
    % Author-to-abstract skip
    \vskip\authorabstractskip %
   \else\if@q@title %
    % Title-to-abstract skip
    \vskip\titleabstractkip %
   \fi\fi %
   % Insert the abstract header
   \bfseries ABSTRACT \vskip\abstractskip %
   % Test for different format for "journal" layout.
   \if@q@journal %
    % Make a block for the abstract.
    \begin{minipage}{13.3cm} %
    % Insert the text.
     \small \normalfont \insertabstract %
    \end{minipage} %
    \vskip\titletextskip %
    \noindent\rule{10.8cm}{1.5pt} %
   \else %
    % Make a block for the abstract.
    \begin{minipage}{\textwidth} %
    % Insert the text.
     \small \normalfont \insertabstract %
    \end{minipage} %
   \fi
   % Abstract-to-text gap
   \vskip\titletextskip %
  \else\if@q@author %
   % Author-to-text gap
   \vskip\titletextskip %
  \else\if@q@title %
   %Title-to-text gap
   \vskip\titletextskip %
  \fi\fi\fi %
 \end{center} %
 % Produce the author footnotes.
 \@thanks %
 % Restart the footnotes (Don't count the 'thanks' information.).
 \setcounter{footnote}{0} %
 % Set the footnote symbol to letters.
 \renewcommand\thefootnote{\@alph\c@footnote} %
}

% This section distinguishes between the two-column and one-column options.
\if@q@journal %
 % For a journal, use two-column format except for the title and abstract.
 \renewcommand{\maketitle}{ %
  % Two-column title area
  \twocolumn[\@maketitle] %
  % Remove extra headers and footers from titlepage.
  \thispagestyle{empty} %
  % This is needed to print the footnotes.
  \saythanks %
  % Reset the footnote style.
  \renewcommand\thefootnote{\@alph\c@footnote}} %
  % Get rid of the line for footnotes.
  \renewcommand{\footnoterule}{} %
\else\if@q@submit %
 % Insert the title area as part of the whole one-column document.
 \renewcommand{\maketitle}{ %
  % Insert the title.
  \@maketitle %
  % Switch to double spacing.
  \doublespacing} %
\else %
 % Insert the title area as part of the whole one-column document.
 \renewcommand{\maketitle}{\@maketitle}
\fi\fi


%% ----- HEADER AND FOOTER -----------------------------------------------------

% This tells LaTeX to not put page numbers.
\pagestyle{empty}


%% ----- SECTION HEADERS -------------------------------------------------------
% Update section numbering.
\renewcommand\thesection      {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection.\@arabic\c@subsubsection}
\renewcommand\theparagraph    {(\@roman\c@paragraph)}
% No counters \paragraph and below
\setcounter{secnumdepth}{4}
% This confusing command puts a period after the section numbers.
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.\quad}
% This makes sure all denominations of paragraph are indented.
\let\@afterindentfalse\@afterindenttrue

% Don't make uppercase for journal.
\if@q@journal
 % This gives formatting rules for section headers.
 \renewcommand\section{ %
  \@startsection {section}{1}{\z@} %
   {3.5ex \@plus 1ex \@minus -.2ex} %
   {1.0ex \@plus.2ex} %
   {\center\normalfont\large\bfseries}} %
\else %
 % This gives formatting rules for section headers.
 \renewcommand\section{ %
  \@startsection {section}{1}{\z@} %
   {3.5ex \@plus 1ex \@minus -.2ex} %
   {1.0ex \@plus.2ex} %
   {\center\normalfont\large\bfseries\MakeUppercase}} %
\fi

% This gives formatting rules for subsection headers.
\renewcommand\subsection{%
 \@afterindenttrue %
 \@startsection{subsection}{2}{\z@}%
  {-3.25ex\@plus -1ex \@minus -.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\bfseries}}

% This gives formatting rules for subsubsection headers.
\if@q@journal
 % No spacing after
 \renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}%
   {-3.25ex\@plus -1ex \@minus -.2ex}%
   {0.2ex \@plus .2ex}%
   {\normalfont\normalsize}}%
\else%
 % Regular spacing after
 \renewcommand\subsubsection{%
  \@startsection{subsubsection}{3}{\z@}%
   {-3.25ex\@plus -1ex \@minus -.2ex}%
   {1.5ex \@plus .2ex}%
   {\normalfont\normalsize}}%
\fi

% If you are silly enough to use paragraphs with headings, this controls them.
\renewcommand\paragraph{%
 \@startsection{paragraph}{4}{\parindent}%
  {2.25ex \@plus1ex \@minus.2ex}%
  {1.5ex \@plus .2ex}%
  {\normalfont\normalsize\itshape}}

% Formatting for subparagraphs.
\renewcommand\subparagraph{%
 \@startsection{subparagraph}{5}{\parindent}%
  {2.25ex \@plus1ex \@minus .2ex}%
  {-1em}%
  {\normalfont\normalfont}}


%% ----- APPENDIX --------------------------------------------------------------
% Keep the original appendix command.
\let\@tex@appendix\appendix

% Store the original \section command
\let\@tex@section\section

% Regular appendix command
\newcommand{\sectionNoStar}[1]{ %
 % Increase the section number.
 \stepcounter{section} %
 % Add a silly line.
 \centerline{\large APPENDIX \thesection}\vskip4pt %
 % Add the title of the section.
 \centerline{\large \bfseries \uppercase{#1}} \vskip6pt %
 % Create a pdf anchor.
 \phantomsection %
 % Add to table of contents.
 \addcontentsline{toc}{chapter}{#1} %
}

% Starred (not numbered) appendix command
\newcommand{\sectionStar}[2]{ %
 % Add a silly line.
 \centerline{\large APPENDIX}\vskip4pt %
 % Add the title of the section.
 \centerline{\large \bfseries \uppercase{#1}} \vskip6pt %
 % Create a pdf anchor.
 \phantomsection %
 % Add to table of contents.
 \addcontentsline{toc}{chapter}{#1} %
}

% Define the appendix command to do some extra tasks.
\renewcommand{\appendix}{ %
 % Reset the counters.
 \setcounter{equation}{0} %
 \setcounter{figure}{0} %
 \setcounter{table}{0} %
 % New label for equations, figures, and tables
 \renewcommand{\theequation}{A\@arabic\c@equation} %
 \renewcommand{\thefigure}{A\@arabic\c@figure} %
 \renewcommand{\thetable}{A\@arabic\c@table} %
 % Use the original appendix command.
 \@tex@appendix %
 % Don't make uppercase for journal.
 \if@q@journal %
 \else %
  % Change the section command.
  \renewcommand{\section}{ %
  \vskip 3.5ex \@plus 1ex \@minus -.2ex
  \@ifstar\sectionStar\sectionNoStar
  } %
 \fi
}


%% ----- BIBILIOGRAPHY ---------------------------------------------------------
% Save the original bibliography command.
\let\@tex@bibliography\bibliography

% Create a new command for the bibliography.
\renewcommand*{\bibliography}[1]{ %
 % Get the old sections back!
 \let\section\@tex@section %
 % Create a pdf anchor.
 \phantomsection %
 % Add to table of contents.
 \addcontentsline{toc}{chapter}{References} %
 % Load the bibliography.
 \@tex@bibliography{#1} %
}


%% ----- CODE ENVIRONMENT ------------------------------------------------------
% This generates a 'code' environment that allows inline citations
% of small snippets of code.
\newenvironment{code} %
 {\quote\small\verbatim} %
 {\endverbatim\endquote}

% Formatting commands
% This command is used for names of files
\newcommand{\tfile}[1]{{\footnotesize\textsf{#1}}}
% This command puts a box around text that is meant for menu entries.
\newcommand{\tmenu}[1]{\framebox[\width]{\ {\tiny\textsf{#1}}\ }}
% This command is intended for names of variables within programs.
\newcommand{\tvar}[1]{{\footnotesize\texttt{#1}}}
% This command is used to display the contents of strings.
% It automatically adds the correct, upright quotes around the argument.
\newcommand{\tstring}[1]{ %
 {\footnotesize\texttt{\textquotesingle#1\textquotesingle}}}
% This command gives a bold version of the variable names.
\newcommand{\tfunction}[1]{{\footnotesize\texttt{\textbf{#1}}}}


%% ----- MATH COMMANDS ---------------------------------------------------------
% Command for differential d
\newcommand{\diff}{\mathrm{d}}
% Command for Leibniz notation of derivatives
\newcommand{\dd}[2]{\frac{\diff#1}{\diff#2}}
% Command for Leibniz notation of partial derivatives
\newcommand{\pd}[2]{\frac{\partial#1}{\partial#2}}
% Command for norm
\newcommand{\norm}[1]{\lVert#1\rVert}
% Command for absolute value
\newcommand{\abs}[1]{\lvert#1\rvert}

% Formatting for vectors
\newcommand{\mvec}[1]{\mathbf{#1}}
% Formatting for matrices
\newcommand{\mmat}[1]{\boldsymbol{\mathsf{#1}}}
% Formatting for special operators


%% ----- TEXT COMMANDS ---------------------------------------------------------
% Command for 'and others'
\newcommand{\etal}{\textit{et al.}}
% Command for 'for example'
\newcommand{\eg}{\textit{e.g.}}
% Command for 'that is'
\newcommand{\ie}{\textit{i.e.}}
% Command for 'and the rest'
\newcommand{\etc}{\textit{etc.}}

% Short space
\newcommand{\sspace}{\hspace{0.18em}}


%% ----- NOMENCLATURE ENVIRONMENT ----------------------------------------------
% New command for nomenclature environment
\newenvironment{nomenclature}[1][]
{ %
 % Insert the title if present.
 \ifthenelse{\equal{#1}{}}{ %
  % Start the tabular environment.
  \noindent\tabular{@{} p{3.5em} @{\hspace{2pt}=\hspace{1em}} l} %
 }{ %
 % Insert the title.
 \noindent\textit{#1}\\[3pt] %
 % Start the tabular environment.
 \noindent\tabular{@{} p{3.5em} @{\hspace{2pt}=\hspace{1em}} l} %
 }
}{ %
 % End the tabular environment
 \endtabular %
}

%% ----- LINKS -----------------------------------------------------------------
% Check if links should be loaded at all
\if@q@links
 % Load the link package.
 \if@q@backref
  % Load the package with backwards references for bibliography.
  \RequirePackage[pagebackref=true,colorlinks=true]{hyperref}
 \else
  % No back references
  \RequirePackage[colorlinks=true]{hyperref}
 \fi
 % Check the colors of the links that should be used.
 \if@links@plain
  % Use all black links.
  \hypersetup{
   citecolor=black,
   linkcolor=black,
   filecolor=black,
   urlcolor=blue}
 \else\if@links@bright
  % Use bright colors for the links
  \hypersetup{urlcolor=cyan}
 \else
  % This loads a package that allows extra colors for links.
  \RequirePackage[usenames,dvipsnames]{color}
  % Custom color for references.
  \definecolor{DarkGreen}{rgb}{0,0.6,0}
  % Use more muted colors.
  \hypersetup{
   citecolor=DarkGreen,
   linkcolor=Maroon,
   urlcolor=blue,
   filecolor=black}
 \fi\fi
\fi


%% ----- REFERENCES ------------------------------------------------------------

% Use the "natbib" package to get parenthetical citations.
\RequirePackage{natbib}

% Make regular citations parenthetical.
\let\cite\citep


%% ----- SET THE FONT SIZES ----------------------------------------------------
% Change the base font size for journal papers.
\if@q@compress
 % 'compress' sizes and skips
 \compresstitle
 \compresssections
 \smallfonts
\fi



%% ----- BEGIN DOCUMENT AREA ---------------------------------------------------
% List of actions to take after the document has begun.
\AtBeginDocument{ %
 % Commands for each format.
 \if@q@journal
  % Sloppy hyphenation
  \sloppy
 \fi %
 % Set the PDF title.
 % We have to wait until here to make sure the user has set the title.
 \if@q@links
  \hypersetup{pdftitle=\inserttitle}
 \fi
}