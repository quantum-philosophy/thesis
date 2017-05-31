\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{style}[2017/05/31 Thesis]

\RequirePackage{xkeyval}
\RequirePackage[absolute]{textpos}
\RequirePackage[figure,table]{totalcount}

\def\createvariable#1{
  \expandafter\def\csname #1\endcsname{\expandafter\gdef\csname @#1\endcsname}
  \csname #1\endcsname{\texttt{\textbackslash #1}}
}

\createvariable{department}
\createvariable{divanumber}
\createvariable{division}
\createvariable{isbn}
\createvariable{issn}
\createvariable{publicationseries}
\createvariable{publicationyear}
\createvariable{publicationnumber}

\gdef\@abstractenglish{\input{include/abstract-en}}
\gdef\@abstractswedish{\input{include/abstract-sv}}
\gdef\@acknowledgments{\input{include/acknowledgments}}
\gdef\@dedication{\input{include/dedication}}
\gdef\@logo{include/assets/figures/logo}

\ExecuteOptions{a4paper}
\ProcessOptions*

\LoadClass{memoir}

\RequirePackage{pdfpages}
\RequirePackage{pbox}
\RequirePackage{ifthen}
\RequirePackage{geometry}
\RequirePackage[pdfusetitle]{hyperref}
\RequirePackage[MnSymbol]{mathspec}

\usepackage{calc}
\usepackage{polyglossia}
\usepackage{xltxtra}

\setmainlanguage{english}
\setotherlanguages{swedish}

\usepackage[backend=biber,hyperref]{biblatex}
\ExecuteBibliographyOptions{maxnames=99}

\newlength{\marginboxlength}
\setlength{\marginboxlength}{\paperwidth}
\addtolength{\marginboxlength}{-\textwidth}
\addtolength{\marginboxlength}{-\spinemargin}
\addtolength{\marginboxlength}{-2mm}

\newcounter{article}
\setcounter{article}{0}
\renewcommand{\thearticle}{\Roman{article}}
\setlength{\TPVertModule}{2cm}
\setlength{\TPHorizModule}{\paperwidth - 4.3cm}

\def\typeface#1{
  \count255=\interactionmode
  \batchmode
  \font\bodyfont="#1"\space at 10pt
  \fontspec{#1}
  \setmainfont{#1}
  \interactionmode=\count255
}

\renewcommand{\maketitle}{
  \typeface{MillerText}
  {
    \center
    {
      \footnotesize\centerline
      \@publicationseries{}%\\
      Dissertations, No. \@publicationnumber
    }\\[25mm]
    {
      \LARGE\bfseries
      \@title
    }\\[20mm]
    {
      \Large\bfseries
      \@author
    }\\
    \vfill
    \includegraphics[width=35mm]{\@logo}\\[12mm]
    {
      \footnotesize
      Linköping University\\
      \@department\\
      \@division\\
      SE-581 83 Linköping, Sweden\\
      \vspace*{5mm}
      Linköping \@publicationyear\\
    }
  }
}

\newcommand{\abstractpages}{%
  \vspace*{6mm}
  \begin{swedish}
    \setlength{\parindent}{0mm}
    \setlength\parskip{8pt}\centerline{POPULÄRVETENSKAPLIG SAMMANFATTNING}
    \vspace{3mm}
    \footnotesize{\@abstractswedish}
  \end{swedish}
  \newpage
  \vspace*{6mm}
  {
    \setlength{\parindent}{0mm}
    \setlength\parskip{8pt}\centerline{ABSTRACT}
    \vspace{3mm}
    \footnotesize{\@abstractenglish}
  }
}

\newcommand{\makepermission}{
  \mbox{}
  \vfill
  \begin{flushleft}
    \copyright\ \@publicationyear\ \@author\\[1em]
    ISBN \@isbn\\
    ISSN \@issn\\
    URL \texttt{http://urn.kb.se/resolve?urn=urn:nbn:se:liu:diva-\@divanumber/}\\[3em]
    Published articles have been reprinted with permission from the respective
    copyright holder.\\[3em]
    Typeset in Korolev LiU and Miller Text\\
    Printed by LiU-Tryck, Linköping \@publicationyear
  \end{flushleft}
  \clearpage
}

\newcommand{\makededication}{
  \mbox{}
  \vfill
  \begin{center}
    \@dedication\\
  \end{center}
  \vfill
}

\clubpenalty=10000
\widowpenalty=10000
\raggedbottom
\midsloppy

\setstocksize{297mm}{210mm}
\settrimmedsize{242mm}{165mm}{*}
\settypeblocksize{*}{28pc}{1.618}

\newcommand{\resetlayout}{
  \setlength{\trimtop}{\stockheight}
  \addtolength{\trimtop}{-\paperheight}
  \setlength{\trimedge}{\stockwidth}
  \addtolength{\trimedge}{-\paperwidth}
  \settrims{0.5\trimtop}{0.5\trimedge}
  \setlrmargins{*}{*}{1.5}
  \setulmargins{2cm}{*}{*}
}

\setmainfont{MillerText}[
  ItalicFont="MillerText-Italic",
  SmallCapsFont="MillerText-RomanSC"
]

\linespread{1.05}

\AtBeginDocument{
  \resetlayout
  \checkandfixthelayout
  \pagestyle{empty}
  \pagenumbering{roman}
  \begin{adjustwidth}{-1cm}{-1cm}
    \maketitle
    \newpage
  \end{adjustwidth}
  \pagestyle{plain}
  \makepermission
  \makededication
  \cleartorecto
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \clearpage
  \abstractpages
  \clearpage
  \newpage
  \@acknowledgments
  \addcontentsline{toc}{chapter}{Acknowledgments}
  \clearpage
  {
    \pagestyle{plain}
    \tableofcontents
    \relax
    \clearpage
  }
  \iftotalfigures{\pagestyle{plain}\listoffigures\relax\clearpage}\fi
  \iftotaltables{\pagestyle{plain}\listoftables\relax\clearpage}\fi
  \cleartorecto
  \pagenumbering{arabic}
  \pagestyle{ruled}
}
