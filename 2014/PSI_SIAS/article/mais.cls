%% MAIS custom style
%% Very early version: (c) ltwood, 2003
%% Modified and powered 7.03.09: (c) ltwood, 2009

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{article}[2004/02/16 v1.4f 57 Standard LaTeX document class]
\LoadClass[12pt,twoside]{article}

\usepackage{fancyhdr}
\usepackage{ifpdf}

\widowpenalty=10000 % Don't allow widows

%% Language resources

\def\mybibname{\CYRL\cyri\cyrt\cyre\cyrr\cyra\cyrt\cyru\cyrr\cyra}
\def\myshortname{%%%
  \CYRM\cyro\cyrd\cyre\cyrl.
  \cyri{}
  \cyra\cyrn\cyra\cyrl\cyri\cyrz{}
  \cyri\cyrn\cyrf\cyro\cyrr\cyrm.
  \cyrs\cyri\cyrs\cyrt\cyre\cyrm.{}
}
\def\mylongname{%%%
  \CYRM\cyro\cyrd\cyre\cyrl\cyri\cyrr\cyro\cyrv\cyra\cyrn\cyri\cyre{}
  \cyri{}
  \cyra\cyrn\cyra\cyrl\cyri\cyrz{}
  \cyri\cyrn\cyrf\cyro\cyrr\cyrm\cyra\cyrc\cyri\cyro\cyrn\cyrn\cyrery\cyrh{}
  \cyrs\cyri\cyrs\cyrt\cyre\cyrm{}
}
\def\myrecname{\cyrp\cyro\cyrl\cyru\cyrch\cyre\cyrn\cyra}
\def\myvolname{\CYRT.}
\def\myUDCname{\CYRU\CYRD\CYRK}

%% Custom Settings

\renewenvironment{abstract}{\vspace{-1cm}\small\quotation}{\endquotation}

%% точки в номерах разделов
\renewcommand{\thesection}{\arabic{section}.}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}.}
\renewcommand{\thesubsubsection}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}.}

%% Изменяем название списка литературы
\renewcommand{\refname}{\mybibname}

%% точки в списке литературы
\makeatletter
\renewcommand{\@biblabel}[1]{#1.\hfill}
\makeatother

%% магия с точкой в подрисуночной подписи
\makeatletter
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1. #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\makeatother

%% Style Settings

\newcounter{firstpage}
\newcounter{lastpage}
\newcounter{volume}
\newcounter{tnumber}
\newcounter{year}

\setcounter{firstpage}{1}

\def\maistitleval{???}
\def\maisshorttitleval{???}
\def\maisauthorval{???}
\def\maisdateval{???}
\def\maisydateval{???}
\def\maisUDCval{???}
\def\maistitlenval{???}
\def\maisauthorenval{???}
\def\maisaffiliationval{???}
\def\maisaffiliationenval{???}
\def\maisemailval{???}
\def\maisrefenval{???}
\def\maisauthorinformval{???}
\def\maiskeywordsval{???}
\def\maisenkeywordsval{???}

\def\maisvolume#1{\setcounter{volume}{#1}}
\def\maisnumber#1{\setcounter{tnumber}{#1}}
\def\maisyear#1{\setcounter{year}{#1}}
\def\firstpage#1{\setcounter{firstpage}{#1} \setcounter{page}{#1}}

\def\title#1{\def\maistitleval{#1}}
\def\shorttitle#1{\def\maisshorttitleval{#1}}
\def\author#1{\def\maisauthorval{#1}}
\def\authorcr#1{\def\maisauthorcrval{#1}}
\def\date#1{\def\maisdateval{#1}}
\def\ydate#1{\def\maisydateval{#1}}%
\def\UDC#1{\def\maisUDCval{#1}}
\def\entitle#1{\def\maistitlenval{#1}}
\def\enauthor#1{\def\maisauthorenval{#1}}
\def\affiliation#1{\def\maisaffiliationval{#1}}
\def\affiliationen#1{\def\maisaffiliationenval{#1}}
\def\email#1{\def\maisemailval{#1}}
\def\enabstract#1{\def\maisrefenval{#1}}
\def\authorinform#1{\def\maisauthorinformval{#1}}
\def\keywords#1{\def\maiskeywordsval{#1}}
\def\enkeywords#1{\def\maisenkeywordsval{#1}}

\InputIfFileExists{mais.opt}{}{
  \maisvolume{0}
  \maisnumber{0}
  \maisyear{2000}
}

\ifpdf
 \topmargin=-1.3cm
 \else
  \topmargin=-0.7cm
 \fi
% Отступ для pdf

\textheight=23cm
\textwidth=15.8cm
\headheight=12pt
\addtolength{\headheight}{\baselineskip}

\fancypagestyle{hdrpage}{
  \fancyhead{}
  \fancyhead[L]{\vspace{10pt}\footnotesize {\em\myshortname}~\myvolname\,{\bf\thevolume},  \No\,{\bf\thetnumber} (\theyear) \thefirstpage--\thelastpage
  \\ \copyright {\it \maisauthorcrval,} \maisydateval}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{plain}{
  \fancyhead{}
  \fancyhead[LE,RO]{\thepage}
  \fancyhead[RE]{{\em\mylongname}~\myvolname\,{\bf\thevolume}, \No\,{\bf\thetnumber} (\theyear)}
  \fancyhead[LO]{\maisshorttitleval}
  \fancyfoot{}
}
\pagestyle{plain}

\def\maketitle{
  \thispagestyle{hdrpage}
  \noindent \myUDCname~\maisUDCval
  \vskip 0pt \null
  \begin{center}
    {\Large\bf\maistitleval}
  \end{center}
  \vskip 8pt \null
  \centerline{\maisauthorval}
  \begin{center}
        {\em \maisaffiliationval}
  \end{center}
  \centerline{\em e-mail: \maisemailval}
  \vskip 6pt
  \centerline{\em \myrecname~\maisdateval~\maisydateval}
  \vskip 6pt
  \begin{center}
    {{\bf Ключевые слова:} \ \ \maiskeywordsval}
  \end{center}
  \vskip 28pt
}

\def\maismakefooter{
  \begin{center}
  {\large\bf
    {\selectlanguage{english}\maistitlenval}
  }
  \end{center}
  \vskip 1pt \noindent
  \centerline{\maisauthorenval}
  \vskip 1pt \noindent
  \begin{center}
        {\em \maisaffiliationenval}
  \end{center}

  \begin{center}
  {{\bf Keywords: \ }
    {\selectlanguage{english}\maisenkeywordsval}
  }
  \end{center}
  \vskip 12pt \noindent
  {\par{\selectlanguage{english}\maisrefenval}}
  \vskip 12pt \noindent
  \begin{center}
  {{\bf Сведения об авторе: \ }
    {\maisauthorinformval}
  }
  \end{center}
}

\makeatletter
\def\lastpagelabel{
  \addtocounter{page}{-1}
  \immediate\write\@auxout{\string\setcounter{lastpage}{\thepage}}
  \addtocounter{page}{1}
}
\makeatother

\AtEndDocument{
  \maismakefooter
  \clearpage\lastpagelabel
}
\evensidemargin=0.5cm  %для печати в ps
\oddsidemargin=-0.3cm    %для печати в ps

