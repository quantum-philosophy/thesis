\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{thesis}[2017/08/23 Thesis]

\LoadClass[a4paper,showtrims]{memoir}

\usepackage{geometry}

\usepackage[no-math]{fontspec}
\usepackage{algorithm}
\usepackage{color}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{ifthen}
\usepackage{microtype}
\usepackage{polyglossia}

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

\gdef\@abstractenglish{\input{include/abstract/english}}
\gdef\@abstractswedish{\input{include/abstract/swedish}}
\gdef\@acknowledgments{\input{include/acknowledgments}}
\gdef\@abbreviations{\input{include/abbreviations}}
\gdef\@dedication{\input{include/dedication}}
\gdef\@logo{include/assets/figures/university}

\setmainlanguage{english}
\setotherlanguages{swedish}

\clubpenalty=10000
\widowpenalty=10000
\raggedbottom
\midsloppy

\setstocksize{297mm}{210mm}
\settrimmedsize{242mm}{165mm}{*}
\settypeblocksize{*}{28pc}{1.618}

\newfontfamily{\headingfont}[]{KorolevLiU Medium}

\setmainfont{MillerText}[
  BoldFont="MillerText-Roman",
  ItalicFont="MillerText-Italic",
  SmallCapsFont="MillerText-RomanSC"
]

\setmonofont{InputMonoNarrow}[
  Scale=MatchLowercase,
]

\newcommand{\makeabstract}{
  \begin{english}
    \centerline{\Large\textsc{Abstract}}
    \vspace{1em}
    \noindent\@abstractenglish
  \end{english}
  \newpage
  \begin{swedish}
    \centerline{\Large\textsc{Sammanfattning}}
    \vspace{1em}
    \noindent\@abstractswedish
  \end{swedish}
}

\newif\ifNoChapterNumber

\makechapterstyle{blackbox}{
  \renewcommand\printchaptername{}
  \renewcommand\printchapternonum{\NoChapterNumbertrue}
  \renewcommand\printchapternum{}
  \renewcommand\printchaptertitle[1]{%
    \setlength\fboxsep{0pt}%
    \setlength\tabcolsep{0pt}%
    \begin{tabular}{p{5em}b{\textwidth-5em}}
      \colorbox{black}{%
        \begin{minipage}[c][10em][t]{2.5em}
          \ifNoChapterNumber
            \strut
          \else
            \headingfont
            \Huge
            \color{white}
            \vspace{0.4em}
            \centering
            \thechapter
          \fi
        \end{minipage}%
      } & \colorbox{white}{%
        \begin{minipage}[c][10em][c]{\textwidth-5em}
          \headingfont
          \Huge
          \raggedright
          ##1
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
    \Large
    \@dedication\\
  \end{center}
  \vfill
}

\newcommand{\makepermission}{
  \mbox{}
  \vfill
  \begin{flushleft}
    \copyright\ \@publicationyear\ \@author\\[2em]
    \setlength\tabcolsep{0pt}%
    \begin{tabular}{p{3em}b{\textwidth-3em}}
      ISBN & \texttt{\@isbn} \\
      ISSN & \texttt{\@issn} \\
      URL  & \texttt{https://urn.kb.se/resolve?urn=urn:nbn:se:liu:diva-\@divanumber/} \\
    \end{tabular}\\[2em]
    Typeset in Korolev LiU, Miller Text, Computer Modern, and Input Mono\\
    Printed by LiU-Tryck, Linköping \@publicationyear
  \end{flushleft}
}

\renewcommand{\maketitle}{
  \center
  {
    \footnotesize\centerline
    \@publicationseries{}%\\
    Dissertations, No. \@publicationnumber
  }\\[10em]
  {
    \headingfont\Huge
    \@title
  }\\[4em]
  {
    \headingfont\huge
    \@author
  }\\
  \vfill
  \includegraphics[width=14em]{\@logo}\\[2em]
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

\AtBeginDocument{
  \chapterstyle{blackbox}
  \resetlayout
  \checkandfixthelayout
  \pagestyle{empty}
  \pagenumbering{roman}
  {
    \maketitle
    \newpage
  }
  {
    \makepermission
    \clearpage
  }
  {
    \makededication
    \cleartorecto
  }
  {
    \pagestyle{plain}
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}
    \clearpage
  }
  {
    \pagestyle{plain}
    \makeabstract
    \clearpage
    \newpage
  }
  {
    \pagestyle{plain}
    \@acknowledgments
    \addcontentsline{toc}{chapter}{Acknowledgments}
    \clearpage
  }
  {
    \pagestyle{plain}
    \renewcommand{\contentsname}{Table of Contents}
    \tableofcontents
    \relax
    \clearpage
  }
  {
    \@abbreviations
    \addcontentsline{toc}{chapter}{List of Abbreviations}
    \clearpage
  }
  {
    \listofalgorithms
    \addcontentsline{toc}{chapter}{List of Algorithms}
    \clearpage
  }
  {
    \pagestyle{plain}
    \listoffigures
    \relax
    \clearpage
  }
  {
    \pagestyle{plain}
    \listoftables
    \relax
    \clearpage
  }
  \cleartorecto
  \pagenumbering{arabic}
  \pagestyle{ruled}
}

% vim: set ft=tex:
