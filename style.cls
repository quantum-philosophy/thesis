\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{style}[2017/06/01 Thesis]

\LoadClass[a4paper,showtrims]{memoir}

\usepackage{geometry}

\usepackage{hyperref}
\usepackage{ifthen}
\usepackage{microtype}
\usepackage{pbox}
\usepackage{pdfpages}
\usepackage{polyglossia}
\usepackage[figure,table]{totalcount}
\usepackage{xltxtra}

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

\setmainlanguage{english}
\setotherlanguages{swedish}

\usepackage[backend=biber,hyperref]{biblatex}

\newlength{\marginboxlength}
\setlength{\marginboxlength}{\paperwidth}
\addtolength{\marginboxlength}{-\textwidth}
\addtolength{\marginboxlength}{-\spinemargin}
\addtolength{\marginboxlength}{-2mm}

\clubpenalty=10000
\widowpenalty=10000
\raggedbottom
\midsloppy

\setstocksize{297mm}{210mm}
\settrimmedsize{242mm}{165mm}{*}
\settypeblocksize{*}{28pc}{1.618}

\setmainfont{MillerText}[
  ItalicFont="MillerText-Italic",
  SmallCapsFont="MillerText-RomanSC"
]

\linespread{1.05}

\newcommand{\makeabstract}{
  \begin{swedish}
    \setlength{\parindent}{0em}
    \setlength{\parskip}{1em}
    \centerline{\textsc{Populärvetenskaplig sammanfattning}}
    \footnotesize{\@abstractswedish}
  \end{swedish}
  \newpage
  \begin{english}
    \setlength{\parindent}{0em}
    \setlength{\parskip}{1em}
    \centerline{\textsc{Abstract}}
    \footnotesize{\@abstractenglish}
  \end{english}
}

\newif\ifNoChapterNumber

\makechapterstyle{blackbox}{
  \renewcommand\printchaptername{}
  \renewcommand\printchapternonum{\NoChapterNumbertrue}
  \renewcommand\printchapternum{}
  \renewcommand\printchaptertitle[1]{
    \setlength\tabcolsep{0pt}
    \begin{tabular}{p{5em}b{\fill}}
      \colorbox{black}{
        \begin{minipage}[c][10em][t]{2.2em}
          \centering\color{white}\Huge
          \ifNoChapterNumber
            \strut
          \else
            \strut\thechapter
          \fi
        \end{minipage}
      } & {
        \begin{minipage}[c][10em][c]{\fill}
          \Huge ##1
        \end{minipage}
      }
    \end{tabular}
    \NoChapterNumberfalse
  }
}

\newcommand{\makededication}{
  \mbox{}
  \vfill
  \begin{center}
    \@dedication\\
  \end{center}
  \vfill
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

\renewcommand{\maketitle}{
  \selecttypeface{MillerText}
  \center
  {
    \footnotesize\centerline
    \@publicationseries{}%\\
    Dissertations, No. \@publicationnumber
  }\\[10em]
  {
    \LARGE
    \@title
  }\\[5em]
  {
    \Large
    \@author
  }\\
  \vfill
  \includegraphics[width=12em]{\@logo}\\[3em]
  {
    \footnotesize
    Linköping University\\
    \@department\\
    \@division\\
    SE-581 83 Linköping, Sweden\\
    \vspace*{2em}
    Linköping \@publicationyear\\
  }
}

\newcommand{\resetlayout}{
  \setlength{\trimtop}{\stockheight}
  \addtolength{\trimtop}{-\paperheight}
  \setlength{\trimedge}{\stockwidth}
  \addtolength{\trimedge}{-\paperwidth}
  \settrims{0.5\trimtop}{0.5\trimedge}
  \setlrmargins{*}{*}{1.5}
  \setulmargins{2cm}{*}{*}
}

\def\selecttypeface#1{
  \count255=\interactionmode
  \batchmode
  \font\bodyfont="#1"\space at 10pt
  \fontspec{#1}
  \setmainfont{#1}
  \interactionmode=\count255
}

\AtBeginDocument{
  \resetlayout
  \checkandfixthelayout
  \pagestyle{empty}
  \pagenumbering{roman}
  {
    \maketitle
    \newpage
  }
  \pagestyle{plain}
  \makepermission
  \makededication
  \cleartorecto
  \phantomsection
  \addcontentsline{toc}{chapter}{Abstract}
  \clearpage
  \makeabstract
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
  \chapterstyle{blackbox}
}

% vim: set ft=tex:
